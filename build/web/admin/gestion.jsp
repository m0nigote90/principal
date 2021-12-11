<%-- 
    Document   : gestion
    Created on : 09-oct-2021, 17:40:40
    Author     : Pedro
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-15"%>
<%--<fmt:requestEncoding value="ISO-8859-1" /> --%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            table{
                background-color: rgba(255, 255, 255, 0.9);
            }

            .accordion-item{
                background-color: rgba(255, 255, 250, 0.6);
            }

            input[type="number"] {
                width:40px;
                height: 37px;
                font-weight: bold;
            }
            #campoCategoria:first-letter {
                text-transform: uppercase;
            }
            /*button{
                box-shadow: 1px 1px 3px graytext;
            }*/
            th{
                background-color: greenyellow;
            }
            .botonesTab, .btnMenuLateral{
                color: black;
            }
            .btnMenuLateral{
                width: 110px;
            }
            .btnMenuLateral[aria-selected="true"]{
                background-color: white;

            }
            .btn-success, .btn-outline-success:hover, option:hover{
                background: linear-gradient(180deg, rgba(0,82,53,0.7) 0%, rgba(0,82,53,0.8368813736432073) 35%, rgba(0,82,53,1) 100%);
                color: white;
            }
            .accordion-body span {
                font-weight: bold;
            }
        </style>

    </head>
    <body>
        <header class="pt-2 bg-light sticky-top mb-0" id="cabecera">
            <div class="container-fluid p-3 align-items-end bg-light" id="cabecera">
                <a class="navbar-brand ms-5" href="../principal.jsp"><img src="../img/logoLtrans.png" alt="logoEmpresa"
                                                                          width="60"></a>
                <a class="display-5 text-decoration-none text-success cartel"><fmt:message key="gestion.titulo" bundle="${lang}"/></a>
            </div>

            <section id="tabPanelGeneral" class="text-light mt-0">
                <div class="container-fluid p-0 mb-0 pb-0 w-100">

                    <ul class="shadow p-3 mx-0 nav nav-tabs bg-light mb-0 pb-0 " id="myTab" role="tablist">

                        <li class="nav-item" role="presentation">
                            <button class="nav-link active botonesTab me-1" id="articulos-tab" data-bs-toggle="tab" 
                                    data-bs-target="#articulos" type="button" role="tab" aria-controls="articulos" aria-selected="true"><fmt:message key="gestion.tab.articulos" bundle="${lang}"/></button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button  class="nav-link botonesTab me-1" id="usuarios-tab" data-bs-toggle="tab" 
                                     data-bs-target="#usuarios" type="button" role="tab" aria-controls="usuarios" aria-selected="false"><fmt:message key="gestion.tab.usuarios" bundle="${lang}"/></button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link botonesTab me-1" id="pedidos-tab" data-bs-toggle="tab" 
                                    data-bs-target="#pedidos" type="button" role="tab" aria-controls="pedidos" aria-selected="false"><fmt:message key="gestion.tab.pedidos" bundle="${lang}"/></button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link botonesTab me-1" id="estadisticas-tab" data-bs-toggle="tab" 
                                    data-bs-target="#estadisticas" type="button" role="tab" aria-controls="estadisticas" aria-selected="false"><fmt:message key="gestion.tab.estadisticas" bundle="${lang}"/></button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link botonesTab me-1 mt-1 mt-sm-0" id="herramientas-tab" data-bs-toggle="tab" 
                                    data-bs-target="#herramientas" type="button" role="tab" aria-controls="herramientas" aria-selected="false"><fmt:message key="gestion.tab.herramientas" bundle="${lang}"/></button>
                        </li>
                    </ul>
                    </header>
                    <!-- Modal Editar Art -->
                    <div class="modal fade" id="modalEditarArticulo" tabindex="-1" aria-labelledby="modalEditarArticulo" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">

                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content border border-success rounded-3">
                                <div class="modal-header">
                                    <h5 id="modEditTit" class="modal-title" id="exampleModalLabel"></h5><!--Titulo-->
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div>
                                    <div class="modal-body">
                                        <form class="form needs-validation" novalidate style="font-size: 0.9em;">
                                            <input id="modEditCat" type="hidden">
                                            <div class="row">
                                                <div class="col p-2 m-2 shadow-sm rounded-3"> <!-- primera columna-->
                                                    <div class="form-floating mb-2">
                                                        <input id="modEditRef" style="height: 45px;" type="text" class="form-control" placeholder="Referencia" required>
                                                        <label for="inputReferencia" class="text-muted"><fmt:message key="gestion.modal.edit.ref" bundle="${lang}"/></label>

                                                        <div id="invalidRef" class="invalid-feedback col-10">
                                                            <fmt:message key="gestion.modal.edit.refInval" bundle="${lang}"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-floating mb-2">
                                                        <input id="modEditNombre" style="height: 45px;" type="text" class="form-control" placeholder="Nombre">
                                                        <label for="inputNombre" class="text-muted"><fmt:message key="gestion.modal.edit.nombre" bundle="${lang}"/></label>

                                                        <div id="feedbackNombre" class="invalid-feedback col-10">
                                                            <fmt:message key="gestion.modal.edit.nombreInval" bundle="${lang}"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-floating mb-2">
                                                        <input id="modEditTipo" style="height: 45px;" type="text" class="form-control"  placeholder="Tipo" required>
                                                        <label for="modEditTipo" class="text-muted"><fmt:message key="gestion.modal.edit.tipo" bundle="${lang}"/></label>

                                                        <div id="invalidTipo" class="invalid-feedback col-10">
                                                            <fmt:message key="gestion.modal.edit.tipoInval" bundle="${lang}"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-floating mb-2">
                                                        <input id="modEditVol" style="height: 45px;" type="text" class="form-control"  placeholder="VolumenA" required>
                                                        <label for="modEditVol" class="text-muted"><fmt:message key="gestion.modal.edit.vol" bundle="${lang}"/> (ml)</label>

                                                        <div id="invalidTipo" class="invalid-feedback col-10">
                                                            <fmt:message key="gestion.modal.edit.volInval" bundle="${lang}"/>
                                                        </div>
                                                    </div>
                                                    <div class="mb-2">
                                                        <div class="form-floating mb-2">
                                                            <input id="modEditFab" style="height: 45px;" type="text" class="form-control"  placeholder="Distribuidor" required>
                                                            <label for="modEditFab" class="text-muted"><fmt:message key="gestion.modal.edit.dis" bundle="${lang}"/></label>

                                                            <div id="invalidTipo" class="invalid-feedback col-10">
                                                                <fmt:message key="gestion.modal.edit.disInval" bundle="${lang}"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-floating mb-3 mt-3">
                                                        <textarea style="height: 140px;" class="form-control" placeholder="Descripción" id="modEditDes" maxlength="400"></textarea>
                                                        <label for="inputDescripcion" class="text-muted"><fmt:message key="gestion.modal.edit.des" bundle="${lang}"/> <i id="contador">400</i>)</label>
                                                        <div class="invalid-feedback col-10">
                                                            <fmt:message key="gestion.modal.edit.desInval" bundle="${lang}"/>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col p-2 m-2 shadow-sm border-light rounded-3"> <!-- columna del centro-->
                                                    <div class="mb-2">
                                                        <select style="height: 45px;font-size: 0.9em;" class="form-select" aria-label="Seleccione IVA" id="modEditIVA">
                                                            <option value="0" selected><fmt:message key="gestion.modal.edit.selectIVA0" bundle="${lang}"/></option>
                                                            <option value="4"><fmt:message key="gestion.modal.edit.selectIVA1" bundle="${lang}"/></option>
                                                            <option value="10"><fmt:message key="gestion.modal.edit.selectIVA2" bundle="${lang}"/></option>
                                                            <option value="21"><fmt:message key="gestion.modal.edit.selectIVA3" bundle="${lang}"/></option>
                                                        </select>
                                                        <div class="invalid-feedback col-10">
                                                            <fmt:message key="gestion.modal.edit.selectIVAInval" bundle="${lang}"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-floating mb-2">
                                                        <input style="height: 45px;font-size: 0.9em;width: 220px;" type="number" class="form-control" id="modEditPrecioSinIVA" placeholder="PrecioSinIVA" required
                                                               oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                               step="0.01" min="1" maxlength="9">
                                                        <label for="inputPrecioSinIVA" class="text-muted"><fmt:message key="gestion.modal.edit.precioSin" bundle="${lang}"/>  <i class="fad fa-euro-sign"></i></label>
                                                        <div class="invalid-feedback col-10">
                                                            <fmt:message key="gestion.modal.edit.precioSinInval" bundle="${lang}"/>
                                                        </div>
                                                    </div>

                                                    <div class="form-floating mb-2">
                                                        <input style="height: 45px;font-size: 0.9em;width: 220px;" type="number" class="form-control" id="modEditPVP" placeholder="PVP" required
                                                               value="0.00" disabled>
                                                        <label for="modEditPVP" class="text-muted"><fmt:message key="gestion.modal.edit.pvp" bundle="${lang}"/>  <i class="fad fa-euro-sign"></i></label>
                                                    </div>

                                                    <hr class="bg-sucess my-2" style="color: green; height: 4px;">

                                                    <div class="row align-items-center">
                                                        <img id="modEditImg" class="" src="" style="width: 250px;"/>
                                                    </div>
                                                </div> 
                                            </div>
                                        </form>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" name="btnCerrarModalEdit" id="btnCerrarModalEdit" class="btn btn-outline-dark" data-bs-dismiss="modal"><fmt:message key="btn.volver" bundle="${lang}"/></button>
                                        <button name="btnEditarArt" id="btnEditarArt" class="btn btn-success"><fmt:message key="btn.editar" bundle="${lang}"/></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-content mx-4" id="myTabContent">
                        <div class="tab-pane fade show active" id="articulos" role="tabpanel" aria-labelledby="articulos-tab">
                            <%--Contenido del panel Artículos--%>

                            <div class="d-flex align-items-start my-3">
                                <div class="nav flex-column nav-pills me-3 d-none d-md-block" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                    <button class="nav-link active mb-2 btnMenuLateral shadow bg-white" style="color: dark;" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true"><fmt:message key="gestion.btn.todos" bundle="${lang}"/></button>
                                    <button class="nav-link mb-2 btnMenuLateral shadow " id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false"><fmt:message key="gestion.btn.plantas" bundle="${lang}"/></button>
                                    <button class="nav-link mb-2 btnMenuLateral shadow" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false"><fmt:message key="gestion.btn.abonos" bundle="${lang}"/></button>
                                    <button class="nav-link mb-2 btnMenuLateral shadow" data-bs-toggle="pill" id="v-pills-settings-tab" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false"><fmt:message key="gestion.btn.macetas" bundle="${lang}"/></button>
                                </div>


                                <div class="tab-content" id="v-pills-tabContent">

                                    <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                                        <div class="row m-4">
                                            <div class="col-12 col-lg-6  border rounded-3 p-3 shadow-sm">
                                                <label class="form-label fw-bolder ms-1" for="selectAgregar"><fmt:message key="gestion.agregarArt.titulo" bundle="${lang}"/></label>
                                                <div class="row">
                                                    <div class="col-9">
                                                        <select class="form-select" aria-label="Agregar nuevo artículo" id="selectAgregar">
                                                            <option value="0" selected><fmt:message key="gestion.agregarArt.sel.0" bundle="${lang}"/></option>
                                                            <option value="1"><fmt:message key="gestion.agregarArt.sel.1" bundle="${lang}"/></option>
                                                            <option value="2"><fmt:message key="gestion.agregarArt.sel.2" bundle="${lang}"/></option>
                                                            <option value="3"><fmt:message key="gestion.agregarArt.sel.3" bundle="${lang}"/></option>
                                                        </select>
                                                    </div>
                                                    <div class="col-3">
                                                        <button id="btnAgregarArt" class="btn btn-outline-seconday w-100" disabled><fmt:message key="gestion.agregarArt.btn" bundle="${lang}"/></button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%--Contenido articulos/todos--%>
                                        <section class="wrap">
                                            <div class="container-fluid ms-0 p-0 ms-lg-3">
                                                <!--<div class="table-responsive-xl">-->
                                                <table class="table table-sm table-bordered table-striped table-hover shadow-sm text-center sortable" id="tableArtSort" width="100%">
                                                    <caption><fmt:message key="gestion.table.caption.art" bundle="${lang}"/> <b>${tienda.articulos.size()}</b></caption>
                                                    <thead>
                                                        <tr><th class="align-middle p-2 sorttable_nosort"><fmt:message key="gestion.table.img" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2"><fmt:message key="gestion.table.ref" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-lg-table-cell"><fmt:message key="gestion.table.cat" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2"><fmt:message key="gestion.table.nombre" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2"><fmt:message key="gestion.table.fabricante" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-lg-table-cell"><fmt:message key="gestion.table.precio" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-lg-table-cell"><fmt:message key="gestion.table.pvp" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-lg-table-cell"><fmt:message key="gestion.table.total" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-xl-table-cell"><fmt:message key="gestion.table.stock" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-xl-table-cell"><fmt:message key="gestion.table.ventas" bundle="${lang}"/></th>
                                                            <th class="p-3 sorttable_nosort"></th>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="ar" items="${tienda.agruparArticulosRef()}">
                                                            <tr>
                                                                <td class="align-middle m-0 p-0"><img class="m-0 p-0" src="../img/articulos/${ar.nombreImagen}" style="width: 100px;"/></td>
                                                                <td class="align-middle p-2">${ar.referencia}</td>
                                                                <td id="campoCategoria" class="align-middle p-2 d-none d-lg-table-cell">${ar.categoria}</td>
                                                                <td class="align-middle p-2">${ar.nombre}</td>
                                                                <td class="align-middle p-2">${ar.fabricante}</td>
                                                                <td class="align-middle p-2 d-none d-lg-table-cell"><fmt:formatNumber value = "${ar.precioSinIVA}" type = "currency"/></td>
                                                                <td class="align-middle p-2 d-none d-lg-table-cell"><fmt:formatNumber value = "${ar.precio}" type = "currency"/></td>
                                                                <td class="align-middle p-2 d-none d-lg-table-cell">${tienda.stockTotalArticulo(ar.referencia)} uds.</td>
                                                                <td class="align-middle p-2 d-none d-xl-table-cell" <c:if test="${tienda.stockParcialArticulo(ar.referencia, false) == 0}">style="color: red; font-weight: 500;"</c:if>>
                                                                    ${tienda.stockParcialArticulo(ar.referencia, false)}
                                                                </td>
                                                                <td class="align-middle d-none d-xl-table-cell">${tienda.stockParcialArticulo(ar.referencia, true)}</td>

                                                                <td class="align-middle p-lg-0">
                                                                    <div class="container p-lg-0">
                                                                        <div class="row px-lg-0 mx-lg-0" >
                                                                            <div class="col-12 col-md-6 mx-md-0 pe-md-0" >
                                                                                <!--Controlamos con javascript la que solo permita 2 digitos-->
                                                                                <input type="number" id="inputNumber${ar.referencia}" class="form-control form-control-sm inline ms-2 mb-1 me-lg-0 pe-lg-0" 
                                                                                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                                                       step="1" value="1" min="1" max="99" maxlength="2" />  
                                                                            </div>
                                                                            <div class="col-12 col-md-6 mx-md-0 ps-md-0">
                                                                                <button id="" data="${ar.referencia}" type="button" class="btnAddUnidades btn btn-outline-success mb-1 ms-lg-0" title="<fmt:message key="gestion.tooltip.agregarUni" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                    <i class="fad fa-plus inline"></i>
                                                                                </button>

                                                                            </div>
                                                                        </div>
                                                                        <div class="row mt-lg-1 mx-lg-0 px-lg-0">
                                                                            <div class="col-12 col-md-6 mx-md-0 pe-md-0">
                                                                                <button id="" data="${ar.referencia}" type="button" class="btnEditArt btn btn-outline-success mb-1 me-lg-2" title="<fmt:message key="gestion.tooltip.editar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                    <i class="fad fa-edit"></i>
                                                                                </button>
                                                                            </div>
                                                                            <div class="col-12 col-md-6 mx-md-0 ps-md-0">
                                                                                <button id="" data1="${ar.referencia}" data2="${tienda.stockTotalArticulo(ar.referencia)}" type="button" class="btnRmvArt btn btn-success" title="<fmt:message key="gestion.tooltip.eliminar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
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
                                                        <a href="../principal.jsp" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-arrow-alt-left fa-2x"></i> <fmt:message key="btn.volver" bundle="${lang}"/></a>
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
                                                    <table class="table table-sm table-bordered table-striped table-hover shadow text-center sortable" id="tablePla">
                                                        <caption><fmt:message key="gestion.table.caption.pla" bundle="${lang}"/> <b>${tienda.plantas.size()}</b></caption>
                                                        <thead>
                                                            <tr><th class="align-middle p-2 sorttable_nosort"><fmt:message key="gestion.table.img" bundle="${lang}"/></th>
                                                                <th class="align-middle p-2"><fmt:message key="gestion.table.ref" bundle="${lang}"/></th>
                                                                <th class="align-middle p-2"><fmt:message key="gestion.table.nombre" bundle="${lang}"/></th>
                                                                <th class="align-middle p-2"><fmt:message key="gestion.table.distribuidor" bundle="${lang}"/></th>
                                                                <th class="align-middle p-2 d-none d-lg-table-cell"><fmt:message key="gestion.table.precio" bundle="${lang}"/></th>
                                                                <th class="align-middle p-2 d-none d-md-table-cell"><fmt:message key="gestion.table.pvp" bundle="${lang}"/></th>
                                                                <th class="align-middle p-2 d-none d-lg-table-cell"><fmt:message key="gestion.table.total" bundle="${lang}"/></th>
                                                                <th class="align-middle p-2 d-none d-xl-table-cell"><fmt:message key="gestion.table.stock" bundle="${lang}"/></th>
                                                                <th class="align-middle p-2 d-none d-md-table-cell"><fmt:message key="gestion.table.ventas" bundle="${lang}"/></th>
                                                                <th class="p-3 sorttable_nosort"></th>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="pla" items="${tienda.agruparArticulosPorRefTipo('Planta')}">
                                                                <tr>
                                                                    <td class="align-middle p-0 m-0"><img class="p-0 m-0" src="../img/articulos/${pla.nombreImagen}" style="width: 100px;"/></td>

                                                                    <td class="align-middle">${pla.referencia}</td>
                                                                    <td class="align-middle">${pla.nombre}</td>
                                                                    <td class="align-middle">${pla.fabricante}</td>

                                                                    <td class="align-middle d-none d-lg-table-cell"><fmt:formatNumber value = "${pla.precioSinIVA}" type = "currency"/></td>
                                                                    <td class="align-middle d-none d-md-table-cell"><fmt:formatNumber value = "${pla.precio}" type = "currency"/></td>
                                                                    <td class="align-middle d-none d-lg-table-cell">${tienda.stockTotalArticulo(pla.referencia)} uds.</td>

                                                                    <td class="align-middle d-none d-xl-table-cell" <c:if test="${tienda.stockParcialArticulo(pla.referencia, false) == 0}">style="color: red; font-weight: 500;"</c:if>>
                                                                        ${tienda.stockParcialArticulo(pla.referencia, false)}
                                                                    </td>
                                                                    <td class="align-middle d-none d-md-table-cell">${tienda.stockParcialArticulo(pla.referencia, true)}</td>
                                                                    <td class="align-middle p-0">
                                                                        <div class="container p-0">
                                                                            <div class="row px-0 mx-0" >
                                                                                <div class="col-12 col-md-6 mx-md-0 pe-md-0" >
                                                                                    <!--Controlamos con javascript la que solo permita 2 digitos-->
                                                                                    <input type="number" id="inputNumber${pla.referencia}" class="form-control form-control-sm inline me-md-0 pe-md-0" 
                                                                                           oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                                                           step="1" value="1" min="1" max="99" maxlength="2" />  
                                                                                </div>
                                                                                <div class="col-12 col-md-6 mx-md-0 ps-md-0">
                                                                                    <button id="" data="${pla.referencia}" type="button" class="btnAddUnidades btn btn-outline-success ms-md-0" title="<fmt:message key="gestion.tooltip.agregarUni" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                        <i class="fad fa-plus inline"></i>
                                                                                    </button>

                                                                                </div>
                                                                            </div>
                                                                            <div class="row mt-1 mx-0 px-0 mt-2">
                                                                                <div class="col-12 col-md-6 mx-md-0 pe-md-0">
                                                                                    <button id="" data="${pla.referencia}" type="button" class="btnEditArt btn btn-outline-success me-md-2" title="<fmt:message key="gestion.tooltip.editar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                        <i class="fad fa-edit"></i>
                                                                                    </button>
                                                                                </div>
                                                                                <div class="col-12 col-md-6 mx-md-0 ps-md-0">
                                                                                    <button id="" data1="${pla.referencia}" data2="${tienda.stockTotalArticulo(pla.referencia)}" type="button" class="btnRmvArt btn btn-success" title="<fmt:message key="gestion.tooltip.eliminar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
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
                                                            <a href="../principal.jsp" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-arrow-alt-left fa-2x" ></i> <fmt:message key="btn.volver" bundle="${lang}"/></a>
                                                        </div>
                                                    </div>

                                                    <!--</div>-->
                                                </div>
                                            </section>
                                        </div>

                                    </div>
                                    <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">


                                        <section class="wrap">
                                            <div class="container-fluid">
                                                <!--<div class="table-responsive-xl">-->
                                                <table class="table table-sm table-bordered table-striped table-hover shadow text-center sortable" id="tableAbo">
                                                    <caption><fmt:message key="gestion.table.caption.abo" bundle="${lang}"/> <b>${tienda.abonos.size()}</b></caption>
                                                    <thead>
                                                        <tr><th class="align-middle p-2 sorttable_nosort"><fmt:message key="gestion.table.img" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2"><fmt:message key="gestion.table.ref" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2"><fmt:message key="gestion.table.nombre" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2"><fmt:message key="gestion.table.fabricante" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-lg-table-cell"><fmt:message key="gestion.table.volumen" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-lg-table-cell"><fmt:message key="gestion.table.precio" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-md-table-cell"><fmt:message key="gestion.table.pvp" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-lg-table-cell"><fmt:message key="gestion.table.total" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-xl-table-cell"><fmt:message key="gestion.table.stock" bundle="${lang}"/></th>
                                                            <th class="align-middle p-2 d-none d-md-table-cell"><fmt:message key="gestion.table.ventas" bundle="${lang}"/></th>
                                                            <th class="p-3 sorttable_nosort"></th>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="abo" items="${tienda.agruparArticulosPorRefTipo('Abono')}">
                                                            <tr>
                                                                <td class="align-middle p-0 m-0"><img class="p-0 m-0" src="../img/articulos/${abo.nombreImagen}" style="width: 100px;"/></td>
                                                                <td class="align-middle">${abo.referencia}</td>
                                                                <td class="align-middle">${abo.nombre}</td>
                                                                <td class="align-middle">${abo.fabricante}</td>
                                                                <td class="align-middle d-none d-lg-table-cell">${abo.volumen} ml</td>
                                                                <td class="align-middle d-none d-lg-table-cell"><fmt:formatNumber value = "${abo.precioSinIVA}" type = "currency"/></td>
                                                                <td class="align-middle d-none d-md-table-cell"><fmt:formatNumber value = "${abo.precio}" type = "currency"/></td>
                                                                <td class="align-middle d-none d-lg-table-cell">${tienda.stockTotalArticulo(abo.referencia)} uds.</td>
                                                                <td class="align-middle d-none d-xl-table-cell" <c:if test="${tienda.stockParcialArticulo(abo.referencia, false) == 0}">style="color: red; font-weight: 500;"</c:if>>
                                                                    ${tienda.stockParcialArticulo(abo.referencia, false)}
                                                                </td>
                                                                <td class="align-middle d-none d-md-table-cell">${tienda.stockParcialArticulo(abo.referencia, true)}</td>
                                                                <td class="align-middle p-0">
                                                                    <div class="container p-0">
                                                                        <div class="row px-0 mx-0" >
                                                                            <div class="col-12 col-md-6 mx-md-0 pe-md-0" >
                                                                                <!--Controlamos con javascript la que solo permita 2 digitos-->
                                                                                <input type="number" id="inputNumber${abo.referencia}" class="form-control form-control-sm inline me-md-0 pe-md-0" 
                                                                                       oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                                                       step="1" value="1" min="1" max="99" maxlength="2" />  
                                                                            </div>
                                                                            <div class="col-12 col-md-6 mx-md-0 ps-md-0">
                                                                                <button id="" data="${abo.referencia}" type="button" class="btnAddUnidades btn btn-outline-success ms-md-0" title="<fmt:message key="gestion.tooltip.agregarUni" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                    <i class="fad fa-plus inline"></i>
                                                                                </button>

                                                                            </div>
                                                                        </div>
                                                                        <div class="row mt-1 mx-0 px-0 mt-2">
                                                                            <div class="col-12 col-md-6 mx-md-0 pe-md-0">
                                                                                <button id="" data="${abo.referencia}" type="button" class="btnEditArt btn btn-outline-success me-md-2" title="<fmt:message key="gestion.tooltip.editar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                    <i class="fad fa-edit"></i>
                                                                                </button>
                                                                            </div>
                                                                            <div class="col-12 col-md-6 mx-md-0 ps-md-0">
                                                                                <button data1="${abo.referencia}" data2="${tienda.stockTotalArticulo(abo.referencia)}" type="button" class="btnRmvArt btn btn-success" title="<fmt:message key="gestion.tooltip.eliminar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
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
                                                        <a href="../principal.jsp" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-arrow-alt-left fa-2x"></i> <fmt:message key="btn.volver" bundle="${lang}"/></a>
                                                    </div>
                                                </div>

                                                <!--</div>-->
                                            </div>
                                        </section>


                                    </div>
                                    <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
                                        Contenido articulos/macetas

                                        <h1 class="display-1"><fmt:message key="gestion.macetas.proximamente" bundle="${lang}"/></h1>
                                    </div>

                                </div>
                            </div>



                        </div>
                        <div class="tab-pane fade" id="usuarios" role="tabpanel" aria-labelledby="usuarios-tab">
                            <%--Contenido del panel Usuarios--%>
                            <div class="container-fluid my-3"> 
                                <section class="">
                                    <div class="border rounded-3 p-3 mb-3 mt-5 ms-2 shadow-sm col-12 col-md-8 col-lg-6">
                                        <div class="row">
                                            <div class="col-12 mb-2 ms-1">
                                                <span class=""><b><fmt:message key="gestion.buscarUsuario.titulo" bundle="${lang}"/></b></span>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-6">

                                                <div class="form-floating">
                                                    <input style="height: 50px;" type="text" class="form-control" id="filtroNombre" placeholder="Nombre">
                                                    <label for="filtroNombre" class="text-muted"><fmt:message key="gestion.table.nombre" bundle="${lang}"/></label>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <input style="height: 50px;" type="text" class="form-control" id="filtroDNI" placeholder="DNI">
                                                    <label for="filtroDNI" class="text-muted" maxlength="9"><fmt:message key="gestion.table.dni" bundle="${lang}"/></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>  
                                    <div class="container-fluid">
                                        <!-- Aquí va el import correspondiente a la tabla usuarios-->
                                        <div id="listadoUsuarios">
                                            <c:import url="filtradoUsuarios.jsp">
                                                <%--<c:param name="filtro" value=""/>--%>
                                            </c:import>
                                        </div>
                                        <div class="row d-flex justify-content-between">
                                            <div class="col-auto">
                                                <a href="../principal.jsp" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-arrow-alt-left fa-2x" style="text-shadow: 1px 1px 1px black;"></i> <fmt:message key="btn.volver" bundle="${lang}"/></a>
                                            </div>
                                        </div>

                                        <!--</div>-->
                                    </div>
                                </section>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="pedidos" role="tabpanel" aria-labelledby="pedidos-tab">
                            <%--Contenido del panel Pedidos--%>
                            <div class="container-fluid my-3"> 
                                <section class="">

                                    <div class="container-fluid">

                                        <div id="listadoPedidos">
                                            <table class="table table-sm table-bordered table-striped table-hover shadow text-center sortable" id="tablePed">
                                                <caption><fmt:message key="gestion.table.caption.ped" bundle="${lang}"/> <b>${tienda.pedidos.size()}</b></caption>
                                                <thead>
                                                    <tr>
                                                        <th class="align-middle p-2"><fmt:message key="gestion.table.pedId" bundle="${lang}"/></th>
                                                        <th class="align-middle p-2"><fmt:message key="gestion.table.pedFec" bundle="${lang}"/></th>
                                                        <th class="align-middle p-2"><fmt:message key="gestion.table.pedUsu" bundle="${lang}"/></th>
                                                        <th class="align-middle p-2"><fmt:message key="gestion.table.pedNumart" bundle="${lang}"/></th>
                                                        <th class="align-middle p-2 d-none d-md-table-cell"><fmt:message key="gestion.table.pedTotalSinIVA" bundle="${lang}"/></th>
                                                        <th class="align-middle p-2"><fmt:message key="gestion.table.pedTotal" bundle="${lang}"/></th>
                                                        <th class="p-3 sorttable_nosort"></th>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="ped" items="${tienda.getPedidos()}">
                                                        <tr>
                                                            <td class="align-middle">${ped.getId()}</td>
                                                            <td class="align-middle">${ped.getFecha()}</td>
                                                            <td class="align-middle">${ped.getUsuario().getNombre()} ${ped.getUsuario().getApellidos()}</td>
                                                            <td class="align-middle">${ped.getNumArticulos()} uds.</td>
                                                            <td class="align-middle sorttable_numeric d-none d-md-table-cell"><fmt:formatNumber value = "${ped.totalSinIVA}" type = "currency"/></td>
                                                            <td class="align-middle sorttable_numeric"><fmt:formatNumber value = "${ped.total}" type = "currency"/></td>
                                                            <td class="align-middle p-0">
                                                                <div class="container p-0">
                                                                    <div class="row mx-0 px-0 my-2">
                                                                        <div class="col-sm-12 col-lg-4 mt-1">
                                                                            <button onclick="alert('Próximamente')" style="width:40px;" id="" data="${ped.getId()}" type="button" class="btnEditPed btn btn-success" title="<fmt:message key="gestion.tooltip.editar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                <i class="fad fa-edit"></i>
                                                                            </button>
                                                                        </div>
                                                                        <div class="col-sm-12 col-lg-4 mt-1">
                                                                            <button style="width:40px;" id="" data="${ped.getId()}" type="button" class="imprimirPed btn btn-success" title="<fmt:message key="misPedidos.tooltip.imprimir" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                                                                <i class="fad fa-print"></i>
                                                                            </button>
                                                                        </div>
                                                                        <div class="col-sm-12 col-lg-4 mt-1">
                                                                            <button style="width:40px;" data1="${ped.getId()}" data2="" type="button" class="btnRmvPed btn btn-success" title="<fmt:message key="gestion.tooltip.eliminar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
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
                                        </div>
                                        <div class="row d-flex justify-content-between">
                                            <div class="col-auto">
                                                <a href="../principal.jsp" class="text-decoration-none text-success" style="font-weight: bold;"><i class="fad fa-arrow-alt-left fa-2x" style="text-shadow: 1px 1px 1px black;"></i> <fmt:message key="btn.volver" bundle="${lang}"/></a>
                                            </div>
                                        </div>

                                        <!--</div>-->
                                    </div>
                                </section>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="estadisticas" role="tabpanel" aria-labelledby="estadisticas-tab">
                            <%--Contenido del panel Estadísticas--%>

                            <div class="container-fluid my-5" >
                                <div class="accordion" id="estGeneral">
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingOne">
                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="true" aria-controls="collapse1">
                                                <fmt:message key="est.general" bundle="${lang}"/>
                                            </button>
                                        </h2>
                                        <div id="collapse1" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#estGeneral">
                                            <div class="accordion-body">

                                                <div class="accordion" id="est1">
                                                    <div class="accordion-item">
                                                        <h2 class="accordion-header" id="headingOne">
                                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse11" aria-expanded="true" aria-controls="collapse11">
                                                                <fmt:message key="est.finanzas" bundle="${lang}"/> (<c:if test = "${fn:contains(varLocale, 'es')}"> ¤</c:if> <c:if test = "${fn:contains(varLocale, 'en')}">£</c:if>)
                                                                </button>
                                                            </h2>
                                                            <div id="collapse11" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#est1">
                                                                <div class="accordion-body">
                                                                    <p><fmt:message key="est.f1" bundle="${lang}"/> <span id="totalDineroArtInvertido"></span></p>
                                                                    <p><fmt:message key="est.f2" bundle="${lang}"/> <span id="totalDineroArtSin"></span></p>
                                                                    <p><fmt:message key="est.f3" bundle="${lang}"/> <span id="totalDineroArt"></span></p>
                                                                    <hr>
                                                                    <p><fmt:message key="est.f4" bundle="${lang}"/> <span id="totalDineroPedSin"></span></p>
                                                                    <p><fmt:message key="est.f5" bundle="${lang}"/> <span id="totalDineroPed"></span></p>
                                                                    <hr>
                                                                    <p><fmt:message key="est.f6" bundle="${lang}"/> <span id="beneficio"></span></p>
                                                                    <p><fmt:message key="est.f7" bundle="${lang}"/> <span id="beneficioNeto"></span></p>
                                                                </div>
                                                            </div>
                                                        </div></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingTwo">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                    <fmt:message key="est.usuarios" bundle="${lang}"/>
                                                </button>
                                            </h2>
                                            <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#estGeneral">
                                                <div class="accordion-body">
                                                    <p><fmt:message key="est.u1" bundle="${lang}"/> <span id="totalUsu"></span></p>
                                                    <p><fmt:message key="est.u2" bundle="${lang}"/> <span id="totalAdmin"></span></p>
                                                    <p><fmt:message key="est.u3" bundle="${lang}"/> <span id="usuPedidos"></span></p>
                                                    <p><fmt:message key="est.u4" bundle="${lang}"/> (<span id="maxNumPed"></span>) (<span id="numMejoresUsu"></span> <fmt:message key="est.u6" bundle="${lang}"/>): <span id="mejorUsuario"></span>
                                                    <p><fmt:message key="est.u5" bundle="${lang}"/> <span id="edadMediaUsu"></span></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingThree">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                    <fmt:message key="est.articulos" bundle="${lang}"/>
                                                </button>
                                            </h2>
                                            <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#estGeneral">
                                                <div class="accordion-body">
                                                    <p><fmt:message key="est.a1" bundle="${lang}"/> <span id="totalArt"></span></p>
                                                    <p><fmt:message key="est.a2" bundle="${lang}"/> <span id="totalArtDif"></span></p>
                                                    <p><fmt:message key="est.a3" bundle="${lang}"/> <span id="totalArtVen"></span></p>
                                                    <hr>
                                                    <p><fmt:message key="est.a4" bundle="${lang}"/> <span id="totalPla"></span></p>
                                                    <p><fmt:message key="est.a5" bundle="${lang}"/> <span id="totalPlaDif"></span></p>
                                                    <p><fmt:message key="est.a6" bundle="${lang}"/> <span id="totalPlaVen"></span></p>
                                                    <hr>
                                                    <p><fmt:message key="est.a7" bundle="${lang}"/> <span id="totalAbo"></span></p>
                                                    <p><fmt:message key="est.a8" bundle="${lang}"/> <span id="totalAboDif"></span></p>
                                                    <p><fmt:message key="est.a9" bundle="${lang}"/> <span id="totalAboVen"></span></p>
                                                    <hr>
                                                    <p><fmt:message key="est.a10" bundle="${lang}"/> <span id="bestSeller"></span></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingFour">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                                    <fmt:message key="est.pedidos" bundle="${lang}"/>
                                                </button>
                                            </h2>
                                            <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#estGeneral">
                                                <div class="accordion-body">
                                                    <p><fmt:message key="est.p1" bundle="${lang}"/> <span id="estTotalPed"></span></p>
                                                        <p><fmt:message key="est.p2" bundle="${lang}"/> <span id="gastoMedPed"></span> <b><c:if test = "${fn:contains(varLocale, 'es')}"> ¤</c:if> <c:if test = "${fn:contains(varLocale, 'en')}">£</c:if></b></p>
                                                    <p></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="herramientas" role="tabpanel" aria-labelledby="herramientas-tab">
                            <%--Contenido del panel Herramientas--%>
                            <div class="border rounded-3 p-4 shadow-sm col-12 col-md-8 col-lg-6 my-5 mx-3" style="background-color: rgba(255, 255, 255, 0.9);">
                                <span class="display-6"><fmt:message key="gestion.herramientas.importar.titulo" bundle="${lang}"/></span>
                                <form action="" method="POST" enctype="multipart/form-data">
                                    <div class="my-4">
                                        <label class="form-label" for="inputFilePlantas"><fmt:message key="gestion.herramientas.importar.plantas.label" bundle="${lang}"/></label>
                                        <input class="form-control" type="file" accept=".txt" id="inputFilePlantas">
                                    </div>
                                    <div class="my-4">
                                        <label class="form-label" for="inputFileAbonos"><fmt:message key="gestion.herramientas.importar.abonos.label" bundle="${lang}"/></label>
                                        <input class="form-control" type="file" accept=".txt" id="inputFileAbonos">
                                    </div>
                                    <div class="my-4">
                                        <label class="form-label" for="inputFileUsuarios"><fmt:message key="gestion.herramientas.importar.usuarios.label" bundle="${lang}"/></label>
                                        <input class="form-control" type="file" accept=".txt" id="inputFileUsuarios">
                                    </div>
                                    <hr class="featurette-divider">
                                    <div class="mt-3">
                                        <button id="btnImportar" style="height: 50px;" type="submit" 
                                                class="btn btn-outline-success mx-1 shadow border border-2 border-success w-100 fw-bold fs-5" value="Cargar"><i class="fad fa-file-import fa-2x"></i> <fmt:message key="gestion.herramientas.importar.btn" bundle="${lang}"/></button>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <img class="fixed-bottom img-fluid" src="../img/fondoGestion.jpg" style="z-index: -1;"> 

            <script src="../js/sortable.js"></script>                      
            <script src="../js/jquery-3.5.1.min.js" ></script>
            <!--<script src="../js/jquery.tablesort.js"></script>-->
            <script>
                $(".botonesTab").each(function () {
                    var activo = $(this).attr("aria-selected");
                    if (activo === "true") {
                        //$(this).css("background-color", "#198754");

                        //$(this).css("background", "linear-gradient(180deg, rgba(255,255,255,0.01) 0%, rgba(25,135,84,0.4968554072019433) 15%, rgba(25,135,84,1) 100%)");
                        $(this).css("background", "linear-gradient(180deg, rgba(0,82,53,0.7) 0%, rgba(0,82,53,0.8368813736432073) 35%, rgba(0,82,53,1) 100%)");
                        $(this).css("color", "white");
                    } else {
                        //$(this).css("background-color", "white");
                        $(this).css("background", "linear-gradient(180deg, rgba(0,0,0,0.05340798428746496) 0%, rgba(255,255,255,1) 50%, rgba(0,0,0,0.01340798428746496) 100%)")
                        $(this).css("color", "black");
                    }
                    ;
                });

                $(".btnMenuLateral").each(function () {
                    var activo = $(this).attr("aria-selected");
                    if (activo === "true") {
                        $(this).css("background", "linear-gradient(180deg, rgba(0,82,53,0.7) 0%, rgba(0,82,53,0.8368813736432073) 35%, rgba(0,82,53,1) 100%)");
                        $(this).css("color", "white");
                    } else {
                        $(this).css("background", "linear-gradient(180deg, rgba(0,0,0,0.05340798428746496) 0%, rgba(255,255,255,1) 50%, rgba(0,0,0,0.01340798428746496) 100%)")
                        $(this).css("color", "black");
                    }
                });

            </script>
            <script 
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
                crossorigin="anonymous"
            ></script>
            <script src="../js/font-awesome5.js" ></script>
            <script src="../js/activadores.js" ></script>  
            <script src="../js/agregarPlanta.js"></script>
            <script src="../js/gestionUsuarios.js"></script>

    </body>

</html>
