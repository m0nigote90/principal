/* 
 Pedro, 11/10/2021
 */
$(document).ready(inicio);
function inicio() {
    //Manejo de filtrado de PLANTAS con animación
    $("#btnPlaTodas").click(function () {
        $('#portafolio div').each(function () {
            if ($(this).hasClass("d-none")) {
                $(this).removeClass("d-none");
                $(this).toggle(1500, function () {
                    $(this).addClass("d-block");
                });
            } 
        });
    });
    
    $("#btnPlaSucu").click(function () {
        $('#portafolio div').each(function () {
            if ($(this).hasClass("tropical")) {
                if ($(this).hasClass("d-block")) {
                    $(this).removeClass("d-block");
                    $(this).toggle(1500, function () {//Cuando completa le añadimos la clase d-none
                        $(this).addClass("d-none");
                    });
                }

            } else if ($(this).hasClass("d-none")) {
                $(this).removeClass("d-none");
                $(this).toggle(1500, function () {
                    $(this).addClass("d-block");
                });

            }

        });
    });
    $("#btnPlaTropi").click(function () {
        $('#portafolio div').each(function () {
            if ($(this).hasClass("suculenta")) {
                if ($(this).hasClass("d-block")) {
                    $(this).removeClass("d-block");
                    $(this).toggle(1500, function () {
                        $(this).addClass("d-none");
                    });
                }

            } else if ($(this).hasClass("d-none")) {
                $(this).removeClass("d-none");
                $(this).toggle(1500, function () {
                    $(this).addClass("d-block");
                });
            }

        });
    });
    //Manejo de filtrado de ABONOS
    $("#btnAboTodos").click(function () {
        $('#portafolio div').each(function () {
            if ($(this).hasClass("d-none")) {
                $(this).removeClass("d-none");
                $(this).toggle(1500, function () {
                    $(this).addClass("d-block");
                });
            } 
        });
    });
    
    $("#btnAboNatu").click(function () {
        $('#portafolio div').each(function () {
            if ($(this).hasClass("quimico")) {
                if ($(this).hasClass("d-block")) {
                    $(this).removeClass("d-block");
                    $(this).toggle(1500, function () {//Cuando completa le añadimos la clase d-none
                        $(this).addClass("d-none");
                    });
                }

            } else if ($(this).hasClass("d-none")) {
                $(this).removeClass("d-none");
                $(this).toggle(1500, function () {
                    $(this).addClass("d-block");
                });

            }

        });
    });
    $("#btnAboQuimi").click(function () {
        $('#portafolio div').each(function () {
            if ($(this).hasClass("natural")) {
                if ($(this).hasClass("d-block")) {
                    $(this).removeClass("d-block");
                    $(this).toggle(1500, function () {
                        $(this).addClass("d-none");
                    });
                }

            } else if ($(this).hasClass("d-none")) {
                $(this).removeClass("d-none");
                $(this).toggle(1500, function () {
                    $(this).addClass("d-block");
                });
            }

        });
    });
    
    
    
    //Petición Ajax de login
    $("#btnLogin").click(function () {
        $.ajax({
            url: "LoginAjax",
            dataType: "json",
            type: "post",
            data: {
                "email": $("#inputEmail").val(),
                "password": $("#inputPassword").val()

            },
            success: function (data) {

                var flag = data.flag;
                if (flag == "true") {
                    $("#errorLogin").prop('style', "color: green; font-weight: 600;");
                    añadirContenido("#errorLogin", "Correcto. Te has logueado con éxito.")
                    setTimeout(recargaPagina, 1500);
                } else {
                    $("#errorLogin").prop('style', "color: red; font-weight: 600;");
                    añadirContenido("#errorLogin", "Error. Usuario o contraseña erróneos.");
                }
            }
        });
    });
    //Petición Ajax mostrar catálogo
    $("#btnTodos").click(function () {
        $.ajax({
            url: "CargarPortafolio",
            dataType: "json",
            type: "post",
            data: {
                "numFiltro": "0",
            },
            success: function (data) {

                var flag = data.flag;
                if (flag == "true") {
                    console.log("Todo ha ido bien Servlet CargarPortafolio");
                    alert("Ha funcionado la request a filtro");
                    recargaPagina();
                } else {
                    console.log("ERROR Servlet CargarPortafolio");
                    alert("ERROR request a filtro");
                }
            }
        });
        recargaPagina();
    });
    $("#btnPlantas").click(function () {
        $.ajax({
            url: "CargarPortafolio",
            dataType: "json",
            type: "post",
            data: {
                "numFiltro": "1",
            },
            success: function (data) {

                var flag = data.flag;
                if (flag == "true") {
                    console.log("Todo ha ido bien Servlet CargarPortafolio");
                    alert("Ha funcionado la request a filtro");
                    recargaPagina();
                } else {
                    console.log("ERROR Servlet CargarPortafolio");
                    alert("ERROR request a filtro");
                }
            }
        });
        recargaPagina();
    });

    $("#btnAbonos").click(function () {
        $.ajax({
            url: "CargarPortafolio",
            dataType: "json",
            type: "post",
            data: {
                "numFiltro": "2",
            },
            success: function (data) {

                var flag = data.flag;
                if (flag == "true") {
                    console.log("Todo ha ido bien Servlet CargarPortafolio");
                    alert("Ha funcionado la request a filtro");
                    recargaPagina();
                } else {
                    console.log("ERROR Servlet CargarPortafolio");
                    alert("ERROR request a filtro");
                }
            }
        });
        recargaPagina();
    });
    //Botones filtrar ARTICULOS por categoria
//    $("#btnTodos").click(cargarPortafolio("0"));
//    $("#btnPlantas").click(cargarPortafolio("1"));
//    $("#btnAbonos").click(cargarPortafolio("2"));
    //Botones filtrar PLANTAS por tipo
    //$("#btnPlaTodas").click(cargarPortafolio("10"));
    //$("#btnPlaSucu").click(cargarPortafolio("11"));
    //$("#btnPlaTropi").click(cargarPortafolio("12"));
    //Botones filtrar ABONOS por tipo
    function añadirContenido(elemento, mensaje) {
        limpiaMensaje(elemento);
        $(elemento).append(mensaje);
    }
    function recargaPagina() {
        location.reload();
    }
    function limpiaMensaje(elemento) {
        $(elemento).empty();
    }
    //ánadir elementos .prop(elemento, propiedad);
    // Select and loop the container element of the elements you want to equalise
    $(".btnComprar").click(function () {
        var ref = $(this).attr('id');
        alert(ref);
        $.ajax({
            url: "AddArticulo",
            dataType: "json",
            type: "post",
            data: {
                "refArticulo": ref,
            },
            success: function (data) {

                var flag = data.flag;
                if (flag == "true") {
                    console.log("Todo ha ido bien Servlet AddArticulo");
                    alert("Ha funcionado la request a add articulo");
                    //recargaPagina();
                } else {
                    console.log("ERROR Servlet AddArticulo");
                    alert("ERROR add articulo");
                }
            }
        });
        //recargaPagina();
    });
    
}
//function añadirArticulo(id){
        //alert(id);
   // }

