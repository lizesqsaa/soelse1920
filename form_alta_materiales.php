

<!DOCTYPE html>
<html lang = "es">
    <head>
        <title>Casa Marquez-Soelse</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="pedido.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
   
            <div class="volver">
                <button onclick="location.href='../../vista/home.php'" id="boton_volver">Volver </button>
            </div>
        </header>
        <br>
        <fieldset>
            <legend align="left">
                Registre su material 
            </legend>

        <form id="formulario" method="GET" style="margin-left: 5%;"></form>
        
        <div><label for="nombre">Nombre del material:</label>
            <input name="nombre" id="nombre" type="text" maxlength="20" required placeholder="Introduzca el nombre del material " style="width: 25%; margin-left: 5%;"/>
        </div><br>
        <div><label for="precio">Precio:</label>
            <input name="nombre" id="nombre" type="text" maxlength="20" required placeholder="Introduzca el precio" style="width: 25%; margin-left: 5%;"/>
        </div><br>
        <div><label for="stock">Stock:</label>
            <input name="stock" id="stock" type="number" minlength="1" required placeholder="Intoduzca la cantidad de este material actualmente " style="width: 25%; margin-left: 5%;"/>
        </div><br>
        <div><label for="seleccionar">Provedor al que pertenece:</label>
            <select name="seleccionar" id="Seleccionar" size="1" title="select">

                <option selected>Proveedor1</option>
                <option value="value">Proveedor2</option>
                <option value="value">Proveedor3</option>
                <option value="value">Proveedor4</option>
                <option>Proveedor5</option>

            </select>
        </div><br>
        </fieldset>
            <div id="botones">
                <button type="reset" name="reset_formulario" value="Reset" style="margin-left: 1%;">
                    Cancelar
                </button>
                <button type="submit" name="submit_formulario" value="Enviar" style="margin-left: 0.25%;">
                    Enviar
                </button>
            </div>
        </form>
 <?php
    
 include_once("pie.php");

?>

        
    </body>
</html>    