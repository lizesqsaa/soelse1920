<?php
  /*
     * #===========================================================#
     * #	Este fichero contiene las funciones de gestión
     * #	de usuarios de la capa de acceso a datos
     * #==========================================================#
     */


    function alta_usuario($conexion,$usuario) {
        $fechaNacimiento = date('d/m/Y', strtotime($usuario["fechaNacimiento"]));
    
        try {
            $consulta = "CALL INSERTAR_USUARIO(:nif, :nombre, :ape, :dir, :mun, :fec, :email, :pass, :perfil)";
            $stmt=$conexion->prepare($consulta);
            $stmt->bindParam(':nif',$usuario["nif"]);
            $stmt->bindParam(':nombre',$usuario["nombre"]);
            $stmt->bindParam(':ape',$usuario["apellidos"]);
            $stmt->bindParam(':dir',$usuario["calle"]);
            $stmt->bindParam(':mun',$usuario["municipio"]);
            $stmt->bindParam(':fec',$fechaNacimiento);
            $stmt->bindParam(':email',$usuario["email"]);
            $stmt->bindParam(':pass',$usuario["pass"]);
            $stmt->bindParam(':perfil',$usuario["perfil"]);
            
            $stmt->execute();
            
           
        } catch(PDOException $e) {
            return false;
            // Si queremos visualizar la excepción durante la depuración: $e->getMessage();
        }
    }


/*function alta_empleado($conexion,$empleados) {
	try {
		$consulta = "CALL insertar(:email, :telefono, :contraseña)";
		$stmt=$conexion->prepare($consulta);
		$stmt->bindParam(':email',$usuario["email"]);
		$stmt->bindParam(':telefono',$usuario["telefono"]);
		$stmt->bindParam(':contraseña',$usuario["contraseña"]);

		$stmt->execute();


	} catch(PDOException $e) {
		return $e->getMessage();
		// Si queremos visualizar la excepción durante la depuración: $e->getMessage();
  }

}*/


function consultarUsuario($conexion,$email,$contraseña) {
 	$consulta = "SELECT COUNT(*) AS TOTAL FROM USUARIO WHERE email=:email AND contraseña=:contraseña";
	$stmt = $conexion->prepare($consulta);
	$stmt->bindParam(':email',$email);
	$stmt->bindParam(':contraseña',$contraseña);
	$stmt->execute();
	return $stmt->fetchColumn();
}
?>