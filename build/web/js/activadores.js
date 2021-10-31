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
                    $("#cuentaAtrasLogin").prop('style', "color: green; font-weight: 600;");
                    añadirContenido("#errorLogin", "Correcto. Te has logueado con éxito.");
                    añadirContenido("#cuentaAtrasLogin", "Cerrando en 2");
                    setTimeout(añadirCuentaAtras, 1000);
                    setTimeout(recargaPagina, 2000);
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

                var flag1 = data.flag1;
                if (flag1 == "true") {
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

                var flag2 = data.flag2;
                if (flag2 == "true") {
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

                var flag3 = data.flag3;
                if (flag3 == "true") {
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
    function añadirCuentaAtras() {
        limpiaMensaje("#cuentaAtrasLogin");
        $("#cuentaAtrasLogin").append("Cerrando en 1");
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
        //var numArticulosCesta = $("#numArtCesta").attr("data-numArt");
        //alert(numArticulosCesta);
        $.ajax({
            url: "AddArticulo",
            dataType: "json",
            type: "post",
            data: {
                "refArticulo": ref,
            },
            success: function (data) {

                var flag = data.flag;
                var numArtCesta = data.numArtCesta;
                if (flag == "true") {

                    //alert("Actualizado ya: "+numArtCesta);
                    //añadirContenido("#numArtCesta", numArtCesta);
                    recargaPagina();
                } else {
                    console.log("ERROR Servlet AddArticulo");
                    alert("ERROR add articulo");
                }
            }
        });
    });

    //Eliminar articulo de la cesta y devolver a la tienda btnEliminarArtCesta
    $(".btnEliArtCesta").click(function () {
        //alert("Boton eliminar ARt");
        var ref = $(this).attr('data');
        //var numArticulosCesta = $("#numArtCesta").attr("data-numArt");
        $.ajax({
            url: "RemoveArticuloCesta",
            dataType: "json",
            type: "post",
            data: {
                "refArticulo": ref,
            },
            success: function (data) {

                var flag = data.flag;

                if (flag == "true") {
                    alert("ELIMINADO DE CESTA" + ref)
                    //alert("Actualizado ya: "+numArtCesta);
                    //añadirContenido("#numArtCesta", numArtCesta);
                    recargaPagina();
                } else {
                    console.log("ERROR Servlet REMOVEArticulo");
                    alert("ERROR REMOVE articulo");
                }
            }
        });
    });

    //Método que agrega unidades del mismo tipo. Recogemos id y numUnidades a agregar del campo input.
    $(".btnAddUnidades").click(function () {

        var ref = $(this).attr('data');
        var idnumber = "#inputNumber" + ref;
        var num = $(idnumber).val();
        if (num > 0) {
            $.ajax({
                url: "AddUnidades",
                dataType: "json",
                type: "post",
                data: {
                    "refArt": ref,
                    "numUnidades": num,
                },
                success: function (data) {
                    var flag = data.flag;
                    var nombre = data.nombre;
                    if (flag == "true") {
                        if (num == 1) {
                            alert("Agregado 1 unidad de "+nombre);
                        } else {
                            alert("Agregado " + num + " unidades de "+nombre);
                        }

                        //alert(num+" unidades añadidas.");
                        //alert("Actualizado ya: "+numArtCesta);
                        //añadirContenido("#numArtCesta", numArtCesta);
                        recargaPagina();
                    } else {
                        alert("ERROR add articulo");
                    }
                }
            });
        } else {
            alert("ERROR. Debe agregar de 1 a 99 unidades.");
            $(idnumber).val(1);
        }
    });

    
}

//function añadirArticulo(id){
//alert(id);
// }

