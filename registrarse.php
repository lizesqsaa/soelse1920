<!DOCTYPE html>
<html lang = "es">
<head>
    <title>Casa Marquez - Soelse</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="registrarse.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <noscript>Sorry, your browser does not support JavaScript!</noscript>
</head>
<body>
    <header class="cabecera">
    <div class="cab">
        <div>
            <a href =soelse.html title="logo"><img src="imagenes/soelse_letras_derecha.png" alt="Logo de Soelse" id="soelse_letras_derecha"></a>
        </div>
    </div>
    <div class="volver">
        <button onclick="location.href='soelse.html'" id="boton_volver">Volver a la tienda</button>
    </div>
    </header>
    <br>
    <form id="formulario" method="GET" action="registrarse.php" onsubmit="return validar_formulario();" style="margin-left: 5%;">
        <div><label for="Nombre">Nombre:</label>
            <input name="Nombre" id="Nombre" type="text" placeholder="Intoduzca el nombre" style="width: 25%; margin-left: 5%;"/> <!-- el Plceholder dependiendo del enfoque que queramos darle.-->
        </div><br>

        <div><label for="Apellido">Apellido:</label>
            <input name="Apellido" id="Apellido" type="text" maxlength="50"  placeholder="Intoduzca el apellido" style="width: 25%;margin-left: 4.8%;"/>
        </div><br>

        <div><label for="Correo">Correo:</label>
            <input name="Correo" id="Correo" type="email" maxlength="50"  placeholder="Introduzca el correo" style="width: 25%;margin-left: 5.5%;"/>
        </div><br>

        <div><label for="Telefono">Teléfono:</label>
            <input name="Telefono" id="Telefono" type="tel" size="9" pattern="[0-9]{9}"  placeholder="Introduzca el telefono" style="width: 25%; margin-left: 4.8%;"/>
        </div><br>

        <div><label for="Banco">Cuenta bancaria:</label>
            <input name="Banco" id="Banco" type="text" size="24" pattern="^[A-Z]{2}[0-9]{22}"  placeholder="Introduzca la cuenta bancaria" style="width: 25%;margin-left: 2%;"/>
        </div><br>

        <div><label for="Direccion">Direccion:</label>
            <input name="Direccion" id="Direccion" type="text" size="140"  placeholder="Introduzca la direccion" style="width: 25%;margin-left: 4.5%;"/>
        </div><br>

        <div><label for="Contraseña">Contraseña:</label>
            <input name="Contraseña" id="Contraseña" type="password" maxlength="50"  placeholder="Introduzca la contraseña" style="width: 25%;margin-left: 4%;"/>
        </div><br>

        <div><label for="rep_Contraseña">Repetir contraseña:</label>
            <input name="rep_Contraseña" id="rep_Contraseña" type="password" maxlength="50"  placeholder="Repita la contraseña" style="width: 25%;margin-left: 1.1%;"/>
        </div><br>
        
        <div id="botones">
        <input type="reset" name="reset_formulario" value="Cancelar" style="margin-left: 10%;">
        <input type="submit" name="submit_formulario" value="Registrarme" style="margin-left: 5%;">
        </div>
   </form>
<br>
<br>
<br>

</body>
</html>