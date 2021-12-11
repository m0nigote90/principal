<%-- 
    Document   : producto2
    Created on : 28-nov-2021, 18:50:44
    Author     : Pedro
--%>


<%@page import="java.util.Locale"%>
<%@page import="modelo.entidades.Planta"%>
<%@page import="modelo.Funcionalidad"%>
<%@page import="java.util.List"%>
<%@page import="modelo.entidades.Articulo"%>
<%@page import="modelo.dao.ArticuloJpaController"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="modelo.dao.PlantaJpaController"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-15"%>



<c:if test="${empty articuloDetalle}">
    <c:redirect url="principal.jsp"/>
</c:if>
<c:if test="${!empty articuloDetalle}">
    <c:set var="ar" value="${articuloDetalle}"/>
</c:if>
<!DOCTYPE html>


<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link 
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
            rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
            crossorigin="anonymous"
            >
        <link rel="icon" type="image/png" href="img/icono.png">
        <title>Eleplant</title>
        <style>
            /* Necesito modificarle el z-index porque el fade-modal quedaba por detrás de la cabecera con .sticky */
            #cabecera {
                z-index: 1050;
            }
            .dropdown-item:hover, .dropdown-item:focus {

                color: white;
                background-color: #007C50;
                /*background-color: #005235;*/
            }

            .nav-item {
                color: #005235;
                font-size: 1.2em; 
                font-weight: 500;
            }
            .fa-stack { font-size: 1.4em; }

            .fa-stack b{
                font-size: 15px;
                vertical-align: baseline;
            }
            #form {
                width: 250px;
                margin: 0 0;
                height: 50px;
            }

            #form p {
                text-align: left;
            }

            #form label {
                font-size: 40px;
                cursor: pointer;
            }

            input[type="radio"] {
                display: none;
            }

            label {
                color: grey;
            }

            .clasificacion {
                direction: rtl;
                unicode-bidi: bidi-override;
            }

            label:hover,
            label:hover ~ label {
                color: green;
                text-shadow: 1px 1px 1px grey;
            }

            input[type="radio"]:checked ~ label {
                color: orange;
            }
            .btn-success, .btn-outline-success:hover{
                background: linear-gradient(180deg, rgba(0,82,53,0.7) 0%, rgba(0,82,53,0.8368813736432073) 35%, rgba(0,82,53,1) 100%);
                color: white;
            }
        </style>
        <!-- Recogemos y definimos la variable locale del navegador del usuario por defecto, si escoge otro idioma, cargamos ese locale -->
        <%--<c:if test="${param.locale!=null}">
            <fmt:setLocale value="${param.locale}" scope="session" />
            <c:set var="varLocale" value="${param.locale}" scope="session" />--%>
        <%--<input id="localeActual" type="hidden" value="${param.locale}">--%>
        <%--<input id="localeActual" type="hidden" value="${varLocale}">
    </c:if>
    <c:if test="${param.locale==null}">
        <c:set var="varLocale" value="${pageContext.request.locale}" scope="session" />
        <fmt:setLocale value="${varLocale}" scope="application"/>
        <input id="localeActual" type="hidden" value="${varLocale}">
    </c:if>
    <fmt:setBundle basename="idioma" var="lang" scope="application"/>
    <fmt:requestEncoding value="ISO-8859-1" />--%>
        <input id="localeActual" type="hidden" value="${varLocale}">
    </head>
    <body ondragstart="return false">
        <!-- Con Bootstrap 5.1.3 debemos colocar los modales en lo más alto del body para que funcionen sin interferencias con otros elementos -->
        <!-- Modal Login -->
        <div class="modal fade" id="modalLogin" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">

            <div class="modal-dialog">
                <div class="modal-content border border-success rounded-3">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Login</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div>
                        <form class="form needs-validation" novalidate>
                            <div class="modal-body">
                                <div class="form-floating mb-3">
                                    <input style="height: 50px;" type="email" class="form-control inputLogin" id="inputEmail" placeholder="name@example.com" required>
                                    <label for="inputEmail" class="text-muted"><i class="fad fa-at me-2"></i><fmt:message key="login.correo" bundle="${lang}"/></label>
                                    <div id="invalidEmail" class="invalid-feedback">
                                        <fmt:message key="login.correoInval" bundle="${lang}"/>
                                    </div>
                                    <div id="invalidEmail2" class="invalid-feedback">
                                        <fmt:message key="login.correoVacio" bundle="${lang}"/>
                                    </div>
                                </div>    

                                <div class="form-floating mb-3 input-group">
                                    <input style="height: 50px;" type="password" class="form-control inputLogin" id="inputPassword" placeholder="Password" required>
                                    <button style="height: 50px;" id="show_password" class="btn btn-outline-success rounded-end" type="button"> <span class="fa fa-eye-slash icon"></span> </button>
                                    <label for="inputPassword" class="text-muted"><i class="fad fa-unlock-alt me-2"></i><fmt:message key="login.password" bundle="${lang}"/></label>
                                    <div id="contraInval" class="invalid-feedback">
                                        <fmt:message key="login.contraInval" bundle="${lang}"/>
                                    </div>
                                    <div id="contraInval2" class="invalid-feedback">
                                        <fmt:message key="login.contraVacia" bundle="${lang}"/>
                                    </div>
                                </div>

                                <div class="">
                                    <p id="mensajeLogin" class="text-center mb-0" style="display: none;"><fmt:message key="login.mensaje" bundle="${lang}"/></p>
                                    <p id="mensajeErrorLogin" class="text-center mb-0" style="display: none;"><fmt:message key="login.mensajeError" bundle="${lang}"/></p>
                                    <p id="cuentaAtrasLogin" class="text-center text-muted" style="display: none;"><fmt:message key="login.cuentaAtras" bundle="${lang}"/> <span id="numCuentaAtras"></span></p>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" name="btnCerrarLogin" id="btnCerrarLogin" class="btn btn-outline-dark" data-bs-dismiss="modal"><fmt:message key="cerrar" bundle="${lang}"/></button>
                                <button type="submit" name="btnLogin" id="btnLogin" class="btn btn-success"><fmt:message key="acceder" bundle="${lang}"/></button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <header class="sticky-top shadow-lg cabecera" id="cabecera">
            <nav class="navbar navbar-expand-lg navbar-light bg-light fs-6">
                <div class="container-fluid ms-4 align-items-end" style="position: relative;">
                    <a class="navbar-brand" href="principal.jsp"><img src="img/logoLtrans.png" alt="logoEmpresa"
                                                                      width="100"></a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false"
                            aria-label="Toggle navigation">
                        <!-- <span class="navbar-toggler-icon"></span> -->
                        <i id="btnHomeColapse" class="fad fa-home-lg fa-2x" style='color: #005235;'></i>
                    </button>
                    <!-- El justify-content-between nos separa el formulario de búsqueda a la derecha de lo demás -->
                    <div class="collapse navbar-collapse justify-content-between" id="navbarNavAltMarkup">
                        <ul class="nav navbar-nav">
                            <c:if test="${empty usuario}">
                                <li>
                                    <!-- visually-hidden (BootStrap 5.0) es el antiguo sr-only para lectores de pantalla 
                                    También agregamos el nav-item y nav-link para que se vean bien-->
                                    <a class="nav-item nav-link" href="#" data-bs-toggle="modal"
                                       data-bs-target="#modalLogin" style="color: #005235;"><i style="font-size: 1.5em;" class="fad fa-sign-in-alt"></i> <fmt:message key="acceder" bundle="${lang}"/><span class="visually-hidden">(Acceder)</span></a>
                                </li>
                                <li>
                                    <a class="nav-item nav-link" href="registro.jsp" style="color: #005235;"><i style="font-size: 1.5em;" class="fad fa-clipboard-list-check"></i> <fmt:message key="registro" bundle="${lang}"/></a>
                                </li>
                            </c:if>
                            <c:if test="${not empty usuario}">
                                <c:if test="${usuario.esAdmin()}">
                                    <li class="dropdown">
                                        <a href="" class="dropdown-toggle nav-item nav-link fw-bold" data-bs-toggle="dropdown"
                                           role="button" aria-expanded="false" style="color: #005235;"><i style="font-size: 1.5em;" class="fad fa-users-cog"></i> <fmt:message key="admin" bundle="${lang}"/></a>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="admin/gestion.jsp" class="dropdown-item"><i class="fad fa-sliders-v me-2"></i> <fmt:message key="gestionTienda" bundle="${lang}"/>
                                                </a></li>
                                            <li><a href="CerrarSesion" class="dropdown-item"><i class="fad fa-sign-out me-2"></i> <fmt:message key="cerrarSesion" bundle="${lang}"/></a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li></li>
                                    </c:if>
                                    <c:if test="${!usuario.esAdmin()}">
                                    <li class="dropdown">
                                        <a href="" class="dropdown-toggle nav-item nav-link fw-bold" data-bs-toggle="dropdown"
                                           role="button" aria-expanded="false" style="color: #005235;"><i style="font-size: 1.5em;" class="fad fa-user-circle"></i></i> 
                                            <c:out value="${usuario.nombre}"></c:out> <c:out value="${usuario.apellidos.charAt(0)}"></c:out>.
                                            </a>
                                            <ul class="dropdown-menu" role="menu">
                                                    <li><a href="misPedidos.jsp" class="dropdown-item"><i class="fad fa-bags-shopping me-2"></i> <fmt:message key="usuario.mispedidos" bundle="${lang}"/></a></li>
                                            <li><a href="#" class="dropdown-item"><i class="fad fa-sliders-v me-2"></i> <fmt:message key="configuracion" bundle="${lang}"/></a></li>
                                            <li><a href="#" class="dropdown-item"><i class="fad fa-user me-2"></i> <fmt:message key="editarPerfil" bundle="${lang}"/></a></li>
                                            <li><a href="CerrarSesion" class="dropdown-item"><i class="fad fa-sign-out me-2"></i> <fmt:message key="cerrarSesion" bundle="${lang}"/></a>
                                            </li>
                                        </ul>
                                    </li>
                                </c:if>
                            </c:if>
                            <!-- Probamos el dropdown-toggle -->
                            <li class="dropdown">
                                <a href="#" class="nav item nav-link dropdown-toggle" data-bs-toggle="dropdown"
                                   role="button" aria-haspopup="true" aria-expanded="false" style="font-size: 1.2em; font-weight: 500;color: #005235;"><i style="font-size: 1.5em;" class="fad fa-store-alt"></i> <fmt:message key="tienda" bundle="${lang}"/></a>
                                <ul class="dropdown-menu">
                                    <!-- Imprescindible agregar dropdown-item para correcta visualización -->
                                    <li><a class="dropdown-item" href="#" id="btnTodos"><i class="fad fa-globe me-2"></i>  <fmt:message key="todos" bundle="${lang}"/></a></li>
                                    <li><a class="dropdown-item" href="#" id="btnPlantas"><i class="fad fa-flower-daffodil me-2"></i>  <fmt:message key="plantas" bundle="${lang}"/></a></li>
                                    <li><a class="dropdown-item" href="#" id="btnAbonos"><i class="fad fa-jug me-2"></i>  <fmt:message key="abonos" bundle="${lang}"/></a></li>
                                    <li><a class="dropdown-item" href="#" id="btnMacetas"><i class="fad fa-chimney me-2"></i>  <fmt:message key="macetas" bundle="${lang}"/></a></li>
                                    <li><a class="dropdown-item" href="#"><i class="fad fa-bug me-2"></i> <fmt:message key="insecticidas" bundle="${lang}"/></a></li>
                                </ul>
                            </li>
                        </ul>
                        <!--Botones derecha cabecera-->
                        <div class="d-flex">

                            <input id="inputBuscar" class="form-control me-2 fs-ls-5 w-100" list="listadoProductosBusqueda" type="search" placeholder="<fmt:message key="buscar" bundle="${lang}"/>" aria-label="Search">
                            <button class="btn btn-outline-success" type="submit"><i class="fad fa-search"></i></button>

                            <div id="listadoProductosBusqueda" style="position: absolute; z-index: 1000;">
                                <c:import url="busquedaProductos.jsp"/>
                            </div>

                            <c:if test="${!empty usuario and !usuario.esAdmin()}">
                                <!-- BOTON DE CESTA DE COMPRA-->
                                <span id="btnCesta" class="fa-stack ms-4 me-3" data-bs-target="#offcanvasCesta" data-bs-toggle="offcanvas" 
                                      aria-controls="offcanvasCesta" style="cursor: pointer; color: rgb(2, 77, 2);">

                                    <!-- The icon that will wrap the number -->
                                    <i class="fal fa-shopping-bag fa-stack-2x">

                                    </i>
                                    <!-- a strong element with the custom content, in this case a number -->
                                    <b id="numArtCesta" class="fa-stack-1x ms-1 btnNumArt">

                                        <c:if test="${usuario.getArticulos() != null}">
                                            <c:out value="${usuario.getArticulos().size()}"/>  
                                        </c:if>

                                    </b>
                                </span>

                            </c:if>
                            </form>
                        </div>
                    </div>
            </nav>
        </header>
        <!-- Offcanvas derecho para la CESTA-->
        <div class="offcanvas offcanvas-end" data-bs-scroll="false" data-bs-backdrop="true" tabindex="-1" id="offcanvasCesta" aria-labelledby="offcanvasCestaLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasCestaLabel"><fmt:message key="cesta" bundle="${lang}"/></h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <c:if test="${usuario.getArticulos().size()==0 or usuario ==  null}">  
                <div class="offcanvas-body text-center">
                    <img style="width: 300px;" src="img/cestaTriste.png" alt="cestaTriste.png">
                    <h5 class="display-6 text-center"><fmt:message key="cestaVacia" bundle="${lang}"/></h5>
                </div>
            </c:if>
            <c:if test="${usuario.getArticulos().size()!=0 && usuario != null && tienda != null}">
                <div class="offcanvas-body">
                    <table class="table text-center table-sm" >
                        <thead>
                            <tr>
                                <th class="align-middle"></th>
                                <th class="align-middle" ><fmt:message key="producto" bundle="${lang}"/></th>
                                <th class="align-middle"><fmt:message key="precio" bundle="${lang}"/>/U.</th>
                                <th class="align-middle"></th>
                                <th class="align-middle"><fmt:message key="subtotal" bundle="${lang}"/></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="articulo" items="${tienda.cestaUsuarioSinRepetidos(usuario.id)}">
                                <tr id="${articulo.referencia}" style="font-size: 0.9em;">
                                    <td class="align-middle"><img src="img/articulos/${articulo.nombreImagen}" style="width: 50px;"/></td>
                                    <td class="align-middle">${articulo.nombre}</td>
                                    <td class="align-middle"><fmt:formatNumber value = "${articulo.precio}" type = "currency"/></td></td>
                                    <td class="align-middle">x${tienda.unidadesCompradas(usuario.id, articulo.referencia)} </td>
                                    <td class="align-middle"><fmt:formatNumber value = "${articulo.precio * tienda.unidadesCompradas(usuario.id, articulo.referencia)}" type = "currency"/></td>
                                    <td id="" data="${articulo.referencia}" class="btnEliArtCesta2 align-middle"><i class="fal fa-times fa-2x" style="color: red; cursor: pointer;"></i></td>
                                </tr>
                            </c:forEach>
                        <input id="numArtCestaHiden2" type="hidden" data="${usuario.getArticulos().size()}"/>
                        <input id="precioSinHiden2" type="hidden" data="${tienda.getPrecioTotal((usuario.articulos), false)}"/>
                        <input id="precioTotalHiden2" type="hidden" data="${tienda.getPrecioTotal((usuario.articulos), true)}"/>
                        </tbody>
                        <tfoot>

                        </tfoot>
                    </table>
                    <hr class="bg-sucess border-2 border-top border-sucess">
                    <div class="container">
                        <div class="row justify-content-md-center">
                            <table class="table table-bordered table-striped">
                                <tr><td><b style="color: #C88307;"><fmt:message key="subtotal" bundle="${lang}"/>:</b></td><td  id="subtotalCesta2" class="text-center"><fmt:formatNumber value = "${tienda.getPrecioTotal((usuario.articulos), false)}" type="currency"/></td></tr>
                                <tr><td><b style="color: #C88307;"><fmt:message key="impuestos" bundle="${lang}"/>:</b></td><td id="impuestoCesta2" class="text-center"><fmt:formatNumber value = "${(tienda.getPrecioTotal((usuario.articulos), true)) - (tienda.getPrecioTotal((usuario.articulos), false)) }" type="currency"/></td></tr>
                                <tr><td><b style="color: #C88307;"><fmt:message key="total" bundle="${lang}"/>:</b></td><td id="totalCesta2" class="text-center"><b><fmt:formatNumber value = "${tienda.getPrecioTotal((usuario.articulos), true)}" type="currency"/></b></td></tr>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas"><fmt:message key="cerrar" bundle="${lang}"/></button>
                        <button id="btnComprarCesta" type="button" class="btn btn-warning"><fmt:message key="comprar" bundle="${lang}"/></button>
                    </div>
                </div>

            </c:if>
        </div>

        <!----------------------------------------------------------------------------------------------------------------------------->
        <!-- Section detalles producto -->
        <section class="container-fluid my-5">
            <div class="row offset-lg-1">
                <div class="col-sm-12 p-4 col-lg-5 rounded-3" style="">
                    <img class="img-fluid img-thumbnail mx-auto" src="img/articulos/${ar.getNombreImagen()}" alt="imgArt" style="width: 500px; box-shadow: 1px 1px 5px gray;">
                </div>
                <div class="col-sm-12 p-4 col-lg-5 rounded-3" style="">
                    <div class="d-flex justify-content-between align-items-end">
                        <span class="display-4 fw-bold" style="color: #005235;">${ar.getNombre()} <span class="display-6 mt-0 pt-0" style="text-transform: capitalize;">(${ar.tipo})</span></span>
                        <i class="fad fa-share-alt fa-2x" title="<fmt:message key="misPedidos.tooltip.compartir" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right" style="color: #005235; cursor:pointer;"></i>
                    </div>

                    <span class="fs-4">${ar.getFabricante()}</span><br>
                    <form id="form">
                        <p class="clasificacion">
                            <input id="radio1" type="radio" name="estrellas" value="5">
                            <label for="radio1">&#9733;</label>
                            <input id="radio2" type="radio" name="estrellas" value="4">
                            <label for="radio2">&#9733;</label>
                            <input id="radio3" type="radio" name="estrellas" value="3">
                            <label for="radio3">&#9733;</label>
                            <input id="radio4" type="radio" name="estrellas" value="2">
                            <label for="radio4">&#9733;</label>
                            <input id="radio5" type="radio" name="estrellas" value="1">
                            <label for="radio5">&#9733;</label>
                        </p>
                    </form>
                    <label class="form-label mt-2" style="font-size: 1.4em; font-weight: bold; color: green;"><fmt:message key="producto.descripcion" bundle="${lang}"/>:</label>
                    <p class="border border-2 border-success p-2 overflow-auto" style="font-size: 1.2em; height: 200px; box-shadow: 1px 1px 5px gray;">${ar.getDescripcion()}</p>


                    <div class="d-flex justify-content-between align-items-end mb-2">
                        <span class="ms-2 text-muted"><fmt:message key="producto.precio" bundle="${lang}"/>: <fmt:formatNumber value = "${ar.precioSinIVA}" type = "currency"/> + <fmt:message key="producto.impuestos" bundle="${lang}"/> (${ar.tipoIVA}%): <fmt:formatNumber value = "${ar.precio - ar.precioSinIVA}" type = "currency"/> </span>
                        <span class="text-muted">Stock: ${tienda.filtrarArticulosReferencia(ar.referencia).size()}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-end">
                        <span class="ms-2" style="font-size: 1.5em;"> 
                            <fmt:message key="producto.pvp" bundle="${lang}"/>: <fmt:formatNumber value = "${ar.precio}" type = "currency"/>
                        </span>
                        <c:if test="${!empty tienda.filtrarArticulosReferencia(ar.referencia)}">
                            <a id="${ar.referencia}" style="width: 150px;box-shadow: 1px 1px 5px gray;" class="btn btn-success btnComprar <c:if test="${usuario.esAdmin() or empty usuario}">disabled</c:if>"><fmt:message key="anadir" bundle="${lang}"/></a> 
                        </c:if>
                        <c:if test="${empty tienda.filtrarArticulosReferencia(ar.referencia)}">
                            <a class="btn btn-outline-danger disabled border border-3 border-danger"  style="color: red; font-weight: 600; width: 150px;"><fmt:message key="agotado" bundle="${lang}"/></a>
                        </c:if>
                    </div>

                </div>
            </div>


        </section>



        <!-- Separación -->
        <div style="height: 50px;"></div> <!-- Div vacio de separación con el footer fixed -->
        <!-- Footer -->
        <footer class="bg-light text-success text-center text-lg-start">
            <!-- Grid container -->
            <div class="container p-4">
                <!--Grid row-->
                <div class="row">
                    <!--Grid column-->
                    <div class="col-lg-6 col-md-12 mb-4 mb-md-0">
                        <h5 class="text-uppercase"><fmt:message key="principal.footer.quien" bundle="${lang}"/></h5>

                        <p>
                            <fmt:message key="principal.footer.quienDes" bundle="${lang}"/>
                        </p>
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-uppercase"><fmt:message key="principal.footer.enlaces" bundle="${lang}"/></h5>

                        <ul class="list-unstyled mb-0">
                            <li>
                                <a href="#!" class="text-dark"><fmt:message key="principal.footer.metodosPago" bundle="${lang}"/></a>
                            </li>
                            <li>
                                <a href="#!" class="text-dark"><fmt:message key="principal.footer.garantia" bundle="${lang}"/></a>
                            </li>
                            <li class="">
                                <a href="#"><i class="fab fa-twitter-square fa-2x" style="color: rgb(30, 226, 251);"></i></a>
                                <a href="#"><i class="fab fa-facebook-square fa-2x"></i></a>
                                <a href="#"><i class="fab fa-instagram-square fa-2x" style="color: rgb(220, 20, 147);"></i></a>
                                <a href="#"><i class="fab fa-tumblr-square fa-2x" style="color: darkblue;"></i></a>
                                <a href="#"><i class="fas fa-rss-square fa-2x" style="color: orange;"></i></a>
                            </li>
                        </ul>
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-lg-3 col-md-6 mb-2">
                        <h5 class="text-uppercase mb-0"><fmt:message key="principal.footer.contacto" bundle="${lang}"/></h5>

                        <ul class="list-unstyled">
                            <li>
                                <a href="#!" class="text-dark"><fmt:message key="principal.footer.formContacto" bundle="${lang}"/></a>
                            </li>
                            <li class="mb-3">
                                <a href="#!" class="text-dark"><fmt:message key="principal.footer.localizacion" bundle="${lang}"/></a>

                            </li>
                            <li>
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3169.3631504678724!2d-6.040672584652257!3d37.40489054112651!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd126b64a210c061%3A0xfc39137313475fad!2sIES%20Camas%20-%20Antonio%20Brisquet!5e0!3m2!1ses!2ses!4v1632659630391!5m2!1ses!2ses" 
                                        width="300" height="225" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                            </li>
                        </ul>
                    </div>
                    <!--Grid column-->
                </div>
                <!--Grid row-->
            </div>
            <!-- Grid container -->

            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
                © 2021 Copyright:
                <a class="text-white" href="index.jsp">Eleplant.com</a>
            </div>
            <!-- Copyright -->
        </footer>

        <script src="js/jquery-3.5.1.min.js"></script>
        <script src="js/activadores.js"></script>
        <script 
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
            crossorigin="anonymous"
        ></script>
        <script src="js/font-awesome5.js" type="text/javascript"></script>

    </body>
</html>


