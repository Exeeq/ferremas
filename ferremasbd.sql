-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-05-2024 a las 04:16:12
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
-- Base de datos: `ferremasbd`
--
CREATE DATABASE IF NOT EXISTS `ferremasbd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ferremasbd`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `SP_DELETE_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DELETE_PRODUCTO` (IN `p_idProducto` INT)   BEGIN
    DELETE FROM core_producto
    WHERE idProducto = p_idProducto;
END$$

DROP PROCEDURE IF EXISTS `SP_DELETE_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DELETE_USUARIO` (IN `p_idUsuario` INT)   BEGIN

    DELETE FROM core_usuario WHERE id = p_idUsuario;
    
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GET_USUARIOS` (OUT `p_out` INT)  NO SQL SELECT * FROM core_usuariocustom$$

DROP PROCEDURE IF EXISTS `SP_POST_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_POST_PRODUCTO` (IN `nombreProducto` VARCHAR(50), IN `precioProducto` INT, IN `stockProducto` INT, IN `imagenProducto` VARCHAR(255), IN `descripcionProducto` VARCHAR(200), IN `idcategoriaProducto` INT, IN `idMarca` INT)   BEGIN
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_POST_USUARIO` (IN `p_username` VARCHAR(150), IN `p_password` VARCHAR(128), IN `p_run` VARCHAR(12), IN `p_pnombre` VARCHAR(20), IN `p_ap_paterno` VARCHAR(24), IN `p_correo_usuario` VARCHAR(254), IN `p_fecha_nacimiento` DATE, IN `p_direccion` VARCHAR(100), IN `p_idRol` INT, IN `p_idComuna` INT)   BEGIN
    INSERT INTO core_usuariocustom (username, password, run, pnombre, ap_paterno, correo_usuario, fecha_nacimiento, direccion, idRol_id, idComuna_id)
    VALUES (p_username, p_password, p_run, p_pnombre, p_ap_paterno, p_correo_usuario, p_fecha_nacimiento, p_direccion, p_idRol, p_idComuna);
    
END$$

DROP PROCEDURE IF EXISTS `SP_PUT_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PUT_PRODUCTO` (IN `p_idProducto` INT, IN `p_nombreProducto` VARCHAR(255), IN `p_precioProducto` DECIMAL(10,0), IN `p_stockProducto` INT, IN `p_imagenProducto` VARCHAR(255), IN `p_descripcionProducto` VARCHAR(120), IN `p_idMarca` INT, IN `p_idcategoriaProducto` INT)   BEGIN
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
(52, 'Can view user', 13, 'view_usuariocustom');

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
(2, 'La Florida', 1);

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
-- Estructura de tabla para la tabla `core_producto`
--

DROP TABLE IF EXISTS `core_producto`;
CREATE TABLE `core_producto` (
  `idProducto` int(11) NOT NULL,
  `nombreProducto` varchar(50) NOT NULL,
  `precioProducto` int(11) NOT NULL,
  `stockProducto` int(11) NOT NULL,
  `imagenProducto` varchar(100) DEFAULT NULL,
  `descripcionProducto` varchar(200) NOT NULL,
  `idMarca_id` int(11) NOT NULL,
  `idcategoriaProducto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_producto`
--

INSERT INTO `core_producto` (`idProducto`, `nombreProducto`, `precioProducto`, `stockProducto`, `imagenProducto`, `descripcionProducto`, `idMarca_id`, `idcategoriaProducto_id`) VALUES
(4, 'Martillo Loco', 6790, 12, 'martillo-venta.jpg', 'Martillo para martillar cosas cualquiera como clavos, madera, etc.', 1, 1),
(6, 'Martillo de felix el reparador', 5999999, 5, '9caea45d370e2f37ed47b77a838c9c99.jpg', 'Martillo de Félix el reparador máximo golpeador, bélico, mastodonte, duro, fuerte, etc.', 1, 1);

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
(1, 'Metropolitana');

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
-- Estructura de tabla para la tabla `core_sucursal`
--

DROP TABLE IF EXISTS `core_sucursal`;
CREATE TABLE `core_sucursal` (
  `idSucursal` int(11) NOT NULL,
  `nombreSucursal` varchar(50) NOT NULL,
  `direccionSucursal` varchar(60) NOT NULL,
  `idComuna_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `correo_usuario` varchar(254) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `direccion` varchar(100) NOT NULL,
  `idComuna_id` int(11) DEFAULT NULL,
  `idRol_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `core_usuariocustom`
--

INSERT INTO `core_usuariocustom` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `run`, `pnombre`, `snombre`, `ap_paterno`, `ap_materno`, `correo_usuario`, `fecha_nacimiento`, `direccion`, `idComuna_id`, `idRol_id`) VALUES
(1, 'pbkdf2_sha256$216000$W8yfRzmhw4qh$85cipHi5oYN4NzQmnocYYKVL9MTM0LI/042qU3Mo3AQ=', '2024-05-15 01:29:59.710782', 1, 'admin', '', '', '', 1, 1, '2024-05-13 19:58:21.484730', '', 'Admin', '', 'Supremo', '', 'admin@ferremas.cl', NULL, '', 1, 5),
(4, 'pbkdf2_sha256$216000$RTCQYm3C7cN5$PAVJ6B3bls+7yQA+4qep2scXluciXChUeon6LgxezNI=', '2024-05-15 01:28:29.361936', 0, 'Exequiel', '', '', '', 0, 1, '2024-05-15 01:28:14.561514', '21.002.289-9', 'Exequiel', '', 'Albornoz', '', 'ex.albornoz@duocuc.cl', '2024-05-12', 'Millantu, 167, Puente Alto', 1, 1);

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
(6, 'core', 'categoriaproducto'),
(7, 'core', 'comuna'),
(8, 'core', 'marca'),
(12, 'core', 'producto'),
(9, 'core', 'region'),
(10, 'core', 'rolusuario'),
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
(21, 'sessions', '0001_initial', '2024-05-13 19:46:06.521666');

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
('7ycni6ehdscgg55fqqgt67goaj9mph8v', '.eJxVjEsOAiEQBe_C2hB-3aBL956BQNPKqIFkmFkZ766TzEK3r6reS8S0LjWug-c4FXESWhx-t5zowW0D5Z7arUvqbZmnLDdF7nTISy_8PO_u30FNo35rk8kotgo0Wl90cERkM8BVoUL0QTNom51h5RIB4tEoi64ED0zFoRfvD7myNqY:1s73Sx:7m2JGtYDBrKxkkyHl02LqQNgnlOK8D42HCDAb3zvmRE', '2024-05-29 01:29:59.713088'),
('zy1fged2q5ogaszivxymsh4qvd0no11j', '.eJxVjEsOAiEQBe_C2hB-3aBL956BQNPKqIFkmFkZ766TzEK3r6reS8S0LjWug-c4FXESWhx-t5zowW0D5Z7arUvqbZmnLDdF7nTISy_8PO_u30FNo35rk8kotgo0Wl90cERkM8BVoUL0QTNom51h5RIB4tEoi64ED0zFoRfvD7myNqY:1s6dUB:p7P9R15anq53G1ehucxdV6xWzgoCfG6VRKFy4BS51SI', '2024-05-27 21:45:31.141588');

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
-- Indices de la tabla `core_marca`
--
ALTER TABLE `core_marca`
  ADD PRIMARY KEY (`idMarca`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `core_categoriaproducto`
--
ALTER TABLE `core_categoriaproducto`
  MODIFY `idcategoriaProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `core_comuna`
--
ALTER TABLE `core_comuna`
  MODIFY `idComuna` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `core_marca`
--
ALTER TABLE `core_marca`
  MODIFY `idMarca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `core_producto`
--
ALTER TABLE `core_producto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `core_region`
--
ALTER TABLE `core_region`
  MODIFY `idRegion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `core_rolusuario`
--
ALTER TABLE `core_rolusuario`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `core_sucursal`
--
ALTER TABLE `core_sucursal`
  MODIFY `idSucursal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_usuariocustom`
--
ALTER TABLE `core_usuariocustom`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
-- Filtros para la tabla `core_comuna`
--
ALTER TABLE `core_comuna`
  ADD CONSTRAINT `core_comuna_idRegion_id_8eb1d498_fk_core_region_idRegion` FOREIGN KEY (`idRegion_id`) REFERENCES `core_region` (`idRegion`);

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
