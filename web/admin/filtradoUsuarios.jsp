<%-- 
    Document   : filtradoUsuarios
    Created on : 16-nov-2021, 19:50:10
    Author     : Pedro
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--<%@page contentType="text/html" pageEncoding="ISO-8859-15"%>--%>
<p>Filtro nombre: ${param.filtroNombre}</p>
<p>Filtro dni: ${param.filtroDNI}</p>
<table class="table table-sm table-bordered table-striped table-hover shadow text-center sortable" id="tableArt" width="100%">
    <caption><fmt:message key="gestion.table.caption.usu" bundle="${lang}"/> <b>${tienda.usuarios.size() - 1}</b></caption>
    <thead>
        <tr><th class="align-middle p-2"><fmt:message key="gestion.table.nombre" bundle="${lang}"/></th>
            <th class="align-middle p-2"><fmt:message key="gestion.table.edad" bundle="${lang}"/></th>
            <th class="align-middle p-2"><fmt:message key="gestion.table.dni" bundle="${lang}"/></th>
            <th class="align-middle p-2"><fmt:message key="gestion.table.correo" bundle="${lang}"/></th>
            <th class="align-middle p-2"><fmt:message key="gestion.table.fechaAlta" bundle="${lang}"/></th>
            <th class="align-middle p-2"><fmt:message key="gestion.table.pedidos" bundle="${lang}"/></th>
            <th class="p-3 sorttable_nosort"></th>
    </thead>
    <tbody>
        <%-- <c:forEach var="usu" items="${tienda.usuarios}">
             <c:forEach var="usu" items="${registro.filtrarPacientesNombre(param.filtro)}">--%>
        <c:set var="usuarios" value="${tienda.filtrarUsuariosNombre(param.filtroNombre)}"/>
        <c:if test="${!empty param.filtroNombre && empty param.filtroDNI}">
            <c:set var="usuarios" value="${tienda.filtrarUsuariosNombre(param.filtroNombre)}"/>
        </c:if>
        <c:if test="${empty param.filtroNombre && !empty param.filtroDNI}">
            <c:set var="usuarios" value="${tienda.filtrarUsuariosDni(param.filtroDNI)}"/>
        </c:if>
        <c:if test="${!empty param.filtroNombre && !empty param.filtroDNI}">
            <c:set var="usuarios" value="${tienda.filtrarUsuariosNombreDni(param.filtroNombre, param.filtroDNI)}"/>
        </c:if>

        <%--<c:forEach var="usu" items="${tienda.filtrarUsuariosNombre(param.filtroNombre)}">--%>
        <c:forEach var="usu" items="${usuarios}">
            <c:if test="${!usu.esAdmin()}">
                <tr>

                    <td class="align-middle p-2">${usu.apellidos}, ${usu.nombre}</td>
                    <td class="align-middle p-2">${usu.getEdad()}</td>
                    <td class="align-middle p-2">${usu.getDNI()}</td>
                    <td class="align-middle p-2">${usu.email}</td>

                    <td class="align-middle p-2"><fmt:formatDate type = "both" 
                                    dateStyle = "short" timeStyle = "short" value = "${usu.fechaAlta}" /></td>
                    <td class="align-middle p-2">${usu.getPedidos().size()}</td>


                    <td class="align-middle p-0">
                        <div class="container p-0">
                            <div class="row px-0 mx-0" >
                                <div class="col-6 mx-0 pe-0" >


                                </div>
                                <div class="col-6 mx-0 ps-0">


                                </div>
                            </div>
                            <div class="row mx-0 px-0 my-2">
                                <div class="col-6 mx-0 pe-0">
                                    <button id="" data="${usu.getDNI()}" type="button" class="btn btn-outline-success" title="<fmt:message key="gestion.tooltip.editar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                        <i class="fad fa-edit"></i>
                                    </button>
                                </div>
                                <div class="col-6 mx-0 ps-0">
                                    <button id="btnRmvArt" data="${usu.getDNI()}" type="button" class="btn btn-success" title="<fmt:message key="gestion.tooltip.eliminar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
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
<script src='../js/sortable.js'></script>
