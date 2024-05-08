-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-05-2024 a las 22:02:06
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
-- Base de datos: `ferremas_bd`
--
CREATE DATABASE IF NOT EXISTS `ferremas_bd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ferremas_bd`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `SP_DELETE_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DELETE_PRODUCTO` (IN `p_idProducto` INT, OUT `p_out` INT)  NO SQL DELETE FROM `producto` WHERE `idProducto` = p_idProducto$$

DROP PROCEDURE IF EXISTS `SP_GET_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GET_PRODUCTO` (IN `idProducto` INT, OUT `p_out` INT)  NO SQL SELECT * FROM producto as p
WHERE p.idProducto = idProducto$$

DROP PROCEDURE IF EXISTS `SP_GET_PRODUCTOS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GET_PRODUCTOS` (OUT `p_out` INT)  NO SQL SELECT * FROM producto$$

DROP PROCEDURE IF EXISTS `SP_PATCH_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PATCH_PRODUCTO` (IN `p_idProducto` INT, IN `p_nombreProducto` VARCHAR(255), IN `p_precioProducto` INT, IN `p_imagenProducto` VARCHAR(255), IN `p_descripcionProducto` VARCHAR(255), IN `p_idcategoriaProducto` INT, IN `p_idmarcaProducto` INT, IN `p_stockProducto` INT, OUT `p_out` INT)   BEGIN
    DECLARE error_occurred INT DEFAULT 0;

    BEGIN
        INSERT INTO producto 
            (`idProducto`, `nombreProducto`, `precioProducto`, `imagenProducto`, 
            `descripcionProducto`, `idCategoria`, `idMarca`, `stockProducto`)
        VALUES
            (p_idProducto, p_nombreProducto, p_precioProducto, p_imagenProducto,
            p_descripcionProducto, p_idcategoriaProducto, p_idmarcaProducto, p_stockProducto);
        SET p_out = 1;
    END;

    BEGIN
        DECLARE CONTINUE HANDLER FOR 1062
        BEGIN
            UPDATE producto
            SET 
                `nombreProducto` = p_nombreProducto,
                `precioProducto` = p_precioProducto,
                `imagenProducto` = p_imagenProducto,
                `descripcionProducto` = p_descripcionProducto,
                `idCategoria` = p_idcategoriaProducto,
                `idMarca` = p_idmarcaProducto,
                `stockProducto` = p_stockProducto
            WHERE 
                `idProducto` = p_idProducto;
            SET p_out = 1;
        END;
    END;

    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
        BEGIN
            SET error_occurred = 1;
            SET p_out = 0;
        END;
    END;
END$$

DROP PROCEDURE IF EXISTS `SP_POST_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_POST_PRODUCTO` (IN `p_idProducto` INT, IN `p_nombreProducto` VARCHAR(255), IN `p_precioProducto` INT, IN `p_imagenProducto` VARCHAR(255), IN `p_descripcionProducto` VARCHAR(255), IN `p_idcategoriaProducto` INT, IN `p_idmarcaProducto` INT, OUT `p_out` INT)   BEGIN 
    INSERT INTO `producto`(
        `idProducto`, 
        `nombreProducto`, 
        `precioProducto`, 
        `imagenProducto`, 
        `descripcionProducto`, 
        `idCategoria`, 
        `idMarca`
    ) VALUES (
        p_idProducto, 
        p_nombreProducto, 
        p_precioProducto, 
        p_imagenProducto, 
        p_descripcionProducto, 
        p_idcategoriaProducto, 
        p_idmarcaProducto
    );

END$$

DROP PROCEDURE IF EXISTS `SP_PUT_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PUT_PRODUCTO` (IN `p_idProducto` INT, IN `p_nombreProducto` VARCHAR(255), IN `p_precioProducto` INT, IN `p_imagenProducto` VARCHAR(255), IN `p_descripcionProducto` VARCHAR(255), IN `p_idcategoriaProducto` INT, IN `p_idmarcaProducto` INT, OUT `p_out` INT)   BEGIN 
    UPDATE `producto` SET
        `nombreProducto` = p_nombreProducto, 
        `precioProducto` = p_precioProducto, 
        `imagenProducto` = p_imagenProducto, 
        `descripcionProducto` = p_descripcionProducto, 
        `idCategoria` = p_idcategoriaProducto, 
        `idMarca` = p_idmarcaProducto 
    WHERE 
        `idProducto` = p_idProducto;
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
(21, 'Can add user', 6, 'add_usuariocustom'),
(22, 'Can change user', 6, 'change_usuariocustom'),
(23, 'Can delete user', 6, 'delete_usuariocustom'),
(24, 'Can view user', 6, 'view_usuariocustom');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bodega`
--

DROP TABLE IF EXISTS `bodega`;
CREATE TABLE `bodega` (
  `idBodega` int(11) NOT NULL,
  `nombreBodega` varchar(255) NOT NULL,
  `idSucursal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_producto`
--

DROP TABLE IF EXISTS `categoria_producto`;
CREATE TABLE `categoria_producto` (
  `idcategoria` int(11) NOT NULL,
  `nombrecategoria` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria_producto`
--

INSERT INTO `categoria_producto` (`idcategoria`, `nombrecategoria`) VALUES
(1, 'Herramientas Manuales'),
(2, 'Materiales Básicos'),
(3, 'Equipos de Seguridad'),
(4, 'Tornillos y Anclajes'),
(5, 'Fijaciones y Adhesivos'),
(6, 'Equipos de Medición');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comuna`
--

DROP TABLE IF EXISTS `comuna`;
CREATE TABLE `comuna` (
  `idComuna` int(11) NOT NULL,
  `nombreComuna` varchar(255) NOT NULL,
  `idRegion` int(11) DEFAULT NULL
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
(5, 'sessions', 'session'),
(6, 'usuario', 'usuariocustom');

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
(1, 'contenttypes', '0001_initial', '2024-05-08 17:01:21.350380'),
(2, 'contenttypes', '0002_remove_content_type_name', '2024-05-08 17:01:21.381877'),
(3, 'auth', '0001_initial', '2024-05-08 17:01:21.418876'),
(4, 'auth', '0002_alter_permission_name_max_length', '2024-05-08 17:01:21.550462'),
(5, 'auth', '0003_alter_user_email_max_length', '2024-05-08 17:01:21.556101'),
(6, 'auth', '0004_alter_user_username_opts', '2024-05-08 17:01:21.561701'),
(7, 'auth', '0005_alter_user_last_login_null', '2024-05-08 17:01:21.568325'),
(8, 'auth', '0006_require_contenttypes_0002', '2024-05-08 17:01:21.571542'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2024-05-08 17:01:21.576585'),
(10, 'auth', '0008_alter_user_username_max_length', '2024-05-08 17:01:21.581793'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2024-05-08 17:01:21.586355'),
(12, 'auth', '0010_alter_group_name_max_length', '2024-05-08 17:01:21.593825'),
(13, 'auth', '0011_update_proxy_permissions', '2024-05-08 17:01:21.601586'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2024-05-08 17:01:21.607313'),
(15, 'usuario', '0001_initial', '2024-05-08 17:01:21.651303'),
(16, 'admin', '0001_initial', '2024-05-08 17:01:21.763657'),
(17, 'admin', '0002_logentry_remove_auto_add', '2024-05-08 17:01:21.816901'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2024-05-08 17:01:21.826355'),
(19, 'sessions', '0001_initial', '2024-05-08 17:01:21.836571'),
(20, 'usuario', '0002_usuariocustom_fecha_nacimiento', '2024-05-08 17:01:21.856471'),
(21, 'usuario', '0003_auto_20240505_1648', '2024-05-08 17:01:21.867518'),
(22, 'usuario', '0004_auto_20240505_2124', '2024-05-08 17:01:21.908054'),
(23, 'usuario', '0005_auto_20240506_1957', '2024-05-08 17:01:21.915203'),
(24, 'usuario', '0006_auto_20240506_1959', '2024-05-08 17:01:21.943609'),
(25, 'usuario', '0007_auto_20240506_2054', '2024-05-08 17:01:22.013511'),
(26, 'usuario', '0008_auto_20240506_2104', '2024-05-08 17:01:22.042271'),
(27, 'usuario', '0009_auto_20240508_1041', '2024-05-08 17:01:22.054415');

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
('nup9ylo9ex4uss4uyac7wr3oc6qtrd53', '.eJxVjEEOwiAQRe_C2hCmZaC4dN8zkAEGqRqalHZlvLtt0oVu33v_v4WnbS1-a7z4KYmrAHH5ZYHik-sh0oPqfZZxrusyBXkk8rRNjnPi1-1s_w4KtbKvcwajk1GsEQI4xMzapEihV9wRK6uQKCM7Z6HbseLBYa_tECOCNiw-X-2xN_4:1s4mwE:USOl6E5aJqw7Tl12nOgav3TVSBMKJ2Uf13byxb56lYo', '2024-05-22 19:26:50.819779');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

DROP TABLE IF EXISTS `inventario`;
CREATE TABLE `inventario` (
  `stock` int(11) NOT NULL,
  `idProducto` int(11) DEFAULT NULL,
  `idBodega` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

DROP TABLE IF EXISTS `marca`;
CREATE TABLE `marca` (
  `idMarca` int(11) NOT NULL,
  `nombreMarca` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` (`idMarca`, `nombreMarca`) VALUES
(1, 'Bosh'),
(2, 'Makita'),
(3, 'Stanley'),
(4, 'Sika');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `idProducto` int(11) NOT NULL,
  `nombreProducto` varchar(255) NOT NULL,
  `precioProducto` int(11) NOT NULL,
  `imagenProducto` blob DEFAULT NULL,
  `descripcionProducto` varchar(255) NOT NULL,
  `idCategoria` int(11) DEFAULT NULL,
  `idMarca` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idProducto`, `nombreProducto`, `precioProducto`, `imagenProducto`, `descripcionProducto`, `idCategoria`, `idMarca`) VALUES
(1, 'Martillo carpintero 16 Oz acero', 7000, '', 'Martillo para martillar', 1, 3),
(2, 'Taladro inalámbrico percutor 10 mm 12V ', 79990, '', 'Taladro todo loco xd', 6, 2),
(3, 'Serrucho Bauker', 100000, '', 'Serrucho para cortar madera', 3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `region`
--

DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `idRegion` int(11) NOT NULL,
  `nombreRegion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rolusuario`
--

DROP TABLE IF EXISTS `rolusuario`;
CREATE TABLE `rolusuario` (
  `idRol` int(11) NOT NULL,
  `nombreRol` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

DROP TABLE IF EXISTS `sucursal`;
CREATE TABLE `sucursal` (
  `idSucursal` int(11) NOT NULL,
  `nombreSucursal` varchar(255) NOT NULL,
  `direccionSucursal` varchar(255) NOT NULL,
  `idComuna` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_usuariocustom`
--

DROP TABLE IF EXISTS `usuario_usuariocustom`;
CREATE TABLE `usuario_usuariocustom` (
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
  `direccion` varchar(40) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL,
  `idComuna` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_usuariocustom`
--

INSERT INTO `usuario_usuariocustom` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `run`, `pnombre`, `snombre`, `ap_paterno`, `ap_materno`, `correo_usuario`, `direccion`, `fecha_nacimiento`, `idRol`, `idComuna`) VALUES
(1, 'pbkdf2_sha256$216000$Fvj667GWimKq$nR9InSdnTyKiC/XT0fQuhylslAUYkq1p4sp8nrM05oc=', '2024-05-08 19:26:50.816738', 1, 'admin', '', '', 'admin@ferremas.cl', 1, 1, '2024-05-08 19:25:55.491879', '', '', '', '', '', '', '', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_usuariocustom_groups`
--

DROP TABLE IF EXISTS `usuario_usuariocustom_groups`;
CREATE TABLE `usuario_usuariocustom_groups` (
  `id` int(11) NOT NULL,
  `usuariocustom_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_usuariocustom_user_permissions`
--

DROP TABLE IF EXISTS `usuario_usuariocustom_user_permissions`;
CREATE TABLE `usuario_usuariocustom_user_permissions` (
  `id` int(11) NOT NULL,
  `usuariocustom_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indices de la tabla `bodega`
--
ALTER TABLE `bodega`
  ADD PRIMARY KEY (`idBodega`),
  ADD KEY `idSucursal` (`idSucursal`);

--
-- Indices de la tabla `categoria_producto`
--
ALTER TABLE `categoria_producto`
  ADD PRIMARY KEY (`idcategoria`);

--
-- Indices de la tabla `comuna`
--
ALTER TABLE `comuna`
  ADD PRIMARY KEY (`idComuna`),
  ADD KEY `idRegion` (`idRegion`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_usuario_usuariocustom_id` (`user_id`);

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
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD KEY `idProducto` (`idProducto`),
  ADD KEY `idBodega` (`idBodega`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`idMarca`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `idCategoria` (`idCategoria`),
  ADD KEY `idMarca` (`idMarca`);

--
-- Indices de la tabla `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`idRegion`);

--
-- Indices de la tabla `rolusuario`
--
ALTER TABLE `rolusuario`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`idSucursal`),
  ADD KEY `idComuna` (`idComuna`);

--
-- Indices de la tabla `usuario_usuariocustom`
--
ALTER TABLE `usuario_usuariocustom`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `fk_usuario_rol` (`idRol`),
  ADD KEY `idComuna` (`idComuna`);

--
-- Indices de la tabla `usuario_usuariocustom_groups`
--
ALTER TABLE `usuario_usuariocustom_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_usuariocustom_gr_usuariocustom_id_group_i_e07ef4d6_uniq` (`usuariocustom_id`,`group_id`),
  ADD KEY `usuario_usuariocustom_groups_group_id_f2e7608e_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `usuario_usuariocustom_user_permissions`
--
ALTER TABLE `usuario_usuariocustom_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_usuariocustom_us_usuariocustom_id_permiss_c31cc8d6_uniq` (`usuariocustom_id`,`permission_id`),
  ADD KEY `usuario_usuariocusto_permission_id_a7fbfbf3_fk_auth_perm` (`permission_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `bodega`
--
ALTER TABLE `bodega`
  MODIFY `idBodega` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categoria_producto`
--
ALTER TABLE `categoria_producto`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `comuna`
--
ALTER TABLE `comuna`
  MODIFY `idComuna` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `idMarca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `region`
--
ALTER TABLE `region`
  MODIFY `idRegion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rolusuario`
--
ALTER TABLE `rolusuario`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `idSucursal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario_usuariocustom`
--
ALTER TABLE `usuario_usuariocustom`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuario_usuariocustom_groups`
--
ALTER TABLE `usuario_usuariocustom_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario_usuariocustom_user_permissions`
--
ALTER TABLE `usuario_usuariocustom_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- Filtros para la tabla `bodega`
--
ALTER TABLE `bodega`
  ADD CONSTRAINT `bodega_ibfk_1` FOREIGN KEY (`idSucursal`) REFERENCES `sucursal` (`idSucursal`);

--
-- Filtros para la tabla `comuna`
--
ALTER TABLE `comuna`
  ADD CONSTRAINT `comuna_ibfk_1` FOREIGN KEY (`idRegion`) REFERENCES `region` (`idRegion`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_usuario_usuariocustom_id` FOREIGN KEY (`user_id`) REFERENCES `usuario_usuariocustom` (`id`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`),
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`idBodega`) REFERENCES `bodega` (`idBodega`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria_producto` (`idcategoria`),
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`idMarca`) REFERENCES `marca` (`idMarca`);

--
-- Filtros para la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD CONSTRAINT `sucursal_ibfk_1` FOREIGN KEY (`idComuna`) REFERENCES `comuna` (`idComuna`);

--
-- Filtros para la tabla `usuario_usuariocustom`
--
ALTER TABLE `usuario_usuariocustom`
  ADD CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`idRol`) REFERENCES `rolusuario` (`idRol`),
  ADD CONSTRAINT `usuario_usuariocustom_ibfk_1` FOREIGN KEY (`idComuna`) REFERENCES `comuna` (`idComuna`);

--
-- Filtros para la tabla `usuario_usuariocustom_groups`
--
ALTER TABLE `usuario_usuariocustom_groups`
  ADD CONSTRAINT `usuario_usuariocusto_usuariocustom_id_3cf3c88e_fk_usuario_u` FOREIGN KEY (`usuariocustom_id`) REFERENCES `usuario_usuariocustom` (`id`),
  ADD CONSTRAINT `usuario_usuariocustom_groups_group_id_f2e7608e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `usuario_usuariocustom_user_permissions`
--
ALTER TABLE `usuario_usuariocustom_user_permissions`
  ADD CONSTRAINT `usuario_usuariocusto_permission_id_a7fbfbf3_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `usuario_usuariocusto_usuariocustom_id_e4c3a412_fk_usuario_u` FOREIGN KEY (`usuariocustom_id`) REFERENCES `usuario_usuariocustom` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
