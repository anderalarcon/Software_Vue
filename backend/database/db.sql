CREATE DATABASE MERKALTOK_VUE;
CREATE TABLE cliente(
	id_cliente SERIAL PRIMARY KEY NOT NULL,
	nombre_cliente VARCHAR(50),
	email_cliente VARCHAR(59) UNIQUE,
	password_cliente VARCHAR(50),
	direccion_cliente VARCHAR(100),
	DNI INTEGER,
	img_cliente VARCHAR
);
CREATE TABLE proveedor(
	id_proveedor SERIAL PRIMARY KEY NOT NULL,
	nombre_proveedor VARCHAR(50),
	email_proveedor VARCHAR(59) UNIQUE,
	password_proveedor VARCHAR(50),
	direccion_proveedor VARCHAR(100),
	RUC INTEGER,
	img_proveedor VARCHAR
);
CREATE TABLE admin(
	id SERIAL primary key NOT NULL,
	admin_nickname varchar(50) NOT NULL,
	password_admin varchar(50) NOT NULL
);
CREATE TABLE tbl_metodo_pago(
	id_metodo_pago bigserial primary key NOT NULL,
	metodo VARCHAR(20)
);
CREATE TABLE tbl_categoria(
	id_categoria bigserial primary key NOT NULL,
	categoria VARCHAR(20),
	img_categoria VARCHAR
);
CREATE TABLE tbl_producto(
	id_producto bigserial primary key NOT NULL,
	nombre VARCHAR(50),
	precio DECIMAL,
	stock int,
	detalle VARCHAR(50),
	id_proveedor BIGINT REFERENCES proveedor(id_proveedor) NOT NULL,
	id_categoria BIGINT REFERENCES tbl_categoria(id_categoria) NOT NULL,
	img_producto VARCHAR
);
CREATE TABLE tbl_carrito(
	id_carrito serial primary key NOT NULL,
	id_cliente BIGINT REFERENCES cliente(id_cliente) NOT NULL
);
CREATE TABLE carrito_producto(
	id serial primary KEY NOT NULL,
	carrito_id BIGINT REFERENCES tbl_carrito(id_carrito) NOT NULL,
	producto_id BIGINT REFERENCES tbl_producto(id_producto) NOT NULL,
	cantidad_id INTEGER
);
CREATE TABLE tbl_pedido(
	id_pedido serial primary key NOT NULL,
	fecha DATE,
	estado VARCHAR(20),
	total DECIMAL(10, 4),
	id_cliente BIGINT REFERENCES cliente(id_cliente) NOT NULL,
	id_metodo BIGINT REFERENCES tbl_metodo_pago(id_metodo_pago) NOT NULL
);
CREATE TABLE tbl_pedido_detalle(
	id_pedido_detalle serial primary key NOT NULL,
	cantidad INTEGER,
	precio DECIMAL(10, 4),
	id_pedido BIGINT REFERENCES tbl_pedido(id_pedido) NOT NULL,
	id_producto BIGINT REFERENCES tbl_producto(id_producto) NOT NULL
);
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;