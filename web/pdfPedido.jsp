<%-- 
    Document   : pdf
    Created on : 23-nov-2021, 14:42:12
    Author     : Pedro
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="modelo.Funcionalidad"%>
<%@page import="modelo.entidades.Pedido"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="modelo.entidades.Usuario"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-15"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer.*"%>
<%@page import="javax.servlet.ServletResponse"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/png" href="img/icono.png">
        <title>Eleplant</title>
    </head>

    <c:set var="usuActivo" value="${usuario}"/>
    <c:if test="${!empty usuario}">
        <c:set var="idUsuarioA" value="${Long.valueOf(usuario.getId())}"/>
        <c:set var="pedidos" value="${usuario.getPedidos()}"/>
    </c:if>
    <c:if test="${!empty param.idPedido}">           
        <c:set var="idPedido" value="${Long.valueOf(param.idPedido)}"/> 
    </c:if>
    <c:if test="${!empty param.idUsuario}">
        <c:set var="idUsuarioR" value="${Long.valueOf(param.idUsuario)}"/>
    </c:if>
    <c:if test="${!empty usuActivo && !empty idPedido}">
        <c:forEach var="p" items="${pedidos}">
            <c:if test="${p.getId() == idPedido}">
                <c:set var="pertenecePedido" value="${true}"/>
            </c:if>
        </c:forEach>

    </c:if>
    <c:if test="${empty idPedido}">
        <%
            out.print("<h2 style='color: red;' >Error. No se encuentra el pedido solicitado.</h2>");
        %>
    </c:if>


    <c:if test="${empty usuActivo}">
        <script>
            alert("No tienes permiso para ver esta página.");
        </script>
        <%
            out.print("<h2 style='color: red;' >Error. No puedes ver este pedido.\nAcceda desde su usuario.</h2>");
        %>
    </c:if>
    <c:if test="${!empty usuActivo && (idUsuarioA == idUsuarioR) && pertenecePedido}"><%-- Si el usuario logueado es igual al usuario que hace la Request, mostramos el pedido--%>

        <%
            HttpSession sesion = request.getSession();

            Usuario u = (Usuario) sesion.getAttribute("usuario");
            Connection con = null;
            File reportfile = new File(application.getRealPath("reportes/facturaPedido.jasper"));
            Map<String, Object> parameters = new HashMap<>();
            String idPed = request.getParameter("idPedido");
            String idUsu = request.getParameter("idUsuario");

            parameters.put("imgLogo", new String(getServletContext().getRealPath("/") + "reportes\\img\\logoLtrans.png"));//IMPORTANTE -> modificar para sistemas Unix las '\\' por '/'.
            parameters.put("imgFondo", new String(getServletContext().getRealPath("/") + "reportes\\img\\marcaAguaEleplant.png"));
            parameters.put("idPedido", new String(idPed));
            parameters.put("idUsuario", new String(idUsu));
            parameters.put("nombreCompletoU", new String(u.getNombre() + " " + u.getApellidos()));
            parameters.put("emailU", new String(u.getEmail()));
            parameters.put("dniU", new String(u.getDNI()));
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto_final?useSSL=false&requireSSL=false", "", "");
                out.print("Conexion establecida correctamente");
            } catch (Exception ex) {
                System.out.println("Error al conectar BD desde ReportePedido" + ex.getMessage());
                out.print("Error estableciendo conexion BD para report");
            }

            try {
                byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameters, con);
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "inline; filename=" + reportfile + ".pdf");
                response.setContentLength(bytes.length);

                ServletOutputStream outputstream = response.getOutputStream();

                outputstream.write(bytes, 0, bytes.length);

                outputstream.flush();

                out.clear();
                out = pageContext.pushBody();
                outputstream.close();
                return;
            } catch (JRException ex) {
                System.out.println(ex.getMessage());
            }
        %>
    </c:if>
    <c:if test="${!pertenecePedido || (idUsuarioA != idUsuarioR)}">
        <%
            out.print("<h2>Error. Este no es tu pedido o no tienes permiso para verlo.</h2>");
        %>
    </c:if>


</html>
