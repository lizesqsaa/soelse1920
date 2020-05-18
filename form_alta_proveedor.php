<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css"  href="css/estilo.css" />
  <!--La línea anterior sirve para importar css. -->
  <title>Gestión de proveedores: Proveedores</title>
</head>

<body>
	<?php
		include_once("cabecera.php"); //Todavía no lo tengo
	?>


    <?php 
    // Mostrar los erroes de validación (Si los hay)
    if (isset($errores) && count($errores)>0) { 
        echo "<div id=\"div_errores\" class=\"error\">";
        echo "<h4> Errores en el formulario:</h4>";
        foreach($errores as $error) echo $error; 
         echo "</div>";
  }
    ?>
    
    <div class="container">
        <fieldset>
            <legend>
                Datos proveedores
            </legend>
    
            <div><label for="Nombre">Nombre:</label>
                <input name="Nombre" id="Nombre" type="text" placeholder="Intoduzca el nombre" style="width: 25%; margin-left: 5%;"/> 
            </div><br>
    
            <div><label for="Telefono">Teléfono:</label>
                <input name="Telefono" id="Telefono" type="tel" size="9" pattern="[0-9]{9}"  placeholder="Introduzca el telefono" style="width: 25%; margin-left: 4.8%;"/>
            </div><br>
    
            <div><label for="Correo">Correo:</label>
                <input name="Correo" id="Correo" type="email" maxlength="35"  placeholder="Introduzca el correo" style="width: 25%;margin-left: 5.5%;"/>
            </div><br>
    
            <div><label for="Empresa afiliada">Empresa afiliada:</label>
                <input name="Empresa afiliada" id="Empresa afiliada" type="text" placeholder="Intoduzca la empresa" style="width: 25%; margin-left: 5%;"/> 
            </div><br>
        </fieldset>
    
        <br>
    

    </div>
    
    <div class="botones">
        <input name="submit" type="submit" value="Continuar">
        </div>
   </form>

   <?php
		include_once("pie.php"); //Todavía no lo tengo 
	?>

    </body>
</html>
