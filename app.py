# app.py
from flask import Flask, render_template, request, redirect, url_for, flash, jsonify
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from conexion.conexion import db   # ✅ seguimos usando db
from forms import ProductoForm, LoginForm, RegisterForm
from models import Usuario, Producto, Bebida, Cliente
from datetime import datetime
from werkzeug.security import generate_password_hash, check_password_hash
import os, csv, json

# ======================================================
# Inicializar Flask
# ======================================================
app = Flask(__name__)
app.config['SECRET_KEY'] = 'dev-secret-key'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:@localhost/proyecto'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

login_manager = LoginManager(app)
login_manager.login_view = "login"

@login_manager.user_loader
def load_user(user_id):
    return Usuario.query.get(int(user_id))

# ======================================================
# Flask-Login: Cargar usuario
# ======================================================
@login_manager.user_loader
def load_user(user_id):
    return Usuario.query.get(int(user_id))

# ======================================================
# Inyectar fecha en templates
# ======================================================
@app.context_processor
def inject_now():
    return {'now': datetime.utcnow}

# ======================================================
# Persistencia en archivos
# ======================================================
def guardar_en_txt(producto):
    ruta = "datos/datos.txt"
    with open(ruta, "a") as f:
        f.write(f"{producto['nombre']},{producto['cantidad']},{producto['precio']}\n")

def leer_de_txt():
    ruta = "datos/datos.txt"
    productos = []
    if os.path.exists(ruta):
        with open(ruta, "r") as f:
            for linea in f:
                nombre, cantidad, precio = linea.strip().split(",")
                productos.append({"nombre": nombre, "cantidad": int(cantidad), "precio": float(precio)})
    return productos

def guardar_en_json(producto):
    ruta = "datos/datos.json"
    productos = []
    if os.path.exists(ruta):
        with open(ruta, "r") as f:
            try:
                productos = json.load(f)
            except:
                productos = []
    productos.append(producto)
    with open(ruta, "w") as f:
        json.dump(productos, f, indent=4)

def leer_de_json():
    ruta = "datos/datos.json"
    if os.path.exists(ruta):
        with open(ruta, "r") as f:
            return json.load(f)
    return []

def guardar_en_csv(producto):
    ruta = "datos/datos.csv"
    existe = os.path.exists(ruta)
    with open(ruta, "a", newline="") as f:
        writer = csv.writer(f)
        if not existe:
            writer.writerow(["nombre", "cantidad", "precio"])
        writer.writerow([producto['nombre'], producto['cantidad'], producto['precio']])

def leer_de_csv():
    ruta = "datos/datos.csv"
    productos = []
    if os.path.exists(ruta):
        with open(ruta, "r") as f:
            reader = csv.DictReader(f)
            for row in reader:
                row_normalizado = {k.lower(): v for k, v in row.items()}
                try:
                    productos.append({
                        "nombre": row_normalizado.get("nombre", ""),
                        "cantidad": int(row_normalizado.get("cantidad", 0)),
                        "precio": float(row_normalizado.get("precio", 0.0))
                    })
                except Exception as e:
                    print("Error procesando fila CSV:", row, e)
    return productos

# ======================================================
# Página principal
# ======================================================
@app.route('/')
def index():
    return render_template('index.html', title='Inicio')

# ======================================================
# Ruta de registro de usuario
# ======================================================
@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegisterForm()
    if form.validate_on_submit():
        # Verificar si el correo ya existe
        existente = Usuario.query.filter_by(correo=form.email.data).first()
        if existente:
            flash("El correo ya está registrado.", "warning")
            return redirect(url_for("register"))

        # Guardar en la base de datos
        nuevo_usuario = Usuario(
            usuario=form.username.data,
            correo=form.email.data,
            password=generate_password_hash(form.password.data)  # Se guarda hasheado
        )
        db.session.add(nuevo_usuario)
        db.session.commit()

        flash("Usuario registrado correctamente. Ahora puedes iniciar sesión.", "success")
        return redirect(url_for("login"))

    return render_template("auth/register.html", title="Registro", form=form)

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        usuario = Usuario.query.filter_by(usuario=form.username.data).first()
        if usuario and check_password_hash(usuario.password, form.password.data):
            login_user(usuario)
            flash("Inicio de sesión exitoso.", "success")
            return redirect(url_for('index'))
        else:
            flash("Usuario o contraseña incorrectos.", "danger")
    return render_template('auth/login.html', title="Iniciar Sesión", form=form)

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Has cerrado sesión.", "info")
    return redirect(url_for('index'))

# ======================================================
# CRUD Productos
# ======================================================
@app.route('/productos')
@login_required
def listar_productos():
    q = request.args.get('q', '').strip()
    if q:
        productos = Producto.query.filter(Producto.nombre.like(f"%{q}%")).all()
    else:
        productos = Producto.query.all()
    return render_template('products/list.html', title='Productos', productos=productos, q=q)

@app.route('/productos/nuevo', methods=['GET', 'POST'])
@login_required
def crear_producto():
    if request.method == 'POST':
        nombre = request.form['nombre']
        cantidad = int(request.form['cantidad'])
        precio = float(request.form['precio'])

        nuevo = Producto(nombre=nombre, cantidad=cantidad, precio=precio)
        db.session.add(nuevo)
        db.session.commit()

        guardar_en_txt({"nombre": nombre, "cantidad": cantidad, "precio": precio})
        guardar_en_json({"nombre": nombre, "cantidad": cantidad, "precio": precio})
        guardar_en_csv({"nombre": nombre, "cantidad": cantidad, "precio": precio})

        flash("Producto agregado correctamente.", "success")
        return redirect(url_for('listar_productos'))

    return render_template('products/form.html', title='Nuevo producto', modo='crear')

@app.route('/productos/<int:pid>/editar', methods=['GET', 'POST'])
@login_required
def editar_producto(pid):
    prod = Producto.query.get(pid)
    if not prod:
        return "Producto no encontrado", 404

    if request.method == 'POST':
        prod.nombre = request.form['nombre']
        prod.cantidad = int(request.form['cantidad'])
        prod.precio = float(request.form['precio'])
        db.session.commit()
        flash("Producto actualizado correctamente.", "success")
        return redirect(url_for('listar_productos'))

    return render_template('products/form.html', title="Editar producto", modo="editar", producto=prod)

@app.route('/productos/<int:pid>/eliminar', methods=['POST'])
@login_required
def eliminar_producto(pid):
    prod = Producto.query.get(pid)
    if prod:
        db.session.delete(prod)
        db.session.commit()
        flash("Producto eliminado correctamente.", "success")
    else:
        flash("Producto no encontrado.", "warning")
    return redirect(url_for('listar_productos'))

# ======================================================
# CRUD para Bebidas
# ======================================================
@app.route('/bebidas')
@login_required
def listar_bebidas():
    bebidas = Bebida.query.all()
    return render_template('bebidas/list.html', title="Bebidas", bebidas=bebidas)

@app.route('/bebidas/nueva', methods=['GET', 'POST'])
@login_required
def crear_bebida():
    if request.method == 'POST':
        nombre = request.form['nombre']
        tamaño = request.form['tamaño']
        precio = float(request.form['precio'])
        nueva = Bebida(nombre=nombre, tamaño=tamaño, precio=precio)
        db.session.add(nueva)
        db.session.commit()
        flash("Bebida agregada correctamente.", "success")
        return redirect(url_for('listar_bebidas'))
    return render_template('bebidas/form.html', title="Nueva Bebida", modo="crear")

@app.route('/bebidas/<int:bid>/editar', methods=['GET', 'POST'])
@login_required
def editar_bebida(bid):
    bebida = Bebida.query.get(bid)
    if not bebida:
        return "Bebida no encontrada", 404
    if request.method == 'POST':
        bebida.nombre = request.form['nombre']
        bebida.tamaño = request.form['tamaño']
        bebida.precio = float(request.form['precio'])
        db.session.commit()
        flash("Bebida actualizada correctamente.", "success")
        return redirect(url_for('listar_bebidas'))
    return render_template('bebidas/form.html', title="Editar Bebida", modo="editar", bebida=bebida)

@app.route('/bebidas/<int:bid>/eliminar', methods=['POST'])
@login_required
def eliminar_bebida(bid):
    bebida = Bebida.query.get(bid)
    if bebida:
        db.session.delete(bebida)
        db.session.commit()
        flash("Bebida eliminada correctamente.", "success")
    else:
        flash("Bebida no encontrada.", "warning")
    return redirect(url_for('listar_bebidas'))

# ======================================================
# CRUD para Clientes
# ======================================================
@app.route('/clientes')
@login_required
def listar_clientes():
    clientes = Cliente.query.all()
    return render_template('clientes/list.html', title="Clientes", clientes=clientes)

@app.route('/clientes/nuevo', methods=['GET', 'POST'])
@login_required
def crear_cliente():
    if request.method == 'POST':
        nombre = request.form['nombre']
        email = request.form['email']
        telefono = request.form['telefono']
        direccion = request.form['direccion']
        nuevo = Cliente(nombre=nombre, email=email, telefono=telefono, direccion=direccion)
        db.session.add(nuevo)
        db.session.commit()
        flash("Cliente registrado correctamente.", "success")
        return redirect(url_for('listar_clientes'))
    return render_template('clientes/form.html', title="Nuevo Cliente", modo="crear")

@app.route('/clientes/<int:cid>/editar', methods=['GET', 'POST'])
@login_required
def editar_cliente(cid):
    cliente = Cliente.query.get(cid)
    if not cliente:
        return "Cliente no encontrado", 404
    if request.method == 'POST':
        cliente.nombre = request.form['nombre']
        cliente.email = request.form['email']
        cliente.telefono = request.form['telefono']
        cliente.direccion = request.form['direccion']
        db.session.commit()
        flash("Cliente actualizado correctamente.", "success")
        return redirect(url_for('listar_clientes'))
    return render_template('clientes/form.html', title="Editar Cliente", modo="editar", cliente=cliente)

@app.route('/clientes/<int:cid>/eliminar', methods=['POST'])
@login_required
def eliminar_cliente(cid):
    cliente = Cliente.query.get(cid)
    if cliente:
        db.session.delete(cliente)
        db.session.commit()
        flash("Cliente eliminado correctamente.", "success")
    else:
        flash("Cliente no encontrado.", "warning")
    return redirect(url_for('listar_clientes'))

# ======================================================
# APIs para ver archivos
# ======================================================
@app.route("/api/txt")
def api_txt():
    return jsonify(leer_de_txt())

@app.route("/api/json")
def api_json():
    return jsonify(leer_de_json())

@app.route("/api/csv")
def api_csv():
    return jsonify(leer_de_csv())

# ======================================================
# Probar conexión con la base de datos
# ======================================================
@app.route('/test_db')
def test_db():
    try:
        result = db.session.execute("SELECT 1").scalar()
        return {"conexion": "exitosa", "resultado": result}
    except Exception as e:
        return {"error": str(e)}

# ======================================================
# Inicializar BD
# ======================================================
with app.app_context():
    db.create_all()

# ======================================================
if __name__ == '__main__':
    app.run(debug=True)
