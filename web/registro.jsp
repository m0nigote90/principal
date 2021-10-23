<%-- 
    Document   : Registro
    Created on : 03-oct-2021, 15:06:57
    Author     : Pedro
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <!-- Uso el bootstrap normal para cambiar variables a mi antojo -->
        <link rel="icon" type="image/png" href="img/icono.png">
        <title>Eleplant</title>
        <style>
            body {
                background-image: url(img/fondoRegistro1.jpg);
                background-size: cover;
            }
            i, h1{
                color: rgb(101, 175, 11);
            }
            h1{
                font-weight: bold;
            }
        </style>
        <script src="js/jquery-3.5.1.min.js"></script>
    </head>

    <body>

        <c:if test="${not empty error}">
            <br>
            <div class="error">
                ${error}
            </div>
        </c:if>
        <section id="registro" class="wrap">
            <div class="container-fluid">
                <div class="row d-flex justify-content-center justify-content-md-start offset-md-3 my-4">
                    <div class="col-auto">
                        <h1>Registro</h1>
                    </div>
                </div>
                <form action="AltaUsuario" method="POST">
                    <div class="row">
                        <div class="col-10 offset-1 col-xl-7 offset-xl-1 my-1">
                            <div class="row g-3 align-items-center">
                                <div class="col-12 col-md-2">
                                    <i class="fad fa-user-tie me-2"></i>
                                    <label for="inputNombre" class="form-label">Nombre</label>
                                </div>
                                <div class="col-12 col-md-6">
                                    <input type="text" class="form-control bg-light shadow" id="inputNombre"
                                           name="nombre" aria-describedby="nombreHelp">
                                </div>
                            </div>
                            <div class="row g-3 align-items-center mt-2">
                                <div class="col-12 col-md-2">
                                    <i class="fad fa-user-tie me-2"></i>
                                    <label for="inputApellidos" class="form-label">Apellidos</label>
                                </div>
                                <div class="col-12 col-md-6">
                                    <input type="text" class="form-control bg-light shadow" id="inputApellidos"
                                           name="apellidos" aria-describedby="apellidosHelp">
                                </div>
                            </div>
                            <div class="row g-3 align-items-center mt-2">
                                <div class="col-12 col-md-2">
                                    <i class="fad fa-calendar-day me-2"></i>
                                    <label for="inputFechaNac" class="form-label">Fecha Nac.</label>
                                </div>
                                <div class="col-12 col-md-6">
                                    <input type="date" class="form-control bg-light shadow" id="inputFechaNac"
                                           name="fechaNac" aria-describedby="fechaNacHelp">
                                </div>
                            </div>
                            <div class="row g-3 mt-2">
                                <div class="col-12 col-md-2">
                                    <i class="fad fa-at me-2"></i>
                                    <label for="inputEmail" class="form-label">Email</label>
                                </div>
                                <div class="col-12 col-md-6">
                                    <input type="email" class="form-control bg-light shadow" id="inputEmail"
                                           name="email" aria-describedby="emailHelp">
                                    <div id="emailHelp" class="form-text">No compartiremos su correo con nadie.</div>
                                </div>
                            </div>
                            <div class="row g-3 mt-1">
                                <div class="col-12 col-md-2">
                                    <i class="fad fa-unlock-alt me-2"></i>
                                    <label for="inputPassword" class="form-label">Password</label>
                                </div>
                                <div class="col-12 col-md-6">
                                    <input type="password" class="form-control bg-light shadow" name="password" id="inputPassword">
                                    <div id="passwordHelpBlock" class="form-text">
                                        Tu contraseña debe tener de 8-20 caracteres, solo letras y números sin espacios ni caracteres especiales.
                                    </div>
                                </div>
                            </div>

                            <div class="row g-3 align-items-center mt-1">
                                <div class="col-12 col-md-2">
                                    <i class="fas fa-id-card me-2"></i>
                                    <label for="inputDNI" class="form-label">DNI/NIF</label>
                                </div>
                                <div class="col-12 col-md-6">
                                    <input type="text" class="form-control bg-light shadow" name="DNI" id="inputDNI">
                                    <div id="dniHelpBlock" class="form-text">
                                        Introduzca su DNI o NIF de la empresa.
                                    </div>
                                </div>
                            </div>
                            <div class="row g-3 align-items-center mt-1">
                                <div class="col-2"></div>
                                <div class="col-1 col-md-auto offset-md-1">
                                    <input type="checkbox" class="form-check-input shadow" id="exampleCheck1"
                                           style="cursor: pointer;" required>
                                </div>
                                <div class="col-8 col-md-auto">
                                    <label class="form-check-label" for="exampleCheck1"><a href="#"
                                                                                           class="text-decoration-none" style="color: rgb(101, 175, 11);">Acepto los
                                            términos y condiciones.</a></label>
                                </div>
                            </div>
                            <hr class="featurette-divider offset-1 w-75">
                            <div class="container offset-md-1">
                                <div class="row offset-1">
                                    <div class="col-12 col-md-6">
                                        <button class="btn btn-primary w-100 fw-bold shadow"><i
                                                class="fab fa-facebook-f" style="color: white;"></i>&nbsp;&nbsp;&nbsp;Registro con
                                            Facebook</button>
                                    </div>
                                </div>
                                <div class="row offset-1 my-3">
                                    <div class="col-12 col-md-6">
                                        <button class="btn btn-info text-white w-100 fw-bold shadow">
                                            <i class="fab fa-google" style="color: red;"></i>&nbsp;&nbsp;&nbsp;Registro con
                                            Google</button>
                                    </div>
                                </div>
                            </div>
                            <hr class="featurette-divider w-100">
                            <div id="footerForm" class="d-flex justify-content-md-center my-5 ">
                                <a href="principal.jsp" class="btn btn-outline-dark active mx-3" role="button"
                                   aria-pressed="false">Volver</a>
                                <input class="btn btn-outline-success" type="reset" value="Reiniciar">
                                <button type="submit" class="btn btn-success mx-3 me-5">Registrarse</button>
                            </div>
                        </div><!-- Col -->
                    </div><!-- Row -->
                </form>
            </div>
        </section>


        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/font-awesome5.js"></script>
    </body>
</html>
