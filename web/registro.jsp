<%-- 
    Document   : Registro
    Created on : 03-oct-2021, 15:06:57
    Author     : Pedro
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%--<c:set var="varLocale" value="${pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${varLocale}" scope="application"/>--%>
<fmt:setBundle basename="idioma" var="lang" scope="application"/>
<fmt:requestEncoding value="ISO-8859-1" /> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link 
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
            rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
            crossorigin="anonymous"
            >
        <link rel="icon" type="image/png" href="img/icono.png">
        <title>Eleplant</title>
        <style>
            body {
                background-image: url(img/fondoRegistro1.jpg);
                background-size: auto auto;
                background-repeat: no-repeat;
            }
            i, h1{
                color: rgb(101, 175, 11);
            }
            .btn-success, .btn-outline-success:hover{
                background: linear-gradient(180deg, rgba(0,82,53,0.7) 0%, rgba(0,82,53,0.8368813736432073) 35%, rgba(0,82,53,1) 100%);
                color: white;
            }
        </style>
        <script src="js/jquery-3.5.1.min.js"></script>
    </head>

    <body>
        <div class="row p-0">
            <div class="col-12 col-sm-10 offset-sm-1 col-md-10 col-lg-8 col-xl-6 offset-xl-3">
                <div class="container-fluid bg-light py-4 mt-2 rounded-3 shadow">
                    <hr class="">
                    <div class="row offset-2">
                        <div class="col-1">
                            <img src="img/logoLtrans.png" alt="logoEmpresa"width="100">
                        </div>
                        <div class="col-8 text-center">
                            <p class="display-4"><fmt:message key="registro.titulo" bundle="${lang}"/></p>
                        </div>
                        <div class="col-1 ms-5">
                            <a href="principal.jsp"><i style="text-shadow: 2px 2px 1px grey;" class="fad fa-house-return fa-2x"></i></a>
                        </div>
                    </div>
                    <hr class="">
                    <form class="form needs-validation" novalidate>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-user fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="text" class="form-control shadow-sm" id="inputNombre" placeholder="Nombre" required>
                                    <label for="inputNombre" class="text-muted"><fmt:message key="registro.nombre" bundle="${lang}"/></label>
                                    <div class="valid-feedback col-10">
                                        <fmt:message key="registro.nomVal" bundle="${lang}"/>
                                    </div>
                                    <div class="invalid-feedback col-10">
                                        <fmt:message key="registro.nomInval" bundle="${lang}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-user fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="text" class="form-control shadow-sm" id="inputApellidos" placeholder="Apellidos" required>
                                    <label for="inputApellidos" class="text-muted"><fmt:message key="registro.apellidos" bundle="${lang}"/></label>
                                    <div class="valid-feedback">
                                        <fmt:message key="registro.apeVal" bundle="${lang}"/>
                                    </div>
                                    <div class="invalid-feedback">
                                        <fmt:message key="registro.apeInval" bundle="${lang}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-calendar-day fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="date" class="form-control shadow-sm" id="inputFechaNac" placeholder="Fecha Nacimiento" required>
                                    <label for="inputFechaNac" class="text-muted"><fmt:message key="registro.fecha" bundle="${lang}"/></label>
                                    <div class="valid-feedback">
                                        <fmt:message key="registro.fecVal" bundle="${lang}"/>
                                    </div>
                                    <div class="invalid-feedback">
                                        <fmt:message key="registro.fecInval" bundle="${lang}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-id-card fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="text" class="form-control shadow-sm" id="inputDNI" placeholder="DNI/NIF" maxlength="9" required>
                                    <label for="inputDNI" class="text-muted"><fmt:message key="registro.DNI" bundle="${lang}"/></label>
                                        <div class="valid-feedback">
                                            <fmt:message key="registro.DNIVal" bundle="${lang}"/>
                                        </div>
                                        <div id="invalidDNI" class="invalid-feedback">
                                            <fmt:message key="registro.DNIInval" bundle="${lang}"/>
                                        </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-at fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="email" class="form-control shadow-sm" id="inputEmail" placeholder="name@example.com" required>
                                    <label for="inputEmail" class="text-muted"><fmt:message key="registro.correo" bundle="${lang}"/></label>
                                    <div class="valid-feedback">
                                        <fmt:message key="registro.corrVal" bundle="${lang}"/>
                                    </div>
                                    <div id="invalidEmail" class="invalid-feedback">
                                        <fmt:message key="registro.corrInval" bundle="${lang}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-lock-alt fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3 input-group">
                                    <input style="height: 50px;" type="password" class="form-control shadow-sm" id="inputPassword" placeholder="Password" required>
                                    <button style="height: 50px;" id="show_password2" class="btn btn-outline-success rounded-end shadow-sm" type="button"> <span class="fa fa-eye-slash icon"></span> </button>
                                    <label for="inputPassword" class="text-muted"><fmt:message key="registro.contra" bundle="${lang}"/></label>
                                    <div class="valid-feedback">
                                        <fmt:message key="registro.conVal" bundle="${lang}"/>
                                    </div>
                                    <div class="invalid-feedback">
                                        <!--Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character-->
                                        <fmt:message key="registro.conInval" bundle="${lang}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-lock-alt fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3 input-group">
                                    <input style="height: 50px;" type="password" class="form-control shadow-sm" id="inputPassword2" placeholder="Password" required>
                                    <button style="height: 50px;" id="show_password3" class="btn btn-outline-success rounded-end shadow-sm" type="button"> <span class="fa fa-eye-slash icon2"></span> </button>
                                    <label for="inputPassword2" class="text-muted"><fmt:message key="registro.contra2" bundle="${lang}"/></label>
                                    <div class="valid-feedback">
                                        <fmt:message key="registro.con2Val" bundle="${lang}"/>
                                    </div>
                                    <div class="invalid-feedback">
                                        <fmt:message key="registro.con2Inval" bundle="${lang}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center"> 
                            <div class="col-8 offset-2">
                                <div class="form-check form-switch">
                                    <input class="form-check-input shadow-sm" type="checkbox" id="checkAcepto" required>
                                    <label class="form-check-label" for="checkAceptoTerminos"><fmt:message key="registro.terminos" bundle="${lang}"/></label>
                                </div>
                            </div>
                        </div>
                        <hr class="bg-sucess" style="color: green; height: 4px;">
                        <div class="row justify-content-center offset-1">
                            <div class="col">
                                <a href="principal.jsp" class="btn btn-outline-dark shadow"><fmt:message key="btn.volver" bundle="${lang}"/></a>
                            </div>
                            <div class="col">
                                <button type="reset" class="btn btn-outline-success shadow"><fmt:message key="btn.reiniciar" bundle="${lang}"/></button>
                            </div>
                            <div class="col">
                                <button id="btnRegistro" type="submit" class="btn btn-success shadow"><fmt:message key="registro.btn" bundle="${lang}"/></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>






        <script 
            src="js/jquery-3.5.1.min.js"
        ></script>
        <!--<script 
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" 
            crossorigin="anonymous"
        ></script>-->
        <script 
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
            crossorigin="anonymous"
        ></script>

        <script src="js/font-awesome5.js"></script>
        <script src="js/activadores.js"></script>
        <script src="js/validacionRegistro.js"></script>
        <script src="http://momentjs.com/downloads/moment.min.js"></script>;
    </body>
</html>

<!-- <hr class="featurette-divider offset-1 w-75">
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
                            </div>-->
