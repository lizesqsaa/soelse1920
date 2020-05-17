<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset='UTF-8'>
    <title>menu con tablas</title>
<style>
    body{background-color: #4642B8;padding: 150px;font-family: Arial;}
#menu{
    background-color: #000;
}

#menu ul{
    list-style: none;
    margin: 0;
    padding: 0;
}

#menu #item{
    float: left;
}

#menu #item a{
    background: rgba(0, 51, 102, 1);
    color: rgba(255, 255, 255, 1);
    padding: 12px 22px;
    display: block;
    font-family: Arial;
    font-size: 16px;
    text-decoration: none;
}

#menu #submenu{
    display: none;
    position: absolute;
    min-width: 220px;
}
#menu #item a:hover{
    background: rgba(0, 102, 204, 1);
    color: rgba(0, 204, 255, 1);
}

#menu #item:hover #submenu{
    display: block;
}


</style>
</head>
<body>
    <div id="menu">
        <ul>
            <li id="item"><a href="#">Home</a></li>
            <li id="item"><a href="#">Clientes</a></li>
            <li id="item"><a href="#">Productos</a>
                <ul id="submenu">
                    <li><a href="#">Envolvente</a></li>
                    <li><a href="#">Puntuaciones Magnéticas y automáticas</a></li>
                    <li><a href="#">Arrancador y Variadores de Velocidad</a></li>
                    <li><a href="#">Contadores</a></li>
                    <li><a href="#">Tipo e</a></li>
                    <li><a href="#">Tipo f</a></li>
                
                </ul>
            </li>
            <li id="item"><a href="#">Empleados</a></li>
            <li id="item"><a href="#">Proveedores</a></li>
            <li id="item"><a href="#">Pedido Materiales</a></li>
        </ul>
    </div>
</body>
</html>