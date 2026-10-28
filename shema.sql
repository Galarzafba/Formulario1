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
  (1, 'Hellstar'), 
  (2, 'Amiri'), 
  (3, 'Valley Dreams'), 
  (4, 'Barbas Hats'), 
  (5, 'Dandy');

INSERT INTO productos (nombre, precio, imagen, id_categoria, id_marca) VALUES
  ('Hoodie Hellstar Path to Paradise', 280.00, 'img/hoodie-hellstar.jpg', 1, 1),
  ('Playera Graphic Hellstar Studios', 150.00, 'img/playera-hellstar.jpg', 2, 1),
  ('Jeans Amiri MX1 Distressed', 890.00, 'img/jeans-amiri.jpg', 3, 2),
  ('Sudadera Amiri Core Logo', 650.00, 'img/sudadera-amiri.jpg', 1, 2),
  ('Playera Valley Dreams Oversized', 95.00, 'img/playera-valleydreams.jpg', 2, 3),
  ('Jogger Valley Dreams Essential', 120.00, 'img/jogger-valleydreams.jpg', 3, 3),
  ('Gorra Barbas Hats Edition Black', 110.00, 'img/gorra-barbas-black.jpg', 4, 4),
  ('Gorra Barbas Hats Leather Patch', 125.00, 'img/gorra-barbas-leather.jpg', 4, 4),
  ('Gorra Dandy Crown Signature', 140.00, 'img/gorra-dandy-crown.jpg', 4, 5),
  ('Gorra Dandy Velvet Edition', 160.00, 'img/gorra-dandy-velvet.jpg', 4, 5);
