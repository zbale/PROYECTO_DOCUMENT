CREATE DATABASE IF NOT EXISTS Proyecto_modificado;
USE Proyecto_modificado;

CREATE TABLE Usuario (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  telefono VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  tipo_usuario ENUM('cliente', 'administrador') NOT NULL
);

CREATE TABLE Direccion_Usuario (
  id_direccion INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  direccion VARCHAR(255) NOT NULL,
  ciudad VARCHAR(100) NOT NULL,
  departamento VARCHAR(100) NOT NULL,
  codigo_postal VARCHAR(10),
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Metodo_Pago (
  id_metodo INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Estado_Pedido (
  id_estado INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Factura (
  id_factura INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_metodo INT NOT NULL,
  id_estado INT NOT NULL DEFAULT 1,  -- Por defecto "Pendiente"
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total INT NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_metodo) REFERENCES Metodo_Pago(id_metodo),
  FOREIGN KEY (id_estado) REFERENCES Estado_Pedido(id_estado)
);

CREATE TABLE Producto (
  id_producto INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  descripcion TEXT,
  precio DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE Historial_Stock (
  id_historial INT PRIMARY KEY AUTO_INCREMENT,
  id_producto INT NOT NULL,
  cantidad_cambiada INT NOT NULL,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  motivo VARCHAR(100),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Detalle_Factura (
  id_detalle INT PRIMARY KEY AUTO_INCREMENT,
  id_factura INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad INT NOT NULL CHECK (cantidad > 0),
  descuento DECIMAL(5,2) DEFAULT 0 CHECK (descuento BETWEEN 0 AND 100),
  FOREIGN KEY (id_factura) REFERENCES Factura(id_factura),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Categoria_Producto (
  id_categoria INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Producto_Categoria (
  id_producto INT NOT NULL,
  id_categoria INT NOT NULL,
  PRIMARY KEY (id_producto, id_categoria),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
  FOREIGN KEY (id_categoria) REFERENCES Categoria_Producto(id_categoria)
);

CREATE TABLE Carro_Compra (
  id_carro INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad INT NOT NULL CHECK (cantidad > 0),
  agregado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Valoracion (
  id_valoracion INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_producto INT NOT NULL,
  calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
  comentario TEXT,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Oferta (
  id_oferta INT PRIMARY KEY AUTO_INCREMENT,
  id_producto INT NOT NULL,
  porcentaje_descuento DECIMAL(5,2) CHECK (porcentaje_descuento BETWEEN 0 AND 100),
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);