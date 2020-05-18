<?php

function consultarMateriales($conexion)
{
    try {
        $consulta = "SELECT * FROM MATERIALES"
            . " ORDER BY NOMBRE_MATERIAL";
        return $consulta;
    } catch(PDOException $e) {
        $_SESSION["errores"] = $e->getMessage();
    }
}

function anyadirMaterial($conexion, $nombre_material, $stock, $precio_total) {
    try {
        $stmt=$conexion->prepare("CALL ADD_MATERIAL(:NOMBRE,:STOCK,:PRECIO)");
        $stmt->bindParam(':NOMBRE',$nombre_material);
        $stmt->bindParam(':STOCK',$stock);
        $stmt->bindParam(':PRECIO',$precio_total);
     
        $stmt->execute();
        return "";
    } catch(PDOException $e) {
        $_SESSION["errores"] = $e->getMessage();
    }
}

function eliminarMaterial($conexion,$delete){
    try{
        $stmt=$conexion->prepare("CALL DELETE_PEDIDO(:NOMBRE)");
        $stmt->bindParam(':NOMBRE',$delete);
        $stmt->execute();
        return "";
    } catch (PDOException $e){
        $_SESSION["errores"] = $e->getMessage();
    }
}

function actualizarMaterial($conexion, $pCodigo, $pFecha, $pHorario, $pTipo) {
    try {
        $stmt=$conexion->prepare("CALL UPDATE_PEDIDO(:CODIGO,:FECHAPEDIDO,:HORARIOPEDIDO,:TIPOPEDIDO)");
        $stmt->bindParam(':CODIGO',$pCodigo);
        $stmt->bindParam(':FECHAPEDIDO',$pFecha);
        $stmt->bindParam(':HORARIOPEDIDO',$pHorario);
        $stmt->bindParam(':TIPOPEDIDO',$pTipo);
        $stmt->execute();
        return "";
    } catch(PDOException $e) {
        $_SESSION["errores"] = $e->getMessage();
    }


?>