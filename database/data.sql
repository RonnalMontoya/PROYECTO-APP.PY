-- ========================================
-- DATOS PRODUCTOS
-- ========================================
INSERT INTO producto (id, nombre, cantidad, precio) VALUES
(1, 'PAN ARTESANAL', 30, 0.30),
(2, 'PAN BRIOCHE', 40, 0.30),
(3, 'PAN DE DULCE', 50, 0.35),
(4, 'Pan Tradicional', 50, 0.25),
(5, 'Torta de Chocolate', 10, 15.00),
(6, 'Galletas de Vainilla', 100, 0.50),
(7, 'Pan Integral', 40, 0.35),
(8, 'Croissant', 25, 0.80),
(9, 'Donas Glaseadas', 30, 0.60),
(10, 'Bizcocho de Naranja', 12, 1.20),
(11, 'Pan de Queso', 35, 0.75),
(12, 'Brownies', 20, 2.00),
(13, 'Empanadas de Pollo', 18, 1.50),
(14, 'Pastel de Zanahoria', 12, 1.70),
(15, 'Pan de Ajo', 22, 0.70),
(16, 'Muffins de Arándanos', 15, 1.80),
(17, 'Tarta de Manzana', 7, 10.00),
(18, 'Baguette', 25, 1.00);

-- ========================================
-- DATOS BEBIDAS
-- ========================================
INSERT INTO bebida (id, nombre, tamaño, precio) VALUES
(1, 'Café Espresso', 'Pequeño', 1.50),
(2, 'Café Americano', 'Mediano', 2.00),
(3, 'Café Cappuccino', 'Grande', 2.80),
(4, 'Chocolate Caliente', 'Mediano', 2.50),
(5, 'Té Verde', 'Mediano', 1.80),
(6, 'Té Negro', 'Grande', 2.00),
(7, 'Jugo de Naranja', 'Grande', 2.20),
(8, 'Limonada', 'Mediano', 1.90),
(9, 'Agua Mineral', 'Botella 500ml', 1.20),
(10, 'Batido de Fresa', 'Grande', 3.00);

-- ========================================
-- DATOS CLIENTES
-- ========================================
INSERT INTO cliente (id, nombre, email, telefono, direccion) VALUES
(1, 'Carlos Pérez', 'carlos.perez@example.com', '0991111111', 'Av. Quito 123'),
(2, 'María López', 'maria.lopez@example.com', '0992222222', 'Calle Bolívar 456'),
(3, 'José González', 'jose.gonzalez@example.com', '0993333333', 'Av. Guayaquil 789'),
(4, 'Ana Torres', 'ana.torres@example.com', '0994444444', 'Calle Esmeraldas 321'),
(5, 'Luis Martínez', 'luis.martinez@example.com', '0995555555', 'Av. Amazonas 654'),
(6, 'Carmen Ramírez', 'carmen.ramirez@example.com', '0996666666', 'Cdla. Kennedy'),
(7, 'Pedro Herrera', 'pedro.herrera@example.com', '0997777777', 'Av. 9 de Octubre 888'),
(8, 'Laura Jiménez', 'laura.jimenez@example.com', '0998888888', 'Malecón 2000'),
(9, 'Andrés Silva', 'andres.silva@example.com', '0999999999', 'Calle Chile 456'),
(10, 'Rosa Fernández', 'rosa.fernandez@example.com', '0981111111', 'Av. Centenario 741'),
(11, 'Jorge Castro', 'jorge.castro@example.com', '0982222222', 'Av. Portete 159'),
(12, 'Gabriela Muñoz', 'gabriela.munoz@example.com', '0983333333', 'Cdla. Alborada'),
(13, 'David Sánchez', 'david.sanchez@example.com', '0984444444', 'Calle Vargas 951'),
(14, 'Isabel Morales', 'isabel.morales@example.com', '0985555555', 'Av. Barcelona 123'),
(15, 'Fernando Ríos', 'fernando.rios@example.com', '0986666666', 'Cdla. Sauces 4'),
(16, 'Patricia Salazar', 'patricia.salazar@example.com', '0987777777', 'Calle Tungurahua 159'),
(17, 'Diego Delgado', 'diego.delgado@example.com', '0988888888', 'Av. Quito Sur 852'),
(18, 'Andrea Ortiz', 'andrea.ortiz@example.com', '0989999999', 'Cdla. Urdesa'),
(19, 'Miguel Castro', 'miguel.castro@example.com', '0971111111', 'Calle Rocafuerte 456'),
(20, 'Daniela Vega', 'daniela.vega@example.com', '0972222222', 'Cdla. Ceibos'),
(21, 'Francisco Cedeño', 'francisco.cedeno@example.com', '0973333333', 'Av. Machala 963'),
(22, 'Elena Viteri', 'elena.viteri@example.com', '0974444444', 'Cdla. Samborondón'),
(23, 'Hugo Cabrera', 'hugo.cabrera@example.com', '0975555555', 'Av. Daule 753'),
(24, 'Silvia Paredes', 'silvia.paredes@example.com', '0976666666', 'Cdla. Garzota'),
(25, 'Raúl Villacís', 'raul.villacis@example.com', '0977777777', 'Calle Cuenca 258');
