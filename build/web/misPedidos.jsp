<%-- 
    Document   : misPedidos
    Created on : 19-nov-2021, 12:08:51
    Author     : Pedro
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-15"%>

<c:if test="${empty usuario}">
    <c:redirect url="principal.jsp"/>
</c:if>
<c:if test="${!empty usuario}">
    <c:set var="usu" value="${usuario}"/>
    <c:set var="numPedidos" value="${usu.getPedidos().size()}"/>
</c:if>
<c:if test="${!empty param.pedidoActivo}">
    <c:set var="articulosPedido" value="${pedidoActivo.getArticulos()}"/>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <link 
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
            rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
            crossorigin="anonymous"
            >
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
        <link rel="icon" type="image/png" href="img/icono.png">
        <link rel="stylesheet" href="sortable-theme-bootstrap.css" />
        <title>Eleplant</title>
        <style>
            html {
                height: 100%;
            }
            body {
                min-height: 100%;
            }
            #tbodyArt{
                height: 200px;
            }
            table.sortable th:not(.sorttable_sorted):not(.sorttable_sorted_reverse):not(.sorttable_nosort):after { 
                content: " \25BE";
                color: gainsboro;
                text-shadow: 0.2px 0.2px 0.2px grey;
            }
            th{
                cursor: pointer;
            }
            .btn-success, .btn-outline-success:hover{
                background: linear-gradient(180deg, rgba(0,82,53,0.7) 0%, rgba(0,82,53,0.8368813736432073) 35%, rgba(0,82,53,1) 100%);
                color: white;
            }
        </style>
        <script src="js/jquery-3.5.1.min.js"></script>
    </head>
    <body>
        <c:if test="${!empty varLocale}">
            <input id="localePedidos" type="hidden" value="${varLocale}"/>
        </c:if>
        <header class="pt-2 bg-light sticky-top mb-0 shadow" id="cabecera">

            <div class="container-fluid p-3 align-items-end bg-light" id="cabecera">
                <a class="navbar-brand ms-5" href="principal.jsp"><img src="img/logoLtrans.png" alt="logoEmpresa"
                                                                       width="100"></a>
                <a class="display-5 text-decoration-none text-success cartel"><fmt:message key="misPedidos.titulo" bundle="${lang}"/></a>
            </div>
        </header>
        <section class="wrap">
            <div class="container-fluid">
                <div class="row justify-content-between">
                    <div class="col-xs-10 col-lg-5 border-2 rounded-3 mt-2 mx-auto">
                        <p class="display-5"><fmt:message key="misPedidos.lista" bundle="${lang}"/></p>
                        <table data-sortable class="table table-sm table-responsive table-bordered table-striped table-hover shadow text-center rounded rounded-3 sortable" id="tablePedidosUsu">
                            <caption><fmt:message key="misPedidos.caption" bundle="${lang}"/> <b>${numPedidos}</b></caption>
                            <thead>
                                <tr>
                                    <th class="align-middle p-2"><fmt:message key="misPedidos.numero" bundle="${lang}"/></th>
                                    <th class="align-middle p-2"><fmt:message key="misPedidos.fecha" bundle="${lang}"/></th>
                                    <th class="align-middle p-2"><fmt:message key="misPedidos.numArt" bundle="${lang}"/></th>
                                    <th class="align-middle p-2"><fmt:message key="misPedidos.precioTotal" bundle="${lang}"/></th>
                                    <th class="p-3 sorttable_nosort"></th>
                            </thead>
                            <tbody>
                                <c:forEach var="ped" items="${usu.getPedidos()}">
                                    <tr>
                                        <td class="align-middle p-2">${ped.getId()}</td>
                                        <fmt:parseDate  value="${ped.getFecha()}"  type="date" pattern="yyyy-MM-dd" var="fechaParseada" />
                                        
                                        <td class="align-middle p-2"><fmt:formatDate type = "date" 
                            dateStyle = "short" timeStyle = "short" value = "${fechaParseada}" /></td>
                                        <td class="align-middle p-2">${ped.getNumArticulos()}</td>
                                        <td class="align-middle p-2"><fmt:formatNumber value = "${ped.getTotal()}" type = "currency"/></td>
                                        <td class="align-middle p-1">
                                            <div class="container p-0">
                                                <div class="row mt-1 mx-0 px-0 my-1">
                                                    <div class="col-6 mx-0 pe-0">
                                                        <button id="" data="${ped.getId()}" type="button" class="verPed btn btn-outline-success me-2" title="<fmt:message key="misPedidos.tooltip.ver" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                                            <i class="fad fa-eye"></i>
                                                        </button>
                                                    </div>
                                                    <div class="col-6 mx-0 ps-0">
                                                        <button id="" data="${ped.getId()}" type="button" class="imprimirPed btn btn-success" title="<fmt:message key="misPedidos.tooltip.imprimir" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                                            <i class="fad fa-print"></i>
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
                    <div class="col-xs-10 col-lg-5 rounded-3 mt-2 mx-auto mb-5">
                        <p class="display-5"><fmt:message key="misPedidos.detalles" bundle="${lang}"/></p>
                        <div class="row border border-2 rounded-3 shadow">
                            <div class="col m-2">
                                <div class="row bg-light border rounded-3 shadow pt-2">
                                    <div class="col-10 border border-light">
                                        <p class=""><b><fmt:message key="misPedidos.numPed" bundle="${lang}"/>: </b><span id="numPedido"></span></p>
                                        <p><b><fmt:message key="misPedidos.fecha" bundle="${lang}"/>: </b><span id="fecPedido"></span></p>
                                    </div>
                                    <div class="col-1">
                                        <img src="img/logoLtrans.png" alt="logoEmpresa" width="50">
                                    </div>
                                </div>
                                <div class="row mt-3 bg-light rounded-3 p3 shadow border" style="heigth: 200px;">
                                    <table id="listaArticulos" class="table text-center">
                                        <thead>
                                            <tr>
                                                <th class="align-middle"></th>
                                                <th class="align-middle"><fmt:message key="misPedidos.articulo" bundle="${lang}"/></th>
                                                <th class="align-middle"><fmt:message key="misPedidos.precio" bundle="${lang}"/></th>
                                                <th class="align-middle">x</th>
                                                <th class="align-middle"><fmt:message key="misPedidos.subtotal" bundle="${lang}"/></th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyArt">
                                            <%--Aqu? se inserta mediante funci?n Ajax--%>
                                        </tbody>
                                    </table>
                                    <hr class="bg-sucess border-2 border-top border-sucess">
                                    <div class="container">
                                        <div class="row justify-content-md-end me-3">
                                            <table class="table table-bordered table-striped w-50 shadow-sm">
                                                <tr><td class="text-end w-50"><b style="color: #C88307;"><fmt:message key="subtotal" bundle="${lang}"/>:</b></td><td id="subtotalPedido" class="text-end w-50"></td></tr>
                                                <tr><td class="text-end"><b style="color: #C88307;"><fmt:message key="impuestos" bundle="${lang}"/>:</b></td><td id="impuestosPedido" class="text-end"></td></tr>
                                                <tr><td class="text-end"><b style="color: #C88307;"><fmt:message key="total" bundle="${lang}"/>:</b></td><td id="totalPedido" class="text-end"></td></tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>







        <script 
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
            crossorigin="anonymous"
        ></script>
        <script src="js/font-awesome5.js"></script>
        <script src="js/activadores.js"></script>
        <script src='js/sortable.js'></script> 
    </body>
</html>
