-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-05-2024 a las 04:47:34
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
-- Base de datos: `ferremas`
--
CREATE DATABASE IF NOT EXISTS `ferremas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ferremas`;

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
(21, 'Can add bodega', 6, 'add_bodega'),
(22, 'Can change bodega', 6, 'change_bodega'),
(23, 'Can delete bodega', 6, 'delete_bodega'),
(24, 'Can view bodega', 6, 'view_bodega'),
(25, 'Can add categoria producto', 7, 'add_categoriaproducto'),
(26, 'Can change categoria producto', 7, 'change_categoriaproducto'),
(27, 'Can delete categoria producto', 7, 'delete_categoriaproducto'),
(28, 'Can view categoria producto', 7, 'view_categoriaproducto'),
(29, 'Can add comuna', 8, 'add_comuna'),
(30, 'Can change comuna', 8, 'change_comuna'),
(31, 'Can delete comuna', 8, 'delete_comuna'),
(32, 'Can view comuna', 8, 'view_comuna'),
(33, 'Can add marca', 9, 'add_marca'),
(34, 'Can change marca', 9, 'change_marca'),
(35, 'Can delete marca', 9, 'delete_marca'),
(36, 'Can view marca', 9, 'view_marca'),
(37, 'Can add region', 10, 'add_region'),
(38, 'Can change region', 10, 'change_region'),
(39, 'Can delete region', 10, 'delete_region'),
(40, 'Can view region', 10, 'view_region'),
(41, 'Can add rol usuario', 11, 'add_rolusuario'),
(42, 'Can change rol usuario', 11, 'change_rolusuario'),
(43, 'Can delete rol usuario', 11, 'delete_rolusuario'),
(44, 'Can view rol usuario', 11, 'view_rolusuario'),
(45, 'Can add sucursal', 12, 'add_sucursal'),
(46, 'Can change sucursal', 12, 'change_sucursal'),
(47, 'Can delete sucursal', 12, 'delete_sucursal'),
(48, 'Can view sucursal', 12, 'view_sucursal'),
(49, 'Can add producto', 13, 'add_producto'),
(50, 'Can change producto', 13, 'change_producto'),
(51, 'Can delete producto', 13, 'delete_producto'),
(52, 'Can view producto', 13, 'view_producto'),
(53, 'Can add inventario', 14, 'add_inventario'),
(54, 'Can change inventario', 14, 'change_inventario'),
(55, 'Can delete inventario', 14, 'delete_inventario'),
(56, 'Can view inventario', 14, 'view_inventario'),
(57, 'Can add user', 15, 'add_usuariocustom'),
(58, 'Can change user', 15, 'change_usuariocustom'),
(59, 'Can delete user', 15, 'delete_usuariocustom'),
(60, 'Can view user', 15, 'view_usuariocustom');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_bodega`
--

DROP TABLE IF EXISTS `core_bodega`;
CREATE TABLE `core_bodega` (
  `idBodega` int(11) NOT NULL,
  `nombreBodega` varchar(50) NOT NULL,
  `idSucursal_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_categoriaproducto`
--

DROP TABLE IF EXISTS `core_categoriaproducto`;
CREATE TABLE `core_categoriaproducto` (
  `idcategoriaProducto` int(11) NOT NULL,
  `nombrecategoriaProducto` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Estructura de tabla para la tabla `core_inventario`
--

DROP TABLE IF EXISTS `core_inventario`;
CREATE TABLE `core_inventario` (
  `id` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `idBodega_id` int(11) NOT NULL,
  `idProducto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_marca`
--

DROP TABLE IF EXISTS `core_marca`;
CREATE TABLE `core_marca` (
  `idMarca` int(11) NOT NULL,
  `nombreMarca` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_producto`
--

DROP TABLE IF EXISTS `core_producto`;
CREATE TABLE `core_producto` (
  `idProducto` int(11) NOT NULL,
  `nombreProducto` varchar(50) NOT NULL,
  `precioProducto` int(11) NOT NULL,
  `imagenProducto` varchar(100) DEFAULT NULL,
  `descripcionProducto` varchar(200) NOT NULL,
  `idMarca_id` int(11) NOT NULL,
  `idcategoriaProducto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'Región Metropolitana');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_rolusuario`
--

DROP TABLE IF EXISTS `core_rolusuario`;
CREATE TABLE `core_rolusuario` (
  `idRol` int(11) NOT NULL,
  `nombreRol` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'pbkdf2_sha256$216000$fLKwwopsDnLm$yviybI29Xy+gn/KYbdDOIEVkE75oXSsAyzXr+zZdwnU=', '2024-05-10 02:43:33.038090', 1, 'admin', '', '', 'admin@ferremas.cl', 1, 1, '2024-05-10 02:41:37.775723', '1.001.111-1', 'Admin', 'Rey', 'Supremo', 'Magnifico', 'admin@ferremas.cl', '2024-05-18', 'dioses 123', NULL, NULL);

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

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-05-10 02:44:06.997236', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"Pnombre\", \"Run\", \"Snombre\", \"Ap paterno\", \"Ap materno\", \"Correo usuario\", \"Fecha nacimiento\", \"Direccion\"]}}]', 15, 1),
(2, '2024-05-10 02:46:07.710107', '1', 'Región Metropolitana', 1, '[{\"added\": {}}]', 10, 1),
(3, '2024-05-10 02:46:27.811301', '1', 'Puente Alto', 1, '[{\"added\": {}}]', 8, 1),
(4, '2024-05-10 02:46:36.329595', '2', 'La Florida', 1, '[{\"added\": {}}]', 8, 1);

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
(6, 'core', 'bodega'),
(7, 'core', 'categoriaproducto'),
(8, 'core', 'comuna'),
(14, 'core', 'inventario'),
(9, 'core', 'marca'),
(13, 'core', 'producto'),
(10, 'core', 'region'),
(11, 'core', 'rolusuario'),
(12, 'core', 'sucursal'),
(15, 'core', 'usuariocustom'),
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
(1, 'contenttypes', '0001_initial', '2024-05-10 02:24:49.329275'),
(2, 'contenttypes', '0002_remove_content_type_name', '2024-05-10 02:24:49.361332'),
(3, 'auth', '0001_initial', '2024-05-10 02:24:49.394301'),
(4, 'auth', '0002_alter_permission_name_max_length', '2024-05-10 02:24:49.496758'),
(5, 'auth', '0003_alter_user_email_max_length', '2024-05-10 02:24:49.505157'),
(6, 'auth', '0004_alter_user_username_opts', '2024-05-10 02:24:49.510557'),
(7, 'auth', '0005_alter_user_last_login_null', '2024-05-10 02:24:49.515090'),
(8, 'auth', '0006_require_contenttypes_0002', '2024-05-10 02:24:49.517301'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2024-05-10 02:24:49.522608'),
(10, 'auth', '0008_alter_user_username_max_length', '2024-05-10 02:24:49.528387'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2024-05-10 02:24:49.533566'),
(12, 'auth', '0010_alter_group_name_max_length', '2024-05-10 02:24:49.541327'),
(13, 'auth', '0011_update_proxy_permissions', '2024-05-10 02:24:49.547068'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2024-05-10 02:24:49.551244'),
(15, 'core', '0001_initial', '2024-05-10 02:24:49.713428'),
(16, 'admin', '0001_initial', '2024-05-10 02:24:49.987262'),
(17, 'admin', '0002_logentry_remove_auto_add', '2024-05-10 02:24:50.046262'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2024-05-10 02:24:50.057075'),
(19, 'sessions', '0001_initial', '2024-05-10 02:24:50.068487'),
(20, 'core', '0002_auto_20240509_2240', '2024-05-10 02:40:37.447253'),
(21, 'core', '0003_auto_20240509_2241', '2024-05-10 02:41:24.749903');

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
-- Indices de la tabla `core_bodega`
--
ALTER TABLE `core_bodega`
  ADD PRIMARY KEY (`idBodega`),
  ADD KEY `core_bodega_idSucursal_id_6bb14e19_fk_core_sucursal_idSucursal` (`idSucursal_id`);

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
-- Indices de la tabla `core_inventario`
--
ALTER TABLE `core_inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_inventario_idBodega_id_7357528f_fk_core_bodega_idBodega` (`idBodega_id`),
  ADD KEY `core_inventario_idProducto_id_b8635577_fk_core_prod` (`idProducto_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `core_bodega`
--
ALTER TABLE `core_bodega`
  MODIFY `idBodega` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_categoriaproducto`
--
ALTER TABLE `core_categoriaproducto`
  MODIFY `idcategoriaProducto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_comuna`
--
ALTER TABLE `core_comuna`
  MODIFY `idComuna` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `core_inventario`
--
ALTER TABLE `core_inventario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_marca`
--
ALTER TABLE `core_marca`
  MODIFY `idMarca` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_producto`
--
ALTER TABLE `core_producto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_region`
--
ALTER TABLE `core_region`
  MODIFY `idRegion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `core_rolusuario`
--
ALTER TABLE `core_rolusuario`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_sucursal`
--
ALTER TABLE `core_sucursal`
  MODIFY `idSucursal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_usuariocustom`
--
ALTER TABLE `core_usuariocustom`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
-- Filtros para la tabla `core_bodega`
--
ALTER TABLE `core_bodega`
  ADD CONSTRAINT `core_bodega_idSucursal_id_6bb14e19_fk_core_sucursal_idSucursal` FOREIGN KEY (`idSucursal_id`) REFERENCES `core_sucursal` (`idSucursal`);

--
-- Filtros para la tabla `core_comuna`
--
ALTER TABLE `core_comuna`
  ADD CONSTRAINT `core_comuna_idRegion_id_8eb1d498_fk_core_region_idRegion` FOREIGN KEY (`idRegion_id`) REFERENCES `core_region` (`idRegion`);

--
-- Filtros para la tabla `core_inventario`
--
ALTER TABLE `core_inventario`
  ADD CONSTRAINT `core_inventario_idBodega_id_7357528f_fk_core_bodega_idBodega` FOREIGN KEY (`idBodega_id`) REFERENCES `core_bodega` (`idBodega`),
  ADD CONSTRAINT `core_inventario_idProducto_id_b8635577_fk_core_prod` FOREIGN KEY (`idProducto_id`) REFERENCES `core_producto` (`idProducto`);

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
