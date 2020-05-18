--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE GERENTE(
    OID_GERENTE SMALLINT PRIMARY KEY,
    nickname VARCHAR(50) not null unique,
    contraseña varchar(140) not null unique,
    correo varchar(50) not null unique,
    telefono CHAR(9) not null unique, CHECK (REGEXP_LIKE(telefono, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
    );

CREATE SEQUENCE Secuencia_GERENTE INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

CREATE OR REPLACE TRIGGER Trigger_Secuencia_GERENTE
BEFORE INSERT ON GERENTE
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_GERENTE.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_GERENTE := valorSec;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE EMPLEADOS(
    OID_EMPLEADO SMALLINT,
    OID_GERENTE SMALLINT not null,
    nombreEmpleado VARCHAR(20) not null unique,
    cargo VARCHAR(25) not null,
    division VARCHAR(25) not null,
    tipoPenalizacionEmpleado varchar(9), check(tipoPenalizacionEmpleado in('MONETARIA','DESPIDO')),
    fecha_inicio CHAR(5) not null,CHECK (REGEXP_LIKE(fecha_inicio, '[0-2][0-9][:][0-5][0-9]')),
    fecha_fin CHAR(5) not null,CHECK (REGEXP_LIKE(fecha_inicio, '[0-2][0-9][:][0-5][0-9]')),
    dia_de_la_semana VARCHAR(20), CHECK(dia_de_la_semana IN('LUNES','MARTES', 'MIERCOLES', 'JUEVES', 'VIERNES', 'SABADO')),
    PRIMARY KEY(OID_EMPLEADO),
    FOREIGN KEY(OID_GERENTE) REFERENCES GERENTE
    );

CREATE SEQUENCE Secuencia_Empleado INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

create or replace TRIGGER Trigger_Secuencia_Empleado
BEFORE INSERT ON EMPLEADOS
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_Empleado.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_EMPLEADO := valorSec;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE PEDIDOMATERIALES(
    OID_PEDIDO_MAT SMALLINT PRIMARY KEY,
    OID_GERENTE SMALLINT NOT NULL,
    tipo_Penalizacion varchar(11), CHECK (tipo_Penalizacion in ('RETRASO','DETERIORADO')),
    fecha_Limite date not null,check(fecha_Limite > TO_DATE('2020-01-12','YYYY-MM-DD')),
    descuento char(2) not null, CHECK (descuento in ('NO','SI')),
    posicion_Cola integer unique,check(posicion_Cola>=0),
    FOREIGN KEY(OID_GERENTE) REFERENCES GERENTE
    );
    
CREATE SEQUENCE Secuencia_P_Mat INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

CREATE OR REPLACE TRIGGER Trigger_Secuencia_P_Mat
BEFORE INSERT ON PEDIDOMATERIALES
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_P_Mat.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_PEDIDO_MAT := valorSec;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE PROVEEDORES(
    OID_PROVEEDOR SMALLINT,
    nombre_proveedor VARCHAR(20) not null unique,
    telefono_proveedor char(9) not null unique,CHECK (REGEXP_LIKE(telefono_proveedor, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
    correo_proveedor varchar(35) not null,
    empresa_proveedor varchar(20) not null,
    primary key(OID_PROVEEDOR)
    );
    
CREATE SEQUENCE Secuencia_Proveedor INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

CREATE OR REPLACE TRIGGER Trigger_Secuencia_Proveedor
BEFORE INSERT ON PROVEEDORES
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_Proveedor.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_PROVEEDOR := valorSec;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE MATERIALES(
    OID_MATERIAL SMALLINT,
    OID_PROVEEDOR SMALLINT not null,
    nombre_material VARCHAR(20) not null unique, 
    stock integer not null, check(stock>=0),
    precio_total integer not null,check(precio_total>=0),
    primary key(OID_MATERIAL),
    foreign key(OID_PROVEEDOR) references PROVEEDORES
    );
    
CREATE SEQUENCE Secuencia_Material INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

CREATE OR REPLACE TRIGGER Trigger_Secuencia_Material
BEFORE INSERT ON MATERIALES
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_Material.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_MATERIAL := valorSec;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE LINEAPEDIDOMATERIALES(
    OID_LPM SMALLINT,
    OID_PEDIDO_MAT SMALLINT not null,
    OID_MATERIAL SMALLINT not null,
    cantidad integer not null,check(cantidad>0),
    precio_pedido integer not null,check(precio_pedido>0),
    primary key(OID_LPM),
    foreign key(OID_PEDIDO_MAT) references PEDIDOMATERIALES,
    foreign key(OID_MATERIAL) references MATERIALES
    );

CREATE SEQUENCE Secuencia_Linea_Pedido_Mat INCREMENT BY 1 START WITH 1 MAXVALUE 99999; 

CREATE OR REPLACE TRIGGER Trigger_Secuencia
BEFORE INSERT ON LINEAPEDIDOMATERIALES
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_Linea_Pedido_Mat.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_LPM := valorSec;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE PRODUCTOS (
    OID_PRODUCTO SMALLINT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL UNIQUE,
    categoria varchar(25) not null unique,
    precio integer NOT NULL,
    descripcion long not null,
    imagen varchar(500) not null unique,
    tiempo_estimado_dias integer not null
);

CREATE SEQUENCE Secuencia_PRODUCTOS INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

CREATE OR REPLACE TRIGGER Trigger_Secuencia_PRODUCTOS
BEFORE INSERT ON PRODUCTOS
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_PRODUCTOS.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_PRODUCTO := valorSec;
END;
/
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE CLIENTES(
    OID_CLIENTE SMALLINT PRIMARY KEY,
    nombre_cliente VARCHAR(20) not null,
    apellido VARCHAR(100) not null,
    correo varchar(75) not null UNIQUE,
    telefono INTEGER not null unique, CHECK (REGEXP_LIKE(telefono,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
    cuenta_bancaria char(24) not null, CHECK (REGEXP_LIKE(cuenta_bancaria,'[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
    recomendacion varchar(140),
    emplazamiento varchar(140) unique NOT NULL
    );

CREATE SEQUENCE Secuencia_Cliente INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

CREATE OR REPLACE TRIGGER Trigger_Secuencia_Cliente
BEFORE INSERT ON CLIENTES
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_Cliente.NEXTVAL INTO :NEW.OID_CLIENTE FROM DUAL;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE PEDIDOS(
    OID_PEDIDO SMALLINT PRIMARY KEY,
    OID_CLIENTE  SMALLINT not null,
    fecha_Limite date not null,check(fecha_Limite > fecha_inicio and fecha_Limite>=fecha_fin),
    fecha_inicio date not null,check(fecha_inicio<fecha_fin),
    fecha_fin date not null,check(fecha_fin>fecha_inicio),
    tipo_Penalizacion varchar(11), CHECK (tipo_Penalizacion in ('MONETARIA','CANCELACION')),
    pena integer,
    descuento integer,
    precio integer not null,
    cantidad integer not null,
    FOREIGN KEY(OID_CLIENTE) REFERENCES CLIENTES
    );
    
CREATE SEQUENCE Secuencia_Pedido INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

CREATE OR REPLACE TRIGGER Trigger_Secuencia_Pedido
BEFORE INSERT ON PEDIDOS
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_Pedido.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_PEDIDO := valorSec;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TIENE_PEDIDOS (
    OID_TIENE_PEDIDOS SMALLINT PRIMARY KEY,
    OID_PRODUCTO SMALLINT not null,
    OID_PEDIDO SMALLINT not null,
    numero integer not null,
    
    CONSTRAINT AK_PRODUCTO_PEDIDO UNIQUE (OID_PRODUCTO),
    CONSTRAINT AK_PEDIDO UNIQUE (OID_PEDIDO)
);

CREATE SEQUENCE Secuencia_Tiene_PEDIDO INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

CREATE OR REPLACE TRIGGER Trigger_Secuencia_T_PEDIDOS
BEFORE INSERT ON TIENE_PEDIDOS
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_Tiene_PEDIDO.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_TIENE_PEDIDOS := valorSec;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------


CREATE TABLE USUARIOS(
    OID_USUARIO SMALLINT PRIMARY KEY,
    OID_CLIENTE SMALLINT UNIQUE,
    OID_GERENTE SMALLINT UNIQUE,
    nickname VARCHAR(25) NOT NULL UNIQUE,
    contrasena VARCHAR(50) NOT NULL,
    FOREIGN KEY(OID_GERENTE) REFERENCES GERENTE,
    FOREIGN KEY(OID_CLIENTE) REFERENCES CLIENTES
);

CREATE SEQUENCE Secuencia_Tiene_USUARIOS INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

CREATE OR REPLACE TRIGGER Trigger_Secuencia_T_USUARIOS
BEFORE INSERT ON USUARIOS
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_Tiene_USUARIOS.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_USUARIO := valorSec;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE CARRITOS (
    OID_CARRITO SMALLINT PRIMARY KEY,
    OID_CLIENTE SMALLINT NOT NULL UNIQUE,
    ID_PEDIDO_1 SMALLINT,
    ID_PEDIDO_2 SMALLINT,
    ID_PEDIDO_3 SMALLINT,
    ID_PEDIDO_4 SMALLINT,
    ID_PEDIDO_5 SMALLINT,
    ID_PEDIDO_6 SMALLINT,
    ID_PEDIDO_7 SMALLINT,
    ID_PEDIDO_8 SMALLINT,
    ID_PEDIDO_9 SMALLINT,
    ID_PEDIDO_10 SMALLINT,
    FOREIGN KEY(OID_CLIENTE) REFERENCES CLIENTES
);

CREATE SEQUENCE Secuencia_CARRITO INCREMENT BY 1 START WITH 1 MAXVALUE 99999;

CREATE OR REPLACE TRIGGER Trigger_Secuencia_USUARIOS
BEFORE INSERT ON CARRITOS
FOR EACH ROW
DECLARE
valorSec NUMBER := 0;
BEGIN
SELECT Secuencia_CARRITO.NEXTVAL INTO valorSec FROM DUAL;
:NEW.OID_CARRITO := valorSec;
END;
/

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------