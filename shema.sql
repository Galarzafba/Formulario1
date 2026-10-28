CREATE DATABASE IF NOT EXISTS tienda_db CHARACTER SET utf8mb4;
USE tienda_db;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS marcas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    imagen VARCHAR(255),
    id_categoria INT,
    id_marca INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id),
    FOREIGN KEY (id_marca) REFERENCES marcas(id)
);

CREATE TABLE IF NOT EXISTS contactos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    mensaje TEXT NOT NULL
);

TRUNCATE TABLE productos;
DELETE FROM categorias;
DELETE FROM marcas;

INSERT INTO categorias (id, nombre) VALUES 
  (1, 'Hoodies & Sudaderas'), 
  (2, 'Playeras'), 
  (3, 'Pantalones & Jeans'), 
  (4, 'Gorras');

INSERT INTO marcas (id, nombre) VALUES 
  (1, 'Denim Tears'),
  (2, 'Hellstar'), 
  (3, 'Amiri'), 
  (4, 'Valley Dreams'), 
  (5, 'Barbas Hats'), 
  (6, 'Dandy');

INSERT INTO productos (nombre, precio, imagen, id_categoria, id_marca) VALUES
  ('hoodie manga larga Cotton Wreath', 8662.00, 'img/denim-tears-hoodie.jpg', 1, 1),
  ('playera manga larga Wreath', 7180.00, 'img/denim-tears-sweatshirt.jpg', 2, 1),
  ('jeans Cotton Wreath Light Wash', 9200.00, 'img/denim-tears-jeans.jpg', 3, 1),
  ('hoodie Path to Paradise', 5800.00, 'img/hoodie-hellstar.jpg', 1, 2),
  ('playera Graphic Studios', 3200.00, 'img/playera-hellstar.jpg', 2, 2),
  ('jeans MX1 Distressed', 18500.00, 'img/jeans-amiri.jpg', 3, 3),
  ('sudadera Core Logo', 12500.00, 'img/sudadera-amiri.jpg', 1, 3),
  ('playera Oversized Logo', 1900.00, 'img/playera-valleydreams.jpg', 2, 4),
  ('gorra Edition Black', 2400.00, 'img/gorra-barbas-black.jpg', 4, 5),
  ('gorra Crown Signature', 2800.00, 'img/gorra-dandy-crown.jpg', 4, 6);

