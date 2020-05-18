function validar_formulario() {
    var nombre, apellido, correo, telefono, banco, direccion, contraseña, rep_Contraseña;
    nombre = document.getElementById("Nombre").value;
    apellido = document.getElementById("Apellido").value;
    correo = document.getElementById("Correo").value;
    telefono = document.getElementById("Telefono").value;
    banco = document.getElementById("Banco").value;
    direccion = document.getElementById("Direccion").value;
    contraseña = document.getElementById("Contraseña").value;
    rep_Contraseña = document.getElementById("rep_Contraseña").value;
    expresion_correo = /\w+@\w+\.+[a-z]/;
    expresion_banco = /[A-Z]+[A-Z]+\d{22}/;
    if (nombre === "" || apellido === "" || correo === "" || telefono === "" || banco === "" || direccion === "" || contraseña === "" || rep_Contraseña === "") {
        alert("Todos los campos son obligatorios.");
        return false;
    }
    else if (nombre.length > 20) {
        alert("El nombre tiene que ser menor de 21 caracteres.");
        return false;
    }
    else if (apellido.length > 50) {
        alert("El apellido tiene que ser menor de 51 caracteres.");
        return false;
    }
    else if (correo.length > 50) {
        alert("El correo electronico tiene que ser menor de 51 caracteres.");
        return false;
    }
    else if (!expresion_correo.test(correo)) {
        alert("Correo electronico no valido,por favor introduzca uno que si lo sea.");
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
    else if (!expresion_banco.test(banco)) {
        alert("Cuenta bancaria no valida,por favor introduzca una que si lo sea.");
        return false;
    }
    else if (Banco.length > 24) {
        alert("La numero de cuenta bancaria tiene que ser menor de 25.");
        return false;
    }
    else if (direccion.length > 140) {
        alert("La direccion tiene que ser menor de 141 caracteres.");
        return false;
    }
    else if (contraseña.length > 50) {
        alert("La contraseña tiene que ser menor de 51 caracteres.");
        return false;
    }
    else if (rep_Contraseña.length > 50) {
        alert("La contraseña tiene que ser menor de 51 caracteres.");
        return false;
    }
    else if (!(contraseña === rep_Contraseña)) {
        alert("La contraseña tiene que ser la misma.");
        return false;
    }
}