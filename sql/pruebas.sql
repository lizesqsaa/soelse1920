CREATE OR REPLACE 
FUNCTION ASSERT_EQUALS (salida BOOLEAN, salida_esperada boolean) return VARCHAR as 
begin
if (salida = salida_esperada) then
    return 'Exito';
    else
    return 'Fallo';
    end if;
end ASSERT_EQUALS;
/

create or replace
package PRUEBAS_CLIENTES as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_nombre_cliente VARCHAR, w_apellido varchar, w_correo varchar, w_telefono CHAR,w_cuenta_bancaria CHAR, w_recomendacion VARCHAR, w_emplazamiento VARCHAR, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_CLIENTE SMALLINT, w_nombre_cliente VARCHAR,w_apellido varchar, w_correo varchar, w_telefono CHAR, w_cuenta_bancaria CHAR, w_recomendacion VARCHAR, w_emplazamiento VARCHAR, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar,W_OID_CLIENTE SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_CLIENTES;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_CLIENTES AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM CLIENTES;
END inicializar;

PROCEDURE insertar(nombre_prueba varchar,w_nombre_cliente VARCHAR, w_apellido varchar, w_correo varchar, w_telefono CHAR,w_cuenta_bancaria CHAR, w_recomendacion VARCHAR, w_emplazamiento VARCHAR, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    cliente CLIENTES%ROWTYPE;
    w_OID_CLIENTE SMALLINT;
    
BEGIN

    INSERT INTO CLIENTES VALUES(Secuencia_Cliente.nextval,w_nombre_cliente, w_apellido, w_correo,w_telefono,w_cuenta_bancaria, w_recomendacion, w_emplazamiento);

    w_OID_CLIENTE := Secuencia_Cliente.currval;
    SELECT * INTO cliente FROM CLIENTES WHERE OID_CLIENTE=w_OID_CLIENTE;
    IF (cliente.nombre_cliente<>w_nombre_cliente) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_CLIENTE SMALLINT, w_nombre_cliente VARCHAR, w_apellido varchar, w_correo varchar, w_telefono CHAR,w_cuenta_bancaria CHAR, w_recomendacion VARCHAR, w_emplazamiento VARCHAR, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    cliente CLIENTES%ROWTYPE;
    
BEGIN

    UPDATE CLIENTES SET nombre_cliente =w_nombre_cliente WHERE OID_CLIENTE=w_OID_CLIENTE;
    UPDATE CLIENTES SET apellido = w_apellido WHERE OID_CLIENTE=w_OID_CLIENTE;
    UPDATE CLIENTES SET correo=w_correo WHERE OID_CLIENTE=w_OID_CLIENTE;
    UPDATE CLIENTES SET telefono= w_telefono WHERE OID_CLIENTE=w_OID_CLIENTE;
    UPDATE CLIENTES SET cuenta_bancaria= w_cuenta_bancaria WHERE OID_CLIENTE=w_OID_CLIENTE;
    UPDATE CLIENTES SET recomendacion= w_recomendacion WHERE OID_CLIENTE=w_OID_CLIENTE;
    UPDATE CLIENTES SET emplazamiento= w_emplazamiento WHERE OID_CLIENTE=w_OID_CLIENTE;

    SELECT * INTO cliente FROM CLIENTES WHERE OID_CLIENTE=w_OID_CLIENTE;

    IF (cliente.nombre_cliente<>w_nombre_cliente) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar,W_OID_CLIENTE SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_clientes INTEGER;
BEGIN

    DELETE FROM CLIENTES WHERE OID_CLIENTE=W_OID_CLIENTE;
    
    SELECT COUNT(*) INTO n_clientes from CLIENTES WHERE OID_CLIENTE= W_OID_CLIENTE;
    IF (n_clientes <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------
end PRUEBAS_CLIENTES;
/





create or replace
package PRUEBAS_PEDIDOS as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_OID_CLIENTE SMALLINT, w_fecha_limite date, w_fecha_inicio date, w_fecha_fin date, w_tipo_Penalizacion varchar,w_pena integer, w_descuento integer,w_precio integer,w_cantidad integer, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar, w_OID_PEDIDO SMALLINT,w_OID_CLIENTE SMALLINT, w_fecha_limite date, w_fecha_inicio date, w_fecha_fin date, w_tipo_Penalizacion varchar,w_pena integer, w_descuento integer,w_precio integer,w_cantidad integer, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar,W_OID_PEDIDO SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_PEDIDOS;
/
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PRUEBAS_PEDIDOS AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM PEDIDOS;
END inicializar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE insertar(nombre_prueba varchar,w_OID_CLIENTE SMALLINT, w_fecha_limite date, w_fecha_inicio date, w_fecha_fin date, w_tipo_Penalizacion varchar,w_pena integer, w_descuento integer,w_precio integer,w_cantidad integer, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    pedido PEDIDOS%ROWTYPE;
    w_OID_PEDIDO SMALLINT;
    
BEGIN

    INSERT INTO PEDIDOS VALUES(Secuencia_Pedido.nextval,w_OID_CLIENTE, w_fecha_limite,w_fecha_inicio,w_fecha_fin,w_tipo_Penalizacion,w_pena,w_descuento,w_precio,w_cantidad);

    w_OID_PEDIDO := Secuencia_Pedido.currval;
    SELECT * INTO pedido FROM PEDIDOS WHERE OID_PEDIDO=w_OID_PEDIDO;
    IF (pedido.descuento>w_descuento) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar, w_OID_PEDIDO SMALLINT,w_OID_CLIENTE SMALLINT, w_fecha_limite date, w_fecha_inicio date, w_fecha_fin date, w_tipo_Penalizacion varchar,w_pena integer, w_descuento integer,w_precio integer,w_cantidad integer, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    pedido PEDIDOS%ROWTYPE;
    
BEGIN
    
    UPDATE PEDIDOS SET OID_CLIENTE =w_OID_CLIENTE WHERE OID_PEDIDO=w_OID_PEDIDO;
    UPDATE PEDIDOS SET fecha_limite =w_fecha_limite WHERE OID_PEDIDO=w_OID_PEDIDO;
    UPDATE PEDIDOS SET fecha_inicio =w_fecha_inicio WHERE OID_PEDIDO=w_OID_PEDIDO;
    UPDATE PEDIDOS SET fecha_fin = w_fecha_fin WHERE OID_PEDIDO=w_OID_PEDIDO;
    UPDATE PEDIDOS SET tipo_Penalizacion = w_tipo_Penalizacion WHERE OID_PEDIDO=w_OID_PEDIDO;
    UPDATE PEDIDOS SET pena = w_pena WHERE OID_PEDIDO=w_OID_PEDIDO;
    UPDATE PEDIDOS SET descuento = w_descuento WHERE OID_PEDIDO=w_OID_PEDIDO;
    UPDATE PEDIDOS SET precio= w_precio WHERE OID_PEDIDO=w_OID_PEDIDO;
    UPDATE PEDIDOS SET cantidad= w_cantidad WHERE OID_PEDIDO=w_OID_PEDIDO;

    SELECT * INTO pedido FROM PEDIDOS WHERE OID_PEDIDO=w_OID_PEDIDO;

    IF (pedido.descuento<>w_descuento) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar,W_OID_PEDIDO SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_pedidos INTEGER;
BEGIN

    DELETE FROM PEDIDOS WHERE OID_PEDIDO=W_OID_PEDIDO;
    
    SELECT COUNT(*) INTO n_pedidos from PEDIDOS WHERE OID_PEDIDO= W_OID_PEDIDO;
    IF (n_pedidos <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------
end PRUEBAS_PEDIDOS;
/





create or replace
package PRUEBAS_GERENTE as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_nickname varchar, w_contraseña varchar, w_correo varchar, w_telefono CHAR, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_GERENTE SMALLINT,w_nickname VARCHAR, w_contraseña varchar, w_correo varchar, w_telefono CHAR, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar,W_OID_GERENTE SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_GERENTE;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_GERENTE AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM GERENTE;
END inicializar;

PROCEDURE insertar(nombre_prueba varchar,w_nickname VARCHAR, w_contraseña varchar, w_correo varchar, w_telefono CHAR, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    gerentes GERENTE%ROWTYPE;
    w_OID_GERENTE SMALLINT;
    
BEGIN

    INSERT INTO GERENTE VALUES(Secuencia_GERENTE.nextval,w_nickname, w_contraseña , w_correo , w_telefono);

    w_OID_GERENTE := Secuencia_GERENTE.currval;
    SELECT * INTO gerentes FROM GERENTE WHERE OID_GERENTE=w_OID_GERENTE;
    IF (gerentes.nickname<>w_nickname) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_GERENTE SMALLINT,w_nickname VARCHAR, w_contraseña varchar, w_correo varchar, w_telefono CHAR, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    gerentes GERENTE%ROWTYPE;
    
BEGIN

    UPDATE GERENTE SET nickname =w_nickname WHERE OID_GERENTE=w_OID_GERENTE;
    UPDATE GERENTE SET contraseña = w_contraseña WHERE OID_GERENTE=w_OID_GERENTE;
    UPDATE GERENTE SET correo=w_correo WHERE OID_GERENTE=w_OID_GERENTE;
    UPDATE GERENTE SET telefono= w_telefono WHERE OID_GERENTE=w_OID_GERENTE;

    SELECT * INTO gerentes FROM GERENTE WHERE OID_GERENTE=w_OID_GERENTE;

    IF (gerentes.nickname<>w_nickname) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar,w_OID_GERENTE SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_gerente INTEGER;
BEGIN

    DELETE FROM GERENTE WHERE OID_GERENTE=w_OID_GERENTE;
    
    SELECT COUNT(*) INTO n_gerente from GERENTE WHERE OID_GERENTE=w_OID_GERENTE;
    IF (n_gerente <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------
end PRUEBAS_GERENTE;
/





create or replace
package PRUEBAS_GERENTE as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_nickname varchar, w_contraseña varchar, w_correo varchar, w_telefono CHAR, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_GERENTE SMALLINT,w_nickname VARCHAR, w_contraseña varchar, w_correo varchar, w_telefono CHAR, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar,W_OID_GERENTE SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_GERENTE;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_GERENTE AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM GERENTE;
END inicializar;

PROCEDURE insertar(nombre_prueba varchar,w_nickname VARCHAR, w_contraseña varchar, w_correo varchar, w_telefono CHAR, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    gerentes GERENTE%ROWTYPE;
    w_OID_GERENTE SMALLINT;
    
BEGIN

    INSERT INTO GERENTE VALUES(Secuencia_GERENTE.nextval,w_nickname, w_contraseña , w_correo , w_telefono);

    w_OID_GERENTE := Secuencia_GERENTE.currval;
    SELECT * INTO gerentes FROM GERENTE WHERE OID_GERENTE=w_OID_GERENTE;
    IF (gerentes.nickname<>w_nickname) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_GERENTE SMALLINT,w_nickname VARCHAR, w_contraseña varchar, w_correo varchar, w_telefono CHAR, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    gerentes GERENTE%ROWTYPE;
    
BEGIN

    UPDATE GERENTE SET nickname =w_nickname WHERE OID_GERENTE=w_OID_GERENTE;
    UPDATE GERENTE SET contraseña = w_contraseña WHERE OID_GERENTE=w_OID_GERENTE;
    UPDATE GERENTE SET correo=w_correo WHERE OID_GERENTE=w_OID_GERENTE;
    UPDATE GERENTE SET telefono= w_telefono WHERE OID_GERENTE=w_OID_GERENTE;

    SELECT * INTO gerentes FROM GERENTE WHERE OID_GERENTE=w_OID_GERENTE;

    IF (gerentes.nickname<>w_nickname) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar,w_OID_GERENTE SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_gerente INTEGER;
BEGIN

    DELETE FROM GERENTE WHERE OID_GERENTE=w_OID_GERENTE;
    
    SELECT COUNT(*) INTO n_gerente from GERENTE WHERE OID_GERENTE=w_OID_GERENTE;
    IF (n_gerente <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------
end PRUEBAS_GERENTE;
/





create or replace
package PRUEBAS_EMPLEADOS as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_OID_GERENTE SMALLINT, w_nombreEmpleado varchar, w_cargo varchar, w_division varchar, w_tipoPenalizacionEmpleado varchar,w_fecha_inicio CHAR,w_fecha_fin CHAR,w_dia_de_la_semana varchar, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar, w_OID_EMPLEADO SMALLINT,w_OID_GERENTE SMALLINT, w_nombreEmpleado varchar, w_cargo varchar, w_division varchar, w_tipoPenalizacionEmpleado varchar,w_fecha_inicio CHAR,w_fecha_fin CHAR,w_dia_de_la_semana varchar, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar,w_OID_EMPLEADO SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_EMPLEADOS;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_EMPLEADOS AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM EMPLEADOS;
END inicializar;

PROCEDURE insertar(nombre_prueba varchar,w_OID_GERENTE SMALLINT, w_nombreEmpleado varchar, w_cargo varchar, w_division varchar, w_tipoPenalizacionEmpleado varchar,w_fecha_inicio CHAR,w_fecha_fin CHAR,w_dia_de_la_semana varchar, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    empleado EMPLEADOS%ROWTYPE;
    w_OID_EMPLEADO SMALLINT;
    
BEGIN

    INSERT INTO EMPLEADOS VALUES(Secuencia_Empleado.nextval,w_OID_GERENTE, w_nombreEmpleado, w_cargo , w_division , w_tipoPenalizacionEmpleado ,w_fecha_inicio ,w_fecha_fin ,w_dia_de_la_semana);

    w_OID_EMPLEADO := Secuencia_Empleado.currval;
    SELECT * INTO empleado FROM EMPLEADOS WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    IF (empleado.nombreEmpleado<>w_nombreEmpleado) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_EMPLEADO SMALLINT,w_OID_GERENTE SMALLINT, w_nombreEmpleado varchar, w_cargo varchar, w_division varchar, w_tipoPenalizacionEmpleado varchar,w_fecha_inicio CHAR,w_fecha_fin CHAR,w_dia_de_la_semana varchar, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    empleado EMPLEADOS%ROWTYPE;
    
BEGIN

    UPDATE EMPLEADOS SET OID_GERENTE =w_OID_GERENTE WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET nombreEmpleado =w_nombreEmpleado WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET cargo =w_cargo WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET division =w_division WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET tipoPenalizacionEmpleado =w_tipoPenalizacionEmpleado WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET fecha_inicio =w_fecha_inicio WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET fecha_fin =w_fecha_fin WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET dia_de_la_semana =w_dia_de_la_semana WHERE OID_EMPLEADO=w_OID_EMPLEADO;

    SELECT * INTO empleado FROM EMPLEADOS WHERE OID_EMPLEADO=w_OID_EMPLEADO;

    IF (empleado.nombreEmpleado<>w_nombreEmpleado) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar,w_OID_EMPLEADO SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_empleado INTEGER;
BEGIN

    DELETE FROM EMPLEADOS WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    
    SELECT COUNT(*) INTO n_empleado from EMPLEADOS WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    IF (n_empleado <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------
end PRUEBAS_EMPLEADOS;
/





create or replace
package PRUEBAS_EMPLEADOS as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_OID_GERENTE SMALLINT, w_nombreEmpleado varchar, w_cargo varchar, w_division varchar, w_tipoPenalizacionEmpleado varchar,w_fecha_inicio CHAR,w_fecha_fin CHAR,w_dia_de_la_semana varchar, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar, w_OID_EMPLEADO SMALLINT,w_OID_GERENTE SMALLINT, w_nombreEmpleado varchar, w_cargo varchar, w_division varchar, w_tipoPenalizacionEmpleado varchar,w_fecha_inicio CHAR,w_fecha_fin CHAR,w_dia_de_la_semana varchar, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar,w_OID_EMPLEADO SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_EMPLEADOS;
/

CREATE OR REPLACE PACKAGE BODY PRUEBAS_EMPLEADOS AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM EMPLEADOS;
END inicializar;

PROCEDURE insertar(nombre_prueba varchar,w_OID_GERENTE SMALLINT, w_nombreEmpleado varchar, w_cargo varchar, w_division varchar, w_tipoPenalizacionEmpleado varchar,w_fecha_inicio CHAR,w_fecha_fin CHAR,w_dia_de_la_semana varchar, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    empleado EMPLEADOS%ROWTYPE;
    w_OID_EMPLEADO SMALLINT;
    
BEGIN

    INSERT INTO EMPLEADOS VALUES(Secuencia_Empleado.nextval,w_OID_GERENTE, w_nombreEmpleado, w_cargo , w_division , w_tipoPenalizacionEmpleado ,w_fecha_inicio ,w_fecha_fin ,w_dia_de_la_semana);

    w_OID_EMPLEADO := Secuencia_Empleado.currval;
    SELECT * INTO empleado FROM EMPLEADOS WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    IF (empleado.nombreEmpleado<>w_nombreEmpleado) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_EMPLEADO SMALLINT,w_OID_GERENTE SMALLINT, w_nombreEmpleado varchar, w_cargo varchar, w_division varchar, w_tipoPenalizacionEmpleado varchar,w_fecha_inicio CHAR,w_fecha_fin CHAR,w_dia_de_la_semana varchar, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    empleado EMPLEADOS%ROWTYPE;
    
BEGIN

    UPDATE EMPLEADOS SET OID_GERENTE =w_OID_GERENTE WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET nombreEmpleado =w_nombreEmpleado WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET cargo =w_cargo WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET division =w_division WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET tipoPenalizacionEmpleado =w_tipoPenalizacionEmpleado WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET fecha_inicio =w_fecha_inicio WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET fecha_fin =w_fecha_fin WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    UPDATE EMPLEADOS SET dia_de_la_semana =w_dia_de_la_semana WHERE OID_EMPLEADO=w_OID_EMPLEADO;

    SELECT * INTO empleado FROM EMPLEADOS WHERE OID_EMPLEADO=w_OID_EMPLEADO;

    IF (empleado.nombreEmpleado<>w_nombreEmpleado) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar,w_OID_EMPLEADO SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_empleado INTEGER;
BEGIN

    DELETE FROM EMPLEADOS WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    
    SELECT COUNT(*) INTO n_empleado from EMPLEADOS WHERE OID_EMPLEADO=w_OID_EMPLEADO;
    IF (n_empleado <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------
end PRUEBAS_EMPLEADOS;
/





create or replace
package PRUEBAS_PEDIDOMATERIALES as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_OID_GERENTE SMALLINT, w_tipo_Penalizacion VARCHAR, w_fecha_Limite date, w_descuento char, w_posicion_Cola CHAR, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_PEDIDO_MAT SMALLINT, w_OID_GERENTE SMALLINT,w_tipo_Penalizacion VARCHAR, w_fecha_Limite date, w_descuento char, w_posicion_Cola CHAR, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar,w_OID_PEDIDO_MAT SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_PEDIDOMATERIALES;
/
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PRUEBAS_PEDIDOMATERIALES AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM PEDIDOMATERIALES;
END inicializar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE insertar(nombre_prueba varchar,w_OID_GERENTE SMALLINT, w_tipo_Penalizacion VARCHAR, w_fecha_Limite date, w_descuento char, w_posicion_Cola CHAR, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    pedidomaterial PEDIDOMATERIALES%ROWTYPE;
    w_OID_PEDIDO_MAT SMALLINT;
    
BEGIN

    INSERT INTO PEDIDOMATERIALES VALUES(Secuencia_P_Mat.nextval, w_OID_GERENTE, w_tipo_Penalizacion , w_fecha_Limite , w_descuento , w_posicion_Cola);

    w_OID_PEDIDO_MAT := Secuencia_P_Mat.currval;
    SELECT * INTO pedidomaterial FROM PEDIDOMATERIALES WHERE OID_PEDIDO_MAT=w_OID_PEDIDO_MAT;
    IF (pedidomaterial.tipo_Penalizacion<>w_tipo_Penalizacion) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_PEDIDO_MAT SMALLINT, w_OID_GERENTE SMALLINT, w_tipo_Penalizacion VARCHAR, w_fecha_Limite date, w_descuento char, w_posicion_Cola CHAR, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    pedidomaterial PEDIDOMATERIALES%ROWTYPE;
    
BEGIN

    UPDATE PEDIDOMATERIALES SET OID_GERENTE= w_OID_GERENTE WHERE OID_PEDIDO_MAT=w_OID_PEDIDO_MAT;
    UPDATE PEDIDOMATERIALES SET tipo_Penalizacion =w_tipo_Penalizacion WHERE OID_PEDIDO_MAT=w_OID_PEDIDO_MAT;
    UPDATE PEDIDOMATERIALES SET fecha_Limite = w_fecha_Limite WHERE OID_PEDIDO_MAT=w_OID_PEDIDO_MAT;
    UPDATE PEDIDOMATERIALES SET descuento=w_descuento WHERE OID_PEDIDO_MAT=w_OID_PEDIDO_MAT;
    UPDATE PEDIDOMATERIALES SET posicion_Cola= w_posicion_Cola WHERE OID_PEDIDO_MAT=w_OID_PEDIDO_MAT;

    SELECT * INTO pedidomaterial FROM PEDIDOMATERIALES WHERE OID_PEDIDO_MAT=w_OID_PEDIDO_MAT;

    IF (pedidomaterial.tipo_Penalizacion<>w_tipo_Penalizacion) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar,W_OID_PEDIDO_MAT SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_pedidomateriales INTEGER;
BEGIN

    DELETE FROM PEDIDOMATERIALES WHERE OID_PEDIDO_MAT=W_OID_PEDIDO_MAT;
    
    SELECT COUNT(*) INTO n_pedidomateriales from PEDIDOMATERIALES WHERE OID_PEDIDO_MAT= W_OID_PEDIDO_MAT;
    IF (n_pedidomateriales <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------

end PRUEBAS_PEDIDOMATERIALES;
/





create or replace
package PRUEBAS_PROVEEDORES as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_nombre_proveedor VARCHAR, w_telefono_proveedor char, w_correo_proveedor varchar, w_empresa_proveedor VARCHAR, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_PROVEEDOR SMALLINT,w_nombre_proveedor VARCHAR, w_telefono_proveedor char, w_correo_proveedor varchar, w_empresa_proveedor VARCHAR, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar,W_OID_PROVEEDOR SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_PROVEEDORES;
/
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PRUEBAS_PROVEEDORES AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM PROVEEDORES;
END inicializar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE insertar(nombre_prueba varchar,w_nombre_proveedor VARCHAR, w_telefono_proveedor char, w_correo_proveedor varchar, w_empresa_proveedor VARCHAR, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    proveedor PROVEEDORES%ROWTYPE;
    w_OID_PROVEEDOR SMALLINT;
    
BEGIN

    INSERT INTO PROVEEDORES VALUES(Secuencia_Proveedor.nextval,w_nombre_proveedor , w_telefono_proveedor , w_correo_proveedor , w_empresa_proveedor);

    w_OID_PROVEEDOR := Secuencia_Proveedor.currval;
    SELECT * INTO proveedor FROM PROVEEDORES WHERE OID_PROVEEDOR=w_OID_PROVEEDOR;
    IF (proveedor.nombre_proveedor<>w_nombre_proveedor) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_PROVEEDOR SMALLINT,w_nombre_proveedor VARCHAR, w_telefono_proveedor char, w_correo_proveedor varchar, w_empresa_proveedor VARCHAR, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    proveedor PROVEEDORES%ROWTYPE;
    
BEGIN

    UPDATE PROVEEDORES SET nombre_proveedor =w_nombre_proveedor WHERE OID_PROVEEDOR=w_OID_PROVEEDOR;
    UPDATE PROVEEDORES SET telefono_proveedor = w_telefono_proveedor WHERE OID_PROVEEDOR=w_OID_PROVEEDOR;
    UPDATE PROVEEDORES SET correo_proveedor=w_correo_proveedor WHERE OID_PROVEEDOR=w_OID_PROVEEDOR;
    UPDATE PROVEEDORES SET empresa_proveedor= w_empresa_proveedor WHERE OID_PROVEEDOR=w_OID_PROVEEDOR;

    SELECT * INTO proveedor FROM PROVEEDORES WHERE OID_PROVEEDOR=w_OID_PROVEEDOR;

    IF (proveedor.nombre_proveedor<>w_nombre_proveedor) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar,W_OID_PROVEEDOR SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_proveedores INTEGER;
BEGIN

    DELETE FROM PROVEEDORES WHERE OID_PROVEEDOR=W_OID_PROVEEDOR;
    
    SELECT COUNT(*) INTO n_proveedores from PROVEEDORES WHERE OID_PROVEEDOR= W_OID_PROVEEDOR;
    IF (n_proveedores <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------
end PRUEBAS_PROVEEDORES;
/





create or replace
package PRUEBAS_MATERIALES as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar, w_OID_PROVEEDOR SMALLINT, w_nombre_material VARCHAR, w_stock integer,w_precio_total integer, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_MATERIAL SMALLINT,w_OID_PROVEEDOR SMALLINT, w_nombre_material VARCHAR, w_stock integer, w_precio_total integer, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar,w_OID_MATERIAL SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_MATERIALES;
/
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PRUEBAS_MATERIALES AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM MATERIALES;
END inicializar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE insertar(nombre_prueba varchar, w_OID_PROVEEDOR SMALLINT, w_nombre_material VARCHAR, w_stock integer,w_precio_total integer, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    mat MATERIALES%ROWTYPE;
    w_OID_MATERIAL SMALLINT;
    
BEGIN

    INSERT INTO MATERIALES VALUES(Secuencia_Material.nextval,w_OID_PROVEEDOR,w_nombre_material,w_stock,w_precio_total);

    w_OID_MATERIAL := Secuencia_Material.currval;
    SELECT * INTO mat FROM MATERIALES WHERE OID_MATERIAL=w_OID_MATERIAL;
    IF (mat.nombre_material<>w_nombre_material) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_MATERIAL SMALLINT,w_OID_PROVEEDOR SMALLINT, w_nombre_material VARCHAR, w_stock integer, w_precio_total integer, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    mat MATERIALES%ROWTYPE;
    
BEGIN

    UPDATE MATERIALES SET OID_PROVEEDOR   =w_OID_PROVEEDOR WHERE OID_MATERIAL=w_OID_MATERIAL;
    UPDATE MATERIALES SET nombre_material =w_nombre_material WHERE OID_MATERIAL=w_OID_MATERIAL;
    UPDATE MATERIALES SET stock =w_stock WHERE OID_MATERIAL=w_OID_MATERIAL;
    UPDATE MATERIALES SET precio_total =w_precio_total WHERE OID_MATERIAL=w_OID_MATERIAL;


    SELECT * INTO mat FROM MATERIALES WHERE OID_MATERIAL=w_OID_MATERIAL;

    IF (mat.nombre_material<>w_nombre_material) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar,w_OID_MATERIAL SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_materiales INTEGER;
BEGIN

    DELETE FROM MATERIALES WHERE OID_MATERIAL=w_OID_MATERIAL;
    
    SELECT COUNT(*) INTO n_materiales from MATERIALES WHERE OID_MATERIAL=w_OID_MATERIAL;
    IF (n_materiales <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------

end PRUEBAS_MATERIALES;
/





create or replace
package PRUEBAS_LINEAPEDIDOMATERIALES as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar, w_OID_PEDIDO_MAT SMALLINT, w_OID_MATERIAL SMALLINT, w_cantidad integer, w_precio_pedido integer, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_LPM SMALLINT, w_OID_PEDIDO_MAT SMALLINT, w_OID_MATERIAL SMALLINT, w_cantidad integer, w_precio_pedido integer, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar,w_OID_LPM SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_LINEAPEDIDOMATERIALES;
/
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PRUEBAS_LINEAPEDIDOMATERIALES AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM LINEAPEDIDOMATERIALES;
END inicializar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE insertar(nombre_prueba varchar, w_OID_PEDIDO_MAT SMALLINT, w_OID_MATERIAL SMALLINT, w_cantidad integer, w_precio_pedido integer, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    lpm LINEAPEDIDOMATERIALES%ROWTYPE;
    w_OID_LPM SMALLINT;
    
BEGIN

    INSERT INTO LINEAPEDIDOMATERIALES VALUES(Secuencia_Linea_Pedido_Mat.nextval,w_OID_PEDIDO_MAT, w_OID_MATERIAL, w_cantidad, w_precio_pedido);

    w_OID_LPM := Secuencia_Linea_Pedido_Mat.currval;
    SELECT * INTO lpm FROM LINEAPEDIDOMATERIALES WHERE OID_LPM=w_OID_LPM;
    IF (lpm.cantidad<>w_cantidad) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_LPM SMALLINT, w_OID_PEDIDO_MAT SMALLINT, w_OID_MATERIAL SMALLINT, w_cantidad integer, w_precio_pedido integer, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    lpm LINEAPEDIDOMATERIALES%ROWTYPE;
    
BEGIN

    UPDATE LINEAPEDIDOMATERIALES SET OID_PEDIDO_MAT = w_OID_PEDIDO_MAT WHERE OID_LPM=w_OID_LPM;
    UPDATE LINEAPEDIDOMATERIALES SET OID_MATERIAL = w_OID_MATERIAL WHERE OID_LPM=w_OID_LPM;
    UPDATE LINEAPEDIDOMATERIALES SET cantidad = w_cantidad WHERE OID_LPM=w_OID_LPM;
    UPDATE LINEAPEDIDOMATERIALES SET precio_pedido = w_precio_pedido WHERE OID_LPM=w_OID_LPM;


    SELECT * INTO lpm FROM LINEAPEDIDOMATERIALES WHERE OID_LPM = w_OID_LPM;

    IF (lpm.cantidad<>w_cantidad) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar,w_OID_LPM SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_lpm INTEGER;
BEGIN

    DELETE FROM LINEAPEDIDOMATERIALES WHERE OID_LPM=w_OID_LPM;
    
    SELECT COUNT(*) INTO n_lpm from LINEAPEDIDOMATERIALES WHERE OID_LPM=w_OID_LPM;
    IF (n_lpm <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------

end PRUEBAS_LINEAPEDIDOMATERIALES;
/





create or replace
package PRUEBAS_PRODUCTOS as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar, w_nombre_producto VARCHAR, w_categoria varchar, w_precio integer, w_descripcion long, w_imagen varchar, w_tiempo_estimado_dias integer, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_PRODUCTO SMALLINT, w_nombre_producto VARCHAR, w_categoria varchar, w_precio integer, w_descripcion long, w_imagen varchar, w_tiempo_estimado_dias integer, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar, w_OID_PRODUCTO SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_PRODUCTOS;
/
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PRUEBAS_PRODUCTOS AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM PRODUCTOS;
END inicializar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE insertar(nombre_prueba varchar, w_nombre_producto VARCHAR, w_categoria varchar, w_precio integer, w_descripcion long, w_imagen varchar, w_tiempo_estimado_dias integer, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    product PRODUCTOS%ROWTYPE;
    w_OID_PRODUCTO SMALLINT;
    
BEGIN

    INSERT INTO PRODUCTOS VALUES(Secuencia_PRODUCTOS.nextval,w_nombre_producto , w_categoria , w_precio , w_descripcion , w_imagen , w_tiempo_estimado_dias );

    w_OID_PRODUCTO := Secuencia_PRODUCTOS.currval;
    SELECT * INTO product FROM PRODUCTOS WHERE OID_PRODUCTO=w_OID_PRODUCTO;
    IF (product.nombre_producto<>w_nombre_producto) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_PRODUCTO SMALLINT, w_nombre_producto VARCHAR, w_categoria varchar, w_precio integer, w_descripcion long, w_imagen varchar, w_tiempo_estimado_dias integer, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    product PRODUCTOS%ROWTYPE;
    
BEGIN

    UPDATE PRODUCTOS SET nombre_producto = w_nombre_producto WHERE OID_PRODUCTO = w_OID_PRODUCTO;
    UPDATE PRODUCTOS SET categoria = w_categoria WHERE OID_PRODUCTO = w_OID_PRODUCTO;
    UPDATE PRODUCTOS SET precio = w_precio WHERE OID_PRODUCTO = w_OID_PRODUCTO;
    UPDATE PRODUCTOS SET descripcion = w_descripcion WHERE OID_PRODUCTO = w_OID_PRODUCTO;
    UPDATE PRODUCTOS SET imagen = w_imagen WHERE OID_PRODUCTO = w_OID_PRODUCTO;
    UPDATE PRODUCTOS SET tiempo_estimado_dias = w_tiempo_estimado_dias WHERE OID_PRODUCTO = w_OID_PRODUCTO;


    SELECT * INTO product FROM PRODUCTOS WHERE OID_PRODUCTO = w_OID_PRODUCTO;

    IF (product.nombre_producto<>w_nombre_producto) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar, w_OID_PRODUCTO SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_product INTEGER;
BEGIN

    DELETE FROM PRODUCTOS WHERE OID_PRODUCTO = w_OID_PRODUCTO;
    
    SELECT COUNT(*) INTO n_product from PRODUCTOS WHERE OID_PRODUCTO = w_OID_PRODUCTO;
    IF (n_product <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------

end PRUEBAS_PRODUCTOS;
/





create or replace
package PRUEBAS_TIENE_PEDIDOS as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_OID_PRODUCTO SMALLINT, w_OID_PEDIDO SMALLINT, w_numero integer, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_TIENE_PEDIDOS SMALLINT,w_OID_PRODUCTO SMALLINT, w_OID_PEDIDO SMALLINT, w_numero integer, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar, w_OID_TIENE_PEDIDOS SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_TIENE_PEDIDOS;
/
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PRUEBAS_TIENE_PEDIDOS AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM TIENE_PEDIDOS;
END inicializar;

-------------------------------------------------------------------------------------------------------------------
PROCEDURE insertar(nombre_prueba varchar,w_OID_PRODUCTO SMALLINT, w_OID_PEDIDO SMALLINT, w_numero integer, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    t_pedidos TIENE_PEDIDOS%ROWTYPE;
    w_OID_TIENE_PEDIDOS SMALLINT;
    
BEGIN

    INSERT INTO TIENE_PEDIDOS VALUES(Secuencia_Tiene_PEDIDO.nextval,w_OID_PRODUCTO, w_OID_PEDIDO,w_numero);

    w_OID_TIENE_PEDIDOS := Secuencia_Tiene_PEDIDO.currval;
    SELECT * INTO t_pedidos FROM TIENE_PEDIDOS WHERE OID_TIENE_PEDIDOS=w_OID_TIENE_PEDIDOS;
    IF (t_pedidos.numero<>w_numero) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_TIENE_PEDIDOS SMALLINT,w_OID_PRODUCTO SMALLINT, w_OID_PEDIDO SMALLINT, w_numero integer, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    t_pedidos TIENE_PEDIDOS%ROWTYPE;
    
BEGIN

    UPDATE TIENE_PEDIDOS SET OID_PRODUCTO = w_OID_PRODUCTO WHERE OID_TIENE_PEDIDOS = w_OID_TIENE_PEDIDOS;
    UPDATE TIENE_PEDIDOS SET OID_PEDIDO = w_OID_PEDIDO WHERE OID_TIENE_PEDIDOS = w_OID_TIENE_PEDIDOS;
    UPDATE TIENE_PEDIDOS SET numero = w_numero WHERE OID_TIENE_PEDIDOS = w_OID_TIENE_PEDIDOS;

    SELECT * INTO t_pedidos FROM TIENE_PEDIDOS WHERE OID_TIENE_PEDIDOS = w_OID_TIENE_PEDIDOS;

    IF (t_pedidos.numero<>w_numero) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar, w_OID_TIENE_PEDIDOS SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_t_pedidos INTEGER;
BEGIN

    DELETE FROM TIENE_PEDIDOS WHERE OID_TIENE_PEDIDOS = w_OID_TIENE_PEDIDOS;
    
    SELECT COUNT(*) INTO n_t_pedidos from TIENE_PEDIDOS WHERE OID_TIENE_PEDIDOS = w_OID_TIENE_PEDIDOS;
    IF (n_t_pedidos <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------

end PRUEBAS_TIENE_PEDIDOS;
/





create or replace
package PRUEBAS_USUARIOS as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_OID_CLIENTE SMALLINT,w_OID_GERENTE SMALLINT, w_nickname VARCHAR, w_contrasena varchar, salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_USUARIO SMALLINT, w_OID_CLIENTE SMALLINT,w_OID_GERENTE SMALLINT, w_nickname VARCHAR, w_contrasena varchar, salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar, w_OID_USUARIO SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_USUARIOS;
/
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PRUEBAS_USUARIOS AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM USUARIOS;
END inicializar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE insertar(nombre_prueba varchar,w_OID_CLIENTE SMALLINT,w_OID_GERENTE SMALLINT, w_nickname VARCHAR, w_contrasena varchar, salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    usuar USUARIOS%ROWTYPE;
    w_OID_USUARIO SMALLINT;
    
BEGIN

    INSERT INTO USUARIOS VALUES(Secuencia_Tiene_USUARIOS.nextval,w_OID_CLIENTE,w_OID_GERENTE, w_nickname, w_contrasena);

    w_OID_USUARIO := Secuencia_Tiene_USUARIOS.currval;
    SELECT * INTO usuar FROM USUARIOS WHERE OID_USUARIO=w_OID_USUARIO;
    IF (usuar.nickname<>w_nickname) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_USUARIO SMALLINT, w_OID_CLIENTE SMALLINT,w_OID_GERENTE SMALLINT, w_nickname VARCHAR, w_contrasena varchar, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    usuar USUARIOS%ROWTYPE;
    
BEGIN

    UPDATE USUARIOS SET OID_CLIENTE = w_OID_CLIENTE WHERE OID_USUARIO = w_OID_USUARIO;
    UPDATE USUARIOS SET OID_GERENTE = w_OID_GERENTE WHERE OID_USUARIO = w_OID_USUARIO;
    UPDATE USUARIOS SET nickname = w_nickname WHERE OID_USUARIO = w_OID_USUARIO;
    UPDATE USUARIOS SET contrasena = w_contrasena WHERE OID_USUARIO = w_OID_USUARIO;


    SELECT * INTO usuar FROM USUARIOS WHERE OID_USUARIO = w_OID_USUARIO;

    IF (usuar.nickname<>w_nickname) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar, w_OID_USUARIO SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_usuar INTEGER;
BEGIN

    DELETE FROM USUARIOS WHERE OID_USUARIO = w_OID_USUARIO;
    
    SELECT COUNT(*) INTO n_usuar from USUARIOS WHERE OID_USUARIO = w_OID_USUARIO;
    IF (n_usuar <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------

end PRUEBAS_USUARIOS;
/





create or replace
package PRUEBAS_CARRITOS as
    procedure inicializar;
    procedure insertar (nombre_prueba varchar,w_OID_CLIENTE SMALLINT,w_ID_PEDIDO_1 SMALLINT,w_ID_PEDIDO_2 SMALLINT,w_ID_PEDIDO_3 SMALLINT,w_ID_PEDIDO_4 SMALLINT,w_ID_PEDIDO_5 SMALLINT,w_ID_PEDIDO_6 SMALLINT,w_ID_PEDIDO_7 SMALLINT,w_ID_PEDIDO_8 SMALLINT,w_ID_PEDIDO_9 SMALLINT,w_ID_PEDIDO_10 SMALLINT,salidaEsperada boolean);
    procedure actualizar(nombre_prueba varchar,w_OID_CARRITO SMALLINT,w_OID_CLIENTE SMALLINT,w_ID_PEDIDO_1 SMALLINT,w_ID_PEDIDO_2 SMALLINT,w_ID_PEDIDO_3 SMALLINT,w_ID_PEDIDO_4 SMALLINT,w_ID_PEDIDO_5 SMALLINT,w_ID_PEDIDO_6 SMALLINT,w_ID_PEDIDO_7 SMALLINT,w_ID_PEDIDO_8 SMALLINT,w_ID_PEDIDO_9 SMALLINT,w_ID_PEDIDO_10 SMALLINT,salidaEsperada boolean);
    procedure eliminar(nombre_prueba varchar, w_OID_CARRITO SMALLINT, salidaEsperada boolean);
    
end PRUEBAS_CARRITOS;
/
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PRUEBAS_CARRITOS AS

PROCEDURE inicializar AS
BEGIN
    DELETE FROM CARRITOS;
END inicializar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE insertar(nombre_prueba varchar,w_OID_CLIENTE SMALLINT,w_ID_PEDIDO_1 SMALLINT,w_ID_PEDIDO_2 SMALLINT,w_ID_PEDIDO_3 SMALLINT,w_ID_PEDIDO_4 SMALLINT,w_ID_PEDIDO_5 SMALLINT,w_ID_PEDIDO_6 SMALLINT,w_ID_PEDIDO_7 SMALLINT,w_ID_PEDIDO_8 SMALLINT,w_ID_PEDIDO_9 SMALLINT,w_ID_PEDIDO_10 SMALLINT,salidaEsperada boolean) AS
    
    salida BOOLEAN := true;
    carrit CARRITOS%ROWTYPE;
    w_OID_CARRITO SMALLINT;
    
BEGIN

    INSERT INTO CARRITOS VALUES(Secuencia_CARRITO.nextval,w_OID_CLIENTE ,w_ID_PEDIDO_1 ,w_ID_PEDIDO_2 ,w_ID_PEDIDO_3 ,w_ID_PEDIDO_4 ,w_ID_PEDIDO_5 ,w_ID_PEDIDO_6 ,w_ID_PEDIDO_7 ,w_ID_PEDIDO_8 ,w_ID_PEDIDO_9 ,w_ID_PEDIDO_10);

    w_OID_CARRITO := Secuencia_CARRITO.currval;
    SELECT * INTO carrit FROM CARRITOS WHERE OID_CARRITO=w_OID_CARRITO;
    IF (carrit.ID_PEDIDO_1<>w_ID_PEDIDO_1) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida,salidaEsperada));
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END insertar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE actualizar(nombre_prueba varchar,w_OID_CARRITO SMALLINT,w_OID_CLIENTE SMALLINT,w_ID_PEDIDO_1 SMALLINT,w_ID_PEDIDO_2 SMALLINT,w_ID_PEDIDO_3 SMALLINT,w_ID_PEDIDO_4 SMALLINT,w_ID_PEDIDO_5 SMALLINT,w_ID_PEDIDO_6 SMALLINT,w_ID_PEDIDO_7 SMALLINT,w_ID_PEDIDO_8 SMALLINT,w_ID_PEDIDO_9 SMALLINT,w_ID_PEDIDO_10 SMALLINT,salidaEsperada boolean) AS
    salida BOOLEAN := true;
    carrit CARRITOS%ROWTYPE;
    
BEGIN

    UPDATE CARRITOS SET OID_CLIENTE = w_OID_CLIENTE WHERE OID_CARRITO = w_OID_CARRITO;
    UPDATE CARRITOS SET ID_PEDIDO_1 = w_ID_PEDIDO_1 WHERE OID_CARRITO = w_OID_CARRITO;
    UPDATE CARRITOS SET ID_PEDIDO_2 = w_ID_PEDIDO_2 WHERE OID_CARRITO = w_OID_CARRITO;
    UPDATE CARRITOS SET ID_PEDIDO_3 = w_ID_PEDIDO_3 WHERE OID_CARRITO = w_OID_CARRITO;
    UPDATE CARRITOS SET ID_PEDIDO_4 = w_ID_PEDIDO_4 WHERE OID_CARRITO = w_OID_CARRITO;
    UPDATE CARRITOS SET ID_PEDIDO_5 = w_ID_PEDIDO_5 WHERE OID_CARRITO = w_OID_CARRITO;
    UPDATE CARRITOS SET ID_PEDIDO_6 = w_ID_PEDIDO_6 WHERE OID_CARRITO = w_OID_CARRITO;
    UPDATE CARRITOS SET ID_PEDIDO_7 = w_ID_PEDIDO_7 WHERE OID_CARRITO = w_OID_CARRITO;
    UPDATE CARRITOS SET ID_PEDIDO_8 = w_ID_PEDIDO_8 WHERE OID_CARRITO = w_OID_CARRITO;
    UPDATE CARRITOS SET ID_PEDIDO_9 = w_ID_PEDIDO_9 WHERE OID_CARRITO = w_OID_CARRITO;
    UPDATE CARRITOS SET ID_PEDIDO_10 =w_ID_PEDIDO_10 WHERE OID_CARRITO = w_OID_CARRITO;

    SELECT * INTO carrit FROM CARRITOS WHERE OID_CARRITO = w_OID_CARRITO;

    IF (carrit.ID_PEDIDO_1<>w_ID_PEDIDO_1) THEN
        salida := false;
    END IF;
    COMMIT WORK;

    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END actualizar;
-------------------------------------------------------------------------------------------------------------------
PROCEDURE eliminar(nombre_prueba varchar, w_OID_CARRITO SMALLINT, salidaEsperada boolean) AS
    salida BOOLEAN := true;
    n_carrit INTEGER;
BEGIN

    DELETE FROM CARRITOS WHERE OID_CARRITO = w_OID_CARRITO;
    
    SELECT COUNT(*) INTO n_carrit from CARRITOS WHERE OID_CARRITO = w_OID_CARRITO;
    IF (n_carrit <> 0) THEN
        salida := false;
    END IF;
    COMMIT WORK;
    
    DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(salida ,salidaEsperada));
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(nombre_prueba || ':' || ASSERT_EQUALS(false, salidaEsperada));
        ROLLBACK;
END eliminar;
-------------------------------------------------------------------------------------------------------------------

end PRUEBAS_CARRITOS;
/







begin

PRUEBAS_GERENTE.inicializar;
PRUEBAS_GERENTE.insertar('Prueba Insertar Gerente', 'admin','admin','casamarquez@gmail.com','123456789', true);
PRUEBAS_CLIENTES.inicializar;
PRUEBAS_CLIENTES.insertar('Prueba Insertar cliente','Antonio Manuel','Solis Miranda','antomanu2000@hotmail.es',611408436,'ES1234567891234567891234','Recomendacion Buena','Sevilla Este Sevilla España, Eolo nº40', true);
PRUEBAS_USUARIOS.inicializar;
PRUEBAS_USUARIOS.insertar('Pruebas Insertar Usuario','4','1','antsolmir','contraseñaIISSI2',true);

end;



Select * from Clientes;
Select * from Gerente;
Select * from Usuarios;