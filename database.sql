-- Script de creación de Base de Datos para el Ejercicio
CREATE DATABASE IF NOT EXISTS empleados CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE empleados;

DROP TABLE IF EXISTS empleados;

CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NOT NULL,
    edad INT NOT NULL
);

-- Registros iniciales de prueba (opcionales)
INSERT INTO empleados (nombres, apellido1, apellido2, edad) VALUES
('Carlos', 'Gómez', 'Pérez', 28),
('Laura', 'Martínez', 'Ríos', 34);
