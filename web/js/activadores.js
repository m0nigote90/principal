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
                            alert("Agregado 1 unidad de " + nombre);
                        } else {
                            alert("Agregado " + num + " unidades de " + nombre);
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

    $("#btnComprarCesta").click(function () {
        alert("Boton pedido");
        //var ref = $(this).attr('data');
        //var numArticulosCesta = $("#numArtCesta").attr("data-numArt");
        $.ajax({
            url: "CrearPedido",
            dataType: "json",
            type: "post",
            data: {
                //"refArticulo": ref,
            },
            success: function (data) {

                var flag = data.flag;

                if (flag == "true") {
                    alert("Pedido hecho");

                    recargaPagina();
                } else {
                    console.log("ERROR Servlet CrearPedido");
                    alert("ERROR Crear Pedido");
                }
            }
        });
    });

    //activadores del select de agregar articulo nuevo
    $('#selectAgregar').on('change', function () {
        var valor = $(this).val();
        if (valor == '0') {
            $('#btnAgregarArt').prop('disabled', true);
            $('#btnAgregarArt').removeClass('btn-outline-success');
            $('#btnAgregarArt').addClass('btn-outline-secondary');
        } else {
            $('#btnAgregarArt').prop('disabled', false);
            $('#btnAgregarArt').removeClass('btn-outline-secondary');
            $('#btnAgregarArt').addClass('btn-outline-success');
        }
    });


    $('#btnAgregarArt').click(function () {
        var opc = $('#selectAgregar').val();
        switch (opc) {
            case '1':
                window.location.assign("agregarPlanta.jsp");
                break;
            case '2':
                window.location.assign("agregarAbono.jsp");
                break;
            case '3':
                alert("Macetas aún no disponibles.\nPróximamente");
                break;
        }

    });

    //Al pulsar el boton editar de la página de gestión
    $('.btnEditArt').click(function () {
        var ref = $(this).attr('data');
        alert(ref);
        //Limpiamos todos los invalid anteriores
        $(":input").each(function () {
            $(this).removeClass('is-invalid');
            $(this).removeClass('is-valid');
        });
        $.ajax({
            url: "EditArticulo",
            dataType: "json",
            type: "post",
            data: {
                "ref": ref,
                "opc": "modal"
            },
            success: function (data) {

                var flag = data.flag;
                var categoria = data.categoria;
                var fab = data.fab;
                var nombre = data.nombre;
                var tipo = data.tipo;
                var des = data.des;
                var iva = data.iva;
                var precioSin = data.precioSin;
                var pvp = data.pvp;
                var vol = data.volumen;
                //todas los datos del artículo
                if (flag == "true") {
                    if (categoria == 'planta') {
                        $('#modEditVol').hide();
                    } else {
                        $('#modEditVol').show();
                    }
                    //alert(categoria);
                    $('#modEditTit').text("Editar " + capitalize(categoria));
                    $('#modEditCat').val(categoria);
                    $('#modEditRef').val(ref);
                    $('#modEditNombre').val(nombre);
                    $('#modEditTipo').val(tipo);
                    $('#modEditTipoA').val(tipo);
                    $('#modEditFab').val(fab);
                    $('#modEditDes').val(des);
                    $("#modEditIVA option[value=" + iva + "]").attr("selected", true);
                    $('#modEditPrecioSinIVA').val(precioSin);
                    $('#modEditPVP').val(pvp);
                    $('#modEditVol').val(vol);
                    $('#modEditImg').attr("src", "../img/articulos/" + ref + ".jpg");
                    $('#modalEditarArticulo').modal('show'); // abrir

                    //$('#modalEditarArticulo').modal('hide');


                    //recargaPagina();
                } else {

                }
            }
        });
    });
    //Función para el boton confirmar la edición del artículo
    $('#btnEditarArt').click(function () {
        var numVal = 0;
        var ref = $('#modEditRef').val();
        var categoria = $('#modEditCat').val();
        var nombre = $('#modEditNombre').val();
        var tipo = $('#modEditTipo').val();
        var fab = $('#modEditFab').val();
        var des = $('#modEditDes').val();
        var iva = $('#modEditIVA').val();
        var precioSin = $('#modEditPrecioSinIVA').val();
        var vol = $('#modEditVol').val();

        alert(ref + " " + categoria + " " + nombre + " " + tipo + " " + fab + " " + des + " " + iva + " " + precioSin + " " + vol);
        //hacemos comprobaciones
        if (ref != '') {
            $('#modEditRef').removeClass('is-invalid');
            $('#modEditRef').addClass('is-valid');
            numVal += 1;
        } else {
            $('#modEditRef').removeClass('is-valid');
            $('#modEditRef').addClass('is-invalid');
        }
        if (nombre != '') {
            $('#modEditNombre').removeClass('is-invalid');
            $('#modEditNombre').addClass('is-valid');
            numVal += 1;
        } else {
            $('#modEditNombre').removeClass('is-valid');
            $('#modEditNombre').addClass('is-invalid');
        }

        $('#modEditFab').addClass('is-valid');
        $('#modEditDes').addClass('is-valid');
        $('#modEditVol').addClass('is-valid');
        if (tipo != '') {
            $('#modEditTipo').removeClass('is-invalid');
            $('#modEditTipo').addClass('is-valid');
            numVal += 1;
        } else {
            $('#modEditTipo').removeClass('is-valid');
            $('#modEditTipo').addClass('is-invalid');
        }
        //Validacion tipo IVA
        if (iva != '0') {
            $('#modEditIVA').removeClass('is-invalid');
            $('#modEditIVA').addClass('is-valid');
            numVal += 1;
        } else {
            $('#modEditIVA').removeClass('is-valid');
            $('#modEditIVA').addClass('is-invalid');
        }
        if (precioSin != 0) {
            $('#modEditPrecioSinIVA').removeClass('is-invalid');
            $('#modEditPrecioSinIVA').addClass('is-valid');
            numVal += 1;
        } else {
            $('#modEditPrecioSinIVA').removeClass('is-valid');
            $('#modEditPrecioSinIVA').addClass('is-invalid');
        }

        if (numVal == 5) {
            alert("Hacemos llamada de edit");
            $.ajax({
            url: "EditArticulo",
            dataType: "json",
            type: "post",
            data: {
                "opc": "edit",
                "categoria": categoria,
                "ref": ref,
                "nombre": nombre,
                "tipo": tipo,
                "fab": fab,
                "des": des,
                "iva": iva,
                "precioSin": precioSin,
                "vol": vol      
            },
            success: function (data) {
                var flag = data.flag;
                var cat = data.categoria;
                var n = data.n;
//                var categoria = data.categoria;
//                var fab = data.fab;
//                var nombre = data.nombre;
//                var tipo = data.tipo;
//                var des = data.des;
//                var iva = data.iva;
//                var precioSin = data.precioSin;
//                var pvp = data.pvp;
//                var vol = data.volumen;
                //todas los datos del artículo
                if (flag == "true") {
                    alert("se ha editado bien "+cat+", \nSe han hecho "+n+" modificaciones");
                    //location.reload();
                } else {

                }
            }
        });
        }

    });

    $(':input').on('keyup keydown change', function ()
    {
        $(this).removeClass('is-invalid');
        $(this).removeClass('is-valid');

    });



    function capitalize(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }
}

//function añadirArticulo(id){
//alert(id);
// }

