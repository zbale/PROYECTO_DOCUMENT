CREATE DATABASE IF NOT EXISTS ecomerce;
USE ecomerce;

-- Usuarios
CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    direccion TEXT,
    contraseña VARCHAR(255) NOT NULL, -- Se recomienda encriptar con bcrypt
    tipo_usuario ENUM('cliente', 'administrador') NOT NULL DEFAULT 'cliente'
);

-- Productos
CREATE TABLE Producto (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0),
    imagen VARCHAR(255) -- URL de la imagen del producto
);

-- Pedidos
CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente', 'procesando', 'enviado', 'entregado', 'cancelado') NOT NULL DEFAULT 'pendiente',
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- Detalles de Pedido (Relacion entre Pedido y Producto)
CREATE TABLE DetallePedido (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto) ON DELETE CASCADE
);

-- Historial de Compras
CREATE TABLE HistorialCompras (
    id_historial INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_pedido INT NOT NULL,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE
);

-- Gestion de Usuarios (Recuperacion de Contraseña y Administracion)
CREATE TABLE GestionUsuarios (
    id_gestion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    accion ENUM('recuperar_contraseña', 'cambio_datos', 'suspension', 'otro') NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- Edicion de Perfil
CREATE TABLE EdicionPerfil (
    id_edicion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    campo_editado ENUM('nombre', 'apellido', 'email', 'telefono', 'direccion', 'contraseña') NOT NULL,
    valor_anterior TEXT NOT NULL,
    valor_nuevo TEXT NOT NULL,
    fecha_edicion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- Añadir Usuario (solo administradores pueden añadir usuarios)
CREATE TABLE AdministracionUsuarios (
    id_admin INT PRIMARY KEY AUTO_INCREMENT,
    id_administrador INT NOT NULL,
    id_usuario_nuevo INT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_administrador) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario_nuevo) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- En la tabla de los Usuarios 
-- Insertar usuarios
INSERT INTO Usuario (nombre, apellido, email, telefono, direccion, contraseña, tipo_usuario) 
VALUES ('Juan', 'Pérez', 'juan.perez@example.com', '3123456789', 'Calle 123', '123456', 'cliente');

-- Obtener todos los usuarios
SELECT * FROM Usuario;

-- Buscar un usuario por email
SELECT * FROM Usuario WHERE email = 'juan.perez@example.com';

-- Actualizar el telefono de un usuario
UPDATE Usuario SET telefono = '3209876543' WHERE email = 'juan.perez@example.com';

-- Cambiar la contraseña de un usuario
UPDATE Usuario SET contraseña = 'nueva_clave_segura' WHERE id_usuario = 1;

-- Eliminar un usuario (solo si no tiene pedidos)
DELETE FROM Usuario WHERE id_usuario = 5;

-- Contar cuantos clientes y administradores hay
SELECT tipo_usuario, COUNT(*) AS cantidad FROM Usuario GROUP BY tipo_usuario;

-- Obtener solo los administradores
SELECT * FROM Usuario WHERE tipo_usuario = 'administrador';

-- Buscar usuarios cuyo nombre empiece con 'J'
SELECT * FROM Usuario WHERE nombre LIKE 'J%';

-- Mostrar los 5 usuarios mas recientes
SELECT * FROM Usuario ORDER BY id_usuario DESC LIMIT 5;

-- En la tabla de productos
-- Insertar producto
INSERT INTO Producto (nombre, descripcion, precio, stock, imagen) 
VALUES ('Laptop Gamer', 'Laptop con RTX 3060 y 16GB RAM', 4999000, 10, 'laptop.jpg');

-- Obtener todos los productos
SELECT * FROM Producto;

--  Buscar un producto por nombre
SELECT * FROM Producto WHERE nombre LIKE '%Laptop%';

-- Actualizar el stock de un producto
UPDATE Producto SET stock = stock - 1 WHERE id_producto = 2;

-- Aumentar precio de los productos en un 10%
UPDATE Producto SET precio = precio * 1.10;

-- Eliminar un producto por ID
DELETE FROM Producto WHERE id_producto = 5;

-- Obtener los productos con stock menor a 5
SELECT * FROM Producto WHERE stock < 5;

-- Contar cuantos productos hay en la tienda
SELECT COUNT(*) AS total_productos FROM Producto;

-- Mostrar los 3 productos mas caros
SELECT * FROM Producto ORDER BY precio DESC LIMIT 3;

-- Mostrar los productos en orden alfabetico
SELECT * FROM Producto ORDER BY nombre ASC;


-- En la tabla de Pedidos
-- Insertar pedido
INSERT INTO Pedido (id_usuario, total) VALUES (1, 199.99);

-- Obtener todos los pedidos
SELECT * FROM Pedido;

-- Buscar pedidos de un usuario específico
SELECT * FROM Pedido WHERE id_usuario = 1;

-- Cambiar el estado de un pedido
UPDATE Pedido SET estado = 'enviado' WHERE id_pedido = 3;

-- Obtener pedidos que estan pendientes
SELECT * FROM Pedido WHERE estado = 'pendiente';

-- Contar cuantos pedidos hay por estado
SELECT estado, COUNT(*) FROM Pedido GROUP BY estado;

-- Obtener los ultimos 5 pedidos
SELECT * FROM Pedido ORDER BY fecha_pedido DESC LIMIT 5;

-- Calcular el total de ventas
SELECT SUM(total) AS total_ventas FROM Pedido;

-- Buscar pedidos con total mayor a 500
SELECT * FROM Pedido WHERE total > 500;

-- Eliminar un pedido (solo si esta pendiente)
DELETE FROM Pedido WHERE id_pedido = 4 AND estado = 'pendiente';

-- En la tabla Detalles de Pedido
-- Insertar un detalle de pedido
INSERT INTO DetallePedido (id_pedido, id_producto, cantidad, precio_unitario) 
VALUES (1, 2, 3, 49.99);

-- Obtener los detalles de un pedido
SELECT * FROM DetallePedido WHERE id_pedido = 1;

-- Obtener el total gastado en un pedido
SELECT id_pedido, SUM(cantidad * precio_unitario) AS total FROM DetallePedido WHERE id_pedido = 1 GROUP BY id_pedido;

-- Mostrar los productos de un pedido con su cantidad
SELECT P.nombre, D.cantidad FROM DetallePedido D JOIN Producto P ON D.id_producto = P.id_producto WHERE id_pedido = 1;

-- Contar cuántos productos distintos tiene un pedido
SELECT COUNT(DISTINCT id_producto) FROM DetallePedido WHERE id_pedido = 1;

-- Eliminar un detalle de pedido
DELETE FROM DetallePedido WHERE id_detalle = 2;

-- Mostrar los pedidos con más de 5 productos
SELECT id_pedido, SUM(cantidad) AS total_productos FROM DetallePedido GROUP BY id_pedido HAVING total_productos > 5;

-- Obtener los 3 productos más comprados
SELECT id_producto, SUM(cantidad) AS total_vendidos FROM DetallePedido GROUP BY id_producto ORDER BY total_vendidos DESC LIMIT 3;

-- Buscar pedidos donde se compraron más de 3 unidades de un mismo producto
SELECT id_pedido FROM DetallePedido WHERE cantidad > 3;

-- Actualizar la cantidad de un producto en un pedido
UPDATE DetallePedido SET cantidad = 4 WHERE id_detalle = 5;

-- En la tabla de Historial de Compras
-- Insertar una compra en el historial
INSERT INTO HistorialCompras (id_usuario, id_pedido) VALUES (1, 3);

-- Obtener el historial de compras de un usuario
SELECT * FROM HistorialCompras WHERE id_usuario = 1;

-- Contar cuantas compras ha hecho un usuario
SELECT COUNT(*) FROM HistorialCompras WHERE id_usuario = 1;

-- Obtener la última compra de un usuario
SELECT * FROM HistorialCompras WHERE id_usuario = 1 ORDER BY fecha_compra DESC LIMIT 1;

-- Eliminar un registro del historial
DELETE FROM HistorialCompras WHERE id_historial = 4;

-- Obtener compras hechas en los ultimos 30 días
SELECT * FROM HistorialCompras WHERE fecha_compra >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);

-- Mostrar los usuarios con mas compras
SELECT id_usuario, COUNT(*) AS total_compras FROM HistorialCompras GROUP BY id_usuario ORDER BY total_compras DESC LIMIT 5;

-- Obtener pedidos hechos en una fecha específica
SELECT * FROM HistorialCompras WHERE DATE(fecha_compra) = '2024-03-15';

-- Mostrar compras junto con datos del usuario
SELECT H.*, U.nombre, U.apellido FROM HistorialCompras H JOIN Usuario U ON H.id_usuario = U.id_usuario;

-- Mostrar la primera compra de cada usuario
SELECT id_usuario, MIN(fecha_compra) AS primera_compra FROM HistorialCompras GROUP BY id_usuario;