function validar_producto(){
    var nombre,categoria,precio,descripcion,foto,tiempo;
    nombre=document.getElementById("Nombre").value;
    categoria=document.getElementById("Categoria").value;
    precio=document.getElementById("Precio").value;
    descripcion=document.getElementById("Descripcion").value;
    foto=document.getElementById("Foto").value;
    tiempo=document.getElementById("Dias").value;
    if (nombre === "" || categoria === "" || precio === "" || descripcion === "" || foto === "" || tiempo === "" ) {
        alert("Todos los campos son obligatorios.");
        return false;
    }
    else if (nombre.length < 100) {
        alert("El nombre tiene que ser menor de 101 caracteres.");
        return false;
    }
    else if (categora.length < 25) {
        alert("La categoria debe ser menor de 26 caracteres.");
        return false;
    }
    else if (precio.length >1) {
        alert("El precio debe ser de al menos 1 euro.");
        return false;
    }
    else if (descripcion.length <500) {
        alert("La descripcion debe tener como maximo 500 caracteres");
        return false;
    }
    else if (foto.length <255) {
        alert("La url de la imagen debe tener como maximo 255 caracteres");
        return false;
    }
    else if (tiempo.length >1) {
        alert("El tiempo estimado debe ser de al menos 1 día.");
        return false;
    }
}