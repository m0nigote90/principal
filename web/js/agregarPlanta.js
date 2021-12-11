/* 
 * Pedro 04/11/2021
 */

$(document).ready(inicio);
function inicio() {

    $('#selectTipoPlanta').on('change', function () {
        var valor = $(this).val();
        if (valor == 'nuevo') {
            if ($('#inputTipoNuevo').is(":hidden")) {
                $('#inputTipoNuevo').show(600);
                $('#inputTipoPlantaNuevo').focus();
            }
        } else {
            if (!$('#inputTipoNuevo').is(":hidden")) {
                $('#inputTipoNuevo').hide(600);
            }
        }
    });


    $('#selectFabricantePlanta').on('change', function () {
        var valor = $(this).val();
        if (valor == 'nuevo') {
            if ($('#inputFabNuevo').is(":hidden")) {
                $('#inputFabNuevo').show(600);
                $('#inputFabricanteNuevo').focus();
            }
        } else {
            if (!$('#inputFabNuevo').is(":hidden")) {
                $('#inputFabNuevo').hide(600);
            }
        }
    });

    //El input precio se activara cuando se seleccione el tipo IVA
    $('#selectIVA').on('change', function () {
        var valor = $(this).val();
        var precio = new Number($('#inputPrecioSinIVA').val());
        if (valor == '0') {
            $('#inputPrecioSinIVA').prop('disabled', true);
        } else {
            $('#inputPrecioSinIVA').prop('disabled', false);
            $('#inputPVP').val(((precio) + ((precio) * (valor / 100))).toFixed(2));
            $('#inputPrecioSinIVA').focus();
        }
    });
    //Tratamos el precio
    $('#inputPrecioSinIVA').on('keyup keydown change', function ()
    {
        var precio = new Number($(this).val());
        var iva = new Number($('#selectIVA').val());
        var pvp = precio + ((precio) * (iva / 100));

        if (iva == '0') {
            $('#inputPVP').val("0");
        } else {
            $('#inputPVP').val(((precio) + ((precio) * (iva / 100))).toFixed(2));
        }

    });
    //Modificaciones del modal EDIT
    $('#modEditIVA').on('change', function () {
        var valor = $(this).val();
        var precio = new Number($('#modEditPrecioSinIVA').val());
        if (valor == '0') {
            $('#modEditPrecioSinIVA').prop('disabled', true);
        } else {
            $('#modEditPrecioSinIVA').prop('disabled', false);
            $('#modEditPVP').val(((precio) + ((precio) * (valor / 100))).toFixed(2));
            $('#modEditPrecioSinIVA').focus();
        }
    });
    $('#modEditPrecioSinIVA').on('keyup keydown change', function ()
    {
        var precio = new Number($(this).val());
        var iva = new Number($('#modEditIVA').val());
        var pvp = precio + ((precio) * (iva / 100));

        if (iva == '0') {
            $('#modEditPVP').val("0");
        } else {
            $('#modEditPVP').val(((precio) + ((precio) * (iva / 100))).toFixed(2));
        }

    });


    $('form').on('submit', function (e) {
        e.preventDefault();
        var numVal = 0;
        var ref = $('#inputReferencia').val();
        var nombre = $('#inputNombre').val();
        var tipo = $('#selectTipoPlanta').val();
        var tipoNuevo = $('#inputTipoPlantaNuevo').val();
        var tipoValido;
        var fab = $('#selectFabricantePlanta').val();
        var fabNuevo = $('#inputFabricanteNuevo').val();
        var fabValido;
        var iva = $('#selectIVA').val();
        var precioSin = $('#inputPrecioSinIVA').val();
        var des = $('#inputDescripcion').val();
        var numUni = $('#inputUni').val();

        if (ref != '') {
            $('#inputReferencia').removeClass('is-invalid');
            $('#inputReferencia').addClass('is-valid');
            numVal += 1;
        } else {
            $('#inputReferencia').removeClass('is-valid');
            $('#inputReferencia').addClass('is-invalid');

        }
        var inputN = $('#inputNombre');
        if (nombre != '') {
            if (validarNombre(nombre)) {
                numVal += 1;
                inputN.removeClass('is-invalid');
                inputN.addClass('is-valid');
            } else {
                $('#feedbackNombre').text('El nombre debe comenzar por mayúsculas.');
                inputN.removeClass('is-valid');
                inputN.addClass('is-invalid');
            }
        } else {
            inputN.removeClass('is-valid');
            inputN.addClass('is-invalid');
        }

        //Validaciones de tipo planta
        if (tipo != '0') {
            if (tipo != 'nuevo') {
                tipoValido = tipo;
                $('#selectTipoPlanta').removeClass('is-invalid');
                $('#selectTipoPlanta').addClass('is-valid');
                numVal += 1;
            } else {
                $('#selectTipoPlanta').removeClass('is-invalid');
                $('#selectTipoPlanta').removeClass('is-valid');
                if(tipoNuevo != ''){
                    tipoValido = tipoNuevo;
                    $('#inputTipoPlantaNuevo').removeClass('is-invalid');
                    $('#inputTipoPlantaNuevo').addClass('is-valid');
                    numVal += 1;
                } else {
                    $('#inputTipoPlantaNuevo').removeClass('is-valid');
                    $('#inputTipoPlantaNuevo').addClass('is-invalid');
                }
            }
        } else {
            $('#selectTipoPlanta').removeClass('is-valid');
            $('#selectTipoPlanta').addClass('is-invalid');
        }
        //Validaciones de fabricante
        if (fab != '0') {
            if (fab != 'nuevo') {
                fabValido = fab;
                $('#selectFabricantePlanta').removeClass('is-invalid');
                $('#selectFabricantePlanta').addClass('is-valid');
                numVal += 1;
            } else {
                $('#selectFabricantePlanta').removeClass('is-invalid');
                $('#selectFabricantePlanta').removeClass('is-valid');
                if(fabNuevo != ''){
                    fabValido = fabNuevo;
                    $('#inputFabricanteNuevo').removeClass('is-invalid');
                    $('#inputFabricanteNuevo').addClass('is-valid');
                    numVal += 1;
                } else {
                    $('#inputFabricanteNuevo').removeClass('is-valid');
                    $('#inputFabricanteNuevo').addClass('is-invalid');
                }
            }
        } else {
            $('#selectFabricantePlanta').removeClass('is-valid');
            $('#selectFabricantePlanta').addClass('is-invalid');
        }
        
        //Validacion tipo IVA
        if(iva != '0'){
            $('#selectIVA').removeClass('is-invalid');
            $('#selectIVA').addClass('is-valid');
            numVal += 1;
        } else {
            $('#selectIVA').removeClass('is-valid');
            $('#selectIVA').addClass('is-invalid');
        }
        if(precioSin != 0){
            $('#inputPrecioSinIVA').removeClass('is-invalid');
            $('#inputPrecioSinIVA').addClass('is-valid');
            numVal += 1;
        } else {
            $('#inputPrecioSinIVA').removeClass('is-valid');
            $('#inputPrecioSinIVA').addClass('is-invalid');
        }
        if(des != ''){
            $('#inputDescripcion').removeClass('is-invalid');
            $('#inputDescripcion').addClass('is-valid');
            numVal += 1;
        } else {
            $('#inputDescripcion').removeClass('is-valid');
            $('#inputDescripcion').addClass('is-invalid');
        }
        //numUni = $('#inputUni')
        if(numUni >= 1){
            $('#inputUni').removeClass('is-invalid');
            $('#inputUni').addClass('is-valid');
            numVal+=1;
        } else {
            $('#inputUni').removeClass('is-valid');
            $('#inputUni').addClass('is-invalid');
        }

        if (numVal == 8) {
            //llamada ajax o modal
            $.ajax({
                url: "AltaPlanta",
                dataType: "json",
                type: "post",
                data: {
                    "ref": ref,
                    "nombre": nombre,
                    "tipo": tipoValido,
                    "fab": fabValido,
                    "tipoIVA": iva,
                    "precioSinIVA": precioSin,
                    "des": des,
                    "numUni": numUni,
                },
                success: function (data) {
                    var flag = data.flag;
                    var nombre = data.nombre;
                    var errorRef = data.errorRef;
                    
                    if (flag == "true") {
                        alert('Planta '+nombre+" se ha registrado correctamente.\n"+numUni+" unidad/es agregadas.");
                        location.reload();
                    } else {
                        alert("ERROR REGISTRO");
                        if (errorRef != null) {
                            $('#inputReferencia').removeClass('is-valid');
                            $('#inputReferencia').addClass('is-invalid');
                            $('#invalidRef').text(errorRef);
                        }
                        
                    }
                }
            });
        }


    });

    function validarNombre(nombre) {
        var expReg = /^[A-Z]{1}(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/;
        if (expReg.test(nombre)) {
            return true;
        } else {
            return false;
        }
    }
}

