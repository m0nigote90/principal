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

            .nav-item{

            }
            .nav-item::selection{
                background-color: red;
            }
            input[type="number"] {
                width:40px;
                height: 37px;
                font-weight: bold;
            }
            #campoCategoria:first-letter {
                text-transform: uppercase;
            }
            button{
                box-shadow: 1px 1px 3px graytext;
            }
            th{
                background-color: greenyellow;
            }
        </style>

    </head>
    <body>
        <header class="pt-2 bg-light sticky-top mb-0" id="cabecera">

            <div class="container-fluid p-3 align-items-end bg-light ms-4" id="cabecera">
                <a class="navbar-brand" href="../principal.jsp"><img src="../img/logoLtrans.png" alt="logoEmpresa"
                                                                     width="60"></a>
                <a class="display-5 mx-4 text-decoration-none text-success cartel">Área de Gestión</a>
            </div>

            <section id="tabPanelGeneral" class="text-light mt-0">
                <div class="container-fluid p-0 mb-0 pb-0">

                    <ul class="shadow p-3 mx-0 nav nav-tabs bg-light mb-0 pb-0" id="myTab" role="tablist">

                        <li class="nav-item" role="presentation">
                            <button class="nav-link active botonesTab" id="articulos-tab" data-bs-toggle="tab" 
                                    data-bs-target="#articulos" type="button" role="tab" aria-controls="articulos" aria-selected="true">Artículos</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button  class="nav-link botonesTab mx-1" id="usuarios-tab" data-bs-toggle="tab" 
                                     data-bs-target="#usuarios" type="button" role="tab" aria-controls="usuarios" aria-selected="false">Usuarios</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link botonesTab" id="pedidos-tab" data-bs-toggle="tab" 
                                    data-bs-target="#pedidos" type="button" role="tab" aria-controls="pedidos" aria-selected="false">Pedidos</button>
                        </li>
                    </ul>
                    </header>
                    <div class="tab-content ms-4 me-4" id="myTabContent">
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
                                        <div class="row m-4">
                                    <div class="col-6  border rounded-3 p-3 shadow-sm">
                                        <label class="form-label fw-bolder" for="selectAgregar">Agregar artículo nuevo</label>
                                        <div class="row">
                                            <div class="col-9">
                                                <select class="form-select" aria-label="Agregar nuevo artículo" id="selectAgregar">
                                                    <option value="0" selected>Seleccione tipo</option>
                                                    <option value="1">Planta</option>
                                                    <option value="2">Abono</option>
                                                    <option value="3">Maceta</option>
                                                </select>
                                            </div>
                                            <div class="col-3">
                                                <button id="btnAgregarArt" class="btn btn-outline-seconday w-100" disabled>Agregar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                        <%--Contenido articulos/todos--%>
                                        <section class="wrap">
                                            <div class="container-fluid ms-3">
                                                <!--<div class="table-responsive-xl">-->
                                                <table class="table table-sm table-bordered table-striped table-hover shadow-sm text-center sortable" id="tableArt" width="100%">
                                                    <caption>Lista de artículos. Total: <b>${tienda.articulos.size()}</b></caption>
                                                    <thead>
                                                        <tr><th class="align-middle p-2 sorttable_nosort">Imagen</th>
                                                            <th class="align-middle p-2">Ref.</th>
                                                            <th class="align-middle p-2">Categoria</th>
                                                            <th class="align-middle p-2">Nombre</th>
                                                            <th class="align-middle p-2">Fabricante</th>
                                                            <th class="align-middle p-2">Precio</th>
                                                            <th class="align-middle p-2">PVP</th>
                                                            <th class="align-middle p-2">Total</th>
                                                            <th class="align-middle p-2">Stock</th>
                                                            <th class="align-middle p-2">Ventas</th>
                                                            <th class="p-3 sorttable_nosort"></th>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="ar" items="${tienda.agruparArticulosRef()}">
                                                            <tr>
                                                                <td class="align-middle m-0 p-0"><img class="m-0 p-0" src="../img/articulos/${ar.nombreImagen}" style="width: 100px;"/></td>
                                                                <td class="align-middle p-2">${ar.referencia}</td>
                                                                <td id="campoCategoria" class="align-middle p-2">${ar.categoria}</td>
                                                                <td class="align-middle p-2">${ar.nombre}</td>
                                                                <td class="align-middle p-2">${ar.fabricante}</td>
                                                                <td class="align-middle p-2"><fmt:formatNumber value = "${ar.precioSinIVA}" type = "currency"/></td>
                                                                <td class="align-middle p-2"><fmt:formatNumber value = "${ar.precio}" type = "currency"/></td>
                                                                <td class="align-middle p-2">${tienda.stockTotalArticulo(ar.referencia)} uds.</td>
                                                                <td class="align-middle p-2" <c:if test="${tienda.stockParcialArticulo(ar.referencia, false) == 0}">style="color: red; font-weight: 500;"</c:if>>
                                                                    ${tienda.stockParcialArticulo(ar.referencia, false)}
                                                                </td>
                                                                <td class="align-middle">${tienda.stockParcialArticulo(ar.referencia, true)}</td>

                                                                <td class="align-middle p-0">
                                                                    <div class="container p-0">
                                                                        <div class="row px-0 mx-0" >
                                                                            <div class="col-6 mx-0 pe-0" >
                                                                                <!--Controlamos con javascript la que solo permita 2 digitos-->
                                                                                <input type="number" id="inputNumber${ar.referencia}" class="form-control form-control-sm inline me-0 pe-0" 
                                                                                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                                                       step="1" value="1" min="1" max="99" maxlength="2" />  
                                                                            </div>
                                                                            <div class="col-6 mx-0 ps-0">
                                                                                <button id="" data="${ar.referencia}" type="button" class="btnAddUnidades btn btn-outline-success ms-0" title="Agregar udidades" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                    <i class="fad fa-plus inline"></i>
                                                                                </button>

                                                                            </div>
                                                                        </div>
                                                                        <div class="row mt-1 mx-0 px-0 mt-2">
                                                                            <div class="col-6 mx-0 pe-0">
                                                                                <button id="" data="${ar.referencia}" type="button" class="btn btn-outline-success pe-2 me-2" title="Editar" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                    <i class="fad fa-edit"></i>
                                                                                </button>
                                                                            </div>
                                                                            <div class="col-6 mx-0 ps-0">
                                                                                <button id="btnRmvArt" data="${ar.referencia}" type="button" class="btn btn-success" title="Eliminar" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                    <i class="fad fa-trash-alt"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div> 
                                                                    </div>
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
                                                        <a href="" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-user-plus fa-2x" style="text-shadow: 1px 1px 1px black;"></i> Nuevo Artículo</a>
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
                                                        <caption>Lista de plantas. Total unidades: <b>${tienda.plantas.size()}</b></caption>
                                                        <thead>
                                                            <tr><th class="align-middle p-2 sorttable_nosort">Imagen</th>
                                                                <th class="align-middle p-2">Referencia</th>
                                                                <th class="align-middle p-2">Nombre</th>
                                                                <th class="align-middle p-2">Fabricante</th>
                                                                <th class="align-middle p-2">Precio</th>
                                                                <th class="align-middle p-2">PVP</th>
                                                                <th class="align-middle p-2">Total</th>
                                                                <th class="align-middle p-2">Stock</th>
                                                                <th class="align-middle p-2">Ventas</th>
                                                                <th class="p-3 sorttable_nosort"></th>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="pla" items="${tienda.agruparArticulosPorRefTipo('Planta')}">
                                                                <tr>
                                                                    <td class="align-middle p-0 m-0"><img class="p-0 m-0" src="../img/articulos/${pla.nombreImagen}" style="width: 100px;"/></td>

                                                                    <td class="align-middle">${pla.referencia}</td>
                                                                    <td class="align-middle">${pla.nombre}</td>
                                                                    <td class="align-middle">${pla.fabricante}</td>

                                                                    <td class="align-middle"><fmt:formatNumber value = "${pla.precioSinIVA}" type = "currency"/></td>
                                                                    <td class="align-middle"><fmt:formatNumber value = "${pla.precio}" type = "currency"/></td>
                                                                    <td class="align-middle">${tienda.stockTotalArticulo(pla.referencia)} uds.</td>

                                                                    <td class="align-middle" <c:if test="${tienda.stockParcialArticulo(pla.referencia, false) == 0}">style="color: red; font-weight: 500;"</c:if>>
                                                                        ${tienda.stockParcialArticulo(pla.referencia, false)}
                                                                    </td>
                                                                    <td class="align-middle">${tienda.stockParcialArticulo(pla.referencia, true)}</td>
                                                                    <td class="align-middle p-0">
                                                                        <div class="container p-0">
                                                                            <div class="row px-0 mx-0" >
                                                                                <div class="col-6 mx-0 pe-0" >
                                                                                    <!--Controlamos con javascript la que solo permita 2 digitos-->
                                                                                    <input type="number" id="inputNumber${pla.referencia}" class="form-control form-control-sm inline me-0 pe-0" 
                                                                                           oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                                                           step="1" value="1" min="1" max="99" maxlength="2" />  
                                                                                </div>
                                                                                <div class="col-6 mx-0 ps-0">
                                                                                    <button id="" data="${pla.referencia}" type="button" class="btnAddUnidades btn btn-outline-success ms-0" title="Agregar udidades" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                        <i class="fad fa-plus inline"></i>
                                                                                    </button>

                                                                                </div>
                                                                            </div>
                                                                            <div class="row mt-1 mx-0 px-0 mt-2">
                                                                                <div class="col-6 mx-0 pe-0">
                                                                                    <button id="" data="${pla.referencia}" type="button" class="btn btn-outline-success pe-2 me-2" title="Editar" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                        <i class="fad fa-edit"></i>
                                                                                    </button>
                                                                                </div>
                                                                                <div class="col-6 mx-0 ps-0">
                                                                                    <button id="btnRmvArt" data="${pla.referencia}" type="button" class="btn btn-success" title="Eliminar" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                        <i class="fad fa-trash-alt"></i>
                                                                                    </button>
                                                                                </div>
                                                                            </div> 
                                                                        </div>
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
                                                    <caption>Lista de abonos/fertilizantes. Total unidades: <b>${tienda.abonos.size()}</b></caption>
                                                    <thead>
                                                        <tr><th class="align-middle p-2 sorttable_nosort">Imagen</th>
                                                            <th class="align-middle p-2">Referencia</th>
                                                            <th class="align-middle p-2">Nombre</th>
                                                            <th class="align-middle p-2">Fabricante</th>
                                                            <th class="align-middle p-2">Volumen</th>
                                                            <th class="align-middle p-2">Precio</th>
                                                            <th class="align-middle p-2">PVP</th>
                                                            <th class="align-middle p-2">Total</th>
                                                            <th class="align-middle p-2">Stock</th>
                                                            <th class="align-middle p-2">Ventas</th>
                                                            <th class="p-3 sorttable_nosort"></th>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="abo" items="${tienda.agruparArticulosPorRefTipo('Abono')}">
                                                            <tr>
                                                                <td class="align-middle p-0 m-0"><img class="p-0 m-0" src="../img/articulos/${abo.nombreImagen}" style="width: 100px;"/></td>
                                                                <td class="align-middle">${abo.referencia}</td>
                                                                <td class="align-middle">${abo.nombre}</td>
                                                                <td class="align-middle">${abo.fabricante}</td>
                                                                <td class="align-middle">${abo.volumen} ml</td>
                                                                <td class="align-middle"><fmt:formatNumber value = "${abo.precioSinIVA}" type = "currency"/></td>
                                                                <td class="align-middle"><fmt:formatNumber value = "${abo.precio}" type = "currency"/></td>
                                                                <td class="align-middle">${tienda.stockTotalArticulo(abo.referencia)} uds.</td>
                                                                <td class="align-middle" <c:if test="${tienda.stockParcialArticulo(abo.referencia, false) == 0}">style="color: red; font-weight: 500;"</c:if>>
                                                                    ${tienda.stockParcialArticulo(abo.referencia, false)}
                                                                </td>
                                                                <td class="align-middle">${tienda.stockParcialArticulo(abo.referencia, true)}</td>
                                                                <td class="align-middle p-0">
                                                                    <div class="container p-0">
                                                                        <div class="row px-0 mx-0" >
                                                                            <div class="col-6 mx-0 pe-0" >
                                                                                <!--Controlamos con javascript la que solo permita 2 digitos-->
                                                                                <input type="number" id="inputNumber${abo.referencia}" class="form-control form-control-sm inline me-0 pe-0" 
                                                                                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                                                       step="1" value="1" min="1" max="99" maxlength="2" />  
                                                                            </div>
                                                                            <div class="col-6 mx-0 ps-0">
                                                                                <button id="" data="${abo.referencia}" type="button" class="btnAddUnidades btn btn-outline-success ms-0" title="Agregar udidades" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                    <i class="fad fa-plus inline"></i>
                                                                                </button>

                                                                            </div>
                                                                        </div>
                                                                        <div class="row mt-1 mx-0 px-0 mt-2">
                                                                            <div class="col-6 mx-0 pe-0">
                                                                                <button id="" data="${abo.referencia}" type="button" class="btn btn-outline-success pe-2 me-2" title="Editar" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                    <i class="fad fa-edit"></i>
                                                                                </button>
                                                                            </div>
                                                                            <div class="col-6 mx-0 ps-0">
                                                                                <button id="btnRmvArt" data="${abo.referencia}" type="button" class="btn btn-success" title="Eliminar" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                    <i class="fad fa-trash-alt"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div> 
                                                                    </div>
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
                                <section class="wrap">
                                    <div class="container mb-5">
                                        <div class="row">
                                            <h3>Buscar usuario</h3>
                                            <div class="col">
                                                <label class="form-label" for="buscarTarjeta">Nombre: </label>
                                                <input id="filtroTarjeta" type="text" class="form-control" 
                                                       size="16" maxlength="16"  placeholder="AN XXXXXXXXXX">
                                            </div>
                                            <vr class="featurette-divider mt-4">
                                                <div class="col">
                                                    <label class="form-label" for="buscarNombre">DNI: </label>
                                                    <input type="text" class="form-control" id="filtroNombre" onkeyup="filtrar()">
                                                </div>
                                        </div>   
                                    </div>
                                    <div class="container-fluid">
                                        <!--<div class="table-responsive-xl">-->
                                        <table class="table table-sm table-bordered table-striped table-hover shadow text-center sortable" id="tableArt" width="100%">
                                            <caption>Lista de usuarios. Total: <b>${tienda.usuarios.size() - 1}</b></caption>
                                            <thead>
                                                <tr><th class="align-middle p-2">Nombre</th>
                                                    <th class="align-middle p-2">Edad</th>
                                                    <th class="align-middle p-2">DNI</th>
                                                    <th class="align-middle p-2">Email</th>
                                                    <th class="align-middle p-2">Fecha alta</th>
                                                    <th class="align-middle p-2">Pedidos</th>
                                                    <th class="p-3 sorttable_nosort"></th>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="usu" items="${tienda.usuarios}">
                                                    <c:if test="${!usu.esAdmin()}">
                                                        <tr>

                                                            <td class="align-middle p-2">${usu.apellidos}, ${usu.nombre}</td>
                                                            <td class="align-middle p-2">${usu.getEdad()}</td>
                                                            <td class="align-middle p-2">${usu.getDNI()}</td>
                                                            <td class="align-middle p-2">${usu.email}</td>

                                                            <td class="align-middle p-2">${usu.fechaAlta}</td>
                                                            <td class="align-middle p-2">${usu.getPedidos().size()}</td>


                                                            <td class="align-middle p-0">
                                                                <div class="container p-0">
                                                                    <div class="row px-0 mx-0" >
                                                                        <div class="col-6 mx-0 pe-0" >
                                                                            <!--Controlamos con javascript la que solo permita 2 digitos-->

                                                                        </div>
                                                                        <div class="col-6 mx-0 ps-0">


                                                                        </div>
                                                                    </div>
                                                                    <div class="row mx-0 px-0 my-2">
                                                                        <div class="col-6 mx-0 pe-0">
                                                                            <button id="" data="${usu.getDNI()}" type="button" class="btn btn-outline-success" title="Editar" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                <i class="fad fa-edit"></i>
                                                                            </button>
                                                                        </div>
                                                                        <div class="col-6 mx-0 ps-0">
                                                                            <button id="btnRmvArt" data="${usu.getDNI()}" type="button" class="btn btn-success" title="Eliminar" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                <i class="fad fa-trash-alt"></i>
                                                                            </button>
                                                                        </div>
                                                                    </div> 
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="row d-flex justify-content-between">
                                            <div class="col-auto">
                                                <a href="../principal.jsp" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-arrow-alt-left fa-2x" style="text-shadow: 1px 1px 1px black;"></i> Volver</a>
                                            </div>
                                            <div class="col-auto">
                                                <a href="" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-user-plus fa-2x" style="text-shadow: 1px 1px 1px black;"></i> Nuevo Usuario</a>
                                            </div>

                                        </div>

                                        <!--</div>-->
                                    </div>
                                </section>

                            </div>
                        </div>
                        <div class="tab-pane fade" id="pedidos" role="tabpanel" aria-labelledby="pedidos-tab">
                            <%--Contenido del panel Pedidos--%>
                            Contenido pedidos
                        </div>
                    </div>
                </div>
            </section>


            <script src="../js/jquery-3.5.1.min.js" ></script>
            <script 
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
                crossorigin="anonymous"
            ></script>
            <script src="../js/font-awesome5.js" ></script>
            <script src="../js/activadores.js" ></script>          
    </body>

</html>
