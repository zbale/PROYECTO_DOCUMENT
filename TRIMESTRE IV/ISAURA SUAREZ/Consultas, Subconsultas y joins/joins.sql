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

-- los join
-- Mostar los pedidos junto con el nombre del usuario que los hizo
SELECT Pedido.id_pedido, Pedido.fecha, Usuario.nombre, Usuario.apellido 
FROM Pedido 
INNER JOIN Usuario ON Pedido.id_usuario = Usuario.id_usuario;

-- Lista de los productos que forman parte de cada pedido con su cantidad
SELECT PedidoDetalle.id_pedido, Producto.nombre AS producto, PedidoDetalle.cantidad 
FROM PedidoDetalle 
INNER JOIN Producto ON PedidoDetalle.id_producto = Producto.id_producto;

-- Mostrar solo los usuarios que han hecho al menos un pedido.
SELECT DISTINCT Usuario.id_usuario, Usuario.nombre, Usuario.apellido 
FROM Usuario 
INNER JOIN Pedido ON Usuario.id_usuario = Pedido.id_usuario;

-- Lista de los usuarios que aun no han hecho un pedido
SELECT Usuario.id_usuario, Usuario.nombre, Usuario.apellido 
FROM Usuario 
LEFT JOIN Pedido ON Usuario.id_usuario = Pedido.id_usuario 
WHERE Pedido.id_pedido IS NULL;

-- Calcular cuanto ha gastado cada usuario sumando los precios de los productos en sus pedidos
SELECT Usuario.id_usuario, Usuario.nombre, SUM(Producto.precio * PedidoDetalle.cantidad) AS total_gastado 
FROM Usuario 
INNER JOIN Pedido ON Usuario.id_usuario = Pedido.id_usuario 
INNER JOIN PedidoDetalle ON Pedido.id_pedido = PedidoDetalle.id_pedido 
INNER JOIN Producto ON PedidoDetalle.id_producto = Producto.id_producto 
GROUP BY Usuario.id_usuario, Usuario.nombre;

-- Lista de los productos que no han sido comprados por ningun usuario
SELECT Producto.id_producto, Producto.nombre 
FROM Producto 
LEFT JOIN PedidoDetalle ON Producto.id_producto = PedidoDetalle.id_producto 
WHERE PedidoDetalle.id_pedido IS NULL;

-- Mostrar los pedidos junto con la informacion del usuario y los productos en cada pedido
SELECT Pedido.id_pedido, Usuario.nombre AS cliente, Producto.nombre AS producto, PedidoDetalle.cantidad 
FROM Pedido 
INNER JOIN Usuario ON Pedido.id_usuario = Usuario.id_usuario 
INNER JOIN PedidoDetalle ON Pedido.id_pedido = PedidoDetalle.id_pedido 
INNER JOIN Producto ON PedidoDetalle.id_producto = Producto.id_producto;

-- Mostrar cuantos productos ha pedido cada usuario en total.
SELECT Usuario.id_usuario, Usuario.nombre, SUM(PedidoDetalle.cantidad) AS total_productos 
FROM Usuario 
INNER JOIN Pedido ON Usuario.id_usuario = Pedido.id_usuario 
INNER JOIN PedidoDetalle ON Pedido.id_pedido = PedidoDetalle.id_pedido 
GROUP BY Usuario.id_usuario, Usuario.nombre;

-- Lista de los productos ordenados por la cantidad total vendida
SELECT Producto.id_producto, Producto.nombre, SUM(PedidoDetalle.cantidad) AS total_vendido 
FROM Producto 
INNER JOIN PedidoDetalle ON Producto.id_producto = PedidoDetalle.id_producto 
GROUP BY Producto.id_producto, Producto.nombre 
ORDER BY total_vendido DESC;

-- Mostrar la ultima compra de cada usuario
SELECT Usuario.id_usuario, Usuario.nombre, MAX(Pedido.fecha) AS ultima_compra 
FROM Usuario 
INNER JOIN Pedido ON Usuario.id_usuario = Pedido.id_usuario 
GROUP BY Usuario.id_usuario, Usuario.nombre;



