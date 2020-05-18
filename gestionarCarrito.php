<?php
function quitar_producto_carrito($conexion,$OID_CARRITO) {
    try {
        $stmt=$conexion->prepare('DELETE FROM CARRITOS WHERE OID_CARRITO = :OID_CARRITO');
		$stmt->bindParam(':OID_CARRITO',$OID_CARRITO);
		$stmt->execute();
		return "";
    } catch (PDOException $e) {
        return $e->getMessage();
    }
}
?>