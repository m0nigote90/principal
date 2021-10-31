/* 
 * Pedro, 31/10/2020
 */
$(document).ready(inicio);
function inicio() {

    $('#btnRegistro').click(function () {
        var nombre = $('#inputNombre').val();
        var apellidos = $('#inputApellidos').val();
        var email = $('#inputEmail').val();
        var dni = $('#inputDNI').val();
        var regNombreApellido = /^[A-Z]{1}(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/;

        var regEmail = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;


        //alert("Nombre: " + nombre + " Apellidos: " + apellidos);
        alert("Nombre válido? " + regNombreApellido.test(nombre));
        //alert("Apellido: " + valApe);
        alert("Email: " + regEmail.test(email));
        alert("DNI "+validarDNI(dni));

    });
    function validarDNI (dni) {
        var numero
        var letr
        var letra
        var regExpDNI
        var correcto = false;

        regExpDNI = /^\d{8}[a-zA-Z]$/;

        if (regExpDNI.test(dni) == true) {
            numero = dni.substr(0, dni.length - 1);
            letr = dni.substr(dni.length - 1, 1);
            numero = numero % 23;
            letra = 'TRWAGMYFPDXBNJZSQVHLCKET';
            letra = letra.substring(numero, numero + 1);
            if (letra != letr.toUpperCase()) {
                correcto = false;
            } else {
                correcto = true;
            }
        } else {
            correcto = false;
        }
        return correcto;
    };

}

//$(this).hasClass("d-none")) {
//                $(this).removeClass("d-none");
//                $(this).toggle(1500, function () {
//                    $(this).addClass("d-block");
//                });