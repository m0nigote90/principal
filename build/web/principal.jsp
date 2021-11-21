<%-- 
    Document   : principal
    Created on : 29-sep-2021, 10:03:37
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

<%--Si objeto tienda está vacío, llamamos al Servlet que lo genera, igualmente si ya está creado, cargamos usuarios y artículos--%>

<c:if test="${empty tienda}">
    <c:redirect url="Arranque"/>
</c:if>

<!-- Color verde oscuro style='color: #005235;-->
<!DOCTYPE html>


<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
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
            /* Necesito modificarle el z-index porque el fade-modal quedaba por detrás de la cabecera con .sticky */
            #cabecera {
                z-index: 1050;
            }
            /*#portafolio img:hover{
                cursor: pointer;
                transition-duration: 0.8s;
                transform: scale(1.15);
                border: solid 1px black;
                box-shadow: 3px 3px 10px black;
                z-index: 2000;
                border-radius: 10px;

            }
            #portafolio img{
                transition-duration: 0.8s;
                transform: scale(1);
            }*/
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
        </style>
        <!-- Recogemos y definimos la variable locale del navegador del usuario por defecto, si escoge otro idioma, cargamos ese locale -->
        <c:if test="${param.locale!=null}">
            <fmt:setLocale value="${param.locale}" scope="session" />
            <c:set var="varLocale" value="${param.locale}" scope="session" />
        <%--<input id="localeActual" type="hidden" value="${param.locale}">--%>
        <input id="localeActual" type="hidden" value="${varLocale}">
    </c:if>
    <c:if test="${param.locale==null}">
        <c:set var="varLocale" value="${pageContext.request.locale}" scope="session" />
        <fmt:setLocale value="${varLocale}" scope="application"/>
        <input id="localeActual" type="hidden" value="${varLocale}">
    </c:if>
    <fmt:setBundle basename="idioma" var="lang" scope="application"/>
    <fmt:requestEncoding value="ISO-8859-1" />
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

                            <div class="form-floating mb-3">
                                <input style="height: 50px;" type="password" class="form-control inputLogin" id="inputPassword" placeholder="Password" required>
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
                         <a>Num. Pedidos del usuario: <c:out value="${usuario.nombre}"/>: <c:out value="${usuario.pedidos.size()}"/></a>
                        <%-- Esto es una lista de Prueba, BORRAR
                        <li>
                            <a>Locale: <c:out value="${varLocale}"/></a>
                            <a>Languaje: <c:out value="${varLocale.language}"/></a>
                            <a>País: <c:out value="${varLocale.country}"/></a>
                            <a>Display País: <c:out value="${varLocale.displayCountry}"/></a>
                            <a>Num. Pedidos del usuario: <c:out value="${usuario.nombre}"/>: <c:out value="${usuario.pedidos.size()}"/></a>
                        </li>
                        --%>
                    </ul>
                    <!--Botones derecha cabecera-->


                    <div class="d-flex">

                        <!--Botones de idiomas -->

                        <a id="btnENG" href="principal.jsp?locale=en_GB" title="<fmt:message key="tooltip.ingles" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                            <img id="iconoEN" class="" src="img/iconoEN.png" alt="Icono EN" width="35" height="20" style="cursor: pointer;">
                        </a>
                        <a id="btnESP" href="principal.jsp?locale=es_ES" class="me-4 ms-2" title="<fmt:message key="tooltip.espanol" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                            <img id="iconoES" class="" src="img/iconoES.png" alt="Icono ES" width="35" height="20" style="cursor: pointer;">
                        </a>
                        <input id="inputBuscar" class="form-control me-2 fs-ls-5 w-100" list="listadoProductosBusqueda" type="search" placeholder="<fmt:message key="buscar" bundle="${lang}"/>" aria-label="Search">
                        <button class="btn btn-outline-success" type="submit"><i class="fad fa-search"></i></button>
                       <%-- <datalist id="listadoProductosBusqueda">Aquí importaremos la busqueda de productos
                            <c:import url="busquedaProductos.jsp"/>
                        </datalist>--%>
                        <div id="listadoProductosBusqueda" style="position: absolute;">
                            <c:import url="busquedaProductos.jsp"/>
                        </div>
                        <%--Prueba para BORRAR
                        <details>
                            <summary>Click to get the user details</summary>
                            <table>
                                <tr>
                                    <th>Name</th>
                                    <th>Date of birth</th>
                                    <th>Job</th>
                                </tr>
                                <tr>
                                    <td>John</td>
                                    <td>March 19</td>
                                    <td>Accountant</td>
                                </tr>
                            </table>
                        </details>--%>
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

        <!-- Offcanvas derecho para la CESTA-->
        <div class="offcanvas offcanvas-end" data-bs-scroll="false" data-bs-backdrop="true" tabindex="-1" id="offcanvasCesta" aria-labelledby="offcanvasCestaLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasCestaLabel"><fmt:message key="cesta" bundle="${lang}"/></h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <c:if test="${usuario.getArticulos().size()==0 or usuario ==  null}">
                <h5 class="display-5">Cesta vacía</h5>
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
                                <tr id="${articulo.referencia}" class="" style="font-size: 0.9em;">
                                    <td class="align-middle"><img src="img/articulos/${articulo.nombreImagen}" style="width: 50px;"/></td>
                                    <td class="align-middle">${articulo.nombre}</td>
                                    <td class="align-middle"><fmt:formatNumber value = "${articulo.precio}" type = "currency"/></td></td>
                                    <td class="align-middle">x${tienda.unidadesCompradas(usuario.id, articulo.referencia)} </td>
                                    <td class="align-middle"><fmt:formatNumber value = "${articulo.precio * tienda.unidadesCompradas(usuario.id, articulo.referencia)}" type = "currency"/></td>
                                    <td id="" data="${articulo.referencia}" class="btnEliArtCesta align-middle"><i class="fal fa-times fa-2x" style="color: red; cursor: pointer;"></i></td>
                                </tr>
                            </c:forEach>
                        <input id="numArtCestaHiden" type="hidden" data="${usuario.getArticulos().size()}"/>
                        <input id="precioSinHiden" type="hidden" data="${tienda.getPrecioTotal((usuario.articulos), false)}"/>
                        <input id="precioTotalHiden" type="hidden" data="${tienda.getPrecioTotal((usuario.articulos), true)}"/>
                        </tbody>
                        <tfoot>

                        </tfoot>
                    </table>
                    <hr class="bg-sucess border-2 border-top border-sucess">
                    <div class="container">
                        <div class="row justify-content-md-center">
                            <table class="table table-bordered table-striped">
                                <tr><td><b style="color: #C88307;"><fmt:message key="subtotal" bundle="${lang}"/>:</b></td><td  id="subtotalCesta" class="text-center"><fmt:formatNumber value = "${tienda.getPrecioTotal((usuario.articulos), false)}" type="currency"/></td></tr>
                                <tr><td><b style="color: #C88307;"><fmt:message key="impuestos" bundle="${lang}"/>:</b></td><td id="impuestoCesta" class="text-center"><fmt:formatNumber value = "${(tienda.getPrecioTotal((usuario.articulos), true)) - (tienda.getPrecioTotal((usuario.articulos), false)) }" type="currency"/></td></tr>
                                <tr><td><b style="color: #C88307;"><fmt:message key="total" bundle="${lang}"/>:</b></td><td id="totalCesta" class="text-center"><b><fmt:formatNumber value = "${tienda.getPrecioTotal((usuario.articulos), true)}" type="currency"/></b></td></tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas"><fmt:message key="cerrar" bundle="${lang}"/></button>
                    <button id="btnComprarCesta" type="button" class="btn btn-warning"><fmt:message key="comprar" bundle="${lang}"/></button>
                </div>
            </c:if>
        </div>
        <!-- Navbar perteneciente al portafolio -->
        <c:if test="${isFiltroCategoria}">
            <nav class="navbar navbar-expand-lg navbar-light bg-light ps-5 shadow">
                <div class="container-fluid">
                    <c:if test="${filtroCategoria eq 'planta'}">
                        <a class="navbar-brand" style="user-select: none;"><fmt:message key="plantas" bundle="${lang}"/></a>
                    </c:if>
                    <c:if test="${filtroCategoria eq 'abono'}">
                        <a class="navbar-brand" style="user-select: none;"><fmt:message key="abonos" bundle="${lang}"/></a>
                    </c:if>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <c:if test="${filtroCategoria eq 'planta'}">
                                    <a id="btnPlaTodas" class="nav-link active" href="#" ><fmt:message key="todas" bundle="${lang}"/></a>
                                </c:if>
                                <c:if test="${filtroCategoria eq 'abono'}">
                                    <a id="btnAboTodos" class="nav-link active" href="#" ><fmt:message key="todos" bundle="${lang}"/></a>
                                </c:if>
                            </li>
                            <li class="nav-item">
                                <c:if test="${filtroCategoria eq 'planta'}">
                                    <a id="btnPlaSucu" class="nav-link active" href="#" ><fmt:message key="suculentas" bundle="${lang}"/></a>
                                </c:if>
                                <c:if test="${filtroCategoria eq 'abono'}">
                                    <a id="btnAboNatu" class="nav-link active" href="#" ><fmt:message key="naturales" bundle="${lang}"/></a>
                                </c:if>

                            </li>
                            <li class="nav-item">
                                <c:if test="${filtroCategoria eq 'planta'}">
                                    <a id="btnPlaTropi" class="nav-link active" href="#" ><fmt:message key="tropicales" bundle="${lang}"/></a>
                                </c:if>
                                <c:if test="${filtroCategoria eq 'abono'}">
                                    <a id="btnAboQuimi" class="nav-link active" href="#" ><fmt:message key="quimicos" bundle="${lang}"/></a>
                                </c:if>

                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </c:if>
    </header>



    <section id="portafolio" class="wrap">
        <div class="container col-10 my-4">
            <div class="row justify-content-center">
                <%-- 

                    Por cada tipo de artículo, creamos Card y mostramos 
                    
                --%>
                <%--PRUEBAS BORRAR<a>Filtro Categoria: <c:out value="${filtroCategoria}"/></a>
                <a>Activo filtro cat?: <c:out value="${isFiltroCategoria}"/></a>
                <c:if test="${isFiltroCategoria}"><a>Se detecta filtro</a></c:if>--%>

                <c:if test="${!empty tienda}">
                    <%--BORRAR<a>Activa TIENDA?: <c:out value="${tienda}"/></a>
                    <a>Numero articulos BD: <c:out value="${tienda.articulos.size()}"/> </a>--%>
                    <c:forEach var="articulo" items="${tienda.agruparArticulosRef()}" varStatus="status">
                        <%--Si está activado filtro de categoria, filtramos por el que se haya indicado--%>
                        <c:if test="${isFiltroCategoria and articulo.categoria eq filtroCategoria}">
                            <div id="<c:out value="${articulo.referencia}"/>" style="user-select: none;"
                                 class="<c:out value="${articulo.categoria}"/> <c:out value="${articulo.tipo}"/>
                                 col-12 col-sm-6 col-md-5 col-xl-3 d-flex d-block justify-content-center p-3">
                                <div class="card shadow-sm" style="width: 18rem;">

                                    <img src="img/articulos/<c:out value="${articulo.nombreImagen}"/>" class="card-img-top img-thumbnail" alt="...">

                                    <div class="card-body">
                                        <h5 class="card-title"><c:out value="${articulo.nombre}"/></h5>
                                        <p class="card-text"><c:out value="${articulo.descripcion}"/></p>
                                        <p class="text-muted text-end">Stock: ${tienda.filtrarArticulosReferencia(articulo.referencia).size()}</p>
                                        <div class="d-flex justify-content-between">
                                            <span class="ms-2" style="font-size: 1.5em;"> 
                                                <fmt:formatNumber value = "${articulo.precio}" type = "currency"/>
                                            </span>
                                            <c:if test="${!empty tienda.filtrarArticulosReferencia(articulo.referencia)}">
                                                <a id="${articulo.referencia}" class="btn btn-success btnComprar <c:if test="${usuario.esAdmin() or empty usuario}">disabled</c:if>"><fmt:message key="anadir" bundle="${lang}"/></a> 
                                            </c:if>
                                            <c:if test="${empty tienda.filtrarArticulosReferencia(articulo.referencia)}">
                                                <span style="color: red; font-weight: 600;"><fmt:message key="agotado" bundle="${lang}"/></span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${!isFiltroCategoria}">

                            <div id="<c:out value="${articulo.referencia}"/>" style="user-select: none;"
                                 class="<c:out value="${articulo.categoria}"/> <c:out value="${articulo.tipo}"/>
                                 col-12 col-sm-6 col-md-5 col-xl-3 d-flex d-block justify-content-center p-3">
                                <div class="card shadow-sm" style="width: 18rem;">
                                    <img src="img/articulos/<c:out value="${articulo.nombreImagen}"/>" class="card-img-top img-thumbnail" alt="..." width="200">
                                    <div class="card-body">
                                        <h5 class="card-title"><c:out value="${articulo.nombre}"/></h5>
                                        <p class="card-text"><c:out value="${articulo.descripcion}"/></p>
                                        <p class="text-muted text-end">Stock: ${tienda.filtrarArticulosReferencia(articulo.referencia).size()}</p>
                                        <div class="d-flex justify-content-between align-items-end">
                                            <span class="ms-2" style="font-size: 1.5em;"> 
                                                <fmt:formatNumber value = "${articulo.precio}" type = "currency"/>
                                            </span>
                                            <c:if test="${!empty tienda.filtrarArticulosReferencia(articulo.referencia)}">
                                                <a id="${articulo.referencia}" class="btn btn-success btnComprar <c:if test="${usuario.esAdmin() or empty usuario}">disabled</c:if>"><fmt:message key="anadir" bundle="${lang}"/></a> 
                                            </c:if>
                                            <c:if test="${empty tienda.filtrarArticulosReferencia(articulo.referencia)}">
                                                <span style="color: red; font-weight: 600;"><fmt:message key="agotado" bundle="${lang}"/></span>
                                            </c:if>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:if> <%--Este es el if de si hay tienda--%>


                <%-- Aqui solo es de prueba, lo antiguo--%>
                <%-- <div id="card1"
                      class="echeverria col-12 col-sm-6 col-md-5 col-xl-3 d-flex d-block justify-content-center p-3">
                     <div class="card" style="width: 18rem;">
                         <img src="img/articulos/plant1.jpg" class="card-img-top" alt="...">
                         <div class="card-body">
                             <h5 class="card-title">Sansilviera</h5>
                             <p class="card-text">La Sansevieria Trifasciata Fire es una de las más deseadas y
                                 exclusivas de su familia, por sus hojas hipnóticas que parecen fuego. Una planta única
                                 que también es
                                 conocida como llama de oro, lengua de tigre o planta de serpiente.</p>
                             <a href="#" class="btn btn-success me-5">Comprar</a> <span style="font-size: 1.5em;">23.00
                             </span><i class="fad fa-euro-sign" style="color: rgb(2, 1, 0);"></i>
                         </div>

                        </div>
                    </div>
                    <div class="echeverria col-12 col-sm-6 col-md-5 col-xl-3 d-flex d-block justify-content-center p-3">
                        <div class="card" style="width: 18rem;">
                            <img src="img/plants/plant2.jpg" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title">Little Mercury</h5>
                                <p class="card-text">Mercury es todo un espectáculo con el movimiento hacia arriba y abajo
                                    de sus hojas durante el día.
                                    El contraste de color y las vetas de la Maranta Leuconeura le da un toque retro único.
                                    Purifica el aire, querrás tenerla cerca. </p>
                                <a href="#" class="btn btn-success me-5">Comprar</a> <span style="font-size: 1.5em;">21.50
                                </span><i class="fad fa-euro-sign" style="color: rgb(2, 1, 0);"></i>
                            </div>

                        </div>
                    </div>
                    <div class="echeverria col-12 col-sm-6 col-md-5 col-xl-3 d-flex d-block justify-content-center p-3">
                        <div class="card" style="width: 18rem;">
                            <img src="img/plants/plant3.jpg" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title">Anturio Rojo</h5>
                                <p class="card-text">Para las personas que quieren sorprender de verdad: regala una planta.
                                    A tu novio, a tu mujer, a tu madre, a tu amiga o a ti misma. Es conocida por su ardiente
                                    color rojo y la forma de corazón de sus brácteas que te enamorarán. </p>
                                <a href="#" class="btn btn-success me-5">Comprar</a> <span style="font-size: 1.5em;">14.99
                                </span><i class="fad fa-euro-sign" style="color: rgb(2, 1, 0);"></i>
                            </div>
                            <!-- <ul class="list-group list-group-flush">
                            <li class="list-group-item">An item</li>
                            <li class="list-group-item">A second item</li>
                        </ul> -->
                        </div>
                    </div>
                    <div class="suculenta col-12 col-sm-6 col-md-5 col-xl-3 d-flex d-block justify-content-center p-3">
                        <div class="card" style="width: 18rem;">
                            <img src="img/plants/plant4.jpg" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title">Cactus Catedral</h5>
                                <p class="card-text">Parece un cactus pero es una suculenta. Adora los climas cálidos y
                                    crece con un tronco vertical de tres o cuatro tallos suculentos en forma de candelabro.
                                    Sus hojas parecen espátulas y están unidas a los tallos por una espina.
                                </p>
                                <a href="#" class="btn btn-success me-5">Comprar</a> <span style="font-size: 1.5em;">18.00
                                </span><i class="fad fa-euro-sign" style="color: rgb(2, 1, 0);"></i>
                            </div>
                            <!-- <ul class="list-group list-group-flush">
                            <li class="list-group-item">An item</li>
                            <li class="list-group-item">A second item</li>
                        </ul> -->
                        </div>
                    </div>
                    <div class="suculenta col-12 col-sm-6 col-md-5 col-xl-3 d-flex d-block justify-content-center p-3">
                        <div class="card" style="width: 18rem;">
                            <img src="img/plants/plant5.jpg" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title">Ficus Elástica Abidjan</h5>
                                <p class="card-text">De hojas grandes y brillantes de un color verde oscuro muy elegante, el
                                    Ficus Elastica Abidjan, conocido como Higuera o Árbol de Caucho, necesita poco
                                    mantenimiento y duradera. Gala es una planta purificadora del aire.</p>
                                <a href="#" class="btn btn-success me-5">Comprar</a> <span style="font-size: 1.5em;">17.99
                                </span><i class="fad fa-euro-sign" style="color: rgb(2, 1, 0);"></i>
                            </div>

                        </div>
                    </div>
                    <div class="echeverria col-12 col-sm-6 col-md-5 col-xl-3 d-flex d-block justify-content-center p-3">
                        <div class="card" style="width: 18rem;">
                            <img src="img/plants/plant6.jpg" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title">Monstera Deliciosa</h5>
                                <p class="card-text">Mercury es todo un espectáculo con el movimiento hacia arriba y abajo
                                    de sus hojas durante el día.
                                    El contraste de color y las vetas de la Maranta Leuconeura le da un toque retro único.
                                    Purifica el aire, querrás tenerla cerca.</p>
                                <a href="#" class="btn btn-success me-5">Comprar</a> <span style="font-size: 1.5em;">24.99
                                </span><i class="fad fa-euro-sign" style="color: rgb(2, 1, 0);"></i>
                            </div>

                        </div>
                    </div>
                    <div class="suculenta col-12 col-sm-6 col-md-5 col-xl-3 d-flex d-block justify-content-center p-3">
                        <div class="card" style="width: 18rem;">
                            <img src="img/plants/plant7.jpg" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title">Árbol del dinero</h5>
                                <p class="card-text">Ella es Pamela. Pachira Aquatica, Castaño de agua o Árbol del dinero,
                                    Pamela es un arbolito de grandes hojas verdes, palmeadas y brillantes.
                                    Su original tronco enrollado como una trenza le da un aspecto rústico y un gran valor
                                    ornamental. </p>
                                <a href="#" class="btn btn-success me-5">Comprar</a> <span style="font-size: 1.5em;">22.50
                                </span><i class="fad fa-euro-sign" style="color: rgb(2, 1, 0);"></i>
                            </div>
                            <!-- <ul class="list-group list-group-flush">
                            <li class="list-group-item">An item</li>
                            <li class="list-group-item">A second item</li>
                        </ul> -->
                        </div>
                    </div>
                    <div class="suculenta col-12 col-sm-6 col-md-5 col-xl-3 d-flex d-block justify-content-center p-3">
                        <div class="card" style="width: 18rem;">
                            <img src="img/plants/plant8.jpg" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title">Trebol Morado</h5>
                                <p class="card-text">Su color púrpura está cargado de simbolismo. Resistencia y lucha.
                                    Oxalis triangularis, planta mariposa? sus hojas triangulares crecen muy rápido y tienen
                                    mucho ritmo.
                                    Verás que dependiendo de la intensidad de la luz que reciba, sus hojas se cerrarán y se
                                    abrirán.</p>
                                <a href="#" class="btn btn-success me-5">Comprar</a> <span style="font-size: 1.5em;">18.00
                                </span><i class="fad fa-euro-sign" style="color: rgb(2, 1, 0);"></i>
                            </div>
                            <!-- <ul class="list-group list-group-flush">
                            <li class="list-group-item">An item</li>
                            <li class="list-group-item">A second item</li>
                        </ul> -->
                        </div>
                    </div>--%>
            </div><!-- Row 1 -->
        </div><!-- Container -->
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
                <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-uppercase"><fmt:message key="principal.footer.enlaces" bundle="${lang}"/></h5>

                    <ul class="list-unstyled mb-0">
                        <li>
                            <a href="#!" class="text-dark"><fmt:message key="principal.footer.metodosPago" bundle="${lang}"/></a>
                        </li>
                        <li>
                            <a href="#!" class="text-dark"><fmt:message key="principal.footer.garantia" bundle="${lang}"/></a>
                        </li>

                    </ul>
                </div>
                <!--Grid column-->

                <!--Grid column-->
                <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-uppercase mb-0"><fmt:message key="principal.footer.contacto" bundle="${lang}"/></h5>

                    <ul class="list-unstyled">
                        <li>
                            <a href="#!" class="text-dark"><fmt:message key="principal.footer.formContacto" bundle="${lang}"/></a>
                        </li>
                        <li>
                            <a href="#!" class="text-dark"><fmt:message key="principal.footer.localizacion" bundle="${lang}"/></a>

                        </li>
                        <li>
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3169.3631504678724!2d-6.040672584652257!3d37.40489054112651!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd126b64a210c061%3A0xfc39137313475fad!2sIES%20Camas%20-%20Antonio%20Brisquet!5e0!3m2!1ses!2ses!4v1632659630391!5m2!1ses!2ses" 
                                    width="300" height="225" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                        </li>
                        <li class="mt-2">
                            <a href="#"><i class="fab fa-twitter-square fa-2x" style="color: rgb(30, 226, 251);"></i></a>
                            <a href="#"><i class="fab fa-facebook-square fa-2x"></i></a>
                            <a href="#"><i class="fab fa-instagram-square fa-2x" style="color: rgb(220, 20, 147);"></i></a>
                            <a href="#"><i class="fab fa-tumblr-square fa-2x" style="color: darkblue;"></i></a>
                            <a href="#"><i class="fas fa-rss-square fa-2x" style="color: orange;"></i></a>
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
    <script src="js/font-awesome5.js" type="text/javascript"></script>

</body>
</html>

