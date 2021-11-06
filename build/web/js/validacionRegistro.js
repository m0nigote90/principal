/* 
 * Pedro, 31/10/2020
 */

$(document).ready(inicio);
function inicio() {


    //Ante cualquier cambio en los input, borramos mensajes de validación y ¿ponemos a false la validación?
    $(':input').on('keyup keydown change', function ()
    {
        $(this).removeClass('is-invalid');
        $(this).removeClass('is-valid');
        $('#checkAcepto').css("border", "none");
    });

    $('form').on('submit', function (e) {
        e.preventDefault();


        var numVal = 0;
        var nombre = $('#inputNombre').val();
        var apellidos = $('#inputApellidos').val();
        var email = $('#inputEmail').val();
        var dni = $('#inputDNI').val();
        var fechaNac = $('#inputFechaNac').val();
        var password = $('#inputPassword').val();
        var password2 = $('#inputPassword2').val();



        if (validarNombreApellido(nombre)) {
            $('#inputNombre').removeClass('is-invalid');
            $('#inputNombre').addClass('is-valid');
            numVal += 1;
        } else {
            $('#inputNombre').removeClass('is-valid');
            $('#inputNombre').addClass('is-invalid');

        }
        if (validarNombreApellido(apellidos)) {
            $('#inputApellidos').removeClass('is-invalid');
            $('#inputApellidos').addClass('is-valid');
            numVal += 1;
        } else {
            $('#inputApellidos').removeClass('is-valid');
            $('#inputApellidos').addClass('is-invalid');
        }
        if (validarEmail(email)) {
            $('#inputEmail').removeClass('is-invalid');
            $('#inputEmail').addClass('is-valid');
            numVal += 1;
        } else {
            $('#invalidEmail').text("Introduce un email válido, 'nombre@ejemplo.com'.")
            $('#inputEmail').removeClass('is-valid');
            $('#inputEmail').addClass('is-invalid');
        }

        if (validarFechaNac(fechaNac)) {
            $('#inputFechaNac').removeClass('is-invalid');
            $('#inputFechaNac').addClass('is-valid');
            numVal += 1;
        } else {
            $('#inputFechaNac').removeClass('is-valid');
            $('#inputFechaNac').addClass('is-invalid');
        }
        if (validarDNI(dni)) {
            $('#inputDNI').removeClass('is-invalid');
            $('#inputDNI').addClass('is-valid');
            numVal += 1;
        } else {
            $('#invalidDNI').text("Debe introducir un DNI válido en formato 12345678X.")
            $('#inputDNI').removeClass('is-valid');
            $('#inputDNI').addClass('is-invalid');
        }
        //alert("Password: " + password + " Buena?: " + validarPassword(password));
        if (validarPassword(password)) {
            $('#inputPassword').removeClass('is-invalid');
            $('#inputPassword').addClass('is-valid');
            numVal += 1;
            if (password2 != '') {
                if (password == password2) {
                    $('#inputPassword2').removeClass('is-invalid');
                    $('#inputPassword2').addClass('is-valid');
                    numVal += 1;
                } else {
                    $('#inputPassword2').removeClass('is-valid');
                    $('#inputPassword2').addClass('is-invalid');
                }
            } else {
                $('#inputPassword2').removeClass('is-valid');
                $('#inputPassword2').addClass('is-invalid');
            }
        } else {
            $('#inputPassword').removeClass('is-valid');
            $('#inputPassword').addClass('is-invalid');
        }

        if ($('#checkAcepto').is(':checked')) {
            console.log("Checkbox seleccionado");

            numVal += 1;
        } else {
            $('#checkAcepto').css("border", "solid 2px red");
        }

        //Si se hacen todas las validaciones correctamente y suman 8, hacemos la peticion Ajax
        if (numVal == 8) {
            alert("Válido! se hace llamamiento.")

            var ref = $(this).attr('data');
            var idnumber = "#inputNumber" + ref;
            var num = $(idnumber).val();

            $.ajax({
                url: "AltaUsuario",
                dataType: "json",
                type: "post",
                data: {
                    "nombre": nombre,
                    "apellidos": apellidos,
                    "email": email,
                    "dni": dni,
                    "fechaNac": fechaNac,
                    "password": password,
                },
                success: function (data) {
                    var flag = data.flag;
                    var nombre = data.nombre;
                    var errorDNI = data.errorDNI;
                    var errorEmail = data.errorEmail;
                    //var nombre = data.nombre;
                    if (flag == "true") {
                        alert('Usuario '+nombre+" se ha registrado correctamente.");
                        $(':input').val("");
                        $('#checkAcepto').prop("checked",false);
                        //recargaPagina();
                    } else {
                        alert("ERROR REGISTRO");
                        if (errorDNI != null) {
                            alert(errorDNI);
                            $('#inputDNI').removeClass('is-valid');
                            $('#inputDNI').addClass('is-invalid');
                            $('#invalidDNI').text(errorDNI);
                        }
                        if (errorEmail != null) {
                            alert(errorEmail);
                            $('#inputEmail').removeClass('is-valid');
                            $('#inputEmail').addClass('is-invalid');
                            $('#invalidEmail').text(errorEmail);
                        }
                    }
                }
            });
        }
        ;



    });

    //Funciones de validación de los diferentes campos
    function validarNombreApellido(nombre) {
        var expReg = /^[A-Z]{1}(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/;
        if (expReg.test(nombre)) {
            return true;
        } else {
            return false;
        }
    }
    function validarEmail(email) {
        var expReg = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
        if (expReg.test(email)) {
            return true;
        } else {
            return false;
        }
    }
    function validarDNI(dni) {
        var numero;
        var letr;
        var letra;
        var regExpDNI;
        var correcto = false;

        regExpDNI = /^\d{8}[a-zA-Z]$/;

        if (regExpDNI.test(dni)) {
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
    }
    ;

    function validarFechaNac(fecha) {
        if (fecha != '') {
            var dia = fecha.split('-')[2];
            var mes = fecha.split('-')[1];
            var ano = fecha.split('-')[0];

            var hoy = new Date();
            var diaH = hoy.getDate();
            var mesH = hoy.getMonth() + 1; //Enero es 0
            var anoH = hoy.getFullYear();

            var a = moment([anoH, mesH, diaH]);
            var b = moment([ano, mes, dia]);

            var diff = moment.duration(a.diff(b));
            //alert("Dias: "+diff.days()+" Meses: "+diff.months()+" Años: "+diff.years());
            //Si no tiene 16 años, daremos invalido
            if (diff.years() < 16 || ano < 1900) {
                //alert("No tienes 16 años.");
                return false;
            } else {

                return true;
            }
        } else {
            return false;
        }
//        alert("Dia: " + dia + ", Mes: " + mes + ", Año: " + ano);
//        alert("DiaH: " + diaH + ", MesH: " + mesH + ", AñoH: " + anoH);  
    }
    ;

    function validarPassword(password) {
        var regExp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$.!%*?&])[A-Za-z\d@$.!%*?&]{8,}$/;
        if (regExp.test(password)) {
            return true;
        } else {
            return false;
        }
    }


}
