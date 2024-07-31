INSERT INTO clientes (id, nombre, apellidos, celular, direccion, correo_electronico)
VALUES ("1097492869", "Joel", "Sierra", 3160514020, "Ruitoque Alto", "j.santisileon@gmail.com"),
("1091572648", "Jair", "Bernal", 3164521782, "Zapamanga", "jairsito@gmail.com"),
("63578926", "Juan", "Rojas", 3035836974, "Norte", "juansitogamer@gmail.com"),
("987558225", "Jhon", "Arley", 3024874152, "Floridablanca", "jhonpixel2324@gmail.com")

INSERT INTO categorias (descripcion, estado)
VALUES ("Categoria_A", 1), ("Categoria_B", 2), ("Categoria_C", 3), ("Categoria_D", 4), ("Categoria_E", 5)

INSERT INTO compras (medio_pago, comentario, estado)
VALUES (1, "Agradable", 3)

INSERT INTO productos (nombre, codigo_barras, precio_venta, cantidad_stock, estado)
VALUES ("Pera", "103164532132051321555468155321389786543876051", 2.33, 230, 1),
("Yogurt", "55498465165198421965468468", 4.70, 140, 2),
("Desodorante", "72503507424892421361214", 1.45, 170, 3),
("Camisa", "978564654964231684641321", 6.81, 100, 4)

INSERT INTO compras_productos (cantidad, total, estado)
VALUES (6, 22.06, 4)
