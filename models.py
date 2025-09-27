# models.py
from conexion.conexion import db
from flask_login import UserMixin

# =====================================
# Modelo Usuario
# =====================================
class Usuario(UserMixin, db.Model):
    __tablename__ = "usuarios"  
    id = db.Column(db.Integer, primary_key=True)
    usuario = db.Column(db.String(100), nullable=False, unique=True)
    correo = db.Column(db.String(120), nullable=False, unique=True)
    password = db.Column(db.String(200), nullable=False)

    def __repr__(self):
        return f"<Usuario {self.usuario}>"

# =====================================
# Modelo Producto
# =====================================
class Producto(db.Model):
    __tablename__ = "producto"
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    cantidad = db.Column(db.Integer, nullable=False)
    precio = db.Column(db.Float, nullable=False)

    def __repr__(self):
        return f"<Producto {self.nombre}>"

# ==============================
# Modelo de Bebida
# ==============================
class Bebida(db.Model):
    __tablename__ = 'bebida'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    tamaño = db.Column(db.String(50), nullable=False)  # Ej: "Pequeña", "Mediana", "Grande"
    precio = db.Column(db.Float, nullable=False)

    def __repr__(self):
        return f"<Bebida {self.nombre} ({self.tamaño})>"

# ==============================
# Modelo de Cliente
# ==============================
class Cliente(db.Model):
    __tablename__ = 'cliente'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    telefono = db.Column(db.String(20), nullable=True)
    direccion = db.Column(db.String(200), nullable=True)

    def __repr__(self):
        return f"<Cliente {self.nombre}>"