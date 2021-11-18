<%-- 
    Document   : busquedaProductos
    Created on : 17-nov-2021, 16:32:15
    Author     : Pedro
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="articulos" value="${tienda.filtrarArticulos(param.filtro)}"/>

<%--<c:forEach var="pro" items="${productos}">
    <option><img src="img/articulos/${pro.getNombreImagen()}"> ${pro.getNombre()}</option>
</c:forEach>--%>
<div class="table-wrapper p-0 w-100 shadow" style="max-height: 480px; overflow: auto; display:inline-block;">
    <table class="table table-hover bg-light border rounded-3 m-0" style="cursor: pointer;">
        <c:forEach var="ar" items="${articulos}">
            <tr class="artBusqueda" id="${ar.getReferencia()}">
                <td><img style="width: 50px;" src="img/articulos/${ar.getNombreImagen()}"></td> 
                <td>${ar.getNombre()}<br><i class="text-muted" style="font-size: 0.8em;">${ar.getFabricante()}</i></td>
            </tr>
        </c:forEach>
    </table>
</div>

<script src="js/activadores.js"></script>