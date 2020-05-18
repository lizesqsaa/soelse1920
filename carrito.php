<?php
session_start();

if (!isset($_SESSION['login']))
	Header("Location: iniciar_sesion.php");
else {
	if (isset($_SESSION["carrito"])) {
		$carrito = $_SESSION["carrito"];
		unset($_SESSION["carrito"]);
	}
?>
<!DOCTYPE html>
<html lang = "es">
<head>
    <title>Casa Marquez - Soelse</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="carrito.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>
    function eliminarProducto(id){
        producto = document.getElementById(id);	
        if (!producto){
            alert("El elemento selecionado no existe");
        } else {
            padre = producto.parentNode;
            padre.removeChild(producto);
        }
    }
    </script>
</head>
<body>
    <header class="cabecera">
        <img src="imagenes/soelse_letras_derecha.png" alt="Logo de Soelse" id="soelse_letras_derecha">
    </header>

    <div id="caja_productos">
        <div class="div_productos">
            <div id="datos_productos">
                <input id="OID_CARRITO" name="OID_CARRITO" type="hidden" value="">
            </div>
            <div id="p1">1<button class="boton_eliminar" onclick="eliminarProducto('p1');"></div>
            <div id="p2">2<button class="boton_eliminar" onclick="eliminarProducto('p2');"></div>
            <div id="p3">3<button class="boton_eliminar" onclick="eliminarProducto('p3');"></div>
            <div id="p4">4<button class="boton_eliminar" onclick="eliminarProducto('p4');"></div>
            <div id="p5">5<button class="boton_eliminar" onclick="eliminarProducto('p5');"></div>
            <div id="p6">6<button class="boton_eliminar" onclick="eliminarProducto('p6');"></div>
            <div id="p7">7<button class="boton_eliminar" onclick="eliminarProducto('p7');"></div>
            <div id="p8">8<button class="boton_eliminar" onclick="eliminarProducto('p8');"></div>
            <div id="p9">9<button class="boton_eliminar" onclick="eliminarProducto('p9');"></div>
            <div id="p10">10<button class="boton_eliminar" onclick="eliminarProducto('p10');"></div>
        </div>
    </div>


    <div id=padre>
        <div id="detalles">
            <div style="overflow: auto; height: 85%; padding: 1%; padding-top: 0;">
                <p>Pedido 1</p>
                <p>Pedido 2</p>
                <p>Pedido 3</p>
                <p>Pedido 4</p>
                <p>Pedido 5</p>
                <p>Pedido 6</p>
                <p>Pedido 7</p>
                <p>Pedido 8</p>
                <p>Pedido 9</p>
                <p>Pedido 10</p>
            </div>
            <hr size="1px" color="black" style="width: 94%;"/>
            <div style="display: flex;">
                <div id="Total" style="text-align: left;padding: 1%; padding-top: 0;">
                    Total
                </div>
                <div id="Suma" style="position: absolute;right: 0; padding: 1%; padding-top: 0;">
                    1+2+3+4+5+6+7+8+9+10 = 55
                </div>
            </div>
        </div>
        <button href="" id="boton_finalizar">Finalizar Pedido</button>
        <div id="imagenes_compra">
            <div class="d1">
                <img id="imagen_indiv_1" src="imagenes/icono-transporte-2-800x800.png">
                <div>Envio gratis</div>
            </div>
            <div class="d2">
                <img id="imagen_indiv_2" src="imagenes/folder.png">
                <div>Devoluciones</div>
            </div>
            <div class="d3">
                <img id="imagen_indiv_3" src="imagenes/antencion_al_cliente.png">
                <div>Atención<br>al<br>Cliente</div>
            </div>
        </div>
    </div>


    <footer>
        <p id="formas_de_pago">Formas de pago:</p>
        <hr size="1px" color="black" />
        <div id="foot">
        <img src="imagenes/VISA-logo.png" alt="Logo de VISA" style="width: 15%; align-self: center;"/>
        <img src="imagenes/1200px-MasterCard_Logo.svg.png" alt="Logo de MasterCard" style="width: 15%; align-self: center;"/>
        <img src="imagenes/paypal-logo-3.png" alt="Logo de PayPal" style="width: 25%; margin-bottom: 1%;"/>
        </div>
        <p id="dir">POL. INDUSTRIAL CR.AMARILLA (PICA)) 3 – 41007 en Sevilla. ESPAÑA</p>
        <hr size="1px" color="black"/>
    </footer>
<br>
</body>
</html>