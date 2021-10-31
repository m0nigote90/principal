<%-- 
    Document   : Registro
    Created on : 03-oct-2021, 15:06:57
    Author     : Pedro
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--<link 
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" 
            rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" 
            crossorigin="anonymous"
            >-->
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
            button{
                box-shadow: 1px 2px 3px grey, -1px -2px 3px grey;

            }
            input{
                box-shadow: 1px 2px 5px grey;
            }
        </style>
        <script src="js/jquery-3.5.1.min.js"></script>
    </head>

    <body>

        <div class="row p-0" style="border: solid 1px blue;">
            <div class="col-12 col-sm-10 offset-sm-1 col-md-10 col-lg-8 col-xl-6 offset-xl-3" style="border: solid 1px red;">
                <div class="container-fluid bg-light py-4 mt-5 rounded-3 shadow" style="border: solid 1px green;">
                    <hr class="">
                    <div class="row offset-2">
                        <div class="col-1">
                            <img src="img/logoLtrans.png" alt="logoEmpresa"width="100">
                        </div>
                        <div class="col-8 text-center">
                            <p class="display-4">Registro</p>
                        </div>
                    </div>
                    <hr class="">
                    <form class="needs-validation" novalidate>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-user fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="text" class="form-control" id="inputNombre" placeholder="Nombre" required>
                                    <label for="inputNombre" class="text-muted">Nombre</label>
                                    <div class="valid-feedback">
                                        Nombre correcto.
                                    </div>
                                    <div class="invalid-feedback">
                                        No se permiten caracteres especiales ni números.
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
                                    <input style="height: 50px;" type="text" class="form-control" id="inputApellidos" placeholder="Apellidos" required>
                                    <label for="inputApellidos" class="text-muted">Apellidos</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-calendar-day fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="date" class="form-control text-muted" id="inputFechaNac" placeholder="Fecha Nacimiento" required>
                                    <label for="inputFechaNac" class="text-muted">Fecha Nacimiento</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-id-card fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="text" class="form-control" id="inputDNI" placeholder="DNI/NIF" maxlength="9" required>
                                    <label for="inputDNI" class="text-muted">DNI/NIF</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-at fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="email" class="form-control" id="inputEmail" placeholder="name@example.com" required>
                                    <label for="inputEmail" class="text-muted">Email</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <i class="fad fa-lock-alt fa-2x mt-3"></i>
                            </div>
                            <div class="col-10">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="password" class="form-control" id="inputPassword" placeholder="Password" required>
                                    <label for="inputPassword" class="text-muted">Contraseña</label>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center"> 
                            <div class="col-8 offset-2">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="checkAceptoTerminos" required>
                                    <label class="form-check-label" for="checkAceptoTerminos">Acepto los términos y condiciones</label>
                                </div>
                            </div>
                        </div>
                        <hr class="bg-sucess" style="color: green; height: 4px;">
                        <div class="row justify-content-center offset-1">
                            <div class="col">
                                <button type="" class="btn btn-outline-dark">Volver</button>
                            </div>
                            <div class="col">
                                <button type="reset" class="btn btn-outline-success">Reset</button>
                            </div>
                            <div class="col">
                                <button id="btnRegistro" type="submit" class="btn btn-success">Registro</button>
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
