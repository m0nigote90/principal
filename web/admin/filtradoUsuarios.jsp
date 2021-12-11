<%-- 
    Document   : filtradoUsuarios
    Created on : 16-nov-2021, 19:50:10
    Author     : Pedro
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--<%@page contentType="text/html" pageEncoding="ISO-8859-15"%>--%>
<c:set var="usuarios" value="${tienda.filtrarUsuariosNombre(param.filtroNombre)}"/>
<table class="table table-sm table-bordered table-striped table-hover shadow text-center caption-top sortable" id="tableUsuSort" width="100%" style="background-color: rgba(255, 255, 255, 0.9);">

    <thead>
        <tr><th class="align-middle p-2"><fmt:message key="gestion.table.nombre" bundle="${lang}"/></th>
            <th class="align-middle p-2 d-none d-md-table-cell"><fmt:message key="gestion.table.edad" bundle="${lang}"/></th>
            <th class="align-middle p-2"><fmt:message key="gestion.table.dni" bundle="${lang}"/></th>
            <th class="align-middle p-2 d-none d-md-table-cell"><fmt:message key="gestion.table.correo" bundle="${lang}"/></th>
            <th class="align-middle p-2"><fmt:message key="gestion.table.fechaAlta" bundle="${lang}"/></th>
            <th class="align-middle p-2 d-none d-lg-table-cell"><fmt:message key="gestion.table.pedidos" bundle="${lang}"/></th>
            <th class="p-3 sorttable_nosort"></th>
    </thead>
    <tbody>
        <%-- <c:forEach var="usu" items="${tienda.usuarios}">
             <c:forEach var="usu" items="${registro.filtrarPacientesNombre(param.filtro)}">--%>

        <c:if test="${!empty param.filtroNombre && empty param.filtroDNI}">
            <c:set var="usuarios" value="${tienda.filtrarUsuariosNombre(param.filtroNombre)}"/>
        </c:if>
        <c:if test="${empty param.filtroNombre && !empty param.filtroDNI}">
            <c:set var="usuarios" value="${tienda.filtrarUsuariosDni(param.filtroDNI)}"/>
        </c:if>
        <c:if test="${!empty param.filtroNombre && !empty param.filtroDNI}">
            <c:set var="usuarios" value="${tienda.filtrarUsuariosNombreDni(param.filtroNombre, param.filtroDNI)}"/>
        </c:if>
    <caption><fmt:message key="gestion.table.caption.usu" bundle="${lang}"/> 
        <b>${tienda.getUsuarios().size()}</b><br>
        <fmt:message key="gestion.table.caption.coinci" bundle="${lang}"/>
        <b>${usuarios.size()}</b>
    </caption>
    <%--<c:forEach var="usu" items="${tienda.filtrarUsuariosNombre(param.filtroNombre)}">--%>
    <c:forEach var="usu" items="${usuarios}">         
        <tr>
            <td class="align-middle p-2">${usu.apellidos}, ${usu.nombre}</td>
            <td class="align-middle p-2 d-none d-md-table-cell">${usu.getEdad()}</td>
            <td class="align-middle p-2">${usu.getDNI()}</td>
            <td class="align-middle p-2 d-none d-md-table-cell">${usu.email}</td>

            <td class="align-middle p-2"><fmt:formatDate type = "both" 
                            dateStyle = "short" timeStyle = "short" value = "${usu.fechaAlta}" /></td>
            <td class="align-middle p-2 d-none d-lg-table-cell">${usu.getPedidos().size()}</td>


            <td class="align-middle p-0">
                <div class="container p-0">
                    <div class="row px-0 mx-0" >
                        <div class="col-6 mx-0 pe-0" >


                        </div>
                        <div class="col-6 mx-0 ps-0">


                        </div>
                    </div>
                    <div class="row mx-0 px-0 my-2">
                        <div class="col-12 col-lg-6 mx-lg-0 pe-lg-0">
                            <button id="" data="${usu.id}" type="button" class="btn btn-outline-success btnEditUsu" title="<fmt:message key="gestion.tooltip.editar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
                                <i class="fad fa-edit"></i>
                            </button>
                        </div>
                        <div class="col-12 mt-1 mt-lg-0 col-lg-6 mx-lg-0 ps-lg-0">
                            <button id="btnRmvArt" data="${usu.id}" type="button" class="btn btn-success btnBajaUsu" title="<fmt:message key="gestion.tooltip.eliminar" bundle="${lang}"/>" data-bs-toggle="tooltip" data-bs-placement="right">
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
    <script src="../js/gestionUsuarios.js"></script>
    <script src="../js/jquery-3.5.1.min.js"></script>
