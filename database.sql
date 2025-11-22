CREATE DATABASE facturacion;

USE facturacion;

CREATE TABLE t_rol(
    id_rol      int(11) AUTO_INCREMENT NOT NULL,
    rol         varchar(50),
    CONSTRAINT  pk_rol PRIMARY KEY (id_rol)
)ENGINE=InnoDB;

CREATE TABLE t_usuario(
    id_usuario      int(11) AUTO_INCREMENT NOT NULL,
    nombre          varchar(50),
    apellido        varchar(50),
    correo          varchar(100),
    password        varchar(100),
    id_rol          int(11),
    CONSTRAINT      pk_usuario PRIMARY KEY (id_usuario),
    CONSTRAINT      fk_rol FOREIGN KEY (id_rol) REFERENCES t_rol(id_rol)
)ENGINE=InnoDB;

CREATE TABLE t_ciudad (
    id_ciudad   int(11) AUTO_INCREMENT NOT NULL,
    ciudad      varchar (100),
    CONSTRAINT  pk_ciudad PRIMARY KEY (id_ciudad)
)ENGINE=InnoDB;

INSERT INTO t_ciudad (id_ciudad,ciudad) values (null, "Bogota");
INSERT INTO t_ciudad (id_ciudad,ciudad) values (null, "Ibague");
INSERT INTO t_ciudad (id_ciudad,ciudad) values (null, "Cartagena");

CREATE TABLE t_unidad(
    id_unidad   int(11)  AUTO_INCREMENT NOT NULL,
    unidad      varchar(50),
    CONSTRAINT  pk_unidad PRIMARY KEY (id_unidad)
)ENGINE=InnoDB;

insert into t_unidad (id_unidad, unidad) values (null,"unidad");
insert into t_unidad (id_unidad, unidad) values (null,"kilo");
insert into t_unidad (id_unidad, unidad) values (null,"resma");


CREATE TABLE t_cliente(
    id_cliente       int(11) AUTO_INCREMENT NOT NULL,
    nombre           varchar(100),
    direccion        varchar(100),
    id_ciudad        int(11),
    CONSTRAINT       pk_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT       fk_ciudad  FOREIGN KEY (id_ciudad) REFERENCES t_ciudad(id_ciudad)
)ENGINE=InnoDB;

CREATE TABLE t_producto(
    id_producto     int(11) AUTO_INCREMENT NOT NULL,
    descripcion     varchar(100),
    id_unidad       int(11),
    vr_unidatario   float (10,2),
    CONSTRAINT      pk_producto PRIMARY KEY (id_producto),
    CONSTRAINT      fk_unidad   FOREIGN KEY (id_unidad) REFERENCES t_unidad(id_unidad)
)ENGINE=InnoDB;

CREATE TABLE t_factura(
    id_factura      int(11) AUTO_INCREMENT NOT NULL,
    id_usuario      int(11),
    id_cliente      int(11),
    id_producto     int(11),
    cantidad        int(11),
    fecha           date,
    vr_unitario   float (10,2),
    CONSTRAINT      pk_factura PRIMARY KEY (id_factura),
    CONSTRAINT      fk_cliente FOREIGN KEY (id_cliente) REFERENCES t_cliente(id_cliente),
    CONSTRAINT      fk_producto FOREIGN KEY (id_producto) REFERENCES t_producto(id_producto),
    CONSTRAINT      fk_usuario FOREIGN KEY (id_usuario) REFERENCES t_usuario(id_usuario)
)ENGINE=InnoDB;


------- Factura

SELECT FAC.id_factura,
       FAC.fecha,
       FAC.id_usuario,
       USU.nombre,
       USU.apellido,
       FAC.id_cliente,
       CLI.nombre,
       CLI.direccion,
       FAC.id_producto,
       PRO.descripcion,
       PRO.vr_unitario,
       FAC.cantidad,
       FAC.cantidad * FAC.vr_unitario AS total
FROM t_factura FAC
INNER JOIN t_usuario USU ON USU.id_usuario = FAC.id_usuario
INNER JOIN t_cliente CLI ON CLI.id_cliente = FAC.id_cliente
INNER JOIN t_producto PRO ON PRO.id_producto = FAC.id_producto
