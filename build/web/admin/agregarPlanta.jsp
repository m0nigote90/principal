<%-- 
    Document   : agregarplanta
    Created on : 03-nov-2021, 19:40:50
    Author     : Pedro
--%>
<%@page import="com.sun.xml.internal.ws.util.StringUtils"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-15"%>
<fmt:requestEncoding value="ISO-8859-15" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
        <title>Eleplant</title>
        <link 
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
            rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
            crossorigin="anonymous"
            >

        <link rel="icon" type="image/png" href="../img/icono.png">
        <title>Eleplant - Gesti?n</title>
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
        <style>
            .btn-success, .btn-outline-success:hover{
                background: linear-gradient(180deg, rgba(0,82,53,0.7) 0%, rgba(0,82,53,0.8368813736432073) 35%, rgba(0,82,53,1) 100%);
                color: white;
            }
        </style>
    </head>
    <body>
        <header class="pt-2 bg-light sticky-top mb-0 shadow-sm" id="cabecera">

            <div class="container-fluid p-3 align-items-end bg-light ps-5" id="cabecera">
                <a class="navbar-brand" href="../admin/gestion.jsp"><img src="../img/logoLtrans.png" alt="logoEmpresa"
                                                                         width="60"></a>
                <a class="display-5 mx-4 text-decoration-none text-success cartel"><fmt:message key="gestion.altaPlanta.titulo" bundle="${lang}"/></a>
            </div>
        </header>
        <section class="m-5 border-light shadow-sm rounded-3">
            <form class="form needs-validation" novalidate style="background-color: rgba(255, 255, 255, 0.8);">
                <div class="row">
                    <div class="col-sm-12 col-lg-4 p-4 shadow-sm border-light rounded-3"> <!-- primera columna-->
                        <div class="form-floating mb-3">
                            <input style="height: 50px;" type="text" class="form-control" id="inputReferencia" placeholder="Referencia" required>
                            <label for="inputReferencia" class="text-muted"><fmt:message key="gestion.altaPlanta.ref" bundle="${lang}"/></label>

                            <div id="invalidRef" class="invalid-feedback col-10">
                                <fmt:message key="gestion.altaPlanta.invalidRef" bundle="${lang}"/>
                            </div>
                        </div>
                        <div class="form-floating mb-3">
                            <input style="height: 50px;" type="text" class="form-control" id="inputNombre" placeholder="Nombre">
                            <label for="inputNombre" class="text-muted"><fmt:message key="gestion.altaPlanta.nombre" bundle="${lang}"/></label>

                            <div id="feedbackNombre" class="invalid-feedback col-10">
                                <fmt:message key="gestion.altaPlanta.invalidNombre" bundle="${lang}"/>
                            </div>
                        </div>
                        <div class="mb-3">
                            <select style="height: 50px;" class="form-select" aria-label="Seleccione tipo" id="selectTipoPlanta">
                                <option value="0" selected><fmt:message key="gestion.altaPlanta.selectTipo" bundle="${lang}"/></option>
                                <c:forEach var="pla" items="${tienda.devuelveTipos('planta')}">
                                    <option value="${pla.tipo}"><c:out value="${StringUtils.capitalize(pla.tipo)}"/></option>                          
                                </c:forEach>
                                <option value="nuevo">+ <fmt:message key="gestion.altaPlanta.addTipoNuevo" bundle="${lang}"/></option>
                            </select>
                            <div class="invalid-feedback col-10">
                                <fmt:message key="gestion.altaPlanta.invalidSelectTipo" bundle="${lang}"/>
                            </div>

                        </div>
                        <div id="inputTipoNuevo" class="form-floating mb-3 mt-3" style="display: none;">
                            <input style="height: 50px;" type="text" class="form-control" id="inputTipoPlantaNuevo" placeholder="Tipo nuevo" required>
                            <label for="inputTipoPlantaNuevo" class="text-muted"><fmt:message key="gestion.altaPlanta.tipoNuevo" bundle="${lang}"/></label>
                            <div class="invalid-feedback col-10">
                                <fmt:message key="gestion.altaPlanta.invalidTipoNuevo" bundle="${lang}"/>
                            </div>
                        </div>
                        <div class="mb-3">
                            <select style="height: 50px;" class="form-select" aria-label="Seleccione distribuidor" id="selectFabricantePlanta">
                                <option value="0" selected><fmt:message key="gestion.altaPlanta.selectDis" bundle="${lang}"/></option>
                                <c:forEach var="pla" items="${tienda.devuelveFabricantes('Planta')}">
                                    <option value="${pla.fabricante}"><c:out value="${StringUtils.capitalize(pla.fabricante)}"/></option>                                    
                                </c:forEach>
                                <option value="nuevo">+ <fmt:message key="gestion.altaPlanta.addDisNuevo" bundle="${lang}"/></option>
                            </select>
                            <div class="invalid-feedback col-10">
                                <fmt:message key="gestion.altaPlanta.invalidDisNuevo" bundle="${lang}"/>
                            </div>
                            <div id="inputFabNuevo" class="form-floating mb-3 mt-3" style="display: none;">
                                <input style="height: 50px;" type="text" class="form-control" id="inputFabricanteNuevo" placeholder="Fabricante nuevo" required>
                                <label for="inputFabricanteNuevo" class="text-muted"><fmt:message key="gestion.altaPlanta.disNuevo" bundle="${lang}"/></label>
                                <div class="invalid-feedback col-10">
                                    <fmt:message key="gestion.altaPlanta.invalidDisNuevo" bundle="${lang}"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-floating mb-3 mt-3">
                            <textarea style="height: 200px;" class="form-control" placeholder="Descripci?n" id="inputDescripcion" maxlength="400"></textarea>
                            <label for="inputDescripcion" class="text-muted"><fmt:message key="gestion.altaPlanta.des" bundle="${lang}"/> <i id="contador">400</i>)</label>
                            <div class="invalid-feedback col-10">
                                <fmt:message key="gestion.altaPlanta.invalidDes" bundle="${lang}"/>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-sm-12 col-lg-4 p-4 shadow-sm border-light rounded-3"> <!-- columna del centro-->
                        <div class="mb-3">
                            <select style="height: 50px;" class="form-select" aria-label="Seleccione IVA" id="selectIVA">
                                <option value="0" selected><fmt:message key="gestion.altaPlanta.selectIVA" bundle="${lang}"/></option>
                                <option value="4"><fmt:message key="gestion.modal.edit.selectIVA1" bundle="${lang}"/></option>
                                <option value="10"><fmt:message key="gestion.modal.edit.selectIVA2" bundle="${lang}"/></option>
                                <option value="21"><fmt:message key="gestion.modal.edit.selectIVA3" bundle="${lang}"/></option>
                            </select>
                            <div class="invalid-feedback col-10">
                                <fmt:message key="gestion.modal.edit.selectIVAInval" bundle="${lang}"/>
                            </div>
                        </div>
                        <div class="form-floating mb-3">
                            <input style="height: 50px;" type="number" class="form-control" id="inputPrecioSinIVA" placeholder="PrecioSinIVA" required
                                   oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                   step="0.01" min="1" maxlength="9" disabled>
                            <label for="inputPrecioSinIVA" class="text-muted"><fmt:message key="gestion.modal.edit.precioSin" bundle="${lang}"/>  <fmt:message key="misPedidos.moneda" bundle="${lang}"/></i></label>
                            <div class="invalid-feedback col-10">
                                <fmt:message key="gestion.modal.edit.precioSinInval" bundle="${lang}"/>
                            </div>
                        </div>

                        <div class="form-floating mb-3">
                            <input style="height: 50px;" type="number" class="form-control" id="inputPVP" placeholder="PVP" required
                                   value="0.00" disabled>
                            <label for="inputPVP" class="text-muted"><fmt:message key="gestion.modal.edit.pvp" bundle="${lang}"/>  <fmt:message key="misPedidos.moneda" bundle="${lang}" /></label>
                        </div>
                        <div class="form-floating mb-5">
                            <!--Controlamos con javascript la que solo permita 3 digitos-->
                            <input type="number" id="inputUni" class="form-control" 
                                   oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                   step="1" value="1" min="1" max="99" maxlength="3" />
                            <label for="inputUni" class="text-muted"><fmt:message key="gestion.altaPlanta.numUnidades" bundle="${lang}"/></label>
                            <div class="invalid-feedback col-10">
                                <fmt:message key="gestion.altaPlanta.invalidNumUni" bundle="${lang}"/>
                            </div>
                        </div>
                        <hr class="bg-sucess my-2" style="color: green; height: 4px;">
                        <div class="row justify-content-center mt-5">
                            <div class="col">
                                <a href="gestion.jsp" class="btn btn-outline-dark shadow"><fmt:message key="btn.volver" bundle="${lang}"/></a>
                            </div>
                            <div class="col">
                                <button type="reset" class="btn btn-outline-success shadow"><fmt:message key="btn.reiniciar" bundle="${lang}"/></button>
                            </div>
                            <div class="col">
                                <button id="btnAgregarPlanta" type="submit" class="btn btn-success shadow w-100"><fmt:message key="btn.agregar" bundle="${lang}"/></button>
                            </div>
                        </div>
                    </div> 

                    <div class="col-sm-12 col-lg-4 p-4 shadow-sm border-light rounded-3"><!-- columna del final-->
                        <div class="row text-start shadow-sm fw-bold text-success">
                            <label class="label-form my-2"><fmt:message key="gestion.altaPlanta.plaDis" bundle="${lang}"/></label>
                        </div>
                        <div class="row">
                            <table class="table table-sm text-center">
                                <tr><th><fmt:message key="gestion.altaPlanta.table.ref" bundle="${lang}"/></th>
                                    <th><fmt:message key="gestion.altaPlanta.table.nom" bundle="${lang}"/></th>
                                    <th><fmt:message key="gestion.altaPlanta.table.tip" bundle="${lang}"/></th></tr>
                                        <c:forEach var="pla" items="${tienda.agruparArticulosPorRefTipo('Planta')}">
                                    <tr>
                                        <td>${pla.referencia}</td>
                                        <td>${pla.nombre}</td>
                                        <td>${pla.tipo}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div> 
                </div>
            </form>

        </section>
        <footer class="footer mt-auto py-3">
            <div class="container">
                
            </div>
        </footer>

               <img class="fixed-bottom img-fluid" src="../img/fondoAltaPlanta.jpg" style="z-index: -1;">







        <script src="../js/jquery-3.5.1.min.js" ></script>
        <script 
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
            crossorigin="anonymous"
        ></script>
        <script src="../js/font-awesome5.js" ></script>
        <script src="../js/activadores.js" ></script> 
        <script src="../js/agregarPlanta.js"></script>
    </body>
</html>
