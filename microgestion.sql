-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-05-2025 a las 05:46:45
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `microgestion`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_movimientos`
--

CREATE TABLE `categorias_movimientos` (
  `categoria_movimiento_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `nombre_categoria` varchar(50) NOT NULL,
  `tipo_movimiento` enum('ingreso','gasto') NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias_movimientos`
--

INSERT INTO `categorias_movimientos` (`categoria_movimiento_id`, `empresa_id`, `nombre_categoria`, `tipo_movimiento`, `descripcion`, `activa`) VALUES
(1, 1, 'Ventas', 'ingreso', 'Ingresos por venta de productos', 1),
(2, 1, 'Servicios', 'gasto', 'Pago de servicios públicos', 1),
(3, 1, 'Nómina', 'gasto', 'Pagos de salarios', 1),
(4, 1, 'Alquiler', 'gasto', 'Pago de alquiler del local', 1),
(5, 1, 'Inversión', 'gasto', 'Inversiones en el negocio', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_productos`
--

CREATE TABLE `categorias_productos` (
  `categoria_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `nombre_categoria` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias_productos`
--

INSERT INTO `categorias_productos` (`categoria_id`, `empresa_id`, `nombre_categoria`, `descripcion`, `activa`) VALUES
(1, 1, 'Electrónicos', 'Productos electrónicos y dispositivos', 1),
(2, 1, 'Ropa', 'Prendas de vestir', 1),
(3, 1, 'Alimentos', 'Productos alimenticios', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `cliente_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `nombre_cliente` varchar(100) NOT NULL,
  `tipo_documento` enum('CC','NIT','CE','TI','PASAPORTE') NOT NULL DEFAULT 'CC',
  `numero_documento` varchar(20) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(),
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`cliente_id`, `empresa_id`, `nombre_cliente`, `tipo_documento`, `numero_documento`, `direccion`, `telefono`, `email`, `fecha_registro`, `activo`) VALUES
(1, 1, 'Cliente Corporativo', 'NIT', '900123456-7', 'Calle 100 #11-20', '6024445566', 'corporate@example.com', '2025-05-28 20:47:58', 1),
(2, 1, 'Juan Pérez', 'CC', '1234567890', 'Carrera 5 #12-34', '3001112233', 'juan@example.com', '2025-05-28 20:47:58', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos`
--

CREATE TABLE `contactos` (
  `contacto_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `asunto` varchar(100) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` datetime NOT NULL DEFAULT current_timestamp(),
  `leido` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_venta`
--

CREATE TABLE `detalles_venta` (
  `detalle_id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `empresa_id` int(11) NOT NULL,
  `nombre_empresa` varchar(100) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `ciudad` varchar(50) NOT NULL DEFAULT 'Cali',
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(),
  `activa` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`empresa_id`, `nombre_empresa`, `direccion`, `ciudad`, `telefono`, `fecha_registro`, `activa`) VALUES
(1, 'Empresa Demo', 'Carrera 100 #15-20', 'Cali', '6025551234', '2025-05-28 20:36:33', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_financieros`
--

CREATE TABLE `movimientos_financieros` (
  `movimiento_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `categoria_movimiento_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tipo_movimiento` enum('ingreso','gasto') NOT NULL,
  `fecha_movimiento` date NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `referencia` varchar(50) DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `producto_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `codigo_producto` varchar(20) NOT NULL,
  `nombre_producto` varchar(100) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio_compra` decimal(10,2) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `stock_actual` int(11) NOT NULL DEFAULT 0,
  `stock_minimo` int(11) NOT NULL DEFAULT 5,
  `unidad_medida` varchar(20) NOT NULL DEFAULT 'unidad',
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`producto_id`, `empresa_id`, `categoria_id`, `codigo_producto`, `nombre_producto`, `descripcion`, `precio_compra`, `precio_venta`, `stock_actual`, `stock_minimo`, `unidad_medida`, `activo`, `fecha_creacion`) VALUES
(1, 1, 1, 'ELEC-001', 'Smartphone X', 'Teléfono inteligente gama alta', 500.00, 800.00, 10, 3, 'unidad', 1, '2025-05-28 20:36:33'),
(2, 1, 1, 'ELEC-002', 'Tablet Pro', 'Tablet 10 pulgadas', 300.00, 450.00, 15, 5, 'unidad', 1, '2025-05-28 20:36:33'),
(3, 1, 2, 'ROPA-001', 'Camiseta básica', 'Camiseta de algodón', 10.00, 25.00, 50, 10, 'unidad', 1, '2025-05-28 20:36:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usuario_id` int(11) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(),
  `ultimo_acceso` datetime DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `business` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuario_id`, `nombre_completo`, `email`, `password_hash`, `telefono`, `fecha_registro`, `ultimo_acceso`, `activo`, `business`) VALUES
(1, 'Administrador', 'admin@microgestion.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '3000000000', '2025-05-28 20:36:33', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_empresa`
--

CREATE TABLE `usuario_empresa` (
  `usuario_empresa_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `rol` enum('propietario','administrador','empleado') NOT NULL DEFAULT 'empleado',
  `fecha_asignacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_empresa`
--

INSERT INTO `usuario_empresa` (`usuario_empresa_id`, `usuario_id`, `empresa_id`, `rol`, `fecha_asignacion`) VALUES
(1, 1, 1, 'administrador', '2025-05-28 20:36:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `venta_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha_venta` datetime NOT NULL DEFAULT current_timestamp(),
  `subtotal` decimal(10,2) NOT NULL,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','completada','cancelada') NOT NULL DEFAULT 'completada',
  `metodo_pago` enum('efectivo','tarjeta','transferencia','nequi','daviplata') NOT NULL DEFAULT 'efectivo',
  `observaciones` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias_movimientos`
--
ALTER TABLE `categorias_movimientos`
  ADD PRIMARY KEY (`categoria_movimiento_id`),
  ADD UNIQUE KEY `uk_empresa_categoria_mov` (`empresa_id`,`nombre_categoria`,`tipo_movimiento`);

--
-- Indices de la tabla `categorias_productos`
--
ALTER TABLE `categorias_productos`
  ADD PRIMARY KEY (`categoria_id`),
  ADD UNIQUE KEY `uk_empresa_categoria` (`empresa_id`,`nombre_categoria`),
  ADD KEY `idx_nombre_categoria` (`nombre_categoria`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cliente_id`),
  ADD UNIQUE KEY `uk_empresa_documento` (`empresa_id`,`tipo_documento`,`numero_documento`),
  ADD KEY `idx_nombre_cliente` (`nombre_cliente`),
  ADD KEY `idx_numero_documento` (`numero_documento`);

--
-- Indices de la tabla `contactos`
--
ALTER TABLE `contactos`
  ADD PRIMARY KEY (`contacto_id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_fecha_envio` (`fecha_envio`);

--
-- Indices de la tabla `detalles_venta`
--
ALTER TABLE `detalles_venta`
  ADD PRIMARY KEY (`detalle_id`),
  ADD KEY `venta_id` (`venta_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`empresa_id`),
  ADD KEY `idx_nombre_empresa` (`nombre_empresa`);

--
-- Indices de la tabla `movimientos_financieros`
--
ALTER TABLE `movimientos_financieros`
  ADD PRIMARY KEY (`movimiento_id`),
  ADD KEY `empresa_id` (`empresa_id`),
  ADD KEY `categoria_movimiento_id` (`categoria_movimiento_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `idx_tipo_movimiento` (`tipo_movimiento`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`producto_id`),
  ADD UNIQUE KEY `uk_empresa_codigo` (`empresa_id`,`codigo_producto`),
  ADD KEY `categoria_id` (`categoria_id`),
  ADD KEY `idx_nombre_producto` (`nombre_producto`),
  ADD KEY `idx_codigo_producto` (`codigo_producto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`);

--
-- Indices de la tabla `usuario_empresa`
--
ALTER TABLE `usuario_empresa`
  ADD PRIMARY KEY (`usuario_empresa_id`),
  ADD UNIQUE KEY `uk_usuario_empresa` (`usuario_id`,`empresa_id`),
  ADD KEY `empresa_id` (`empresa_id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`venta_id`),
  ADD KEY `empresa_id` (`empresa_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `idx_cliente` (`cliente_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias_movimientos`
--
ALTER TABLE `categorias_movimientos`
  MODIFY `categoria_movimiento_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `categorias_productos`
--
ALTER TABLE `categorias_productos`
  MODIFY `categoria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `cliente_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `contactos`
--
ALTER TABLE `contactos`
  MODIFY `contacto_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalles_venta`
--
ALTER TABLE `detalles_venta`
  MODIFY `detalle_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `empresa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `movimientos_financieros`
--
ALTER TABLE `movimientos_financieros`
  MODIFY `movimiento_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `producto_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuario_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario_empresa`
--
ALTER TABLE `usuario_empresa`
  MODIFY `usuario_empresa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `venta_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categorias_movimientos`
--
ALTER TABLE `categorias_movimientos`
  ADD CONSTRAINT `categorias_movimientos_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `categorias_productos`
--
ALTER TABLE `categorias_productos`
  ADD CONSTRAINT `categorias_productos_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias_productos` (`categoria_id`);

--
-- Filtros para la tabla `usuario_empresa`
--
ALTER TABLE `usuario_empresa`
  ADD CONSTRAINT `usuario_empresa_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usuario_empresa_ibfk_2` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
