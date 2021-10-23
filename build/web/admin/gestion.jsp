<%-- 
    Document   : gestion
    Created on : 09-oct-2021, 17:40:40
    Author     : Pedro
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
        <!-- Uso el bootstrap normal para cambiar variables a mi antojo -->
        <link rel="icon" type="image/png" href="../img/icono.png">
        <title>Eleplant - Gestión</title>
        <c:if test="${empty tienda}">
            <c:redirect url="../principal.jsp"/>
        </c:if>
        <c:if test="${empty usuario}">
            <script>alert("Debes estar logueado y ser Administrador");</script>
            <c:redirect url="../principal.jsp"/>
        </c:if>
        <c:if test="${!empty usuario and !usuario.esAdmin()}">
            <script>alert("No tienes permisos de administrador. Redirigiendo.");</script>
            <c:redirect url="../principal.jsp"/>
        </c:if>
        <c:if test="${!empty param.mensaje}">
            <script>
                alert("${param.mensaje}");
            </script>
        </c:if>

        <script src='../js/sortable.js'></script>
        <style>
            table.sortable th:not(.sorttable_sorted):not(.sorttable_sorted_reverse):not(.sorttable_nosort):after { 
                content: " \25BE";
                color: gainsboro;
                text-shadow: 0.2px 0.2px 0.2px grey;

            }
            th{
                cursor: pointer;
            }
            button.botonesTab{
                box-shadow: 1px 0px 2px black;
            }


        </style>

    </head>
    <body style="border: solid 2px red;">
        <header class="my-2 bg-light" id="cabecera" style="border: solid 2px blue;">

            <div class="container-fluid p-3 align-items-end bg-light" id="cabecera">
                <a class="navbar-brand" href="../principal.jsp"><img src="../img/logoLtrans.png" alt="logoEmpresa"
                                                                     width="60"></a>
                <a class="display-5 mx-4 text-decoration-none text-success cartel">Área de Gestión</a>
            </div>
        </header>
        <section id="tabPanelGeneral" style="border: solid 2px red;">
            <div class="container-fluid p-3">

                <ul class="sticky-top shadow-sm pt-3 nav nav-tabs bg-light" id="myTab" role="tablist">

                    <li class="nav-item" role="presentation">
                        <button class="nav-link active botonesTab" id="articulos-tab" data-bs-toggle="tab" 
                                data-bs-target="#articulos" type="button" role="tab" aria-controls="articulos" aria-selected="true">Artículos</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link botonesTab mx-1" id="usuarios-tab" data-bs-toggle="tab" 
                                data-bs-target="#usuarios" type="button" role="tab" aria-controls="usuarios" aria-selected="false">Usuarios</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link botonesTab" id="pedidos-tab" data-bs-toggle="tab" 
                                data-bs-target="#pedidos" type="button" role="tab" aria-controls="pedidos" aria-selected="false">Pedidos</button>
                    </li>
                </ul>

                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="articulos" role="tabpanel" aria-labelledby="articulos-tab">
                        <%--Contenido del panel Artículos--%>
                        <div class="d-flex align-items-start my-3">
                            <div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                <button class="nav-link active mb-2 btnMenuLateral" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">Todos</button>
                                <button class="nav-link mb-2 btnMenuLateral" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">Plantas</button>
                                <button class="nav-link mb-2 btnMenuLateral" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">Abonos</button>
                                <button class="nav-link mb-2 btnMenuLateral" data-bs-toggle="pill" id="v-pills-settings-tab" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">Macetas</button>

                            </div>
                            <div class="tab-content" id="v-pills-tabContent">
                                <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">

                                    <%--Contenido articulos/todos--%>
                                    <section class="wrap">
                                        <div class="container-fluid">
                                            <!--<div class="table-responsive-xl">-->
                                            <table class="table table-sm table-bordered table-striped table-hover shadow text-center sortable" id="tableArt">
                                                <caption>Lista de artículos. Total: <b>${tienda.articulos.size()}</b></caption>
                                                <thead>
                                                    <tr><th class="align-middle p-2 sorttable_nosort">Imagen</th>
                                                        <th class="align-middle p-2">Referencia</th>
                                                        <th class="align-middle p-2">Categoria</th>
                                                        <th class="align-middle p-2">Nombre</th>
                                                        <th class="align-middle p-2">Fabricante</th>
                                                        <th class="align-middle p-2">Precio</th>
                                                        <th class="align-middle p-2">Precio + IVA</th>
                                                        <th class="align-middle p-2">Stock</th>
                                                        <th class="p-3 sorttable_nosort"></th>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="ar" items="${tienda.articulos}">
                                                        <tr>
                                                            <td class="align-middle m-0 p-0"><img class="m-0 p-0" src="../img/articulos/${ar.nombreImagen}" style="width: 100px;"/></td>
                                                            <td class="align-middle">${ar.referencia}</td>
                                                            <td class="align-middle">${ar.categoria}</td>
                                                            <td class="align-middle">${ar.nombre}</td>
                                                            <td class="align-middle">${ar.fabricante}</td>
                                                            <td class="align-middle"><fmt:formatNumber value = "${ar.precioSinIVA}" type = "currency"/></td>
                                                            <td class="align-middle"><fmt:formatNumber value = "${ar.precio}" type = "currency"/></td>
                                                            <td class="align-middle">${ar.stock} uds.</td>

                                                            <td class="align-middle px-2">
                                                                <form action="EditarArticulo" method="POST">
                                                                    <input type="hidden" name="id" value="${ar.id}">

                                                                    <button type="submit" class="btn btn-outline-success" value="Editar">
                                                                        <i class="fas fa-user"></i> Editar
                                                                    </button>
                                                                </form>
                                                                <form action="BorrarArticulo" method="POST">
                                                                    <input type="hidden" name="id" value="${ar.id}">
                                                                    <button type="submit" class="btn btn-success mt-1" value="Borrar">
                                                                        <i class="fad fa-trash-alt"></i> Borrar
                                                                    </button>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                            <div class="row d-flex justify-content-between">
                                                <div class="col-auto">
                                                    <a href="../principal.jsp" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-arrow-alt-left fa-2x" style="text-shadow: 1px 1px 1px black;"></i> Volver</a>
                                                </div>
                                                <div class="col-auto">
                                                    <a href="" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-user-plus fa-2x" style="text-shadow: 1px 1px 1px black;"></i> Nuevo Sanitario</a>
                                                </div>

                                            </div>

                                            <!--</div>-->
                                        </div>
                                    </section>

                                </div>
                                <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                                    <%--Contenido dentro de Plantas para gestionarlas--%>
                                    <div class="tab-content" id="myTabContent">
                                            <section class="wrap">
                                                <div class="container-fluid">
                                                    <!--<div class="table-responsive-xl">-->
                                                    <table class="table table-sm table-bordered table-striped table-hover shadow text-center sortable" id="tableArt">
                                                        <caption>Lista de plantas. Total: <b>${tienda.plantas.size()}</b></caption>
                                                        <thead>
                                                            <tr><th class="align-middle p-2 sorttable_nosort">Imagen</th>
                                                                <th class="align-middle p-2">Referencia</th>
                                                                <th class="align-middle p-2">Nombre</th>
                                                                <th class="align-middle p-2">Fabricante</th>
                                                                <th class="align-middle p-2">Precio</th>
                                                                <th class="align-middle p-2">Precio + IVA</th>
                                                                <th class="align-middle p-2">Stock</th>
                                                                <th class="p-3 sorttable_nosort"></th>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="pla" items="${tienda.plantas}">
                                                                <tr>
                                                                    <td class="align-middle p-0 m-0"><img class="p-0 m-0" src="../img/articulos/${pla.nombreImagen}" style="width: 100px;"/></td>
                                                                    
                                                                    <td class="align-middle">${pla.referencia}</td>
                                                                    <td class="align-middle">${pla.nombre}</td>
                                                                    <td class="align-middle">${pla.fabricante}</td>
                                                                    
                                                                    <td class="align-middle"><fmt:formatNumber value = "${pla.precioSinIVA}" type = "currency"/></td>
                                                                    <td class="align-middle"><fmt:formatNumber value = "${pla.precio}" type = "currency"/></td>
                                                                    <td class="align-middle">${pla.stock} uds.</td>

                                                                    <td class="align-middle">
                                                                        <form action="EditarPlanta" method="POST">
                                                                            <input type="hidden" name="id" value="${pla.id}">

                                                                            <button type="submit" class="btn btn-outline-success" value="Editar">
                                                                                <i class="fas fa-user"></i> Editar
                                                                            </button>
                                                                        </form>
                                                                        <form action="BorrarAbono" method="POST">
                                                                            <input type="hidden" name="id" value="${pla.id}">
                                                                            <button type="submit" class="btn btn-success mt-1" value="Borrar">
                                                                                <i class="fad fa-trash-alt"></i> Borrar
                                                                            </button>
                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                    <div class="row d-flex justify-content-between">
                                                        <div class="col-auto">
                                                            <a href="../principal.jsp" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-arrow-alt-left fa-2x" style="text-shadow: 1px 1px 1px black;"></i> Volver</a>
                                                        </div>
                                                        <div class="col-auto">
                                                            <a href="" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-user-plus fa-2x" style="text-shadow: 1px 1px 1px black;"></i> Nuevo planta</a>
                                                        </div>

                                                    </div>

                                                    <!--</div>-->
                                                </div>
                                            </section>

                                            <div class="container-fluid border border-primary " >
                                                <%--Contenido articulos/planta/agregar--%>
                                                <!--ESTO VALE<div class="container-fluid border border-danger">
                                                    <div class="row d-flex justify-content-center justify-content-md-start offset-md-1 my-4">
                                                        <div class="col">
                                                            <h1>Agregar nueva planta</h1>
                                                        </div>
                                                    </div>
                                                    <form action="AltaPlanta" method="POST" id="altaPlanta">
                                                <%--public Planta (String referencia, String categoria, String tipo, String nombre, String fabricante, String descripcion, Integer tipoIVA, Integer stock, Double precioSinIVA){
                                                        super(referencia, "planta", fabricante, descripcion, 10, stock); --%>
                                                <div class="row">
                                                    <div class="col">
                                                        <div class="row g-3 align-items-center mb-3">
                                                            <div class="col-12 col-md-2 mb-0 pb-0">
                                                                <i class="fad fa-user-tie me-2"></i>
                                                                <label for="inputReferencia" class="form-label">Referencia</label>
                                                            </div>
                                                            <div class="col-12 col-md-6 mt-0 pt-0">
                                                                <input type="text" class="form-control bg-light shadow" id="inputReferencia"
                                                                       name="referencia" aria-describedby="referenciaHelp" required>
                                                            </div>
                                                        </div>
                                                        <div class="row g-3 align-items-center mb-3">
                                                            <div class="col-12 col-md-2 mb-0 pb-0">
                                                                <i class="fad fa-user-tie me-2"></i>
                                                                <label for="inputTipo" class="form-label">Tipo</label>
                                                            </div>
                                                            <div class="col-12 col-md-6 mt-0 pt-0">

                                                                <select name="tipo" class="form-select bg-light shadow" id="inputTipo" form="altaPlanta" aria-describedby="tipoHelp" required>
                                                                    <option selected value="default">Seleccione tipo</option>
                                                                    <option value="suculenta">Suculenta</option>
                                                                    <option value="verde">Planta Verde</option>
                                                                    <option value="cactus">Cactus</option>
                                                                    <option value="orquidea">Orquídea</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row g-3 align-items-center">
                                                            <div class="col-12 col-md-2 mb-0 pb-0">
                                                                <i class="fad fa-user-tie me-2"></i>
                                                                <label for="inputNombre" class="form-label">Nombre</label>
                                                            </div>
                                                            <div class="col-12 col-md-6 mt-0 pt-0">
                                                                <input type="text" class="form-control bg-light shadow" id="inputNombre"
                                                                       name="nombre" aria-describedby="nombreHelp" required>
                                                            </div>
                                                        </div>
                                                        <div class="row g-3 align-items-center mb-3">
                                                            <div class="col-12 col-md-2 mb-0 pb-0">
                                                                <i class="fad fa-user-tie me-2"></i>
                                                                <label for="inputFabricante" class="form-label">Fabricante</label>
                                                            </div>
                                                            <div class="col-12 col-md-6 mt-0 pt-0">
                                                                <input type="text" class="form-control bg-light shadow" id="inputFabricante"
                                                                       name="fabricante" aria-describedby="fabricanteHelp" required>
                                                            </div>
                                                        </div>
                                                        <div class="row g-3 align-items-center mb-3">
                                                            <div class="col-12 col-md-2 mb-0 pb-0">
                                                                <i class="fad fa-user-tie me-2"></i>
                                                                <label for="inputIVA" class="form-label">IVA</label>
                                                            </div>
                                                            <div class="col-12 col-md-6 mt-0 pt-0">

                                                                <select name="tipoIVA" class="form-select bg-light shadow" id="inputIVA" form="altaPlanta" aria-describedby="ivaHelp" required>
                                                                    <option selected>Seleccione IVA</option>
                                                                    <option value="4">(4%) Super Reducido</option>
                                                                    <option value="10">(10%) Reducido</option>
                                                                    <option value="21">(21%) General</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row g-3 align-items-center mb-3">
                                                            <div class="col-12 col-md-2 mb-0 pb-0">
                                                                <i class="fad fa-user-tie me-2"></i>
                                                                <label for="inputPrecioSinIVA" class="form-label">Precio sin IVA</label>
                                                            </div>
                                                            <div class="col-12 col-md-6 mt-0 pt-0">
                                                                <input type="number" step="0.01" class="form-control bg-light shadow mb-3" id="inputPrecioSinIVA"
                                                                       name="precioSinIVA" aria-describedby="precioSinIVAHelp" required>
                                                                <input type="number" class="form-control bg-light shadow" id="inputPVP"
                                                                       name="precioPVP" aria-describedby="precioPVPHelp" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="row g-3 align-items-center mb-3">
                                                            <div class="col-12 col-md-2 mb-0 pb-0">
                                                                <i class="fad fa-user-tie me-2"></i>
                                                                <label for="inputStock" class="form-label">Stock</label>
                                                            </div>
                                                            <div class="col-12 col-md-6 mt-0 pt-0">
                                                                <input type="number" class="form-control bg-light shadow" id="inputStock"
                                                                       name="stock" aria-describedby="stockHelp" required>
                                                            </div>
                                                        </div>

                                                        <div class="row g-3 align-items-center mb-3">
                                                            <div class="col-12 col-md-2 mb-0 pb-0">
                                                                <i class="fad fa-user-tie me-2"></i>
                                                                <label for="inputDescripcion" class="form-label">Descripción</label>
                                                            </div>
                                                            <div class="col-12 col-md-6 mt-0 pt-0">
                                                                <input type="textArea" class="form-control bg-light shadow" id="inputDescripcion"
                                                                       name="descripcion" aria-describedby="descripcionHelp" required>
                                                            </div>
                                                        </div>

                                                        <hr class="featurette-divider offset-1 w-75">

                                                        <hr class="featurette-divider w-100">
                                                        <div id="footerForm" class="d-flex justify-content-md-center my-5 ">
                                                            <a href="principal.jsp" class="btn btn-outline-dark active mx-3" role="button"
                                                               aria-pressed="false">Volver</a>
                                                            <input class="btn btn-outline-success" type="reset" value="Reiniciar">
                                                            <button type="submit" class="btn btn-success mx-3 me-5">Agregar</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>-->
                                            </div>

                                        
                                    </div>

                                </div>
                                <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
                                    
                                    
                                    <section class="wrap">
                                                <div class="container-fluid">
                                                    <!--<div class="table-responsive-xl">-->
                                                    <table class="table table-sm table-bordered table-striped table-hover shadow text-center sortable" id="tableArt">
                                                        <caption>Lista de abonos/fertilizantes. Total: <b>${tienda.abonos.size()}</b></caption>
                                                        <thead>
                                                            <tr><th class="align-middle p-2 sorttable_nosort">Imagen</th>
                                                                
                                                                <th class="align-middle p-2">Categoria</th>
                                                                <th class="align-middle p-2">Nombre</th>
                                                                <th class="align-middle p-2">Fabricante</th>
                                                                <th class="align-middle p-2">Volumen</th>
                                                                <th class="align-middle p-2">Precio</th>
                                                                <th class="align-middle p-2">Precio + IVA</th>
                                                                <th class="align-middle p-2">Stock</th>
                                                                <th class="p-3 sorttable_nosort"></th>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="abo" items="${tienda.abonos}">
                                                                <tr>
                                                                    <td class="align-middle p-0 m-0"><img class="p-0 m-0" src="../img/articulos/${abo.nombreImagen}" style="width: 100px;"/></td>
                                                                    
                                                                    <td class="align-middle">${abo.categoria}</td>
                                                                    <td class="align-middle">${abo.nombre}</td>
                                                                    <td class="align-middle">${abo.fabricante}</td>
                                                                    <td class="align-middle">${abo.volumen} ml</td>
                                                                    <td class="align-middle"><fmt:formatNumber value = "${abo.precioSinIVA}" type = "currency"/></td>
                                                                    <td class="align-middle"><fmt:formatNumber value = "${abo.precio}" type = "currency"/></td>
                                                                    <td class="align-middle">${abo.stock} uds.</td>

                                                                    <td class="align-middle">
                                                                        <form action="EditarAbono" method="POST">
                                                                            <input type="hidden" name="id" value="${abo.id}">

                                                                            <button type="submit" class="btn btn-outline-success" value="Editar">
                                                                                <i class="fas fa-user"></i> Editar
                                                                            </button>
                                                                        </form>
                                                                        <form action="BorrarPlanta" method="POST">
                                                                            <input type="hidden" name="id" value="${abo.id}">
                                                                            <button type="submit" class="btn btn-success mt-1" value="Borrar">
                                                                                <i class="fad fa-trash-alt"></i> Borrar
                                                                            </button>
                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                    <div class="row d-flex justify-content-between">
                                                        <div class="col-auto">
                                                            <a href="../principal.jsp" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-arrow-alt-left fa-2x" style="text-shadow: 1px 1px 1px black;"></i> Volver</a>
                                                        </div>
                                                        <div class="col-auto">
                                                            <a href="" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-user-plus fa-2x" style="text-shadow: 1px 1px 1px black;"></i> Nuevo Abono/Ferti.</a>
                                                        </div>

                                                    </div>

                                                    <!--</div>-->
                                                </div>
                                            </section>
                                    
                                    
                                </div>
                                <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
                                    Contenido articulos/macetas
                                    
                                    <h1 class="display-1">Próximamente</h1>
                                </div>

                            </div>
                        </div>



                    </div>
                    <div class="tab-pane fade" id="usuarios" role="tabpanel" aria-labelledby="usuarios-tab">
                        <%--Contenido del panel Usuarios--%>
                        <div class="container-fluid my-3"> 
                            <!-- Default dropend button -->
                            <div class="btn-group-vertical dropend">
                                <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                    Boton 1
                                </button>
                                <ul class="dropdown-menu mx-1">
                                    <li><a class="dropdown-item" href="#">Action</a></li>
                                    <li><a class="dropdown-item" href="#">Another action</a></li>
                                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="#">Separated link</a></li>
                                </ul>
                                <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                    Boton 2
                                </button>
                                <ul class="dropdown-menu mx-1">
                                    <li><a class="dropdown-item" href="#">Action</a></li>
                                    <li><a class="dropdown-item" href="#">Another action</a></li>
                                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="#">Separated link</a></li>
                                </ul>

                            </div>


                        </div>
                    </div>
                    <div class="tab-pane fade" id="pedidos" role="tabpanel" aria-labelledby="pedidos-tab">
                        <%--Contenido del panel Artículos--%>
                        Contenido pedidos
                    </div>
                </div>
            </div>
        </section>


        <script src="../js/bootstrap.bundle.min.js"></script>
        <script src="../js/font-awesome5.js"></script>
        <script src="../js/jquery-3.5.1.min.js"></script>
    </body>

</html>
