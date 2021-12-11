var oldReady = jQuery.ready;
jQuery.ready = function(){
  try{
      //funcion para filtrar Usuarios
    $("#filtroNombre").keyup(function () {
        var filtroNombre = $(this).val();
        var filtroDNI = $('#filtroDNI').val();

        $.ajax({
            method: "POST",
            url: "filtradoUsuarios.jsp",
            data: {
                filtroNombre: filtroNombre, 
                filtroDNI: filtroDNI
            }
        })
                .done(function (listado) {
                    $("#listadoUsuarios").html(listado);
                });
    });
    $("#filtroDNI").keyup(function () {
        var filtroNombre = $('#filtroNombre').val();
        var filtroDNI = $(this).val();

        $.ajax({
            method: "POST",
            url: "filtradoUsuarios.jsp",
            data: {
                filtroNombre: filtroNombre,
                filtroDNI: filtroDNI
            }
        })
                .done(function (listado) {
                    $("#listadoUsuarios").html(listado);
                });
    });
    //Dar de baja a usuarios
    $(".btnBajaUsu").click(function (){
        var idUsuario = $(this).attr('data');
        var resultado = window.confirm('\u00bfEst\u00e1 seguro que desea dar de baja dicho usuario?');
        
        if(resultado === true){
        $.ajax({
            url: "BajaUsuario",
            dataType: "json",
            type: "post",
            data: {
                "idUsuario": idUsuario
            },
            success: function (data) {
                var flag = data.flag;
                var nombreU = data.nombreUsuario;
                //todas los datos del artículo
                if (flag === "true") {
                    //redirect
                    alert("Se ha dado de baja al usuario:\n"+nombreU);
                    location.reload();
                } else {
                    alert("Algo ha salido mal al intentar dar de baja al usuario.");
                }
            }
        });}
        
        
        
    });
    return oldReady.apply(this, arguments);
  }catch(e){
    // handle e ....
  }
};



