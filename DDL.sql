CREATE DATABASE miscompras;

USE miscompras;

CREATE TABLE clientes (
    id VARCHAR(20),
    nombre VARCHAR(40),
    apellidos VARCHAR(40),
    celular DECIMAL(10,0),
    direccion VARCHAR(80),
    correo_electronico VARCHAR(70),
    CONSTRAINT pk_id PRIMARY KEY (id)
);

CREATE TABLE categorias (
    id_categoria INT UNIQUE AUTO_INCREMENT,
    descripcion VARCHAR(45),
    estado TINYINT,
    CONSTRAINT pk_id_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE compras (
    id_compra INT UNSIGNED AUTO_INCREMENT,
    id_cliente VARCHAR(20),
    fecha DATETIME DEFAULT (CURRENT_TIMESTAMP),
    medio_pago CHAR(1),
    comentario VARCHAR(30),
    estado CHAR(1),
    CONSTRAINT pk_id_compra PRIMARY KEY (id_compra),
    CONSTRAINT fk_id_cliente_clientes FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE productos (
    id_producto INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(45),
    id_categoria INT,
    codigo_barras VARCHAR(150),
    precio_venta DECIMAL(16,2),
    cantidad_stock INT,
    estado TINYINT,
    CONSTRAINT pk_id_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_id_categoria_producto FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE compras_productos (
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

SELECT productos.nombre AS producto, categorias.descripcion 
FROM productos
JOIN categorias ON productos.id_categoria = categorias.id_categoria;

SELECT compras.id_compra, clientes.nombre AS cliente
FROM compras 
JOIN  clientes ON compras.id_cliente = clientes.id;

SELECT productos.nombre AS producto
FROM compras_productos
JOIN productos ON compras_productos.id_producto = productos.id_producto
WHERE compras_productos.id_compra = 1;

INSERT INTO productos (nombre, codigo_barras, precio_venta, cantidad_stock, estado)
VALUES ("Pera", "103164532132051321555468155321389786543876051", 2.33, 230, 1);

UPDATE productos
SET cantidad_stock = 90
WHERE id_producto = 1;

SELECT compras.id_compra, compras.fecha
FROM compras
WHERE compras.id_cliente = "1097492869"

SELECT nombre, correo_electronico
FROM clientes;

SELECT id_compra, SUM(cantidad) AS total_productos
FROM compras_productos
GROUP BY id_compra;

SELECT id_compra, id_cliente, fecha, medio_pago, comentario, estado
FROM compras
WHERE fecha BETWEEN '2023-01-01' AND '2024-01-01'

/*Funciones*/

SELECT categorias.descripcion AS categoria, COUNT(productos, id_producto) AS cantidad_productos
FROM productos
JOIN categorias ON productos.id_categoria = categorias.id_categoria
GROUP BY
categorias.descripcion;

SELECT clientes .nombre AS cliente, SUM(productos.precio_venta*compras_productos.cantidad) AS total_ventas
FROM clientes
JOIN compras ON clientes.id = compras.id_cliente
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
JOIN productos ON compras_productos.id_producto = productos.id_producto
GROUP BY clientes.nombre;

SELECT categorias.descripcion AS categoria, AVG(productos.precio_venta) AS precio_promedio
FROM productos
JOIN categorias ON productos.id_categoria GROUP BY categorias.descripcion;

SELECT MIN('2023-01-01') AS primer_compra, MAX('2024-01-01') AS ultima_compra
FROM compras;

SELECT SUM(total) AS total_ingresos
FROM compras_productos;

SELECT medio_pago, COUNT(id_compra) AS cantidad_compras
FROM compras
GROUP BY medio_pago;

SELECT productos.nombre AS producto, SUM(compras_productos.cantidad) AS total_vendidos
FROM compras_productos
JOIN productos ON compras_productos.id_producto = productos.id_producto
GROUP BY productos.nombre;

SELECT AVG(cantidad) AS promedio_productos_por_compra
FROM compras_productos;

SELECT nombre, cantidad_stock
FROM productos 
ORDER BY cantidad_stock ASC
LIMIT 5;

SELECT clientes.nombre AS cliente, SUM(compras_productos.cantidad) AS total_productos_comprados, SUM(compras_productos.total) AS total_gastado
FROM clientes 
JOIN compras ON clientes.id = compras.id_cliente
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
GROUP BY clientes.nombre;

/*JOIN*/

SELECT productos.nombre AS producto,categorias.descripcion AS categoria
FROM productos
JOIN categorias ON productos.id_categoria = categorias.id_categoria;

SELECT compras.id_compra, clientes.nombre AS cliente
FROM compras
JOIN clientes ON compras.id_cliente = clientes.id;

SELECT compras.id_compra, productos.nombre AS producto, compras_productos.cantidad
FROM compras 
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
JOIN productos ON compras_productos.id_producto = productos.id_producto;

SELECT compras.id_compra, compras.fecha
FROM compras
JOIN clientes ON compras.id_cliente = clientes.id
WHERE clientes.id = 1;

SELECT clientes.nombre AS cliente, SUM(compras_productos.total) AS total_gastado
FROM clientes
JOIN compras ON clientes.id = compras.id_cliente
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
GROUP BY clientes.nombre;

SELECT productos.nombre AS producto, productos.cantidad_stock, categorias.descripcion AS categoria
FROM productos
JOIN categorias ON productos.id_categoria = categorias.id_categoria;

SELECT compras.id_compra, clientes.nombre AS cliente, productos.nombre AS producto, compras_productos.cantidad. compras_productos.total
FROM compras 
JOIN clientes ON compras.id_cliente = clientes.id 
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
JOIN productos ON compras_productos.id_producto = productos.id_producto;

SELECT productos.nombre AS producto, SUM(compras_productos.cantidad) AS total_comprado
FROM compras_productos
JOIN productos ON compras_productos.id_producto = productos.id_producto
GROUP BY productos.nombre
HAVING total_comprado > 10;

SELECT categorias.descripcion AS categoria, SUM(compras_productos.cantidad) AS total_vendidos
FROM compras_productos
JOIN productos ON compras_productos.id_producto = productos.id_producto
JOIN categorias ON productos.id_categoria P categorias.id_categoria
GROUP BY categorias.descripcion;

SELECT clientes.nombre AS cliente, compras.fecha
FROM clientes
JOIN compras ON clientes.id = compras.id_cliente
WHERE compras.fecha BETWEEN '2023-01-01' AND '2023-12-31';

SELECT clientes.nombre AS cliente, SUM(compras_productos.total) AS total_gastado, SUM(compras_productos.cantidad) AS total_productos_comprados
FROM clientes 
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
GROUP BY clientes.nombre;

SELECT productos.nombre AS producto
FROM productos 
LEFT JOIN compras_productos ON productos.id_producto = compras_productos.id_producto
WHERE compras_productos.id_producto IS NULL;

SELECT clientes.nombre AS cliente, COUNT(compras.id_compra) AS cantidad_compras, SUM(compras_productos.total) AS total_gastado
FROM clientes
JOIN compras ON clientes.id = compras.id_cliente
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
GROUP BY clientes.nombre
HAVING cantidad_compras > 1;

SELECT categorias.descripcion AS categoria, productos.nombre AS producto, SUM(compras_productos.cantidad) AS total_vendidos
FROM categorias
JOIN productos ON categorias.id_categoria = productos.id_categoria
JOIN compras_productos ON productos.id_producto = compras_productos.id_producto
GROUP BY categorias.descripcion, productos.nombre
ORDER BY total_vendidos
DESC;

