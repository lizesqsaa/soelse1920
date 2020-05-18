<?php
function consultarUsuario($conexion,$nickname_p,$contrasena_p) {
	$consulta = "SELECT COUNT(*) AS TOTAL FROM USUARIOS WHERE nickname=:nickname_p AND contrasena=:contrasena_p";
	$stmt = $conexion->prepare($consulta);
	$stmt->bindParam(':nickname_p',$nickname_p);
	$stmt->bindParam(':contrasena_p',$contrasena_p);
	$stmt->execute();
	return $stmt->fetchColumn();
}
