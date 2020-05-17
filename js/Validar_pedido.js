function validar_pedido(){
    var ID_Cliente,Fecha_Limite,Tipo_Penalizacion,Descuento,Beneficio_Neto,Posicion_Cola;
    ID_Cliente=document.getDocumentByID("ID_Cliente").value;
    Fecha_Limite=document.getDocumentByID("Fecha_Limite").value;
    Tipo_Penalizacion=document.getDocumentByID("Tipo_Penalizacion").value;
    Descuento=document.getDocumentByID("Descuento").value;
    Beneficio_Neto=document.getDocumentByID("Beneficio_Neto").value;
    Posicion_Cola=document.getDocumentByID("Posicion_Cola").value;
}
if (ID_Cliente === "" || Fecha_Limite === "" || Tipo_Penalizacion === "" || Descuento === "" || Beneficio_Neto === "" || Posicion_Cola === "") {
    alert("Todos los campos son obligatorios.");
    return false;
}
else if (ID_Cliente.lenght>6){
    alert("El ID introducido es incorrecto");
}
else if(Tipo_Penalizacion.lenght>11){
    alert("El Tipo_Penalizacion es demasiado largo");
}
else if(Posicion_Cola.lenght<1){
    alert("La posicion en la cola debe ser al menos 1");
}
