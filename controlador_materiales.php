<?php
    session_start();

    if (isset($_REQUEST["OID_MATERIALES"])){

        $materiales["OID_MATERIALES"] = $_REQUEST["OID_MATERIALES"];



        $_SESSION["materiales"] = $materiales;

		if (isset($_REQUEST["editar"])) Header("Location: consulta_materiales.php");
		else if (isset($_REQUEST["grabar"])) Header("Location: accion_modificar_material.php");
		else if (isset($_REQUEST["borrar"]))  Header("Location: accion_borrar_material.php");
		else Header("Location: accion_comprar_material.php");

    }
   else
    Header("Location: consulta_materialess.php");

?>
