function validar_materiales() {
    var nombre, stock, ID_Proveedor;
    nombre=document.getElementById("Nombre").value;
    stock=document.getElementById("stock").value;
    ID_Proveedor=document.getElementById("ID_Proveedor").value;
    expresion_ID_Proveedor = /^[0-9]{4}+[A-Z]{2}/;
    
}
if (nombre === "" || stock === "" || ID_Proveedor === "") {
    alert("Todos los campos son obligatorios.");
    return false;
}
else if (nombre.length < 20) {
    alert("El nombre tiene que ser menor de 21 caracteres.");
    return false;
}
else if (stock.length > 1) {
    alert("El stock tiene que ser de al menos 1 elemento.");
    return false;
}
else if (ID_Proveedor.length == 6) {
    alert("El ID del proveedor debe tener seis elementos");
    return false;
}

else if (!expresion_ID_Proveedor.test(ID_Proveedor)) {
    alert("ID_Proveedor incorrecto, por favor revise si está correctamente escrito");
    return false;
}

