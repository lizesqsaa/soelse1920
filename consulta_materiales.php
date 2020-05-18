<?php
session_start();

require_once ("gestionBD.php");
require_once ("gestionarMateriales.php");


if (!isset($_SESSION['login']))
    Header("Location: login.php");
    
    else {
        if (isset($_SESSION["materiales"])) {
            $productos = $_SESSION["materiales"];
            unset($_SESSION["materiales"]);
        }
