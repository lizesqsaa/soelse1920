<?php
function consulta_carrito($conn, $query, $OID_CLIENTE)
{

    try {
        $consulta = "SELECT * FROM CARRITOS WHERE OID_CLIENTE = :OID_CLIENTE";
        $stmt = $conn->prepare($consulta);
        $stmt->execute();
        return $stmt;
    }
    catch (PDOException $e) {
        $_SESSION['excepcion']=$e->GetMessage();
        header("Location: excepcion.php");
    }
}
?>