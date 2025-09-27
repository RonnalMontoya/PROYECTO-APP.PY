-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-09-2025 a las 23:45:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bebida`
--

CREATE TABLE `bebida` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tamaño` varchar(50) NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bebida`
--

INSERT INTO `bebida` (`id`, `nombre`, `tamaño`, `precio`) VALUES
(1, 'Café Espresso', 'Pequeño', 1.5),
(2, 'Café Americano', 'Mediano', 2),
(3, 'Café Cappuccino', 'Grande', 2.8),
(4, 'Chocolate Caliente', 'Mediano', 2.5),
(5, 'Té Verde', 'Mediano', 1.8),
(6, 'Té Negro', 'Grande', 2),
(7, 'Jugo de Naranja', 'Grande', 2.2),
(8, 'Limonada', 'Mediano', 1.9),
(9, 'Agua Mineral', 'Botella 500ml', 1.2),
(10, 'Batido de Fresa', 'Grande', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `nombre`, `email`, `telefono`, `direccion`) VALUES
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `nombre`, `cantidad`, `precio`) VALUES
(1, 'PAN ENROLLADO', 30, 0.3),
(2, 'PAN BRIOLLO', 45, 0.3),
(3, 'PAN DE DULCE', 50, 0.35),
(4, 'Pan Tradicional', 50, 0.25),
(5, 'Torta de Chocolate', 10, 15),
(6, 'Galletas de Vainilla', 100, 0.5),
(7, 'Pan Integral', 40, 0.35),
(8, 'Croissant', 25, 0.8),
(9, 'Donas Glaseadas', 30, 0.6),
(10, 'Bizcocho de Naranja', 12, 1.2),
(11, 'Pan de Queso', 35, 0.5),
(12, 'Brownies', 20, 1.2),
(13, 'Empanadas de Pollo', 18, 1.5),
(14, 'Pastel de Zanahoria', 12, 1.7),
(15, 'Pan de Ajo', 22, 0.7),
(16, 'Muffins de Arándanos', 15, 1.8),
(17, 'Tarta de Manzana', 7, 10),
(18, 'Baguette', 25, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL,
  `rol` enum('admin','usuario') NOT NULL DEFAULT 'usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `correo`, `password`, `rol`) VALUES
(1, 'RonnalMontoya', 'mronnal_4@hotmail.com', 'scrypt:32768:8:1$1yqPGQZf7Xp15MfA$bb049f66dc1ba63c1b52fc83f12fe145d738a9dff6efbec980761d3771561e3116aed2a7dfd0f4361ab7ba0efba2920595f143c92b5c3ca77a45ea91279d08c0', 'admin'),
(2, 'PATRICIA BARZOLA', 'mronnal.4@gmail.com', 'scrypt:32768:8:1$kgDO0IUldLGk8hfs$a323fe0572ba8c8265f2b7db6d006e336bb329158f6ccc009e31e770b5deee4ce0e5615e66a6d41f47c9ef35f08d45dab03a0a992c2ecabe2ac3e6f208ad3b43', 'usuario');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bebida`
--
ALTER TABLE `bebida`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mail` (`correo`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bebida`
--
ALTER TABLE `bebida`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;