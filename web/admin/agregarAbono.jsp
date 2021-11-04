<%-- 
    Document   : agregarabono
    Created on : 03-nov-2021, 19:43:44
    Author     : Pedro
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Elenplant</title>
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

        <script src='../js/sortable.js'></script>
    </head>
    <body>
        <header class="pt-2 bg-light sticky-top mb-0" id="cabecera">

            <div class="container-fluid p-3 align-items-end bg-light ms-4" id="cabecera">
                <a class="navbar-brand" href="../admin/gestion.jsp"><img src="../img/logoLtrans.png" alt="logoEmpresa"
                                                                     width="60"></a>
                <a class="display-5 mx-4 text-decoration-none text-success cartel">Área de Gestión - Agregar abono nuevo</a>
            </div>
        </header>
        
        
        
        
        
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
