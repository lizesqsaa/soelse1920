function validar_formulario_prov(){
    var nombre, telefono, correo, empresa;
    nombre = document.getElementById("Nombre").value;
    telefono = document.getElementById("Telefono").value;
    correo = document.getElementById("Correo");
    empresa = document.getElementById("Empresa afiliada");
    expresion_correo = /\w+@\w+\.+[a-z]/;

    if(nombre ==="" || telefono ==="" || correo==="" || empresa===""){
        alert("El campo está vacío");
        return false;
    }

    else if (nombre.length > 20) {
        alert("El nombre tiene que ser menor de 21 caracteres.");
        return false;
    }

    else if (correo.length > 35) {
        alert("El correo electronico tiene que ser menor de 51 caracteres.");
        return false;
    }

    else if (!expresion_correo.test(correo)) {
    alert("Correo electronico no valido, por favor introduzca uno que si lo sea.");
    return false;
    }

    else if (telefono.length > 9) {
        alert("El telefono tiene que ser menor de 10 numeros.");
        return false;
    }

    else if (isNaN(telefono)) {
        alert("Telefono no valido, por favor introduzca uno que si lo sea.");
        return false;
    }

    else if (empresa.length > 20) {
        alert("El nombre de la empresa tiene que ser menor de 20 caracteres.");
        return false;
    }

}