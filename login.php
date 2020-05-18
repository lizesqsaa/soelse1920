

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

 <link rel="stylesheet" type="text/css" href="css/cabecera.css"/>
 <link rel="stylesheet" type="text/css" href="css/menu.css"/>
 <link rel="stylesheet" type="text/css" href="css/pie.css"/>

</head>

<body>
<?php
	include_once("cabecera.php");
	include_once("menu.php");
?>


<main>

	<!-- The HTML login form -->
	<form action="login.php" method="post">
		<div><label for="email">Email: </label><input type="text" name="email" id="email" /></div>
		<div><label for="pass">Contraseña: </label><input type="password" name="pass" id="pass" /></div>
		<input type="submit" name="submit" value="aceptar" />
	</form>
		
	<p>¿Todavia no te has registrado? <a href="form_alta_usuario.php">¡Registrate!</a></p>
</main>
<?php
	include_once("pie.php");
?>

</body>
</html>

