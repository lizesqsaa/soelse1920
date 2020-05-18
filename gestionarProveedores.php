<?php
    
    function alta_proveedor($conexion, $proveedor) {

        try{
            $consulta =  "INSERT INTO proveedores (nombre, telefono, correo, empresa) VALUES(:nombre, :telefono, :correo, :empresa) "; 
            $stmt=$conexion->prepare($consulta);
            $stmt=bindParam(':nombre',$proveedor["nombre"]);
            $stmt=bindParam(':telefono',$proveedor["telefono"]);
            $stmt=bindParam(':correo',$proveedor["correo"]);
            $stmt=bindParam(':empresa',$proveedor["empresa"]);

            $stmt->execute();

            return true;
            catch(PDOException $e) {
                return false;

                // Si queremos visualizar la excepción durante la depuración: $e->getMessage();
            }
        }
    }


    function quitar_proveedor($conexion, $OID_PROVEEDOR){
        try{
            $stmt=$conexion->prepare('CALL QUITAR_PROVEEDOR(:OID_PROVEEDOR)');
		    $stmt->bindParam(':OID_PROVEEDOR',$OID_PROVEEDOR);
		    $stmt->execute();
		    return "";
        }catch(PDOException $e) {
            return $e->getMessage();
        }
    }



?>