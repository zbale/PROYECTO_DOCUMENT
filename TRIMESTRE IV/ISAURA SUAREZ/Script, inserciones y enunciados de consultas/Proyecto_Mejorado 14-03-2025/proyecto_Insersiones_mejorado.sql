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
  precio DECIMAL(10,0) NOT NULL, 
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
  CHECK (fecha_inicio < fecha_fin),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Insersiones de los usuarioss (40)

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario)
VALUES ('Felipe', 'Lorenso', '320-567-876', 'felipelorenso@gmail.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Andres', 'Lopez', '320-456-7890', 'andreslopez@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Carolina', 'Ramirez', '310-987-6543', 'carolinaramirez@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Javier', 'Torres', '322-123-4567', 'javiertorres@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Maria Fernanda', 'Castro', '313-789-0123', 'mariafernandacastro@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Alejandro', 'Gomez', '311-555-6789', 'alejandrogomez@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Jose', 'Zabaleta', '323-599-5105', 'josezabaleta5@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Miguel', 'Torres', '301-777-8888', 'migueltorres@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Michael', 'Vasquez', '316-222-3333', 'michaelvazquez@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Jose', 'Daza', '305-111-2222', 'josedaza@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Sebastian', 'Vargas', '312-999-0000', 'sebastianvargas@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Lucia', 'Moreno', '319-654-7891', 'luciamoreno@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Fernando', 'Rojas', '314-321-9876', 'fernandorojas@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Diana', 'Mendoza', '308-741-2589', 'dianamendoza@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Camilo', 'Hernandez', '317-852-9634', 'camilohernandez@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Paula', 'Silva', '320-123-4567', 'paulasilva@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Hector', 'Navarro', '315-951-7532', 'hectornavarro@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Patricia', 'Cortes', '304-852-1479', 'patriciacortes@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Ruben', 'Quintero', '321-753-9514', 'rubenquintero@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Gabriela', 'Reyes', '318-369-2581', 'gabrielareyes@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Oscar', 'Linares', '312-147-2583', 'oscarlinares@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Veronica', 'Mendez', '319-789-1234', 'veronicamendez@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Ricardo', 'Peralta', '303-951-7896', 'ricardoperalta@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Natalia', 'Bermudez', '320-456-7891', 'nataliabermudez@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Esteban', 'Arango', '310-852-3697', 'estebanarango@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Camila', 'Zapata', '307-741-3698', 'camilazapata@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Jonathan', 'Fuentes', '305-852-7412', 'jonathanfuentes@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Monica', 'Salazar', '309-753-8521', 'monicasalazar@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Felipe', 'Guerra', '322-654-9871', 'felipeguerra@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Vanessa', 'Garcia', '306-852-9631', 'vanessagarcia@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Diego', 'Montoya', '311-456-7893', 'diegomontoya@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Isabela', 'Ortega', '323-987-6542', 'isabelaortega@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Kevin', 'Valencia', '315-321-6548', 'kevinvalencia@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Andrea', 'Mejia', '314-987-3216', 'andreamejia@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Pablo', 'Cabrera', '309-456-1237', 'pablocabrera@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Sandra', 'Espinoza', '318-654-9873', 'sandraespinoza@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Brayan', 'Lozano', '316-741-8523', 'brayanlozano@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Manuel', 'Pineda', '312-369-7415', 'manuelpineda@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Andres', 'Lopez', '320-456-7890', 'andreslopez@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Carolina', 'Ramirez', '310-987-6543', 'carolinaramirez@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Javier', 'Torres', '322-123-4567', 'javiertorres@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Maria Fernanda', 'Castro', '313-789-0123', 'mariafernandacastro@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Alejandro', 'Gomez', '311-555-6789', 'alejandrogomez@email.com', 'cliente');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Jose', 'ZABALETA', '323-599-5105', 'josezabaleta5@email.com', 'administrador');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Miguel', 'Torres', '301-777-8888', 'migueltorres@email.com', 'administrador');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Michael', 'Vasquez', '316-222-3333', 'michaelvazquez@email.com', 'administrador');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Jose', 'Daza', '305-111-2222', 'josedaza@email.com', 'administrador');

INSERT INTO Usuario (nombre, apellido, telefono, email, tipo_usuario) 
VALUES ('Sebastian', 'Vargas', '312-999-0000', 'sebastianvargas@email.com', 'cliente');


-- Insersiones de Direcciones de los usuarios(10)
INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (1, 'Calle 45 #12-34', 'Bogota', 'Cundinamarca', '110111');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (2, 'Carrera 20 #56-78', 'Medellin', 'Antioquia', '050021');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (3, 'Avenida Principal #78-90', 'Cali', 'Valle del Cauca', '760001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (4, 'Calle 10 #5-67', 'Barranquilla', 'Atlántico', '080002');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (5, 'Transversal 33 #44-22', 'Cartagena', 'Bolivar', '130001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (6, 'Carrera 80 #23-19', 'Bucaramanga', 'Santander', '680003');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (7, 'Calle 90 #8-45', 'Pereira', 'Risaralda', '660001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (8, 'Diagonal 12 #34-56', 'Manizales', 'Caldas', '170002');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (9, 'Carrera 67 #45-89', 'Cucuta', 'Norte de Santander', '540001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (10, 'Calle 23 #11-78', 'Villavicencio', 'Meta', '500001');

-- Insersiones + 40
INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (11, 'Carrera 15 #34-56', 'Santa Marta', 'Magdalena', '470001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (12, 'Avenida 68 #10-23', 'Ibague', 'Tolima', '730001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (13, 'Calle 50 #7-89', 'Neiva', 'Huila', '410001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (14, 'Diagonal 25 #12-45', 'Armenia', 'Quindio', '630001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (15, 'Carrera 40 #25-67', 'Popayan', 'Cauca', '190002');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (16, 'Calle 85 #14-33', 'Tunja', 'Boyaca', '150001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (17, 'Transversal 30 #18-90', 'Florencia', 'Caqueta', '180001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (18, 'Carrera 19 #23-78', 'Riohacha', 'La Guajira', '440001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (19, 'Avenida 5 #45-12', 'Valledupar', 'Cesar', '200001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (20, 'Calle 32 #8-56', 'Monteria', 'Cordoba', '230001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (21, 'Carrera 50 #27-34', 'Leticia', 'Amazonas', '910001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (22, 'Diagonal 60 #12-89', 'Quibdo', 'Choco', '270001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (23, 'Transversal 12 #9-78', 'San Andres', 'San Andres y Providencia', '880001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (24, 'Calle 70 #20-50', 'Mocoa', 'Putumayo', '860001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (25, 'Carrera 90 #45-23', 'Yopal', 'Casanare', '850001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (26, 'Avenida 12 #8-77', 'Puerto Carreno', 'Vichada', '990001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (27, 'Calle 48 #15-66', 'San Jose del Guaviare', 'Guaviare', '950001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (28, 'Diagonal 33 #22-11', 'Inirida', 'Guainia', '940001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (29, 'Carrera 77 #10-44', 'Mitú', 'Vaupes', '970001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (30, 'Calle 99 #14-56', 'Arauca', 'Arauca', '810001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (31, 'Avenida 25 #33-78', 'Girardot', 'Cundinamarca', '252432');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (32, 'Carrera 55 #9-90', 'Chia', 'Cundinamarca', '250001');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (33, 'Transversal 40 #18-12', 'Zipaquira', 'Cundinamarca', '250252');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (34, 'Calle 78 #12-30', 'Sogamoso', 'Boyaca', '152210');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (35, 'Diagonal 15 #7-60', 'Duitama', 'Boyaca', '150461');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (36, 'Carrera 20 #40-55', 'Fusagasuga', 'Cundinamarca', '252211');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (37, 'Avenida 11 #90-34', 'Cajica', 'Cundinamarca', '250247');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (38, 'Calle 60 #11-22', 'La Dorada', 'Caldas', '175030');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (39, 'Carrera 77 #16-78', 'Tumaco', 'Nariño', '528500');

INSERT INTO Direccion_Usuario (id_usuario, direccion, ciudad, departamento, codigo_postal) 
VALUES (40, 'Transversal 25 #44-56', 'Ipiales', 'Nariño', '524060');



-- Insersiones para las transferensioa (los pagos)
INSERT INTO Metodo_Pago (nombre) 
VALUES ('Tarjeta de credito');
INSERT INTO Metodo_Pago (nombre) 
VALUES ('Efectivo');
INSERT INTO Metodo_Pago (nombre) 
VALUES ('Transferencia');
INSERT INTO Metodo_Pago (nombre) 
VALUES ('Tarjeta de debito');

-- Inseriosnes del estado del pedido
INSERT INTO Estado_Pedido (nombre) 
VALUES ('Pendiente');
INSERT INTO Estado_Pedido (nombre) 
VALUES ('En proceso');
INSERT INTO Estado_Pedido (nombre) 
VALUES ('Enviado');
INSERT INTO Estado_Pedido (nombre) 
VALUES ('Entregado');
INSERT INTO Estado_Pedido (nombre) 
VALUES ('Cancelado');

-- Insersiones de la factura (10)
INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (1, 1, 1, 50000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (2, 2, 2, 75000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (3, 3, 3, 120000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (4, 4, 4, 35000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (5, 2, 5, 80000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (6, 1, 1, 95000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (7, 3, 3, 110000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (8, 2, 2, 62000);

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (9, 4, 4, 47000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (10, 1, 1, 88000); 

-- Insersiones+ 40
INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (11, 2, 3, 67000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (12, 3, 4, 92000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (13, 1, 5, 55000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (14, 4, 2, 102000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (15, 2, 1, 49000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (16, 3, 3, 87000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (17, 1, 4, 72000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (18, 4, 5, 64000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (19, 2, 2, 98000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (20, 3, 1, 111000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (21, 1, 3, 35000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (22, 4, 4, 76000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (23, 2, 5, 49000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (24, 3, 2, 94000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (25, 1, 1, 83000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (26, 4, 3, 72000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (27, 2, 4, 55000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (28, 3, 5, 87000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (29, 1, 2, 96000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (30, 4, 1, 105000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (31, 2, 3, 73000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (32, 3, 4, 85000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (33, 1, 5, 78000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (34, 4, 2, 49000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (35, 2, 1, 112000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (36, 3, 3, 67000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (37, 1, 4, 89000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (38, 4, 5, 74000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (39, 2, 2, 92000); 

INSERT INTO Factura (id_usuario, id_metodo, id_estado, total) 
VALUES (40, 3, 1, 100000);



-- Insersiones de productos (10)
INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Laptop Lenovo', 'Portatil Lenovo con 16GB RAM y 512GB SSD', 3500000, 15);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Mouse Inalambrico', 'Mouse ergonomico con conexion Bluetooth', 75000, 50);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Teclado Mecanico', 'Teclado con switches rojos y retroiluminacion RGB', 220000, 30);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Monitor 24 pulgadas', 'Monitor Full HD con tecnologia IPS', 680000, 20);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Disco Duro Externo 1TB', 'Disco duro USB 3.0 con gran capacidad de almacenamiento', 320000, 25);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Memoria USB 64GB', 'Unidad flash USB 3.1 de alta velocidad', 60000, 100);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Auriculares Gamer', 'Audifonos con microfono y sonido envolvente 7.1', 150000, 40);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Silla Ergonomica', 'Silla de oficina ajustable con soporte lumbar', 850000, 10);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Cargador Universal', 'Cargador para laptops con diferentes conectores', 120000, 35);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Webcam Full HD', 'Camara web con resolucion 1080p y microfono integrado', 110000, 18);

-- Insersiones + 40
INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Procesador Intel Core i7 13700K', 'CPU de 16 nucleos y 24 hilos con boost hasta 5.4GHz', 2100000, 10);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Procesador AMD Ryzen 7 5800X', 'CPU de 8 nucleos y 16 hilos con boost hasta 4.7GHz', 1700000, 12);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Tarjeta Madre Gigabyte B660', 'Placa base compatible con procesadores Intel de 12va generacion', 720000, 18);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Memoria RAM 32GB DDR4 3600MHz', 'Kit de 2x16GB con disipador termico', 680000, 20);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Disco SSD SATA 2TB', 'Unidad de estado solido de alto rendimiento para almacenamiento masivo', 780000, 15);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Tarjeta Grafica RTX 4060 Ti', 'GPU con 8GB GDDR6 y soporte para Ray Tracing', 2200000, 10);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Fuente de Poder 850W 80 Plus Gold', 'Fuente modular con certificacion de eficiencia', 550000, 15);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Gabinete Mid Tower RGB', 'Chasis espacioso con 3 ventiladores RGB preinstalados', 500000, 12);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Refrigeracion Liquida 360mm', 'Sistema de enfriamiento avanzado con radiador de 360mm', 600000, 8);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Ventilador de PC 140mm', 'Ventilador silencioso de alto flujo con iluminacion LED', 75000, 25);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Tarjeta de Red Ethernet 2.5G', 'Adaptador PCIe para conexiones de alta velocidad', 180000, 10);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Tarjeta de Expansión USB-C', 'Tarjeta PCIe con puertos USB-C de alta velocidad', 220000, 12);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Monitor Gaming 27 pulgadas 144Hz', 'Pantalla IPS con resolucion 1440p y tiempo de respuesta de 1ms', 1400000, 15);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Monitor Ultrawide 34 pulgadas', 'Pantalla curva 3440x1440 con tecnologia FreeSync', 2200000, 10);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Teclado Mecanico Wireless', 'Teclado mecanico compacto con switches intercambiables', 350000, 30);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Mouse Gaming RGB', 'Mouse optico de alta precision con sensor de 16000 DPI', 180000, 40);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Auriculares Inalambricos para PC', 'Audifonos con sonido envolvente y conexion Bluetooth', 350000, 25);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Silla Gamer Premium', 'Silla ergonomica con soporte lumbar y reposabrazos ajustables', 1200000, 8);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Alfombrilla Gaming XL', 'Mousepad extendido con superficie optimizada para precision', 60000, 50);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Micrófono USB para Streaming', 'Microfono condensador con patron cardioide y filtro anti-pop', 450000, 20);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Camara Web 4K para PC', 'Webcam con resolucion UHD y HDR', 500000, 15);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Parlantes para PC 2.1', 'Sistema de sonido con subwoofer y conexion Bluetooth', 350000, 18);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Controlador de Volumen USB', 'Dispositivo para ajuste rapido de audio en PC', 120000, 30);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Hub USB 3.0 de 7 puertos', 'Concentrador USB de alta velocidad con alimentacion externa', 150000, 25);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Base Refrigerante para Laptop', 'Soporte con ventiladores para reducir temperatura', 130000, 20);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Capturadora de Video HDMI', 'Dispositivo para grabacion y transmision en Full HD', 580000, 10);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Switch KVM HDMI', 'Controlador para alternar entre dos PCs con un solo teclado y mouse', 200000, 15);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Brazo para Monitor Dual', 'Soporte ajustable para dos monitores de hasta 32 pulgadas', 380000, 12);

INSERT INTO Producto (nombre, descripcion, precio, stock) 
VALUES ('Kit de Iluminacion RGB', 'Tiras LED con control remoto para personalizacion de setup', 90000, 40);


-- Insersiones del historial_stockk (10)
INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (1, -5, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (2, -3, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (3, 2, 'Devolución de cliente');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (4, -8, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (5, -10, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (6, 5, 'Devolución de cliente');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (7, -7, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (8, -6, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (9, 3, 'Devolución de cliente');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (10, -4, 'Venta realizada');

-- Insersiones + 40
INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (11, -4, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (12, -2, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (13, 3, 'Devolucion de cliente');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (14, -5, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (15, -7, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (16, 6, 'Reabastecimiento de stock');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (17, -10, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (18, -3, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (19, 4, 'Devolucion de cliente');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (20, -8, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (21, 10, 'Reabastecimiento de stock');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (22, -6, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (23, 5, 'Reabastecimiento de stock');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (24, -9, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (25, 7, 'Devolucion de cliente');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (26, -4, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (27, 8, 'Reabastecimiento de stock');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (28, -5, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (29, 3, 'Devolucion de cliente');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (30, -7, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (31, -6, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (32, 10, 'Reabastecimiento de stock');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (33, -8, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (34, 4, 'Devolucion de cliente');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (35, 6, 'Reabastecimiento de stock');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (36, -9, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (37, -3, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (38, 7, 'Reabastecimiento de stock');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (39, -5, 'Venta realizada');

INSERT INTO Historial_Stock (id_producto, cantidad_cambiada, motivo) 
VALUES (40, 2, 'Devolucion de cliente');


-- Insersiones de Detalle_factuura (10)
INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (1, 2, 3, 5);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (2, 5, 2, 10);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (3, 3, 1, 0);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (4, 7, 4, 15);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (5, 1, 2, 5);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (6, 6, 3, 8);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (7, 8, 5, 12);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (8, 10, 2, 0);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (9, 4, 1, 20);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (10, 9, 3, 10);

-- Insersiones + 40
INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (11, 3, 2, 5);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (12, 1, 1, 0);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (13, 7, 3, 12);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (14, 2, 2, 7);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (15, 6, 5, 15);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (16, 4, 3, 8);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (17, 10, 2, 5);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (18, 9, 4, 20);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (19, 8, 3, 10);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (20, 3, 2, 7);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (21, 5, 1, 0);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (22, 7, 5, 18);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (23, 1, 2, 6);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (24, 4, 3, 9);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (25, 6, 4, 12);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (26, 10, 2, 8);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (27, 2, 3, 5);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (28, 9, 1, 15);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (29, 8, 4, 10);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (30, 3, 3, 7);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (31, 5, 2, 9);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (32, 7, 1, 5);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (33, 1, 4, 20);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (34, 4, 2, 8);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (35, 6, 3, 10);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (36, 10, 5, 12);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (37, 2, 2, 7);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (38, 9, 3, 15);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (39, 8, 1, 5);

INSERT INTO Detalle_Factura (id_factura, id_producto, cantidad, descuento) 
VALUES (40, 3, 2, 10);



-- Insersiones de categoria_producto (categorias) 
INSERT INTO Categoria_Producto (nombre) 
VALUES ('Tablets');
INSERT INTO Categoria_Producto (nombre)
VALUES ('Muebles');
INSERT INTO Categoria_Producto (nombre) 
VALUES ('Accesorios');
INSERT INTO Categoria_Producto (nombre) 
VALUES ('Impresoras');
INSERT INTO Categoria_Producto (nombre) 
VALUES ('Electronica');

-- Insersiones de Producto_Categoria(10)
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (1, 1); 
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (2, 2); 
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (3, 3); 
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (4, 4); 
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (5, 5);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (6, 1); 
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (7, 2); 
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (8, 3); 
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (9, 4); 
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (10, 5); 

-- Insersiones + 40
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (11, 1);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (12, 2);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (13, 3);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (14, 4);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (15, 5);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (16, 1);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (17, 2);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (18, 3);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (19, 4);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (20, 5);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (21, 1);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (22, 2);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (23, 3);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (24, 4);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (25, 5);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (26, 1);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (27, 2);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (28, 3);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (29, 4);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (30, 5);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (31, 1);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (32, 2);
INSERT INTO Producto_Categoria (id_producto, id_categoria)
VALUES (33, 3);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (34, 4);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (35, 5);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (36, 1);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (37, 2);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (38, 3);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (39, 4);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (40, 5);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (41, 1);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (42, 2);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (43, 3);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (44, 4);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (45, 5);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (46, 1);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (47, 2);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (48, 3);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (49, 4);
INSERT INTO Producto_Categoria (id_producto, id_categoria) 
VALUES (50, 5);



-- Insersones del carro de compras (10)
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (1, 2, 3);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (2, 5, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (3, 7, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (4, 3, 4);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (5, 8, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (6, 6, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (7, 9, 3);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (8, 1, 5);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (9, 4, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (10, 10, 1);

-- Insersiones + 40
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (1, 11, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (2, 12, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (3, 13, 3);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (4, 14, 4);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (5, 15, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (6, 16, 5);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (7, 17, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (8, 18, 3);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (9, 19, 4);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (10, 20, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (1, 21, 3);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (2, 22, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (3, 23, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (4, 24, 5);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (5, 25, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (6, 26, 3);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (7, 27, 4);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (8, 28, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (9, 29, 5);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (10, 30, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (1, 31, 3);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (2, 32, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (3, 33, 4);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (4, 34, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (5, 35, 5);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (6, 36, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (7, 37, 3);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (8, 38, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (9, 39, 4);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (10, 40, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (1, 41, 3);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (2, 42, 5);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (3, 43, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (4, 44, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (5, 45, 4);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (6, 46, 3);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (7, 47, 2);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (8, 48, 1);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (9, 49, 5);
INSERT INTO Carro_Compra (id_usuario, id_producto, cantidad) 
VALUES (10, 50, 4);



-- Insersiones para la valoracion del usuario (cliente)(10)
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (1, 2, 5, 'Excelente calidad muy recomendado');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (2, 5, 4, 'Buen producto pero el envio fue lento');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (3, 7, 3, 'Cumple su funcion aunque esperaba mas');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (4, 3, 2, 'No me gusto mucho esperaba mejor calidad');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (5, 8, 1, 'Llego defectuoso mala experiencia');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (9, 6, 5, 'Es perfecto justo lo que necesitaba');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (1, 1, 3, NULL);
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (2, 4, 2, 'Podria mejorar la durabilidad');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (3, 10, 5, 'Lo volveria a comprar sin dudarlo');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (4, 9, 4, 'Me gusto bastante pero el precio es algo alto');

-- Insersiones + 40
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (5, 11, 5, 'Excelente rendimiento y muy facil de instalar');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (6, 12, 4, 'Buen producto pero podria ser mas economico');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (7, 13, 3, 'No es malo, pero esperaba una mejor calidad');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (8, 14, 2, 'No lo recomiendo, muy fragil');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (9, 15, 1, 'Llego roto, pesima experiencia');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (10, 16, 5, 'Supera mis expectativas, recomendado');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (1, 17, 4, 'Buena calidad, pero el envio tardo demasiado');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (2, 18, 3, 'Cumple con lo prometido pero sin destacar');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (3, 19, 2, 'Materiales de baja calidad, no lo recomiendo');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (4, 20, 1, 'Definitivamente no vale la pena');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (5, 21, 5, 'Espectacular! Justo lo que buscaba');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (6, 22, 4, 'Muy buen producto, aunque el precio es alto');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (7, 23, 3, 'Regular, no es lo mejor pero tampoco lo peor');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (8, 24, 2, 'Llego con piezas faltantes, decepcionado');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (9, 25, 1, 'Mal servicio, no lo recomiendo');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (10, 26, 5, 'Buen diseño y gran calidad');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (1, 27, 4, 'Responde bien, aunque la bateria dura poco');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (2, 28, 3, 'Normal, esperaba algo mejor');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (3, 29, 2, 'No cumplio mis expectativas');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (4, 30, 1, 'Muy mala experiencia, no recomiendo');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (5, 31, 5, 'Mejor de lo que esperaba, lo volveria a comprar');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (6, 32, 4, 'Calidad aceptable, aunque el envio fue lento');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (7, 33, 3, 'Normal, funciona pero nada destacable');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (8, 34, 2, 'Llego defectuoso, servicio al cliente pesimo');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (9, 35, 1, 'No lo recomiendo, muy mala calidad');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (10, 36, 5, 'Buena compra, funciona perfectamente');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (1, 37, 4, 'Buen producto, aunque mejoraria la ergonomia');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (2, 38, 3, 'Esta bien, pero hay mejores opciones');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (3, 39, 2, 'No me gusto, materiales muy simples');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (4, 40, 1, 'Definitivamente no lo volveria a comprar');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (5, 41, 5, 'Impresionante, super recomendado');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (6, 42, 4, 'Buena opcion, aunque el cable es corto');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (7, 43, 3, 'Aceptable, pero hay mejores por el mismo precio');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (8, 44, 2, 'Fallo a la semana de uso');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (9, 45, 1, 'Pesimo, no funciona como deberia');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (10, 46, 5, 'Perfecto para lo que necesito');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (1, 47, 4, 'Gran calidad, aunque algo costoso');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (2, 48, 3, 'Cumple su funcion, nada extraordinario');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (3, 49, 2, 'Mala experiencia, se calienta demasiado');
INSERT INTO Valoracion (id_usuario, id_producto, calificacion, comentario) 
VALUES (4, 50, 1, 'No lo recomiendo, se rompio en pocos dias');


-- Insersiones de ofertass (10)
INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (1, 10, '2025-03-15', '2025-03-20');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (2, 15, '2025-03-16', '2025-03-22');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (3, 5, '2025-03-17', '2025-03-23');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (4, 20, '2025-03-18', '2025-03-25');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (5, 30, '2025-03-19', '2025-03-27');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (6, 25, '2025-03-20', '2025-03-28');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (7, 12, '2025-03-21', '2025-03-30');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (8, 18, '2025-03-22', '2025-04-01');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (9, 8, '2025-03-23', '2025-04-03');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (10, 50, '2025-03-24', '2025-04-05');

-- Insersiones + 40
INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (11, 10, '2025-03-25', '2025-04-06');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (12, 15, '2025-03-26', '2025-04-07');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (13, 5, '2025-03-27', '2025-04-08');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (14, 20, '2025-03-28', '2025-04-09');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (15, 30, '2025-03-29', '2025-04-10');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (16, 25, '2025-03-30', '2025-04-11');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (17, 12, '2025-03-31', '2025-04-12');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (18, 18, '2025-04-01', '2025-04-13');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (19, 8, '2025-04-02', '2025-04-14');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (20, 50, '2025-04-03', '2025-04-15');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (21, 10, '2025-04-04', '2025-04-16');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (22, 15, '2025-04-05', '2025-04-17');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (23, 5, '2025-04-06', '2025-04-18');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (24, 20, '2025-04-07', '2025-04-19');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (25, 30, '2025-04-08', '2025-04-20');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (26, 25, '2025-04-09', '2025-04-21');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (27, 12, '2025-04-10', '2025-04-22');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (28, 18, '2025-04-11', '2025-04-23');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (29, 8, '2025-04-12', '2025-04-24');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (30, 50, '2025-04-13', '2025-04-25');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (31, 10, '2025-04-14', '2025-04-26');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (32, 15, '2025-04-15', '2025-04-27');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (33, 5, '2025-04-16', '2025-04-28');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (34, 20, '2025-04-17', '2025-04-29');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (35, 30, '2025-04-18', '2025-04-30');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (36, 25, '2025-04-19', '2025-05-01');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (37, 12, '2025-04-20', '2025-05-02');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (38, 18, '2025-04-21', '2025-05-03');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (39, 8, '2025-04-22', '2025-05-04');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (40, 50, '2025-04-23', '2025-05-05');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (41, 10, '2025-04-24', '2025-05-06');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (42, 15, '2025-04-25', '2025-05-07');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (43, 5, '2025-04-26', '2025-05-08');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (44, 20, '2025-04-27', '2025-05-09');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (45, 30, '2025-04-28', '2025-05-10');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (46, 25, '2025-04-29', '2025-05-11');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (47, 12, '2025-04-30', '2025-05-12');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (48, 18, '2025-05-01', '2025-05-13');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (49, 8, '2025-05-02', '2025-05-14');

INSERT INTO Oferta (id_producto, porcentaje_descuento, fecha_inicio, fecha_fin) 
VALUES (50, 50, '2025-05-03', '2025-05-15');