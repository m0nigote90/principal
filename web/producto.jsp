<%-- 
    Document   : producto
    Created on : 18-nov-2021, 15:22:10
    Author     : Pedro
--%>
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
        <link 
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
            rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
            crossorigin="anonymous"
            >
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="icon" type="image/png" href="img/icono.png">
        <title>Eleplant</title>
    </head>
    <body>
        <header class="pt-2 bg-light sticky-top mb-0" id="cabecera">

            <div class="container-fluid p-3 align-items-end bg-light" id="cabecera">
                <a class="navbar-brand ms-5" href="principal.jsp"><img src="img/logoLtrans.png" alt="logoEmpresa"
                                                                          width="100"></a>
                <a class="display-5 text-decoration-none text-success cartel"><fmt:message key="detalleArt.titulo" bundle="${lang}"/> - ${ar.getNombre()}</a>
            </div>
        </header>


        <h1><c:out value="${ar.getNombre()}"/></h1>






        <script src="js/jquery-3.5.1.min.js"></script>
        <script 
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
            crossorigin="anonymous"
        ></script>
        <script src="js/font-awesome5.js"></script>
        <script src="js/activadores.js"></script>
    </body>
</html>
