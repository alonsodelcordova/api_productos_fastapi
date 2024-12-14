create database API_PRODUCTOS;
use API_PRODUCTOS;

CREATE TABLE Ubicacion (
    idUbicacion VARCHAR(50) PRIMARY KEY,
    zona VARCHAR(10) NOT NULL,
    rack INT NOT NULL,
    nivel INT NOT NULL,
    capacidadMaxima INT NOT NULL
);

CREATE TABLE Producto (
    idProducto VARCHAR(50) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    cantidad INT NOT NULL,
    ubicacion_id VARCHAR(50),
    fechaIngreso DATE NOT NULL,
    estado ENUM('ALMACENADO', 'DAÑADO', 'RESERVADO') NOT NULL,
    FOREIGN KEY (ubicacion_id) REFERENCES Ubicacion(idUbicacion)
);

CREATE TABLE OrdenCompra (
    idOrdenCompra VARCHAR(50) PRIMARY KEY,
    proveedor VARCHAR(100) NOT NULL,
    fechaOrden DATE NOT NULL,
    estado ENUM('PENDIENTE', 'COMPLETADA') NOT NULL
);

CREATE TABLE Inventario (
    idInventario VARCHAR(50) PRIMARY KEY,
    ultimoConteo DATE NOT NULL
);

CREATE TABLE Discrepancia (
    idInventario VARCHAR(50),
    producto_id VARCHAR(50),
    cantidadEsperada INT NOT NULL,
    cantidadReal INT NOT NULL,
    PRIMARY KEY (idInventario, producto_id),
    FOREIGN KEY (idInventario) REFERENCES Inventario(idInventario),
    FOREIGN KEY (producto_id) REFERENCES Producto(idProducto)
);

CREATE TABLE Pedido (
    idPedido VARCHAR(50) PRIMARY KEY,
    cliente_nombre VARCHAR(100) NOT NULL,
    cliente_direccion TEXT NOT NULL,
    cliente_contacto VARCHAR(100),
    estado ENUM('PENDIENTE', 'EN_PREPARACION', 'ENVIADO') NOT NULL
);

CREATE TABLE ProductoPedido (
    idPedido VARCHAR(50),
    producto_id VARCHAR(50),
    PRIMARY KEY (idPedido, producto_id),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (producto_id) REFERENCES Producto(idProducto)
);

CREATE TABLE Devolucion (
    idDevolucion VARCHAR(50) PRIMARY KEY,
    pedido_id VARCHAR(50),
    motivo TEXT NOT NULL,
    fecha DATE NOT NULL,
    accionTomada ENUM('REPARAR', 'DESECHAR', 'REINGRESAR') NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(idPedido)
);

CREATE TABLE Usuario (
    idUsuario VARCHAR(50) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    rol ENUM('OPERADOR', 'SUPERVISOR', 'ADMINISTRADOR') NOT NULL,
    nombreUsuario VARCHAR(50) NOT NULL,
    contrasena VARCHAR(100) NOT NULL
);

CREATE TABLE Reporte (
    idReporte VARCHAR(50) PRIMARY KEY,
    tipo ENUM('INVENTARIO', 'PEDIDOS', 'DEVOLUCIONES') NOT NULL,
    fechaGeneracion DATE NOT NULL,
    datos TEXT NOT NULL
);


INSERT INTO Ubicacion (idUbicacion, zona, rack, nivel, capacidadMaxima)
VALUES
    ('U001', 'A', 1, 1, 100),
    ('U002', 'B', 2, 1, 100),
    ('U003', 'C', 3, 2, 50);

INSERT INTO Producto (idProducto, nombre, descripcion, cantidad, ubicacion_id, fechaIngreso, estado)
VALUES
    ('P001', 'Laptop Dell', 'Laptop portátil modelo XPS 13', 20, 'U001', '2024-12-01', 'ALMACENADO'),
    ('P002', 'Teclado Mecánico', 'Teclado mecánico RGB', 50, 'U002', '2024-12-03', 'ALMACENADO'),
    ('P003', 'Monitor 24"', 'Monitor Full HD 24 pulgadas', 15, 'U003', '2024-12-05', 'ALMACENADO');


INSERT INTO ProductoPedido (idPedido, producto_id)
VALUES
    ('OC001', 'P001'),
    ('OC001', 'P002'),
    ('OC002', 'P003');

INSERT INTO Pedido (idPedido, cliente_nombre, cliente_direccion, cliente_contacto, estado)
VALUES
    ('P001', 'Cliente X', 'Av. Principal 123', '987654321', 'PENDIENTE'),
    ('P002', 'Cliente Y', 'Av. Secundaria 456', '912345678', 'EN_PREPARACION');

INSERT INTO ProductoPedido (idPedido, producto_id)
VALUES
    ('P001', 'P001'),
    ('P001', 'P002'),
    ('P002', 'P003');

INSERT INTO Devolucion (idDevolucion, pedido_id, motivo, fecha, accionTomada)
VALUES
    ('D001', 'P001', 'Producto defectuoso', '2024-12-10', 'REPARAR'),
    ('D002', 'P002', 'Cliente no satisfecho', '2024-12-11', 'DESECHAR');


INSERT INTO Usuario (idUsuario, nombre, rol, nombreUsuario, contrasena)
VALUES
    ('U001', 'Juan Pérez', 'ADMINISTRADOR', 'juanperez', 'password123'),
    ('U002', 'Ana Gómez', 'SUPERVISOR', 'anagomez', 'mypassword');

INSERT INTO Reporte (idReporte, tipo, fechaGeneracion, datos)
VALUES
    ('R001', 'INVENTARIO', '2024-12-01', 'Reporte de inventario con 100 productos en stock'),
    ('R002', 'PEDIDOS', '2024-12-02', 'Listado de pedidos pendientes y enviados');

INSERT INTO Discrepancia (idInventario, producto_id, cantidadEsperada, cantidadReal)
VALUES
    ('I001', 'P001', 20, 18), -- Discrepancia en Producto P001
    ('I001', 'P002', 50, 50);  -- Sin discrepancia en Producto P002
