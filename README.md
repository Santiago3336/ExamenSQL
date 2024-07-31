**Consultas Básicas**



1. Consultar todos los productos y sus categorías

```sql
SELECT productos.nombre AS producto, categorias.descripcion 
FROM productos
JOIN categorias ON productos.id_categoria = categorias.id_categoria;
```

2. Consultar todas las compras y los clientes que las realizaron

   ```sql
   SELECT compras.id_compra, clientes.nombre AS cliente
   FROM compras 
   JOIN  clientes ON compras.id_cliente = clientes.id;
   ```

3.  Agregar un nuevo producto

```sql
SELECT productos.nombre AS producto
FROM compras_productos
JOIN productos ON compras_productos.id_producto = productos.id_producto
WHERE compras_productos.id_compra = 1;
```

4. Agregar un nuevo producto

```sql
INSERT INTO productos (nombre, codigo_barras, precio_venta, cantidad_stock, estado)
VALUES ("Pera", "103164532132051321555468155321389786543876051", 2.33, 230, 1);
```

5. Actualizar el stock de un producto

   ```sql
   UPDATE productos
   SET cantidad_stock = 90
   WHERE id_producto = 1;
   ```

6. Consultar todas las compras de un cliente específico

```sql
SELECT compras.id_compra, compras.fecha
FROM compras
WHERE compras.id_cliente = "1097492869";
```

7. Consultar todos los clientes y sus correos electrónicos

   ```sql
   SELECT nombre, correo_electronico
   FROM clientes;
   ```

8. Consultar la cantidad total de productos comprados en cada compra

```sql
SELECT id_compra, SUM(cantidad) AS total_productos
FROM compras_productos
GROUP BY id_compra;
```

9. Consultar las compras realizadas en un rango de fechas

```sql
SELECT id_compra, id_cliente, fecha, medio_pago, comentario, estado
FROM compras
WHERE fecha BETWEEN '2023-01-01' AND '2024-01-01';
```





**Funciones Agregadas**

1. Contar la cantidad de productos por categoría

```sql
SELECT categorias.descripcion AS categoria, COUNT(productos, id_producto) AS cantidad_productos
FROM productos
JOIN categorias ON productos.id_categoria = categorias.id_categoria
GROUP BY
categorias.descripcion;
```

2. Calcular el precio total de ventas por cada cliente

   ```sql
   SELECT clientes .nombre AS cliente, SUM(productos.precio_venta*compras_productos.cantidad) AS total_ventas
   FROM clientes
   JOIN compras ON clientes.id = compras.id_cliente
   JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
   JOIN productos ON compras_productos.id_producto = productos.id_producto
   GROUP BY clientes.nombre;
   ```

3. Calcular el precio promedio de los productos por categoría

```sql
SELECT categorias.descripcion AS categoria, AVG(productos.precio_venta) AS precio_promedio
FROM productos
JOIN categorias ON productos.id_categoria GROUP BY categorias.descripcion;
```

4. Encontrar la fecha de la primera y última compra registrada

```sql
SELECT MIN('2023-01-01') AS primer_compra, MAX('2024-01-01') AS ultima_compra
FROM compras;
```

5. Calcular el total de ingresos por ventas

   ```sql
   SELECT SUM(total) AS total_ingresos
   FROM compras_productos;
   ```

6. Contar la cantidad de compras realizadas por cada medio de pago

   ```sql
   SELECT medio_pago, COUNT(id_compra) AS cantidad_compras
   FROM compras
   GROUP BY medio_pago;
   ```

7. Calcular el total de productos vendidos por cada producto

```sql
SELECT productos.nombre AS producto, SUM(compras_productos.cantidad) AS total_vendidos
FROM compras_productos
JOIN productos ON compras_productos.id_producto = productos.id_producto
GROUP BY productos.nombre;
```

8. Obtener el promedio de cantidad de productos comprados por compra

   ```sql
   SELECT AVG(cantidad) AS promedio_productos_por_compra
   FROM compras_productos;
   ```

9. Encontrar los productos con el stock más bajo

```sql
SELECT nombre, cantidad_stock
FROM productos 
ORDER BY cantidad_stock ASC
LIMIT 5;
```

10. Calcular el total de productos comprados y el total gastado por cliente

    ```sql
    SELECT clientes.nombre AS cliente, SUM(compras_productos.cantidad) AS total_productos_comprados, SUM(compras_productos.total) AS total_gastado
    FROM clientes 
    JOIN compras ON clientes.id = compras.id_cliente
    JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
    GROUP BY clientes.nombre;
    ```

**Consultas con JOIN**



1. Consultar todos los productos con sus categorías 

```sql
SELECT productos.nombre AS producto,categorias.descripcion AS categoria
FROM productos
JOIN categorias ON productos.id_categoria = categorias.id_categoria;
```

2. Consultar todas las compras y los clientes que las realizaron

```sql
SELECT compras.id_compra, clientes.nombre AS cliente
FROM compras
JOIN clientes ON compras.id_cliente = clientes.id;
```

3. Consultar los productos comprados en cada compra

```sql
SELECT compras.id_compra, productos.nombre AS producto, compras_productos.cantidad
FROM compras 
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
JOIN productos ON compras_productos.id_producto = productos.id_producto;
```

4. Consultar las compras realizadas por un cliente específico

```sql
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
```

5. Consultar el total gastado por cada cliente

```sql
SELECT clientes.nombre AS cliente, SUM(compras_productos.total) AS total_gastado
FROM clientes
JOIN compras ON clientes.id = compras.id_cliente
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
GROUP BY clientes.nombre;
```

6. Consultar el stock disponible de productos y su categoría

```sql
SELECT productos.nombre AS producto, productos.cantidad_stock, categorias.descripcion AS categoria
FROM productos
JOIN categorias ON productos.id_categoria = categorias.id_categoria;
```

7. Consultar los detalles de compras junto con la información del cliente y el producto

```sql
SELECT compras.id_compra, clientes.nombre AS cliente, productos.nombre AS producto, compras_productos.cantidad. compras_productos.total
FROM compras 
JOIN clientes ON compras.id_cliente = clientes.id 
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
JOIN productos ON compras_productos.id_producto = productos.id_producto;
```

8. Consultar los productos que han sido comprados por más de una cantidad específica

```sql
SELECT productos.nombre AS producto, SUM(compras_productos.cantidad) AS total_comprado
FROM compras_productos
JOIN productos ON compras_productos.id_producto = productos.id_producto
GROUP BY productos.nombre
HAVING total_comprado > 10;
```

9. Consultar la cantidad total de productos vendidos por categoría

```sql
SELECT categorias.descripcion AS categoria, SUM(compras_productos.cantidad) AS total_vendidos
FROM compras_productos
JOIN productos ON compras_productos.id_producto = productos.id_producto
JOIN categorias ON productos.id_categoria P categorias.id_categoria
GROUP BY categorias.descripcion;
```

10. Consultar los clientes que han realizado compras en un rango de fechas específico

```sql
SELECT clientes.nombre AS cliente, compras.fecha
FROM clientes
JOIN compras ON clientes.id = compras.id_cliente
WHERE compras.fecha BETWEEN '2023-01-01' AND '2023-12-31';
```

11. Consultar el total gastado por cada cliente junto con la cantidad total de productos comprados

```sql
SELECT clientes.nombre AS cliente, SUM(compras_productos.total) AS total_gastado, SUM(compras_productos.cantidad) AS total_productos_comprados
FROM clientes 
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
GROUP BY clientes.nombre;
```

12. Consultar los productos que nunca han sido comprados

```sql
SELECT productos.nombre AS producto
FROM productos 
LEFT JOIN compras_productos ON productos.id_producto = compras_productos.id_producto
WHERE compras_productos.id_producto IS NULL;
```

13. Consultar los clientes que han realizado más de una compra y el total gastado por ellos

```sql
SELECT clientes.nombre AS cliente, COUNT(compras.id_compra) AS cantidad_compras, SUM(compras_productos.total) AS total_gastado
FROM clientes
JOIN compras ON clientes.id = compras.id_cliente
JOIN compras_productos ON compras.id_compra = compras_productos.id_compra
GROUP BY clientes.nombre
HAVING cantidad_compras > 1;
```

14. Consultar los productos más vendidos por categoría

```sql
SELECT categorias.descripcion AS categoria, productos.nombre AS producto, SUM(compras_productos.cantidad) AS total_vendidos
FROM categorias
JOIN productos ON categorias.id_categoria = productos.id_categoria
JOIN compras_productos ON productos.id_producto = compras_productos.id_producto
GROUP BY categorias.descripcion, productos.nombre
ORDER BY total_vendidos
DESC;
```

15. Consultar las compras realizadas por clientes de una ciudad específica y el total gastado

```

```

