<%-- 
    Document   : index
    Created on : 28-sep-2021, 18:54:25
    Author     : Pedro
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<c:set var="locale" value="${pageContext.response.locale}" scope="application" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/png" href="img/icono.png">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">

        <style>
            /* Necesito modificarle el z-index porque el fade-modal quedaba por detr�s de la cabecera con .sticky */
            #cabecera {
                z-index: 1050;
            }
            #letreroPulsa{ 
                z-index: 2000;
                text-shadow: 2px 2px 5px rgb(0, 2, 0); 
                font-size: 1.4em;}

        </style>
        <c:set var="varLocale" value="${pageContext.request.locale}" scope="session" />
        <title>Eleplant</title>
    </head>
    <body>
        
        <header class="sticky-top shadow-sm" id="cabecera">
            <nav class="navbar navbar-expand-lg navbar-light bg-light fs-6">
                <div class="container-fluid ms-4 align-items-end" id="cabecera">
                    <a class="navbar-brand d-md-none" href="principal.jsp"><img src="img/logoLtrans.png" alt="logoEmpresa" width="100" style="cursor: pointer;"></a>
                    <img class="d-none d-md-block mx-5" src="img/banner.png" alt="banner" style="height: 120px;">
                </div>
            </nav>

        </header>
        <div class="row-4 align-items-center my-5 col-8 offset-2 d-flex justify-content-center position-absolute top-25" id="letreroPulsa">
            <a href="principal.jsp" style="text-decoration: none; color: black;">PULSE PARA ENTRAR</a>
        </div>
        <!-- Carrusel -->
        <section class="wrap">
            <div id="carouselExampleDark" class="carousel carousel-dark slide carousel-fade" data-bs-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active"></li>
                    <li data-bs-target="#carouselExampleDark" data-bs-slide-to="1"></li>
                    <li data-bs-target="#carouselExampleDark" data-bs-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active position-relative" data-bs-interval="4000">
                        <a href="principal.jsp" data-bs-toggle="tooltip" data-bs-placement="top"
                           title="CLICK PARA ENTRAR"><img src="img/carrusel4.jpg" class="d-block w-100" alt="..."></a>

                        <div class="carousel-caption d-none d-md-block">
                            <h5>Suculentas</h5>
                            <p>Plantas de interior para todos los estilos</p>
                        </div>
                    </div>
                    <div class="carousel-item" data-bs-interval="4000">

                        <a href="principal.jsp"><img src="img/carrusel5.jpg" class="d-block w-100" alt="...">
                            <div class="carousel-caption d-none d-md-block">
                                <h5>Cactus</h5>
                                <p>Dale un toque de color</p>
                            </div>
                    </div>
                    <div class="carousel-item">
                        <a href="principal.jsp"><img src="img/carrusel6.jpeg" class="d-block w-100" alt="..."></a>
                        <div class="carousel-caption d-none d-md-block">
                            <h5>Monstera Deliciosa</h5>
                            <p>El mejor dise�o minimalista para tu hogar</p>
                        </div>
                    </div>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleDark" role="button" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleDark" role="button" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </a>
            </div>
        </section>



        <!-- Alert coockies -->
        <div class="alert alert-success alert-dismissible fade show align-middle fixed-bottom shadow d-flex align-items-center justify-content-center"
             role="alert" style="height: 130px;">
            <p class="mx-5 d-none d-md-block">Este sitio utiliza <strong>cookies. </strong> Puedes aceptarlas o ver la configuraci�n de las
                mismas.</p>
            <!-- Ocultamos el texto de las cookies en resoluciones peque�as -->
            <p><button type="button" class="btn btn-outline-success shadow-sm" data-bs-toggle="button" data-bs-dismiss="alert">Aceptar Cookies <i
                        class="fad fa-cookie-bite" style="color: rgb(246, 180, 94);"></i></button>
                <button type="button" class="btn btn-outline-success shadow-sm mx-2" data-bs-toggle="button">Configuraci�n
                    <i class="fad fa-cogs"></i></button>
            </p>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>




        <script src="js/jquery-3.5.1.min.js"></script>
        <script src="js/tooltip.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/font-awesome5.js"></script>
    </body>
</html>
