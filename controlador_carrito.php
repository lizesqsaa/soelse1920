<?php	
	session_start();
	
	if (isset($_REQUEST["OID_CARRITO"])){
		$carro["OID_CARRITO"] = $_REQUEST["OID_CARRITO"];
		$carro["OID_CLIENTE"] = $_REQUEST["OID_CLIENTE"];
		$carro["ID_PEDIDO_1"] = $_REQUEST["ID_PEDIDO_1"];
		$carro["ID_PEDIDO_2"] = $_REQUEST["ID_PEDIDO_2"];
		$carro["ID_PEDIDO_3"] = $_REQUEST["ID_PEDIDO_3"];
		$carro["ID_PEDIDO_4"] = $_REQUEST["ID_PEDIDO_4"];
        $carro["ID_PEDIDO_5"] = $_REQUEST["ID_PEDIDO_5"];
        $carro["ID_PEDIDO_6"] = $_REQUEST["ID_PEDIDO_6"];
        $carro["ID_PEDIDO_7"] = $_REQUEST["ID_PEDIDO_7"];
        $carro["ID_PEDIDO_8"] = $_REQUEST["ID_PEDIDO_8"];
        $carro["ID_PEDIDO_9"] = $_REQUEST["ID_PEDIDO_9"];
        $carro["ID_PEDIDO_10"] = $_REQUEST["ID_PEDIDO_10"];

		$_SESSION["carrito"] = $carro;

		if (isset($_REQUEST["editar"])) Header("Location: consulta_libros.php"); 
		else(isset($_REQUEST["grabar"])) Header("Location: accion_modificar_libro.php");
		else /* if (isset($_REQUEST["borrar"])) */ Header("Location: accion_borrar_libro.php"); 
	}
	else 
		Header("Location: consulta_libros.php");

?>