/* 
 Pedro, 11/10/2021
 */
$(document).ready(inicio);
function inicio() {
    //Controlamos la badera según el idioma del navegador del cliente
    var locale = $('#localeActual').attr('value');
    var regexpEN = /^en/;
    var regexpES = /^es/;
    if (regexpEN.test(locale)) {//si es un idioma ingles, activamos bandera inglesa
        $('#iconoEN').attr('src', 'img/iconoEN.png');
        $('#iconoEN').css('box-shadow', '2px 2px 2px grey');
        $('#iconoES').attr('src', 'img/iconoES_DISABLE.png');
        $('#iconoES').css('box-shadow', 'none');
    } else if (regexpES.test(locale)) {//si es idioma espaniol, activamos bandera espaniola
        $('#iconoEN').attr('src', 'img/iconoEN_DISABLE.png');
        $('#iconoEN').css('box-shadow', 'none');
        $('#iconoES').attr('src', 'img/iconoES.png');
        $('#iconoES').css('box-shadow', '2px 2px 2px grey');
    }

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
    $("#btnLogin").click(function (e) {
        e.preventDefault();
        var email = $("#inputEmail").val();
        var password = $("#inputPassword").val();
        if (email != "" && password != "") {
            //$("#mensajeErrorLogin").hide();
            $("#invalidEmail").hide();
            $("#invalidEmail2").hide();
            $("#contraInval").hide();
            $("#contraInval2").hide();
            $('#inputEmail').removeClass('is-valid');
            $('#inputEmail').removeClass('is-invalid');
            $('#inputPassword').removeClass('is-valid');
            $('#inputPassword').removeClass('is-invalid');
            $.ajax({
                url: "LoginAjax",
                dataType: "json",
                type: "post",
                data: {
                    "email": email,
                    "password": password
                },
                success: function (data) {
                    var flag = data.flag;
                    var email = data.email;

                    if (flag == "true") {
                        $('#inputEmail').removeClass('is-invalid');
                        $('#inputEmail').addClass('is-valid');
                        $('#inputPassword').removeClass('is-invalid');
                        $('#inputPassword').addClass('is-valid');
                        $("#invalidEmail").hide();
                        $("#invalidEmail2").hide();
                        $("#contraInval").hide();
                        $("#contraInval2").hide();

                        $("#mensajeLogin").prop('style', "color: green; font-weight: 600;");
                        $("#mensajeLogin").show();

                        $("#cuentaAtrasLogin").prop('style', "font-weight: 600;");
                        $("#cuentaAtrasLogin").show();
                        //anadirContenido("#errorLogin", "Correcto. Te has logueado con &eacute;xito.");
                        anadirContenido("#numCuentaAtras", "2");
                        setTimeout(anadirCuentaAtras, 1000);
                        setTimeout(recargaPagina, 2000);
                    } else {
                        if (email == "true") {
                            $("#invalidEmail").hide();
                            $("#invalidEmail2").hide();
                            $('#inputEmail').removeClass('is-invalid');
                            $('#inputEmail').addClass('is-valid');

                            $("#contraInval").show();
                            $("#contraInval2").hide();
                            $('#inputPassword').removeClass('is-valid');
                            $('#inputPassword').addClass('is-invalid');

                        } else {
                            $("#invalidEmail").show();
                            $("#invalidEmail2").hide();
                            $('#inputEmail').removeClass('is-valid');
                            $('#inputEmail').addClass('is-invalid');
                            $('#inputPassword').removeClass('is-invalid');
                            $('#inputPassword').removeClass('is-valid');
                            $("#contraInval").hide();
                            $("#contraInval2").hide();
                        }
                    }
                }
            });
        } else {
            if (email == "" && password == "") {
                $("#invalidEmail").hide();
                $("#invalidEmail2").show();
                $("#contraInval").hide();
                $("#contraInval2").show();
                $('#inputEmail').removeClass('is-valid');
                $('#inputEmail').addClass('is-invalid');
                $('#inputPassword').removeClass('is-valid');
                $('#inputPassword').addClass('is-invalid');
            } else if (email != "" && password == "") {
                $("#invalidEmail").hide();
                $("#invalidEmail2").hide();
                $("#contraInval").hide();
                $("#contraInval2").show();
                $('#inputEmail').removeClass('is-invalid');
                $('#inputEmail').addClass('is-valid');
                $('#inputPassword').removeClass('is-valid');
                $('#inputPassword').addClass('is-invalid');
            } else if (email == "" && password != "") {
                $("#invalidEmail").hide();
                $("#invalidEmail2").show();
                $("#contraInval").hide();
                $("#contraInval2").hide();
                $('#inputEmail').removeClass('is-valid');
                $('#inputEmail').addClass('is-invalid');
                $('#inputPassword').removeClass('is-invalid');
                $('#inputPassword').removeClass('is-valid');
            }

        }
    });
    //cada vez que se detecte cambio en el input de login, reseteamos validación
    $('#inputEmail').on('keyup keydown change', function ()
    {
        $("#invalidEmail").hide();
        $("#invalidEmail2").hide();
        $(this).removeClass('is-invalid');
        $(this).removeClass('is-valid');
    });
    $('#inputPassword').on('keyup keydown change', function ()
    {
        $("#contraInval").hide();
        $("#contraInval2").hide();
        $(this).removeClass('is-invalid');
        $(this).removeClass('is-valid');
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
                    //console.log("Todo ha ido bien Servlet CargarPortafolio");
                    //alert("Ha funcionado la request a filtro");
                    recargaPagina();
                } else {
                    //console.log("ERROR Servlet CargarPortafolio");
                    //alert("ERROR request a filtro");
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
                    //console.log("Todo ha ido bien Servlet CargarPortafolio");
                    //alert("Ha funcionado la request a filtro");
                    recargaPagina();
                } else {
                    //console.log("ERROR Servlet CargarPortafolio");
                    //alert("ERROR request a filtro");
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
//                    console.log("Todo ha ido bien Servlet CargarPortafolio");
//                    alert("Ha funcionado la request a filtro");
                    recargaPagina();
                } else {
//                    console.log("ERROR Servlet CargarPortafolio");
//                    alert("ERROR request a filtro");
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
    function anadirContenido(elemento, mensaje) {
        limpiaMensaje(elemento);
        $(elemento).append(mensaje);
    }
    function anadirCuentaAtras() {
        limpiaMensaje("#numCuentaAtras");
        $("#numCuentaAtras").append("1");
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
//                    console.log("ERROR Servlet AddArticulo");
//                    alert("ERROR add articulo");
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
                    //console.log("ERROR Servlet REMOVEArticulo");
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
        //alert(ref);
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

        //alert(ref + " " + categoria + " " + nombre + " " + tipo + " " + fab + " " + des + " " + iva + " " + precioSin + " " + vol);
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
            //alert("Hacemos llamada de edit");
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

                    //todas los datos del artículo
                    if (flag == "true") {
                        //alert("se ha editado bien "+cat+".");
                        location.reload();
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


    $('.btnRmvArt').click(function () {

        var ref = $(this).attr('data1');
        var num = $(this).attr('data2');
        var resultado;
        if (num == 0) {
            alert('No quedan unidades en stock por eliminar.');
            return;
        } else {
            resultado = window.confirm('¿Está seguro que desea eliminar las ' + num + ' unidades restantes en stock?');
        }
        if (resultado === true) {
            $.ajax({
                url: "RmvArticulo",
                dataType: "json",
                type: "post",
                data: {
                    "ref": ref,
                    "num": num
                },
                success: function (data) {
                    var flag = data.flag;
                    var nombre = data.nombre;

                    //todas los datos del artículo
                    if (flag == "true") {
                        location.reload();
                        alert("se ha eliminado bien " + ref + ".");

                    } else {

                    }
                }
            });
        } else {

        }
    });

    $('#btnImportar').click(function () {

        var data = new FormData();
        var filePlantas = $('#inputFilePlantas')[0].files[0];
        var fileAbonos = $('#inputFileAbonos')[0].files[0];
        var fileUsuarios = $('#inputFileUsuarios')[0].files[0];
        data.append('filePlantas', filePlantas);
        data.append('fileAbonos', fileAbonos);
        data.append('fileUsuarios', fileUsuarios);

        if (filePlantas != undefined || fileAbonos != undefined || fileUsuarios != undefined) {
            $.ajax({
                url: "Importar",
                data: data,
                processData: false,
                type: 'POST',
                contentType: false,
                dataType: "json",
                success: function (data) {

                    var flag = data.flag;
                    var pla = data.plantas;
                    var abo = data.abonos;
                    var usu = data.usuarios;
                    //todas los datos del artículo
                    if (flag == "true") {
                        if (pla == "Si" || abo == "Si" || usu == "Si") {
                            alert("Archivos importados\nPlantas: " + pla + "\nAbonos: " + abo + "\nUsuarios: " + usu);
                            location.reload();
                        } else {
                            alert("No se ha importado ning&uacute;n archivo.\nCompruebe que ha seleccionado los archivos correctos.\n\
                                    Tambien es posible que los usuarios ya estén cargados en la tienda.")
                        }


                        //alert(mensaje);

                    } else {

                    }
                }
            });
        } else {
            alert("No hay ning&uacute;n archivo seleccionado.")
        }//aqui acaba AJAX

    });

    $('#btnESP').click(function () {
        //var locale = $('#localeActual').attr('value');

        $('#iconoEN').attr('src', 'img/iconoEN_DISABLE.png');
        $('#iconoEN').css('box-shadow', 'none');
        $('#iconoES').attr('src', 'img/iconoES.png');
        $('#iconoES').css('box-shadow', '2px 2px 2px grey');

    });
    $('#btnENG').click(function () {
        $('#iconoEN').attr('src', 'img/iconoEN.png');
        $('#iconoEN').css('box-shadow', '2px 2px 2px grey');
        $('#iconoES').attr('src', 'img/iconoES_DISABLE.png');
        $('#iconoES').css('box-shadow', 'none');
    });
    function capitalize(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }
    //funcion para filtrar Usuarios
    function filtrar() {

    }
    $("#filtroNombre").keyup(function () {
        var filtroNombre = $(this).val();
        var filtroDNI = $('#filtroDNI').val();

//        console.log("filtroNombre: " + filtroNombre);
//        console.log("filtroDNI: " + filtroDNI);
        $.ajax({
            method: "POST",
            url: "filtradoUsuarios.jsp",
            data: {filtroNombre: filtroNombre, filtroDNI: filtroDNI}
        })
                .done(function (listado) {
                    $("#listadoUsuarios").html(listado);
                });
    });
    $("#filtroDNI").keyup(function () {
        var filtroNombre = $('#filtroNombre').val();
        var filtroDNI = $(this).val();

//        console.log("filtroNombre: " + filtroNombre);
//        console.log("filtroDNI: " + filtroDNI);
        $.ajax({
            method: "POST",
            url: "filtradoUsuarios.jsp",
            data: {filtroNombre: filtroNombre, filtroDNI: filtroDNI}
        })
                .done(function (listado) {
                    $("#listadoUsuarios").html(listado);
                });
    });
    //función general para agregar un delay a una determinada función
    function delay(fn, ms) {
        let timer = 0;
        return function (...args) {
            clearTimeout(timer);
            timer = setTimeout(fn.bind(this, ...args), ms || 0);
        };
    }
    ;


    //método que detecta pulsación de teclas en la barra de búsqueda y agrega filtros y muestra div personalizado
    $("#inputBuscar").keyup(delay(function (e) {
        var filtro = $(this).val();
        //var position = $(this).offset();
        var position = $(this).position();
        var width = $(this).width();
//        console.log(position);
//        console.log(width);
//
//        console.log("filtroNombre: " + filtro);
        if (filtro != "") {
            $("#listadoProductosBusqueda").show();
            $.ajax({
                method: "POST",
                url: "busquedaProductos.jsp",
                data: {filtro: filtro}
            })
                    .done(function (listado) {
                        $("#listadoProductosBusqueda").css("width", width + 30);
                        $("#listadoProductosBusqueda").css("top", position.top + 40);
                        $("#listadoProductosBusqueda").css("left", position.left);
                        $("#listadoProductosBusqueda").html(listado);
                    });

        } else {
            $("#listadoProductosBusqueda").hide();
        }
    }, 500));
    $("#inputBuscarOLD").keyup(function () {
        var filtro = $(this).val();
        //var position = $(this).offset();
        var position = $(this).position();
        var width = $(this).width();
//        console.log(position);
//        console.log(width);
//
//        console.log("filtroNombre: " + filtro);
        if (filtro != "") {
            $("#listadoProductosBusqueda").show();
            $.ajax({
                method: "POST",
                url: "busquedaProductos.jsp",
                data: {filtro: filtro}
            })
                    .done(function (listado) {
                        $("#listadoProductosBusqueda").css("width", width + 30);
                        $("#listadoProductosBusqueda").css("top", position.top + 40);
                        $("#listadoProductosBusqueda").css("left", position.left);
                        $("#listadoProductosBusqueda").html(listado);
                    });

        } else {
            $("#listadoProductosBusqueda").hide();
        }
    });
    //capturamos los redimensionamientos de la ventana principal para tener siempre bien posicionado el div
    //absolute de la búsqueda principal
    $(window).resize(function () {
        //console.log("resizeee");
        var position = $("#inputBuscar").position();
        var width = $("#inputBuscar").width();
        $("#listadoProductosBusqueda").css("width", width + 30);
        $("#listadoProductosBusqueda").css("top", position.top + 40);
        $("#listadoProductosBusqueda").css("left", position.left);
    });
    //capturaremos también el boton Home para posicionar bien la búsqueda
    $("#btnHomeColapse").click(function () {
        var position = $("#inputBuscar").position();
        var width = $("#inputBuscar").width();
        $("#listadoProductosBusqueda").css("width", width + 30);
        $("#listadoProductosBusqueda").css("top", position.top + 40);
        $("#listadoProductosBusqueda").css("left", position.left);
    });
    //en un cambio de esto, si está vacío, ocultamos la búsqueda
    $("inputBuscar").on('change', 'input', function () {
        var filtro = $(this).val();
        if (filtro == "") {
            $("#listadoProductosBusqueda").hide();
        }
    });

    //al hacer clic sobre un artículo en la búsqueda nos abrirá la pantalla de dicho artículo
    $(".artBusqueda").click(function () {
        var ref = $(this).attr("id");
        //alert(ref);
        $.ajax({
            url: "ArticuloDetalle",
            dataType: "json",
            type: "post",
            data: {
                "ref": ref
            },
            success: function (data) {
                var flag = data.flag;

                //todas los datos del artículo
                if (flag == "true") {
                    //redirect
                    //mostramos por url ref para dar información al usuario aunque no haga falta
                    window.location.href = "producto.jsp?ref=" + ref;
                } else {

                }
            }
        });
    });

    $(".verPed").click(function () {
        var id = $(this).attr('data');
        //alert(id);
        $.ajax({
            url: "PedidoDetalle",
            dataType: "json",
            type: "post",
            data: {
                "idPedido": id
            },
            success: function (data) {
                var flag = data.flag;
                var fecPed = data.fecPed;
                var numPed = data.numPed;
                var numArt = data.numArt;
                var precioSin = data.precioSin;
                var total = data.precio;
                var articulos = data.articulos;
                var impuestos = data.impuestos;

                //console.log("Object.key(): " + Object.keys(articulos));
                var articulosJOS = JSON.stringify(articulos);
                var JSONAr = JSON.parse(articulosJOS);


                //todas los datos del artículo
                if (flag == "true") {
                    $('#tbodyArt').html("");//limpiamos el listado de articulos anterior
                    $('#numPedido').html(numPed);
                    var fecha = new Date(fecPed);
                    $('#fecPedido').html(fecha.toLocaleDateString("es-ES"));
                    $('#subtotalPedido').html(precioSin.toFixed(2)+" \u20AC");
                    $('#impuestosPedido').html(impuestos.toFixed(2)+" \u20AC");
                    $('#totalPedido').html("<b>"+total.toFixed(2)+" \u20AC</b>");
//                    console.log(id);
//                    console.log(fecPed);
//                    console.log(numPed);
                    Object.keys(JSONAr).forEach(key => {
                        let value = JSONAr[key];
//                    console.log(key, value);
//                    console.log("value: "+value);
//                    console.log(Object.keys(value))
//                    console.log(Object.values(value));
//                    console.log(Object.keys(value)[0]);
                        var precio = Object.values(value)[0];
                        var nomImg = Object.values(value)[1];
                        var cantidad = Object.values(value)[2];
                        var nombre = Object.values(value)[3];
                        console.log("precio: " + Object.values(value)[0]);
                        console.log("nomImg: " + Object.values(value)[1]);
                        console.log("cantidad: " + Object.values(value)[2]);
                        console.log("nombre: " + Object.values(value)[3]);
                        $('#tbodyArt').append("<tr>\n\
                            <td  class='align-middle'><img style='width: 50px;' src='img/articulos/" + nomImg + "' /></td>\n\
                            <td  class='align-middle'>" + nombre + "</td>\n\
                            <td  class='align-middle'>" + precio.toFixed(2) + "\u20AC</td>\n\
                            <td  class='align-middle'>x" +cantidad+"</td>\n\
                            <td  class='align-middle'>x" +(cantidad*precio).toFixed(2)+"\u20AC</td>\n\
                            </tr>");
                    })

                }
            }
        });
    });
}


