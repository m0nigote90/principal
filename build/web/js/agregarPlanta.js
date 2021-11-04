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
            if ($('#inputFabricanteNuevo').is(":hidden")) {
                $('#inputFabricanteNuevo').show(600);
            }
        } else {
            if (!$('#inputFabricanteNuevo').is(":hidden")) {
                $('#inputFabricanteNuevo').hide(600);
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


    //Tratamos el textarea
    var max_chars = 160;

    $('#max').html(max_chars);
    $('#inputDescripcion').keyup(function () {
        var chars = $(this).val().length;
        var diff = max_chars - chars;
        $('#contador').html(diff);
    });

    $('form').on('submit', function (e) {
        e.preventDefault();

        var numVal = 0;

        if ($('#inputReferencia').val() != '') {
            $('#inputReferencia').removeClass('is-invalid');
            $('#inputReferencia').addClass('is-valid');
            numVal += 1;
        } else {
            $('#inputReferencia').removeClass('is-valid');
            $('#inputReferencia').addClass('is-invalid');

        }
        var inputN = $('#inputNombre');
        if (inputN.val() != '') {
            if (validarNombre(inputN.val())) {
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

