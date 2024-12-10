-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-11-2024 a las 04:30:15
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
-- Base de datos: `ambusos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ambulancia`
--

CREATE TABLE `ambulancia` (
  `id` int(11) NOT NULL,
  `placa` varchar(10) NOT NULL,
  `categoria_ambulancia` enum('Básica','Medicalizada','UTIM') NOT NULL,
  `hospital_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ambulancia`
--

INSERT INTO `ambulancia` (`id`, `placa`, `categoria_ambulancia`, `hospital_id`) VALUES
(1, 'ABC123', 'Básica', 1),
(2, 'XYZ987', 'Medicalizada', 1),
(3, 'DEF456', 'UTIM', 1),
(4, 'GHI789', 'Básica', 2),
(5, 'JKL012', 'Medicalizada', 2),
(6, 'MNO345', 'UTIM', 2),
(7, 'PQR678', 'Básica', 3),
(8, 'STU901', 'Medicalizada', 3),
(9, 'VWX234', 'UTIM', 3),
(10, 'YZA567', 'Básica', 3),
(11, 'BCD890', 'Medicalizada', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formularioaccidente`
--

CREATE TABLE `formularioaccidente` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `numero_documento` varchar(255) DEFAULT NULL,
  `genero` enum('M','F','Otro') NOT NULL,
  `seguro_medico` varchar(100) DEFAULT NULL,
  `reporte_accidente` text NOT NULL,
  `fecha_reporte` timestamp NOT NULL DEFAULT current_timestamp(),
  `ubicacion` varchar(255) DEFAULT NULL,
  `EPS` varchar(100) NOT NULL,
  `estado` enum('leve','moderado','grave','critico') NOT NULL,
  `ambulancia_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `formularioaccidente`
--

INSERT INTO `formularioaccidente` (`id`, `nombre`, `apellido`, `numero_documento`, `genero`, `seguro_medico`, `reporte_accidente`, `fecha_reporte`, `ubicacion`, `EPS`, `estado`, `ambulancia_id`) VALUES
(1, 'Carlos', 'Ramírez', '12345678', 'M', 'SaludPlus', 'Accidente en carretera', '2024-10-25 18:11:18', 'Centro de la ciudad', 'Sanitas', 'moderado', 1),
(2, 'Ana', 'López', '87654321', 'F', 'MedPro', 'Caída en sitio de trabajo', '2024-10-25 18:11:18', 'Zona industrial', 'SURA', 'leve', 2),
(3, 'Luis', 'Martínez', '34567890', 'M', 'SegurVida', 'Fractura en pierna', '2024-10-25 18:11:18', 'Parque central', 'Compensar', 'grave', 6),
(4, 'Elena', 'Pérez', '23456789', 'F', 'HealthSecure', 'Golpe en la cabeza', '2024-10-25 18:11:18', 'Estación de tren', 'Famisanar', 'moderado', 3),
(5, 'Miguel', 'Sánchez', '98765432', 'M', 'SaludPlus', 'Quemadura leve', '2024-10-25 18:11:18', 'Aeropuerto internacional', 'Medimás', 'leve', 7),
(6, 'Jorge', 'Hernández', '54321678', 'M', 'MedPro', 'Accidente automovilístico', '2024-10-25 18:11:18', 'Hospital General', 'Famisanar', 'grave', 9),
(7, 'Laura', 'Gómez', '45678901', 'F', 'SegurVida', 'Desmayo en la vía pública', '2024-10-25 18:11:18', 'Universidad Estatal', 'Sanitas', 'leve', 10),
(8, 'Juan', 'Torres', '65432109', 'M', 'HealthSecure', 'Herida en brazo', '2024-10-25 18:11:18', 'Centro Comercial', 'SURA', 'leve', 5),
(9, 'Diana', 'Castillo', '76543218', 'F', 'SaludPlus', 'Intoxicación alimentaria', '2024-10-25 18:11:18', 'Museo de Historia', 'Sanitas', 'leve', 8),
(10, 'Roberto', 'Núñez', '43210987', 'M', 'MedPro', 'Accidente en construcción', '2024-10-25 18:11:18', 'Estadio Municipal', 'Compensar', 'moderado', 11),
(11, 'Marta', 'Ortega', '10987654', 'F', 'SegurVida', 'Caída en escaleras', '2024-10-25 18:11:18', 'Playa Norte', 'Famisanar', 'moderado', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hospitales`
--

CREATE TABLE `hospitales` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `capacidad_atencion` int(11) NOT NULL,
  `categoria` enum('General','Especializado','Clínica','Emergencias') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `hospitales`
--

INSERT INTO `hospitales` (`id`, `nombre`, `direccion`, `capacidad_atencion`, `categoria`) VALUES
(1, 'Hospital Central', 'Av. Libertador 1234', 200, 'General'),
(2, 'Clínica del Sol', 'Calle Luna 567', 100, 'Clínica'),
(3, 'Centro Médico Norte', 'Calle Sur 789', 150, 'Especializado'),
(4, 'Hospital San Juan', 'Av. Bolívar 456', 250, 'Emergencias'),
(5, 'Clínica Santa María', 'Calle Principal 321', 80, 'Clínica'),
(6, 'Centro de Emergencias', 'Av. Urgente 111', 120, 'Emergencias'),
(7, 'Hospital del Oeste', 'Av. Principal 654', 180, 'General'),
(8, 'Hospital de los Andes', 'Av. Montaña 333', 130, 'Especializado'),
(9, 'Clínica MedSalud', 'Calle Salud 444', 90, 'Clínica'),
(10, 'Hospital Regional', 'Av. Libertad 555', 300, 'General'),
(11, 'Clínica Norte', 'Av. Norte 1010', 50, 'Clínica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE `personal` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `estado` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `correo` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `ambulancia_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`id`, `nombre`, `apellido`, `numero_documento`, `estado`, `correo`, `contraseña`, `rol_id`, `ambulancia_id`) VALUES
(1, 'José', 'Martínez', 'A1234567', 'Activo', 'jose.martinez@example.com', 'Ij+xoNpqSmwqtmq6Jxq3sg==', 2, 1),
(2, 'Ana', 'Rodríguez', 'B8765432', 'Activo', 'ana.rodriguez@example.com', 'vOGalIqmBKc/R47Ge2FLyA==', 3, 1),
(3, 'Pedro', 'Santos', 'C3456789', 'Inactivo', 'pedro.santos@example.com', 'I8KG4kSLMiBZuVY9i3EGzw==', 4, 1),
(4, 'Carlos', 'Gómez', 'D2345678', 'Activo', 'carlos.gomez@example.com', 'B3RjOifAGeqy/7Y71KBDrA==', 2, 2),
(5, 'Lucía', 'Pérez', 'E9876543', 'Inactivo', 'lucia.perez@example.com', 'xaW+oYdO6uifGWRqsna0ow==', 3, 2),
(6, 'Raúl', 'López', 'F5432167', 'Activo', 'raul.lopez@example.com', 'NgAodrOR+M/Rdg74UUIloQ==', 4, 2),
(7, 'Diana', 'Morales', 'G4567890', 'Activo', 'diana.morales@example.com', '1SpmNy1Y0E0SCjbPIEi4sg==', 2, 4),
(8, 'Laura', 'Romero', 'H6543210', 'Activo', 'laura.romero@example.com', 'EE4w3qFFw0g0/3sL+zwv8Q==', 3, NULL),
(9, 'Miguel', 'Vargas', 'I7654321', 'Inactivo', 'miguel.vargas@example.com', 'pILjxg5SZlZ7vBTP1EtgYg==', 4, NULL),
(10, 'María', 'Herrera', 'J4321098', 'Activo', 'maria.herrera@example.com', 'eg92lbHn269CEXs/F1Egkw==', 2, NULL),
(11, 'Claudia', 'García', 'K1098765', 'Activo', 'claudia.garcia@example.com', '/Qcy2mlGFF73RAluM6RxHw==', 3, NULL),
(72, 'Elena', 'Martínez', 'U1234567', 'Activo', 'elena.martinez@example.com', 'jiji', 4, NULL),
(73, 'juju', 'heredia', '1324534564', 'Activo', 'admin@gmail.com', 'PpjkydEK3Aq8LqS0uKum6g==', 2, NULL),
(75, 'sergtio', 'r', '3214587942', 'Activo', 'sergio@gmail.com', 'hola', 3, 10),
(76, 'juju', 'heredia', '13245344', 'Activo', 'julianhh.com', '123', 2, 11),
(78, 'sergtio', 'fierro', '7265387265', 'Activo', 'sergio@gmail.com', 'siu', 1, NULL);

--
-- Disparadores `personal`
--
DELIMITER $$
CREATE TRIGGER `before_insert_personal` BEFORE INSERT ON `personal` FOR EACH ROW BEGIN
    DECLARE rol_nombre VARCHAR(255);
    SELECT nombre INTO rol_nombre FROM roles WHERE id = NEW.rol_id;
    SET NEW.rol_id = rol_nombre;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validar_actualizacion_asignacion_ambulancia` BEFORE UPDATE ON `personal` FOR EACH ROW BEGIN
    DECLARE total_conductores INT;
    DECLARE total_paramedicos INT;
    DECLARE total_enfermeros INT;

    -- Validar que no se pueda asignar ambulancia a un administrador
    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Administrador') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede asignar una ambulancia a un administrador.';
    END IF;

    -- Validar asignación de conductor
    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Conductor') THEN
        SELECT COUNT(*) INTO total_conductores 
        FROM personal 
        WHERE ambulancia_id = NEW.ambulancia_id 
          AND rol_id = (SELECT id FROM roles WHERE nombre = 'Conductor') 
          AND id != NEW.id;
        IF total_conductores >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La ambulancia ya tiene un conductor asignado.';
        END IF;
    END IF;

    -- Validar asignación de paramédico
    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Paramédico') THEN
        SELECT COUNT(*) INTO total_paramedicos 
        FROM personal 
        WHERE ambulancia_id = NEW.ambulancia_id 
          AND rol_id = (SELECT id FROM roles WHERE nombre = 'Paramédico') 
          AND id != NEW.id;
        IF total_paramedicos >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La ambulancia ya tiene un paramédico asignado.';
        END IF;
    END IF;

    -- Validar asignación de enfermero
    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Enfermero') THEN
        SELECT COUNT(*) INTO total_enfermeros 
        FROM personal 
        WHERE ambulancia_id = NEW.ambulancia_id 
          AND rol_id = (SELECT id FROM roles WHERE nombre = 'Enfermero') 
          AND id != NEW.id;
        IF total_enfermeros >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La ambulancia ya tiene un enfermero asignado.';
        END IF;
    END IF;

    -- Validar que no se pueda asignar más de 3 roles por ambulancia
    IF (
        (SELECT COUNT(*) 
         FROM personal 
         WHERE ambulancia_id = NEW.ambulancia_id AND id != NEW.id) >= 3
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La ambulancia ya tiene asignadas las 3 personas permitidas.';
    END IF;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validar_asignacion_ambulancia` BEFORE INSERT ON `personal` FOR EACH ROW BEGIN
    DECLARE total_conductores INT;
    DECLARE total_paramedicos INT;
    DECLARE total_enfermeros INT;

    -- Validar que no se pueda asignar ambulancia a un administrador
    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Administrador') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede asignar una ambulancia a un administrador.';
    END IF;

    -- Validar asignación de conductor
    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Conductor') THEN
        SELECT COUNT(*) INTO total_conductores 
        FROM personal 
        WHERE ambulancia_id = NEW.ambulancia_id AND rol_id = (SELECT id FROM roles WHERE nombre = 'Conductor');
        IF total_conductores >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La ambulancia ya tiene un conductor asignado.';
        END IF;
    END IF;

    -- Validar asignación de paramédico
    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Paramédico') THEN
        SELECT COUNT(*) INTO total_paramedicos 
        FROM personal 
        WHERE ambulancia_id = NEW.ambulancia_id AND rol_id = (SELECT id FROM roles WHERE nombre = 'Paramédico');
        IF total_paramedicos >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La ambulancia ya tiene un paramédico asignado.';
        END IF;
    END IF;

    -- Validar asignación de enfermero
    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Enfermero') THEN
        SELECT COUNT(*) INTO total_enfermeros 
        FROM personal 
        WHERE ambulancia_id = NEW.ambulancia_id AND rol_id = (SELECT id FROM roles WHERE nombre = 'Enfermero');
        IF total_enfermeros >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La ambulancia ya tiene un enfermero asignado.';
        END IF;
    END IF;

    -- Validar que no se pueda asignar más de 3 roles por ambulancia
    IF (
        (SELECT COUNT(*) 
         FROM personal 
         WHERE ambulancia_id = NEW.ambulancia_id) >= 3
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La ambulancia ya tiene asignadas las 3 personas permitidas.';
    END IF;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validar_asignacion_ambulancia_update` BEFORE UPDATE ON `personal` FOR EACH ROW BEGIN
    DECLARE total_conductores INT;
    DECLARE total_paramedicos INT;
    DECLARE total_enfermeros INT;

    -- Verificar el rol del nuevo personal
    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Conductor') THEN
        SELECT COUNT(*) INTO total_conductores 
        FROM personal 
        WHERE ambulancia_id = NEW.ambulancia_id AND rol_id = (SELECT id FROM roles WHERE nombre = 'Conductor') AND id != NEW.id;
        IF total_conductores >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La ambulancia ya tiene un conductor asignado.';
        END IF;
    END IF;

    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Paramédico') THEN
        SELECT COUNT(*) INTO total_paramedicos 
        FROM personal 
        WHERE ambulancia_id = NEW.ambulancia_id AND rol_id = (SELECT id FROM roles WHERE nombre = 'Paramédico') AND id != NEW.id;
        IF total_paramedicos >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La ambulancia ya tiene un paramédico asignado.';
        END IF;
    END IF;

    IF NEW.rol_id = (SELECT id FROM roles WHERE nombre = 'Enfermero') THEN
        SELECT COUNT(*) INTO total_enfermeros 
        FROM personal 
        WHERE ambulancia_id = NEW.ambulancia_id AND rol_id = (SELECT id FROM roles WHERE nombre = 'Enfermero') AND id != NEW.id;
        IF total_enfermeros >= 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La ambulancia ya tiene un enfermero asignado.';
        END IF;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reporte_viajes`
--

CREATE TABLE `reporte_viajes` (
  `id` int(11) NOT NULL,
  `ambulancia_asignada` int(11) NOT NULL,
  `tiempo` time NOT NULL,
  `paciente` varchar(50) DEFAULT NULL,
  `punto_i` varchar(100) DEFAULT NULL,
  `punto_f` varchar(100) DEFAULT NULL,
  `accidente_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reporte_viajes`
--

INSERT INTO `reporte_viajes` (`id`, `ambulancia_asignada`, `tiempo`, `paciente`, `punto_i`, `punto_f`, `accidente_id`) VALUES
(1, 1, '00:30:00', 'Carlos', 'Zona industrial', 'Centro de Emergencias', 2),
(2, 2, '01:00:00', NULL, NULL, NULL, NULL),
(3, 3, '00:45:00', NULL, NULL, NULL, NULL),
(4, 4, '01:20:00', NULL, NULL, NULL, NULL),
(5, 5, '00:50:00', NULL, NULL, NULL, NULL),
(6, 6, '01:10:00', NULL, NULL, NULL, NULL),
(7, 7, '00:40:00', NULL, NULL, NULL, NULL),
(8, 8, '01:05:00', NULL, NULL, NULL, NULL),
(9, 9, '00:35:00', NULL, NULL, NULL, NULL),
(10, 10, '00:55:00', NULL, NULL, NULL, NULL),
(11, 1, '00:30:00', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Conductor'),
(3, 'Enfermero'),
(4, 'Paramédico');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ambulancia`
--
ALTER TABLE `ambulancia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `placa` (`placa`),
  ADD UNIQUE KEY `placa_2` (`placa`),
  ADD KEY `fk_ambulancia_hospital` (`hospital_id`);

--
-- Indices de la tabla `formularioaccidente`
--
ALTER TABLE `formularioaccidente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_nombre_apellido` (`nombre`,`apellido`),
  ADD UNIQUE KEY `unique_nombre` (`nombre`),
  ADD UNIQUE KEY `numero_documento` (`numero_documento`),
  ADD UNIQUE KEY `idx_ubicacion` (`ubicacion`),
  ADD KEY `ubicacion` (`ubicacion`),
  ADD KEY `fk_formulario_ambulancia` (`ambulancia_id`);

--
-- Indices de la tabla `hospitales`
--
ALTER TABLE `hospitales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_2` (`nombre`),
  ADD KEY `nombre` (`nombre`);

--
-- Indices de la tabla `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_documento` (`numero_documento`),
  ADD UNIQUE KEY `numero_documento_2` (`numero_documento`),
  ADD KEY `fk_personal_rol_id` (`rol_id`),
  ADD KEY `fk_ambulancia_personal` (`ambulancia_id`);

--
-- Indices de la tabla `reporte_viajes`
--
ALTER TABLE `reporte_viajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ambulancia_asignada` (`ambulancia_asignada`),
  ADD KEY `fk_reporte_viajes_nombre` (`paciente`),
  ADD KEY `fk_reporte_formulario` (`punto_i`),
  ADD KEY `fk_punto_f_hospital_nombre` (`punto_f`),
  ADD KEY `fk_reporte_viajes_accidente` (`accidente_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ambulancia`
--
ALTER TABLE `ambulancia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `formularioaccidente`
--
ALTER TABLE `formularioaccidente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de la tabla `hospitales`
--
ALTER TABLE `hospitales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `personal`
--
ALTER TABLE `personal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `reporte_viajes`
--
ALTER TABLE `reporte_viajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ambulancia`
--
ALTER TABLE `ambulancia`
  ADD CONSTRAINT `fk_ambulancia_hospital` FOREIGN KEY (`hospital_id`) REFERENCES `hospitales` (`id`);

--
-- Filtros para la tabla `formularioaccidente`
--
ALTER TABLE `formularioaccidente`
  ADD CONSTRAINT `fk_formulario_ambulancia` FOREIGN KEY (`ambulancia_id`) REFERENCES `ambulancia` (`id`);

--
-- Filtros para la tabla `personal`
--
ALTER TABLE `personal`
  ADD CONSTRAINT `fk_ambulancia_personal` FOREIGN KEY (`ambulancia_id`) REFERENCES `ambulancia` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_personal_rol_id` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `reporte_viajes`
--
ALTER TABLE `reporte_viajes`
  ADD CONSTRAINT `fk_punto_f_hospital_nombre` FOREIGN KEY (`punto_f`) REFERENCES `hospitales` (`nombre`),
  ADD CONSTRAINT `fk_reporte_formulario` FOREIGN KEY (`punto_i`) REFERENCES `formularioaccidente` (`ubicacion`),
  ADD CONSTRAINT `fk_reporte_viajes_accidente` FOREIGN KEY (`accidente_id`) REFERENCES `formularioaccidente` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reporte_viajes_nombre` FOREIGN KEY (`paciente`) REFERENCES `formularioaccidente` (`nombre`),
  ADD CONSTRAINT `reporte_viajes_ibfk_1` FOREIGN KEY (`ambulancia_asignada`) REFERENCES `ambulancia` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
