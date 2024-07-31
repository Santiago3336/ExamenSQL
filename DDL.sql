CREATE DATABASE miscompras;

USE miscompras;

CREATE TABLE clientes(
    id VARCHAR(20),
    nombre VARCHAR(40),
    apellidos VARCHAR(40),
    celular DECIMAL(10,0),
    direccion VARCHAR(80),
    correo_electronico VARCHAR(70),
    CONSTRAINT pk_id PRIMARY KEY (id),
    
);

CREATE TABLE categorias(
    id_categoria INT UNIQUE AUTO_INCREMENT,
    descripcion VARCHAR(45),
    estado TINYINT,
    CONSTRAINT pk_id_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE compras(
    id_compra INT UNSIGNED AUTO_INCREMENT,
    id_cliente VARCHAR(20),
    fecha DATETIME DEFAULT (CURDATE()),
    medio_pago CHAR (1),
    comentario VARCHAR(30),
    estado CHAR(1)
    CONSTRAINT pk_id_compra PRIMARY KEY (id_compra)
    CONSTRAINT fk_id_cliente_clientes FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE productos(
    id_producto INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(45)
    id_categoria INT,
    codigo_barras VARCHAR(150),
    precio_venta DECIMAL(16,2),
    cantidad_stock INT,
    estado TINYINT,
    CONSTRAINT pk_id_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_id_categoria_producto FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);


CREATE TABLE compras_productos(
    id_compra INT,
    id_producto INT,
    cantidad INT,
    total DECIMAL(16,2),
    estado TINYINT,
    CONSTRAINT pk_id_compra_producto_compose PRIMARY KEY (id_compra, id_producto),
    CONSTRAINT fk_id_compra_producto_compra FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    CONSTRAINT fk_id_compra_producto_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);



/* Consultas básicas */

SELECT productos., categorias.descripcion 
FROM productos
JOIN categorias ON productos.id_categoria = categorias.id_categoria;




