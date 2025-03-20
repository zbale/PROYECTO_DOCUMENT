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


