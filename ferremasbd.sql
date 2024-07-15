-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-07-2024 a las 02:42:16
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
-- Base de datos: `ferremasbd`
--
CREATE DATABASE IF NOT EXISTS `ferremasbd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ferremasbd`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `FiltrarPedidosEntregados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `FiltrarPedidosEntregados` (IN `mes` INT, IN `anio` INT)   BEGIN
    SELECT 
        p.id, 
        p.numero, 
        p.fecha, 
        p.carrito_id,
        s.descripcion AS estado,
        p.apellido,
        COALESCE(c.nombreComuna, 'N/A') AS nombreComuna,
        p.correo,
        COALESCE(p.direccion, 'N/A') AS direccion,
        p.nombre,
        COALESCE(r.nombreRegion, 'N/A') AS nombreRegion,
        p.sucursal_id,
        p.run,
        p.tipo_entrega,
        SUM(ip.cantidad * prod.precioProducto) AS total_pagado
    FROM core_pedido p
    JOIN core_seguimiento s ON p.estado_id = s.id
    LEFT JOIN core_comuna c ON p.comuna_id = c.idComuna  
    LEFT JOIN core_region r ON p.region_id = r.idRegion
    JOIN core_itempedido ip ON p.id = ip.pedido_id
    JOIN core_producto prod ON ip.producto_id = prod.idProducto
    WHERE s.id = 4
    AND (mes IS NULL OR mes = 0 OR MONTH(p.fecha) = mes)
    AND (anio IS NULL OR anio = 0 OR YEAR(p.fecha) = anio)
    GROUP BY p.id;
END$$

DROP PROCEDURE IF EXISTS `SP_DELETE_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DELETE_PRODUCTO` (IN `p_idProducto` INT)   BEGIN
    DELETE FROM core_producto
    WHERE idProducto = p_idProducto;
END$$

DROP PROCEDURE IF EXISTS `SP_DELETE_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DELETE_USUARIO` (IN `p_idUsuario` INT)   BEGIN

    DELETE FROM core_usuariocustom WHERE core_usuariocustom.id = p_idUsuario;
    
END$$

DROP PROCEDURE IF EXISTS `SP_GET_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GET_PRODUCTO` (IN `p_idProducto` INT)  NO SQL SELECT * FROM core_producto 
WHERE idProducto = p_idProducto$$

DROP PROCEDURE IF EXISTS `SP_GET_PRODUCTOS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GET_PRODUCTOS` (OUT `p_out` INT)  NO SQL SELECT * FROM core_producto$$

DROP PROCEDURE IF EXISTS `SP_GET_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GET_USUARIO` (IN `p_idUsuario` INT)  NO SQL SELECT * FROM core_usuariocustom
WHERE id = p_idUsuario$$

DROP PROCEDURE IF EXISTS `SP_GET_USUARIOS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GET_USUARIOS` (OUT `p_out` INT)  NO SQL SELECT u.id,
	   u.username,
       u.run,
       u.pnombre,
       u.ap_paterno,
       u.correo_usuario,
       c.nombreComuna,
       r.nombreRol
FROM core_usuariocustom u
JOIN core_rolusuario r
   ON u.idRol_id = r.idRol
JOIN core_comuna c
	ON u.idComuna_id = c.idComuna$$

DROP PROCEDURE IF EXISTS `SP_POST_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_POST_PRODUCTO` (IN `nombreProducto` LONGTEXT, IN `precioProducto` INT, IN `stockProducto` INT, IN `imagenProducto` VARCHAR(255), IN `descripcionProducto` LONGTEXT, IN `idcategoriaProducto` INT, IN `idMarca` INT)  NO SQL BEGIN
    INSERT INTO core_producto (
        nombreProducto,
        precioProducto,
        stockProducto,
        imagenProducto,
        descripcionProducto,
        idcategoriaProducto_id,
        idMarca_id
    ) VALUES (
        nombreProducto,
        precioProducto,
        stockProducto,
        imagenProducto,
        descripcionProducto,
        idcategoriaProducto,
        idMarca
    );
END$$

DROP PROCEDURE IF EXISTS `SP_POST_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_POST_USUARIO` (IN `p_username` VARCHAR(150), IN `p_run` VARCHAR(12), IN `p_pnombre` VARCHAR(20), IN `p_ap_paterno` VARCHAR(24), IN `p_correo_usuario` VARCHAR(254), IN `p_fecha_nacimiento` DATE, IN `p_direccion` VARCHAR(100), IN `p_idComuna` INT, IN `p_idRol` INT, IN `p_password` VARCHAR(255))   BEGIN
    INSERT INTO core_usuariocustom (username, password, run, pnombre, ap_paterno, correo_usuario, fecha_nacimiento, direccion, idRol_id, idComuna_id)
    VALUES (p_username, p_password, p_run, p_pnombre, p_ap_paterno, p_correo_usuario, p_fecha_nacimiento, p_direccion, p_idRol, p_idComuna);
    
END$$

DROP PROCEDURE IF EXISTS `SP_PUT_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PUT_PRODUCTO` (IN `p_idProducto` INT, IN `p_nombreProducto` LONGTEXT, IN `p_precioProducto` DECIMAL(10,0), IN `p_stockProducto` INT, IN `p_imagenProducto` VARCHAR(255), IN `p_descripcionProducto` LONGTEXT, IN `p_idMarca` INT, IN `p_idcategoriaProducto` INT)   BEGIN
    UPDATE core_producto
    SET nombreProducto = p_nombreProducto,
        precioProducto = p_precioProducto,
        stockProducto = p_stockProducto,
        imagenProducto = p_imagenProducto,
        descripcionProducto = p_descripcionProducto,
        idMarca_id = p_idMarca,
        idcategoriaProducto_id = p_idcategoriaProducto
    WHERE idProducto = p_idProducto;
END$$

DROP PROCEDURE IF EXISTS `SP_PUT_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PUT_USUARIO` (IN `p_id` INT, IN `p_username` VARCHAR(100), IN `p_run` VARCHAR(50), IN `p_pnombre` VARCHAR(100), IN `p_ap_paterno` VARCHAR(100), IN `p_correo_usuario` VARCHAR(100), IN `p_fecha_nacimiento` DATE, IN `p_direccion` VARCHAR(255), IN `p_idComuna` INT, IN `p_idRol` INT)   BEGIN
    UPDATE core_usuariocustom
    SET 
    	core_usuariocustom.username = p_username,
        core_usuariocustom.run = p_run,
        core_usuariocustom.pnombre = p_pnombre,
        core_usuariocustom.ap_paterno = p_ap_paterno,
        core_usuariocustom.correo_usuario = p_correo_usuario,
        core_usuariocustom.fecha_nacimiento = p_fecha_nacimiento,
        core_usuariocustom.direccion = p_direccion,
        core_usuariocustom.idComuna_id = p_idComuna,
        core_usuariocustom.idRol_id = p_idRol
    WHERE core_usuariocustom.id = p_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add categoria producto', 6, 'add_categoriaproducto'),
(22, 'Can change categoria producto', 6, 'change_categoriaproducto'),
(23, 'Can delete categoria producto', 6, 'delete_categoriaproducto'),
(24, 'Can view categoria producto', 6, 'view_categoriaproducto'),
(25, 'Can add comuna', 7, 'add_comuna'),
(26, 'Can change comuna', 7, 'change_comuna'),
(27, 'Can delete comuna', 7, 'delete_comuna'),
(28, 'Can view comuna', 7, 'view_comuna'),
(29, 'Can add marca', 8, 'add_marca'),
(30, 'Can change marca', 8, 'change_marca'),
(31, 'Can delete marca', 8, 'delete_marca'),
(32, 'Can view marca', 8, 'view_marca'),
(33, 'Can add region', 9, 'add_region'),
(34, 'Can change region', 9, 'change_region'),
(35, 'Can delete region', 9, 'delete_region'),
(36, 'Can view region', 9, 'view_region'),
(37, 'Can add rol usuario', 10, 'add_rolusuario'),
(38, 'Can change rol usuario', 10, 'change_rolusuario'),
(39, 'Can delete rol usuario', 10, 'delete_rolusuario'),
(40, 'Can view rol usuario', 10, 'view_rolusuario'),
(41, 'Can add sucursal', 11, 'add_sucursal'),
(42, 'Can change sucursal', 11, 'change_sucursal'),
(43, 'Can delete sucursal', 11, 'delete_sucursal'),
(44, 'Can view sucursal', 11, 'view_sucursal'),
(45, 'Can add producto', 12, 'add_producto'),
(46, 'Can change producto', 12, 'change_producto'),
(47, 'Can delete producto', 12, 'delete_producto'),
(48, 'Can view producto', 12, 'view_producto'),
(49, 'Can add user', 13, 'add_usuariocustom'),
(50, 'Can change user', 13, 'change_usuariocustom'),
(51, 'Can delete user', 13, 'delete_usuariocustom'),
(52, 'Can view user', 13, 'view_usuariocustom'),
(53, 'Can add pedido', 14, 'add_pedido'),
(54, 'Can change pedido', 14, 'change_pedido'),
(55, 'Can delete pedido', 14, 'delete_pedido'),
(56, 'Can view pedido', 14, 'view_pedido'),
(57, 'Can add item carrito', 15, 'add_itemcarrito'),
(58, 'Can change item carrito', 15, 'change_itemcarrito'),
(59, 'Can delete item carrito', 15, 'delete_itemcarrito'),
(60, 'Can view item carrito', 15, 'view_itemcarrito'),
(61, 'Can add seguimiento', 16, 'add_seguimiento'),
(62, 'Can change seguimiento', 16, 'change_seguimiento'),
(63, 'Can delete seguimiento', 16, 'delete_seguimiento'),
(64, 'Can view seguimiento', 16, 'view_seguimiento'),
(65, 'Can add carrito', 17, 'add_carrito'),
(66, 'Can change carrito', 17, 'change_carrito'),
(67, 'Can delete carrito', 17, 'delete_carrito'),
(68, 'Can view carrito', 17, 'view_carrito'),
(69, 'Can add item pedido', 18, 'add_itempedido'),
(70, 'Can change item pedido', 18, 'change_itempedido'),
(71, 'Can delete item pedido', 18, 'delete_itempedido'),
(72, 'Can view item pedido', 18, 'view_itempedido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_carrito`
--

DROP TABLE IF EXISTS `core_carrito`;
CREATE TABLE `core_carrito` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_carrito`
--

INSERT INTO `core_carrito` (`id`, `usuario_id`) VALUES
(3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_categoriaproducto`
--

DROP TABLE IF EXISTS `core_categoriaproducto`;
CREATE TABLE `core_categoriaproducto` (
  `idcategoriaProducto` int(11) NOT NULL,
  `nombrecategoriaProducto` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_categoriaproducto`
--

INSERT INTO `core_categoriaproducto` (`idcategoriaProducto`, `nombrecategoriaProducto`) VALUES
(1, 'Herramientas Manuales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_comuna`
--

DROP TABLE IF EXISTS `core_comuna`;
CREATE TABLE `core_comuna` (
  `idComuna` int(11) NOT NULL,
  `nombreComuna` varchar(80) NOT NULL,
  `idRegion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_comuna`
--

INSERT INTO `core_comuna` (`idComuna`, `nombreComuna`, `idRegion_id`) VALUES
(1, 'Puente Alto', 1),
(2, 'La Florida', 1),
(3, 'Alhué', 1),
(4, 'Cerrillos', 1),
(5, 'Cerro Navia', 1),
(6, 'Conchalí', 1),
(7, 'El Bosque', 1),
(8, 'Estación Central', 1),
(9, 'Huechuraba', 1),
(10, 'Independencia', 1),
(11, 'La Cisterna', 1),
(12, 'La Granja', 1),
(13, 'La Pintana', 1),
(14, 'La Reina', 1),
(15, 'Las Condes', 1),
(16, 'Lo Barnechea', 1),
(17, 'Lo Espejo', 1),
(18, 'Lo Prado', 1),
(19, 'Macul', 1),
(20, 'Maipú', 1),
(21, 'Ñuñoa', 1),
(22, 'Pedro Aguirre Cerda', 1),
(23, 'Peñalolén', 1),
(24, 'Providencia', 1),
(25, 'Pudahuel', 1),
(26, 'Quilicura', 1),
(27, 'Quinta Normal', 1),
(28, 'Recoleta', 1),
(29, 'Renca', 1),
(30, 'San Joaquín', 1),
(31, 'San Miguel', 1),
(32, 'San Ramón', 1),
(33, 'Santiago', 1),
(34, 'Vitacura', 1),
(35, 'Pirque', 1),
(36, 'San José de Maipo', 1),
(37, 'Colina', 1),
(38, 'Lampa', 1),
(39, 'Tiltil', 1),
(40, 'San Bernardo', 1),
(41, 'Buin', 1),
(42, 'Calera de Tango', 1),
(43, 'Paine', 1),
(44, 'Melipilla', 1),
(45, 'Curacaví', 1),
(46, 'María Pinto', 1),
(47, 'San Pedro', 1),
(48, 'Talagante', 1),
(49, 'El Monte', 1),
(50, 'Isla de Maipo', 1),
(51, 'Padre Hurtado', 1),
(52, 'Peñaflor', 1),
(53, 'Arica', 2),
(54, 'Camarones', 2),
(55, 'Putre', 2),
(56, 'General Lagos', 2),
(57, 'Iquique', 3),
(58, 'Alto Hospicio', 3),
(59, 'Pozo Almonte', 3),
(60, 'Camiña', 3),
(61, 'Colchane', 3),
(62, 'Huara', 3),
(63, 'Pica', 3),
(64, 'Antofagasta', 4),
(65, 'Mejillones', 4),
(66, 'Sierra Gorda', 4),
(67, 'Taltal', 4),
(68, 'Calama', 4),
(69, 'Ollagüe', 4),
(70, 'San Pedro de Atacama', 4),
(71, 'Tocopilla', 4),
(72, 'María Elena', 4),
(73, 'Copiapó', 5),
(74, 'Caldera', 5),
(75, 'Tierra Amarilla', 5),
(76, 'Chañaral', 5),
(77, 'Diego de Almagro', 5),
(78, 'Vallenar', 5),
(79, 'Alto del Carmen', 5),
(80, 'Freirina', 5),
(81, 'Huasco', 5),
(82, 'La Serena', 6),
(83, 'Coquimbo', 6),
(84, 'Andacollo', 6),
(85, 'La Higuera', 6),
(86, 'Paiguano', 6),
(87, 'Vicuña', 6),
(88, 'Illapel', 6),
(89, 'Canela', 6),
(90, 'Los Vilos', 6),
(91, 'Salamanca', 6),
(92, 'Ovalle', 6),
(93, 'Combarbalá', 6),
(94, 'Monte Patria', 6),
(95, 'Punitaqui', 6),
(96, 'Río Hurtado', 6),
(97, 'Valparaíso', 7),
(98, 'Casablanca', 7),
(99, 'Concón', 7),
(100, 'Juan Fernández', 7),
(101, 'Puchuncaví', 7),
(102, 'Quintero', 7),
(103, 'Viña del Mar', 7),
(104, 'Isla de Pascua', 7),
(105, 'Los Andes', 7),
(106, 'Calle Larga', 7),
(107, 'Rinconada', 7),
(108, 'San Esteban', 7),
(109, 'La Ligua', 7),
(110, 'Cabildo', 7),
(111, 'Papudo', 7),
(112, 'Petorca', 7),
(113, 'Zapallar', 7),
(114, 'Quillota', 7),
(115, 'Calera', 7),
(116, 'Hijuelas', 7),
(117, 'La Cruz', 7),
(118, 'Nogales', 7),
(119, 'San Antonio', 7),
(120, 'Algarrobo', 7),
(121, 'Cartagena', 7),
(122, 'El Quisco', 7),
(123, 'El Tabo', 7),
(124, 'Santo Domingo', 7),
(125, 'San Felipe', 7),
(126, 'Catemu', 7),
(127, 'Llaillay', 7),
(128, 'Panquehue', 7),
(129, 'Putaendo', 7),
(130, 'Santa María', 7),
(131, 'Quilpué', 7),
(132, 'Limache', 7),
(133, 'Olmué', 7),
(134, 'Villa Alemana', 7),
(135, 'Rancagua', 8),
(136, 'Codegua', 8),
(137, 'Coinco', 8),
(138, 'Coltauco', 8),
(139, 'Doñihue', 8),
(140, 'Graneros', 8),
(141, 'Las Cabras', 8),
(142, 'Machalí', 8),
(143, 'Malloa', 8),
(144, 'Mostazal', 8),
(145, 'Olivar', 8),
(146, 'Peumo', 8),
(147, 'Pichidegua', 8),
(148, 'Quinta de Tilcoco', 8),
(149, 'Rengo', 8),
(150, 'Requínoa', 8),
(151, 'San Vicente', 8),
(152, 'Pichilemu', 8),
(153, 'La Estrella', 8),
(154, 'Litueche', 8),
(155, 'Marchihue', 8),
(156, 'Navidad', 8),
(157, 'Paredones', 8),
(158, 'San Fernando', 8),
(159, 'Chépica', 8),
(160, 'Chimbarongo', 8),
(161, 'Lolol', 8),
(162, 'Nancagua', 8),
(163, 'Palmilla', 8),
(164, 'Peralillo', 8),
(165, 'Placilla', 8),
(166, 'Pumanque', 8),
(167, 'Santa Cruz', 8),
(168, 'Talca', 9),
(169, 'ConsVtitución', 9),
(170, 'Curepto', 9),
(171, 'Empedrado', 9),
(172, 'Maule', 9),
(173, 'Pelarco', 9),
(174, 'Pencahue', 9),
(175, 'Río Claro', 9),
(176, 'San Clemente', 9),
(177, 'San Rafael', 9),
(178, 'Cauquenes', 9),
(179, 'Chanco', 9),
(180, 'Pelluhue', 9),
(181, 'Curicó', 9),
(182, 'Hualañé', 9),
(183, 'Licantén', 9),
(184, 'Molina', 9),
(185, 'Rauco', 9),
(186, 'Romeral', 9),
(187, 'Sagrada Familia', 9),
(188, 'Teno', 9),
(189, 'Vichuquén', 9),
(190, 'Linares', 9),
(191, 'Colbún', 9),
(192, 'Longaví', 9),
(193, 'Parral', 9),
(194, 'Retiro', 9),
(195, 'San Javier', 9),
(196, 'Villa Alegre', 9),
(197, 'Yerbas Buenas', 9),
(198, 'Chillán', 10),
(199, 'Bulnes', 10),
(200, 'Cobquecura', 10),
(201, 'Coelemu', 10),
(202, 'Coihueco', 10),
(203, 'Chillán Viejo', 10),
(204, 'El Carmen', 10),
(205, 'Ninhue', 10),
(206, 'Ñiquén', 10),
(207, 'Pemuco', 10),
(208, 'Pinto', 10),
(209, 'Portezuelo', 10),
(210, 'Quillón', 10),
(211, 'Quirihue', 10),
(212, 'Ránquil', 10),
(213, 'San Carlos', 10),
(214, 'San Fabián', 10),
(215, 'San Ignacio', 10),
(216, 'San Nicolás', 10),
(217, 'Treguaco', 10),
(218, 'Yungay', 10),
(219, 'Temuco', 11),
(220, 'Carahue', 11),
(221, 'Cunco', 11),
(222, 'Curarrehue', 11),
(223, 'Freire', 11),
(224, 'Galvarino', 11),
(225, 'Gorbea', 11),
(226, 'Lautaro', 11),
(227, 'Loncoche', 11),
(228, 'Melipeuco', 11),
(229, 'Nueva Imperial', 11),
(230, 'Padre Las Casas', 11),
(231, 'Perquenco', 11),
(232, 'Pitrufquén', 11),
(233, 'Pucón', 11),
(234, 'Saavedra', 11),
(235, 'Teodoro Schmidt', 11),
(236, 'Toltén', 11),
(237, 'Vilcún', 11),
(238, 'Villarrica', 11),
(239, 'Cholchol', 11),
(240, 'Angol', 11),
(241, 'Collipulli', 11),
(242, 'Curacautín', 11),
(243, 'Ercilla', 11),
(244, 'Lonquimay', 11),
(245, 'Los Sauces', 11),
(246, 'Lumaco', 11),
(247, 'Purén', 11),
(248, 'Renaico', 11),
(249, 'Traiguén', 11),
(250, 'Victoria', 11),
(251, 'Valdivia', 12),
(252, 'Corral', 12),
(253, 'Lanco', 12),
(254, 'Los Lagos', 12),
(255, 'Máfil', 12),
(256, 'Mariquina', 12),
(257, 'Paillaco', 12),
(258, 'Panguipulli', 12),
(261, 'Puerto Montt', 13),
(262, 'Calbuco', 13),
(263, 'Cochamó', 13),
(264, 'Fresia', 13),
(265, 'Frutillar', 13),
(266, 'Los Muermos', 13),
(267, 'Llanquihue', 13),
(268, 'Maullín', 13),
(269, 'Puerto Varas', 13),
(270, 'Castro', 13),
(271, 'Ancud', 13),
(272, 'Chonchi', 13),
(273, 'Curaco de Vélez', 13),
(274, 'Dalcahue', 13),
(275, 'Puqueldón', 13),
(276, 'Queilén', 13),
(277, 'Quellón', 13),
(278, 'Quemchi', 13),
(279, 'Quinchao', 13),
(280, 'Coyhaique', 14),
(281, 'Lago Verde', 14),
(282, 'Aysén', 14),
(283, 'Cisnes', 14),
(284, 'Guaitecas', 14),
(285, 'Cochrane', 14),
(286, 'O’Higgins', 14),
(287, 'Tortel', 14),
(288, 'Punta Arenas', 15),
(289, 'Laguna Blanca', 15),
(290, 'Río Verde', 15),
(291, 'San Gregorio', 15),
(292, 'Cabo de Hornos', 15),
(293, 'Porvenir', 15),
(294, 'Primavera', 15),
(295, 'Timaukel', 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_itemcarrito`
--

DROP TABLE IF EXISTS `core_itemcarrito`;
CREATE TABLE `core_itemcarrito` (
  `id` int(11) NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL CHECK (`cantidad` >= 0),
  `carrito_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_itempedido`
--

DROP TABLE IF EXISTS `core_itempedido`;
CREATE TABLE `core_itempedido` (
  `id` int(11) NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL CHECK (`cantidad` >= 0),
  `pedido_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_itempedido`
--

INSERT INTO `core_itempedido` (`id`, `cantidad`, `pedido_id`, `producto_id`) VALUES
(38, 2, 33, 10),
(39, 1, 34, 10),
(40, 1, 35, 10),
(45, 1, 40, 10),
(46, 1, 41, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_marca`
--

DROP TABLE IF EXISTS `core_marca`;
CREATE TABLE `core_marca` (
  `idMarca` int(11) NOT NULL,
  `nombreMarca` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_marca`
--

INSERT INTO `core_marca` (`idMarca`, `nombreMarca`) VALUES
(1, 'Bosh'),
(2, 'Sika');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_pedido`
--

DROP TABLE IF EXISTS `core_pedido`;
CREATE TABLE `core_pedido` (
  `id` int(11) NOT NULL,
  `numero` varchar(36) NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `carrito_id` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL,
  `apellido` varchar(24) DEFAULT NULL,
  `comuna_id` int(11) DEFAULT NULL,
  `correo` varchar(254) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `run` varchar(12) DEFAULT NULL,
  `tipo_entrega` varchar(20) NOT NULL,
  `comprobante_pago` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_pedido`
--

INSERT INTO `core_pedido` (`id`, `numero`, `fecha`, `carrito_id`, `estado_id`, `apellido`, `comuna_id`, `correo`, `direccion`, `nombre`, `region_id`, `sucursal_id`, `run`, `tipo_entrega`, `comprobante_pago`) VALUES
(33, 'b59035a7-6f56-49ed-b568-7786b315025b', '2024-06-27 02:12:45.710856', 3, 4, 'Albornoz', 1, 'ex.albornoz@duocuc.cl', 'Millantu 123', 'Exequiel', 1, NULL, NULL, 'envio_domicilio', 'comprobantes/mountains-sunset-clean-skyline.jpg'),
(34, '3e43a279-2500-4bfa-b5cb-b600828c29d6', '2024-06-27 02:33:29.002362', 3, 1, 'Albornoz', 14, 'ex.albornoz@duocuc.cl', 'Millantu 123', 'Exequiel', 1, NULL, NULL, 'envio_domicilio', 'comprobantes/FixSpot_Modelo_Lógico.png'),
(35, '96ab5829-8c59-47a9-a070-3378265457ca', '2024-07-14 21:29:55.716945', 3, 1, 'albornoz', 1, 'albornozexequiel01@gmail.com', 'duoc uc puente alto', 'Exequiel Albornoz', 1, NULL, NULL, 'envio_domicilio', 'comprobantes/8f317a6b034e4524972fcab2328526fc.jpg'),
(40, '3a36acdf-739a-40fd-869e-fc2b0aaaa17b', '2024-07-15 00:26:42.137502', 3, 1, 'Albornoz', NULL, NULL, NULL, 'Exequiel', NULL, 2, '21002289-9', 'retiro_tienda', 'comprobantes/8f317a6b034e4524972fcab2328526fc_ufNsXzS.jpg'),
(41, 'fc82cefd-0c3b-4ec4-9b3c-c5386e5c89bf', '2024-07-15 00:28:52.395168', 3, 1, 'Albornoz', NULL, NULL, NULL, 'Exequiel', NULL, 2, '21002289-9', 'retiro_tienda', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_producto`
--

DROP TABLE IF EXISTS `core_producto`;
CREATE TABLE `core_producto` (
  `idProducto` int(11) NOT NULL,
  `nombreProducto` longtext NOT NULL,
  `precioProducto` int(11) NOT NULL,
  `stockProducto` int(11) NOT NULL,
  `imagenProducto` varchar(100) DEFAULT NULL,
  `descripcionProducto` longtext NOT NULL,
  `idMarca_id` int(11) NOT NULL,
  `idcategoriaProducto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_producto`
--

INSERT INTO `core_producto` (`idProducto`, `nombreProducto`, `precioProducto`, `stockProducto`, `imagenProducto`, `descripcionProducto`, `idMarca_id`, `idcategoriaProducto_id`) VALUES
(4, 'Martillo Loco', 100, 0, 'martillo-venta.jpg', 'El martillo es una herramienta versátil diseñada para golpear clavos y otros materiales.', 1, 1),
(6, 'Martillo de felix el reparador', 140, 8, 'descarga.jpg', 'Martillo de Félix el reparador máximo golpeador, bélico, mastodonte, duro, fuerte, etc.', 1, 1),
(9, 'Kit guía de perforación', 230, 11, 'kit guia de perforacion.jpg', 'El sistema permite conectar sus piezas de trabajo rápida y oportunamente, facilitando el ensamblaje y mejorando la eficiencia.', 1, 1),
(10, 'Presa tipo C', 140, 25, 'Prensa tipo c.jpg', 'Prensa Tipo C Puntas Giratorias 18SP™ 18 pulgadas / 455 mm.', 1, 1),
(11, 'Lijadora Orbital', 122, 29, 'Lijadora orbital.jpg', 'Herramienta eléctrica que lija superficies de manera uniforme y eficiente, ideal para trabajos de lijado fino y preparación de superficies.', 2, 1),
(12, 'Cinta Metrica', 114, 67, 'Cinta metrica.png', 'Es una herramienta de medición esencial, ideal para tomar medidas precisas de longitud de manera rápida y fácil.', 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_region`
--

DROP TABLE IF EXISTS `core_region`;
CREATE TABLE `core_region` (
  `idRegion` int(11) NOT NULL,
  `nombreRegion` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_region`
--

INSERT INTO `core_region` (`idRegion`, `nombreRegion`) VALUES
(1, 'Metropolitana'),
(2, 'Arica y Parinacota'),
(3, 'Tarapacá'),
(4, 'Antofagasta'),
(5, 'Atacama'),
(6, 'Coquimbo'),
(7, 'Valparaíso'),
(8, 'O´Higgins'),
(9, 'Maule'),
(10, 'Ñuble'),
(11, 'La Araucanía'),
(12, 'Los Ríos'),
(13, 'Los Lagos'),
(14, 'Aysen'),
(15, 'Magallanes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_rolusuario`
--

DROP TABLE IF EXISTS `core_rolusuario`;
CREATE TABLE `core_rolusuario` (
  `idRol` int(11) NOT NULL,
  `nombreRol` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_rolusuario`
--

INSERT INTO `core_rolusuario` (`idRol`, `nombreRol`) VALUES
(1, 'Cliente'),
(2, 'Vendedor'),
(3, 'Bodeguero'),
(4, 'Contador'),
(5, 'Administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_seguimiento`
--

DROP TABLE IF EXISTS `core_seguimiento`;
CREATE TABLE `core_seguimiento` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_seguimiento`
--

INSERT INTO `core_seguimiento` (`id`, `descripcion`) VALUES
(1, 'En preparación'),
(2, 'Listo para envío'),
(3, 'En reparto'),
(4, 'Entregado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_sucursal`
--

DROP TABLE IF EXISTS `core_sucursal`;
CREATE TABLE `core_sucursal` (
  `idSucursal` int(11) NOT NULL,
  `nombreSucursal` varchar(50) NOT NULL,
  `direccionSucursal` varchar(60) NOT NULL,
  `idComuna_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_sucursal`
--

INSERT INTO `core_sucursal` (`idSucursal`, `nombreSucursal`, `direccionSucursal`, `idComuna_id`) VALUES
(1, 'Surcursal Santiago', 'La Alameda 555', 33),
(2, 'Surcursal La Florida', 'Pedregal 111', 2),
(3, 'Surcursal Providencia', 'Nueva Providencia 123', 24);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_usuariocustom`
--

DROP TABLE IF EXISTS `core_usuariocustom`;
CREATE TABLE `core_usuariocustom` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `run` varchar(12) NOT NULL,
  `pnombre` varchar(20) NOT NULL,
  `snombre` varchar(20) NOT NULL,
  `ap_paterno` varchar(24) NOT NULL,
  `ap_materno` varchar(24) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `direccion` varchar(100) NOT NULL,
  `idComuna_id` int(11) DEFAULT NULL,
  `idRol_id` int(11) DEFAULT NULL,
  `correo_usuario` varchar(254) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_usuariocustom`
--

INSERT INTO `core_usuariocustom` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `run`, `pnombre`, `snombre`, `ap_paterno`, `ap_materno`, `fecha_nacimiento`, `direccion`, `idComuna_id`, `idRol_id`, `correo_usuario`) VALUES
(1, 'pbkdf2_sha256$720000$7Q8saaNQdeVOvXL4gDhOr5$OLOEPdLem2ju9gstivFv+G/lZ4HsITesexG6ku6n1us=', '2024-07-14 22:56:07.269098', 1, 'admin', '', '', 'soporte.ferremas@gmail.com', 1, 1, '2024-05-13 19:58:21.484730', '10.001.100-1', 'Admin', '', 'Supremo', '', '2024-06-06', 'Admins 111', 1, 5, 'soporte.ferremas@gmail.com'),
(35, 'pbkdf2_sha256$216000$y5Ygqec9gC4o$Gnz4fu1qnTs5DDVErNSk0odj+l7t4h6INf6L+/im+hw=', NULL, 0, 'Juan', '', '', 'albornozexequiel01@gmail.com', 0, 1, '2024-05-27 00:51:55.067229', '99.111.999-1', 'Juan', '', 'Callabo', '', '2002-02-01', 'Millantu 123', 1, 1, 'albornozexequiel01@gmail.com'),
(36, 'pbkdf2_sha256$216000$XlYqlH3qPtso$YsL+pzOMee7koRoPtu+kp5fFQk3JDf3RlSrwyVoa28Y=', NULL, 0, 'Jairo', '', '', 'jairoman.number1@gmail.com', 0, 1, '2024-05-27 02:23:19.451079', '21.383.203-4', 'Jairo', '', 'Marin', '', '2003-09-05', 'El canelo calle 2', 36, 1, 'jairoman.number1@gmail.com'),
(37, 'pbkdf2_sha256$720000$jhhfZ11rA0E7Ovn3rpzeVJ$8IuKPPD8Dw7Yd9jBps9zdAZdGRpNCn/bj/Nz2xFxr1U=', '2024-07-15 00:40:29.951069', 0, 'Jeffrey', '', '', '', 0, 1, '2024-07-15 00:39:04.592865', '21555654-4', 'Jeffrey', '', 'Ramirez', '', '2003-01-01', 'San Francisco 123', 32, 4, 'jeff.ramirez@duocuc.cl');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_usuariocustom_groups`
--

DROP TABLE IF EXISTS `core_usuariocustom_groups`;
CREATE TABLE `core_usuariocustom_groups` (
  `id` int(11) NOT NULL,
  `usuariocustom_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_usuariocustom_user_permissions`
--

DROP TABLE IF EXISTS `core_usuariocustom_user_permissions`;
CREATE TABLE `core_usuariocustom_user_permissions` (
  `id` int(11) NOT NULL,
  `usuariocustom_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(17, 'core', 'carrito'),
(6, 'core', 'categoriaproducto'),
(7, 'core', 'comuna'),
(15, 'core', 'itemcarrito'),
(18, 'core', 'itempedido'),
(8, 'core', 'marca'),
(14, 'core', 'pedido'),
(12, 'core', 'producto'),
(9, 'core', 'region'),
(10, 'core', 'rolusuario'),
(16, 'core', 'seguimiento'),
(11, 'core', 'sucursal'),
(13, 'core', 'usuariocustom'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-05-13 19:46:05.794764'),
(2, 'contenttypes', '0002_remove_content_type_name', '2024-05-13 19:46:05.830970'),
(3, 'auth', '0001_initial', '2024-05-13 19:46:05.872379'),
(4, 'auth', '0002_alter_permission_name_max_length', '2024-05-13 19:46:05.986979'),
(5, 'auth', '0003_alter_user_email_max_length', '2024-05-13 19:46:05.993495'),
(6, 'auth', '0004_alter_user_username_opts', '2024-05-13 19:46:05.998566'),
(7, 'auth', '0005_alter_user_last_login_null', '2024-05-13 19:46:06.004049'),
(8, 'auth', '0006_require_contenttypes_0002', '2024-05-13 19:46:06.006067'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2024-05-13 19:46:06.011984'),
(10, 'auth', '0008_alter_user_username_max_length', '2024-05-13 19:46:06.017356'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2024-05-13 19:46:06.022915'),
(12, 'auth', '0010_alter_group_name_max_length', '2024-05-13 19:46:06.031083'),
(13, 'auth', '0011_update_proxy_permissions', '2024-05-13 19:46:06.036695'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2024-05-13 19:46:06.041238'),
(15, 'core', '0001_initial', '2024-05-13 19:46:06.153764'),
(16, 'admin', '0001_initial', '2024-05-13 19:46:06.389461'),
(17, 'admin', '0002_logentry_remove_auto_add', '2024-05-13 19:46:06.439383'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2024-05-13 19:46:06.450593'),
(19, 'core', '0002_auto_20240512_2210', '2024-05-13 19:46:06.480927'),
(20, 'core', '0003_auto_20240513_1545', '2024-05-13 19:46:06.509734'),
(21, 'sessions', '0001_initial', '2024-05-13 19:46:06.521666'),
(22, 'core', '0004_auto_20240517_1533', '2024-05-17 19:33:55.389641'),
(23, 'core', '0005_auto_20240522_1529', '2024-05-22 19:29:14.873112'),
(24, 'core', '0006_auto_20240522_1536', '2024-05-22 19:36:57.937771'),
(25, 'core', '0007_auto_20240522_1618', '2024-05-22 20:18:51.185232'),
(26, 'core', '0008_pedido_sucursal', '2024-05-26 16:29:26.418862'),
(27, 'core', '0009_pedido_run', '2024-05-26 16:33:00.747007'),
(28, 'core', '0010_auto_20240526_1240', '2024-05-26 16:43:57.692317'),
(29, 'core', '0011_auto_20240526_1432', '2024-05-26 18:32:28.303998'),
(30, 'core', '0012_auto_20240526_1447', '2024-05-26 18:48:04.117639'),
(31, 'core', '0013_pedido_tipo_entrega', '2024-05-26 22:35:31.635674'),
(32, 'core', '0014_remove_usuariocustom_correo_usuario', '2024-05-26 23:25:54.202975'),
(33, 'core', '0015_usuariocustom_correo_usuario', '2024-05-26 23:30:38.518545'),
(34, 'core', '0016_pedido_comprobante_pago', '2024-06-27 01:56:58.244371');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('4v0ufx63qfz9si75h545rw7ecrb5878y', '.eJxVjEsOAiEQBe_C2hB-3aBL956BQNPKqIFkmFkZ766TzEK3r6reS8S0LjWug-c4FXESWhx-t5zowW0D5Z7arUvqbZmnLDdF7nTISy_8PO_u30FNo35rk8kotgo0Wl90cERkM8BVoUL0QTNom51h5RIB4tEoi64ED0zFoRfvD7myNqY:1sMesO:yyIbIzIc4x5R3dg3JQgWJQiOlRrAc-srGgYWBT6A6Zo', '2024-07-11 02:28:44.839660'),
('7vlls5rzsrsannaqig64kiw2hc4bdcwk', '.eJxVjMEOwiAQBf-FsyFQQFiP3v0GsrAgVQNJaU_Gf5cmPej1zcx7M4_bWvzW0-JnYhcm2el3Cxifqe6AHljvjcdW12UOfFf4QTu_NUqv6-H-HRTsZdTOoDMCIpEBpcFCRAUBzyIRCJ11ChTsJPOkSDg3FD2IzGS0ttKQZJ8v2-U3gA:1sT5Nh:XHbQyt-mQzIwaaaC2B6KIIEL42QoUzjDi4PLaQ7CHQw', '2024-07-28 19:59:37.011400'),
('a6y4l6syfngjy4n36nh0byvl7fgtgp22', '.eJxVjEsOAiEQBe_C2hB-3aBL956BQNPKqIFkmFkZ766TzEK3r6reS8S0LjWug-c4FXESWhx-t5zowW0D5Z7arUvqbZmnLDdF7nTISy_8PO_u30FNo35rk8kotgo0Wl90cERkM8BVoUL0QTNom51h5RIB4tEoi64ED0zFoRfvD7myNqY:1s9rst:gOMlBE_qD5luSY93Cszr-fQzFpx-0Rq4tSa-a8FZYz4', '2024-06-05 19:44:23.663698'),
('apamj0il8ewpi3rcr0o53szfsr0pzyum', '.eJxVjMEOwiAQBf-FsyFQQFiP3v0GsrAgVQNJaU_Gf5cmPej1zcx7M4_bWvzW0-JnYhcm2el3Cxifqe6AHljvjcdW12UOfFf4QTu_NUqv6-H-HRTsZdTOoDMCIpEBpcFCRAUBzyIRCJ11ChTsJPOkSDg3FD2IzGS0ttKQZJ8v2-U3gA:1sT5Zd:2mXI5MIxNJSheVDlmjreLRszyDmBf9DUoEQeljJZTok', '2024-07-28 20:11:57.822765'),
('b4vdt7scv688oqb31vmk8det3jtpdr4y', 'eyJfcGFzc3dvcmRfcmVzZXRfdG9rZW4iOiJjN25tMTMtMGM5MWQwZTNlODdkZjAyMzk0YzgyY2ZhZjJkOGNiZWYifQ:1sBPWX:LKnobQEQ7p6O9LpOZ-WumO8UOJ0t9LRpQyhm2NbBlV4', '2024-06-10 01:51:41.527453'),
('fn6ffvjp5kuwz82bkpbgrcd3j84z2oe4', 'eyJfcGFzc3dvcmRfcmVzZXRfdG9rZW4iOiJjN25uajctZWIzNjkwMzk0NDBlZDcyZmJhNzJiMjhlNzkyNWJjZmYifQ:1sBQ1Z:lVCPoUpKW7HO4h26d7A7q-ggQrs5lt7BRey21HJN1C0', '2024-06-10 02:23:45.350585'),
('i7qhn9b1igtwxmqhkf40gdmxhap8q841', '.eJxVjMsOgjAUBf-la9P0QqGtS_d8Q9P7qEUNJBRWxn8XEha6PTNz3iqmbS1xq7LEkdVVtU5dfkdM9JTpIPxI033WNE_rMqI-FH3SqoeZ5XU73b-DkmrZa2lAgg2Be-zAiYccGLgBx1lSzgzWsLQIyGR3z3bWZzIGeyJsDHn1-QIgqTjN:1sT9lV:qbRIzdh_YnDUouHCP8SENuey1r5kZsKMYHPiiHuvFiI', '2024-07-29 00:40:29.952069'),
('lg33pqgd4ezwncafkfgkf7zfsrkdnkoj', '.eJxVjEsOAiEQBe_C2hB-3aBL956BQNPKqIFkmFkZ766TzEK3r6reS8S0LjWug-c4FXESWhx-t5zowW0D5Z7arUvqbZmnLDdF7nTISy_8PO_u30FNo35rk8kotgo0Wl90cERkM8BVoUL0QTNom51h5RIB4tEoi64ED0zFoRfvD7myNqY:1sMeND:lEZEGRcb2mv1FB_UaSxY45ZY8PAV1F3HlJbAN83AFCs', '2024-07-11 01:56:31.797439'),
('nall9o7d82gq0ykfvvxr7v8yhirg6gx1', '.eJxVjEsOAiEQBe_C2hB-3aBL956BQNPKqIFkmFkZ766TzEK3r6reS8S0LjWug-c4FXESWhx-t5zowW0D5Z7arUvqbZmnLDdF7nTISy_8PO_u30FNo35rk8kotgo0Wl90cERkM8BVoUL0QTNom51h5RIB4tEoi64ED0zFoRfvD7myNqY:1s9szR:plocTYoZxHPSm2cA14vgjpftm0R3tlaJIinTM8diz68', '2024-06-05 20:55:13.278444'),
('o335608cvoekvx1i9mamyua1lrf05iv7', '.eJxVjMEOwiAQBf-FsyFQQFiP3v0GsrAgVQNJaU_Gf5cmPej1zcx7M4_bWvzW0-JnYhcm2el3Cxifqe6AHljvjcdW12UOfFf4QTu_NUqv6-H-HRTsZdTOoDMCIpEBpcFCRAUBzyIRCJ11ChTsJPOkSDg3FD2IzGS0ttKQZJ8v2-U3gA:1sT5aD:mATsp7qN4mYguTzF6l7gxbzJ4JBD4Q6aLsZIheCB25k', '2024-07-28 20:12:33.907672'),
('rpr2madti7jjklz6yj1l52puvqtrawuz', '.eJxVjMEOwiAQBf-FsyFQQFiP3v0GsrAgVQNJaU_Gf5cmPej1zcx7M4_bWvzW0-JnYhcm2el3Cxifqe6AHljvjcdW12UOfFf4QTu_NUqv6-H-HRTsZdTOoDMCIpEBpcFCRAUBzyIRCJ11ChTsJPOkSDg3FD2IzGS0ttKQZJ8v2-U3gA:1sT5MU:JIi8vofPUx0JBIlnWIY9SAiptmnJ_Xjw9ePNQ7647KY', '2024-07-28 19:58:22.487457'),
('wudb04qcua1qhm1cix3zgr3knl7i3vk2', '.eJxVjMEOwiAQBf-FsyFQQFiP3v0GsrAgVQNJaU_Gf5cmPej1zcx7M4_bWvzW0-JnYhcm2el3Cxifqe6AHljvjcdW12UOfFf4QTu_NUqv6-H-HRTsZdTOoDMCIpEBpcFCRAUBzyIRCJ11ChTsJPOkSDg3FD2IzGS0ttKQZJ8v2-U3gA:1sT5lO:_sdf6nYsD006KkSMkGacNsv7jQjQvDjaiyE2xxa2sWo', '2024-07-28 20:24:06.959710'),
('xh5c7ruo5ckxq5enma4wvz9rdi07viy6', 'eyJfcGFzc3dvcmRfcmVzZXRfdG9rZW4iOiJjN25ubTEtMWFiMzhiYjY4ODVlYjA4NzcyZDk4NThlNWUzZjg3YWEifQ:1sBQ39:Oc1jVynrFlU35m1ZGgAb_NB8tgq4qqaK8TEqEu0SFSg', '2024-06-10 02:25:23.544473');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `core_carrito`
--
ALTER TABLE `core_carrito`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `core_categoriaproducto`
--
ALTER TABLE `core_categoriaproducto`
  ADD PRIMARY KEY (`idcategoriaProducto`);

--
-- Indices de la tabla `core_comuna`
--
ALTER TABLE `core_comuna`
  ADD PRIMARY KEY (`idComuna`),
  ADD KEY `core_comuna_idRegion_id_8eb1d498_fk_core_region_idRegion` (`idRegion_id`);

--
-- Indices de la tabla `core_itemcarrito`
--
ALTER TABLE `core_itemcarrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_itemcarrito_carrito_id_427071c4_fk_core_carrito_id` (`carrito_id`),
  ADD KEY `core_itemcarrito_producto_id_eea3400e_fk_core_prod` (`producto_id`);

--
-- Indices de la tabla `core_itempedido`
--
ALTER TABLE `core_itempedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_itempedido_pedido_id_a233f553_fk_core_pedido_id` (`pedido_id`),
  ADD KEY `core_itempedido_producto_id_b797c050_fk_core_producto_idProducto` (`producto_id`);

--
-- Indices de la tabla `core_marca`
--
ALTER TABLE `core_marca`
  ADD PRIMARY KEY (`idMarca`);

--
-- Indices de la tabla `core_pedido`
--
ALTER TABLE `core_pedido`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero` (`numero`),
  ADD KEY `core_pedido_carrito_id_9422b599_fk_core_carrito_id` (`carrito_id`),
  ADD KEY `core_pedido_estado_id_4cc337f0_fk_core_seguimiento_id` (`estado_id`),
  ADD KEY `core_pedido_comuna_id_66642798_fk_core_comuna_idComuna` (`comuna_id`),
  ADD KEY `core_pedido_sucursal_id_27bef910_fk_core_sucursal_idSucursal` (`sucursal_id`),
  ADD KEY `core_pedido_region_id_f07890b7_fk_core_region_idRegion` (`region_id`);

--
-- Indices de la tabla `core_producto`
--
ALTER TABLE `core_producto`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `core_producto_idMarca_id_b10d4006_fk_core_marca_idMarca` (`idMarca_id`),
  ADD KEY `core_producto_idcategoriaProducto__5888c949_fk_core_cate` (`idcategoriaProducto_id`);

--
-- Indices de la tabla `core_region`
--
ALTER TABLE `core_region`
  ADD PRIMARY KEY (`idRegion`);

--
-- Indices de la tabla `core_rolusuario`
--
ALTER TABLE `core_rolusuario`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `core_seguimiento`
--
ALTER TABLE `core_seguimiento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `core_sucursal`
--
ALTER TABLE `core_sucursal`
  ADD PRIMARY KEY (`idSucursal`),
  ADD KEY `core_sucursal_idComuna_id_8273b0c3_fk_core_comuna_idComuna` (`idComuna_id`);

--
-- Indices de la tabla `core_usuariocustom`
--
ALTER TABLE `core_usuariocustom`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `core_usuariocustom_idComuna_id_79fd03a4_fk_core_comuna_idComuna` (`idComuna_id`),
  ADD KEY `core_usuariocustom_idRol_id_a682a0ba_fk_core_rolusuario_idRol` (`idRol_id`);

--
-- Indices de la tabla `core_usuariocustom_groups`
--
ALTER TABLE `core_usuariocustom_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_usuariocustom_group_usuariocustom_id_group_i_29a9a079_uniq` (`usuariocustom_id`,`group_id`),
  ADD KEY `core_usuariocustom_groups_group_id_8dcd6d1a_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `core_usuariocustom_user_permissions`
--
ALTER TABLE `core_usuariocustom_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_usuariocustom_user__usuariocustom_id_permiss_50e60970_uniq` (`usuariocustom_id`,`permission_id`),
  ADD KEY `core_usuariocustom_u_permission_id_37c6eea2_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_core_usuariocustom_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT de la tabla `core_carrito`
--
ALTER TABLE `core_carrito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `core_categoriaproducto`
--
ALTER TABLE `core_categoriaproducto`
  MODIFY `idcategoriaProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `core_comuna`
--
ALTER TABLE `core_comuna`
  MODIFY `idComuna` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=296;

--
-- AUTO_INCREMENT de la tabla `core_itemcarrito`
--
ALTER TABLE `core_itemcarrito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT de la tabla `core_itempedido`
--
ALTER TABLE `core_itempedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `core_marca`
--
ALTER TABLE `core_marca`
  MODIFY `idMarca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `core_pedido`
--
ALTER TABLE `core_pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `core_producto`
--
ALTER TABLE `core_producto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `core_region`
--
ALTER TABLE `core_region`
  MODIFY `idRegion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `core_rolusuario`
--
ALTER TABLE `core_rolusuario`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `core_seguimiento`
--
ALTER TABLE `core_seguimiento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `core_sucursal`
--
ALTER TABLE `core_sucursal`
  MODIFY `idSucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `core_usuariocustom`
--
ALTER TABLE `core_usuariocustom`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `core_usuariocustom_groups`
--
ALTER TABLE `core_usuariocustom_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_usuariocustom_user_permissions`
--
ALTER TABLE `core_usuariocustom_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `core_carrito`
--
ALTER TABLE `core_carrito`
  ADD CONSTRAINT `core_carrito_usuario_id_9eafcb26_fk_core_usuariocustom_id` FOREIGN KEY (`usuario_id`) REFERENCES `core_usuariocustom` (`id`);

--
-- Filtros para la tabla `core_comuna`
--
ALTER TABLE `core_comuna`
  ADD CONSTRAINT `core_comuna_idRegion_id_8eb1d498_fk_core_region_idRegion` FOREIGN KEY (`idRegion_id`) REFERENCES `core_region` (`idRegion`);

--
-- Filtros para la tabla `core_itemcarrito`
--
ALTER TABLE `core_itemcarrito`
  ADD CONSTRAINT `core_itemcarrito_carrito_id_427071c4_fk_core_carrito_id` FOREIGN KEY (`carrito_id`) REFERENCES `core_carrito` (`id`),
  ADD CONSTRAINT `core_itemcarrito_producto_id_eea3400e_fk_core_prod` FOREIGN KEY (`producto_id`) REFERENCES `core_producto` (`idProducto`);

--
-- Filtros para la tabla `core_itempedido`
--
ALTER TABLE `core_itempedido`
  ADD CONSTRAINT `core_itempedido_pedido_id_a233f553_fk_core_pedido_id` FOREIGN KEY (`pedido_id`) REFERENCES `core_pedido` (`id`),
  ADD CONSTRAINT `core_itempedido_producto_id_b797c050_fk_core_producto_idProducto` FOREIGN KEY (`producto_id`) REFERENCES `core_producto` (`idProducto`);

--
-- Filtros para la tabla `core_pedido`
--
ALTER TABLE `core_pedido`
  ADD CONSTRAINT `core_pedido_carrito_id_9422b599_fk_core_carrito_id` FOREIGN KEY (`carrito_id`) REFERENCES `core_carrito` (`id`),
  ADD CONSTRAINT `core_pedido_estado_id_4cc337f0_fk_core_seguimiento_id` FOREIGN KEY (`estado_id`) REFERENCES `core_seguimiento` (`id`),
  ADD CONSTRAINT `core_pedido_region_id_f07890b7_fk_core_region_idRegion` FOREIGN KEY (`region_id`) REFERENCES `core_region` (`idRegion`),
  ADD CONSTRAINT `core_pedido_sucursal_id_27bef910_fk_core_sucursal_idSucursal` FOREIGN KEY (`sucursal_id`) REFERENCES `core_sucursal` (`idSucursal`);

--
-- Filtros para la tabla `core_producto`
--
ALTER TABLE `core_producto`
  ADD CONSTRAINT `core_producto_idMarca_id_b10d4006_fk_core_marca_idMarca` FOREIGN KEY (`idMarca_id`) REFERENCES `core_marca` (`idMarca`),
  ADD CONSTRAINT `core_producto_idcategoriaProducto__5888c949_fk_core_cate` FOREIGN KEY (`idcategoriaProducto_id`) REFERENCES `core_categoriaproducto` (`idcategoriaProducto`);

--
-- Filtros para la tabla `core_sucursal`
--
ALTER TABLE `core_sucursal`
  ADD CONSTRAINT `core_sucursal_idComuna_id_8273b0c3_fk_core_comuna_idComuna` FOREIGN KEY (`idComuna_id`) REFERENCES `core_comuna` (`idComuna`);

--
-- Filtros para la tabla `core_usuariocustom`
--
ALTER TABLE `core_usuariocustom`
  ADD CONSTRAINT `core_usuariocustom_idComuna_id_79fd03a4_fk_core_comuna_idComuna` FOREIGN KEY (`idComuna_id`) REFERENCES `core_comuna` (`idComuna`),
  ADD CONSTRAINT `core_usuariocustom_idRol_id_a682a0ba_fk_core_rolusuario_idRol` FOREIGN KEY (`idRol_id`) REFERENCES `core_rolusuario` (`idRol`);

--
-- Filtros para la tabla `core_usuariocustom_groups`
--
ALTER TABLE `core_usuariocustom_groups`
  ADD CONSTRAINT `core_usuariocustom_g_usuariocustom_id_5965550d_fk_core_usua` FOREIGN KEY (`usuariocustom_id`) REFERENCES `core_usuariocustom` (`id`),
  ADD CONSTRAINT `core_usuariocustom_groups_group_id_8dcd6d1a_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `core_usuariocustom_user_permissions`
--
ALTER TABLE `core_usuariocustom_user_permissions`
  ADD CONSTRAINT `core_usuariocustom_u_permission_id_37c6eea2_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `core_usuariocustom_u_usuariocustom_id_a30f26bf_fk_core_usua` FOREIGN KEY (`usuariocustom_id`) REFERENCES `core_usuariocustom` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_core_usuariocustom_id` FOREIGN KEY (`user_id`) REFERENCES `core_usuariocustom` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
