/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Funcionalidad;
import modelo.entidades.Abono;
import modelo.entidades.Articulo;
import modelo.entidades.Planta;
import org.json.JSONObject;

/**
 *
 * @author Pedro 06/11/2021 Servlet que recibe la petición de editar un
 * artículo. Primeramente analiza la opción de editar y mostrará el modal.
 * Cuando reciba la opción de editar desde ese modal, entonces efectuará la
 * persistencia en BD.
 */
@WebServlet(name = "EditArticulo", urlPatterns = {"/admin/EditArticulo"})
public class EditArticulo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String opcion = request.getParameter("opc");
            String ref = request.getParameter("ref");
            JSONObject jsonObject = new JSONObject();
            ServletContext aplicacion = getServletContext();
            Funcionalidad tienda = (Funcionalidad) aplicacion.getAttribute("tienda");

            Articulo art = tienda.devolverArtPorRef(ref);
            String categoria = art.getCategoria();
            String fab = art.getFabricante();
            String des = art.getDescripcion();
            Integer iva = art.getTipoIVA();
            Double precioSin = art.getPrecioSinIVA();
            Double pvp = art.getPrecio();

            jsonObject.put("ref", ref);
            jsonObject.put("categoria", categoria);
            jsonObject.put("fab", fab);
            jsonObject.put("des", des);
            jsonObject.put("iva", iva);
            jsonObject.put("precioSin", precioSin);
            jsonObject.put("pvp", pvp);

            //Recogemos los parametros de la request para editar el artículo
            switch (categoria) {
                case "planta":
                    Planta p = (Planta) art;
                    String nombreP = p.getNombre();
                    String tipoP = p.getTipo();
                    if (opcion.equals("modal")) {
                        //mostramos le modal con los datos actuales
                        jsonObject.put("flag", "true");
                        jsonObject.put("nombre", nombreP);
                        jsonObject.put("tipo", tipoP);

                    } else {
                        //hacemos la modificación
                        String nombreR = request.getParameter("nombre");
                        String fabR = request.getParameter("fab");
                        String tipoR = request.getParameter("tipo");
                        String desR = request.getParameter("des");
                        Integer ivaR = Integer.valueOf(request.getParameter("iva"));
                        Double precioSinR = Double.valueOf(request.getParameter("precioSin"));
                        //Double volR = Double.valueOf("vol");
                        int n = tienda.editarPlantaRef(ref, nombreR, tipoR, fabR, desR, ivaR, precioSinR);
                        jsonObject.put("flag", "true");
                        jsonObject.put("nombre", nombreP);
                        jsonObject.put("n", n);
                    }
                    break;
                case "abono":
                    Abono a = (Abono) art;
                    String nombreA = a.getNombre();
                    Double volumenA = a.getVolumen();
                    String tipoA = a.getTipo();

                    if (opcion.equals("modal")) {
                        //mostramos le modal con los datos actuales
                        jsonObject.put("flag", "true");
                        jsonObject.put("nombre", nombreA);
                        jsonObject.put("tipo", tipoA);
                        jsonObject.put("volumen", volumenA);
                    } else {
                        //hacemos la modificación

                        jsonObject.put("flag", "true");
                        jsonObject.put("nombre", nombreA);

                    }
                    break;
            }

            out.print(jsonObject);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
