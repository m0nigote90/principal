/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Funcionalidad;
import modelo.entidades.Planta;
import org.json.JSONObject;

/**
 *
 * @author Pedro
 */
@WebServlet(name = "AltaPlanta", urlPatterns = {"/admin/AltaPlanta"})
public class AltaPlanta extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String ref = request.getParameter("ref");
            String tipo = request.getParameter("tipo");
            String nombre = request.getParameter("nombre");
            String fab = request.getParameter("fab");
            String des = request.getParameter("des");
            String tipoIVA = request.getParameter("tipoIVA");
            Integer tipoIVAaux = Integer.valueOf(tipoIVA);
            String precioSinIVA = request.getParameter("precioSinIVA");
            Double precioSinIVAaux = Double.valueOf(precioSinIVA);
            Integer numUni = Integer.valueOf(request.getParameter("numUni"));
            String errorRef = "";

            JSONObject jsonObject = new JSONObject();
            ServletContext aplicacion = getServletContext();
            Funcionalidad tienda = (Funcionalidad) aplicacion.getAttribute("tienda");

            if (!tienda.existePlantaRef(ref)) {//Si no existe ninguna planta con esa ref continuamos insertando

                for (int i = 0; i < numUni; i++) {//insertaremos tantas unidades como sean indicadas
                    Planta p = new Planta();
                    p.setCategoria("planta");
                    p.setReferencia(ref);
                    p.setNombre(nombre);
                    p.setTipo(tipo);
                    p.setFabricante(fab);
                    p.setTipoIVA(tipoIVAaux);
                    p.setPrecioSinIVA(precioSinIVAaux);
                    p.setDescripcion(des);

                    try {
                        tienda.altaPlanta(p);
                        jsonObject.put("flag", "true");
                        jsonObject.put("nombre", nombre);

                    } catch (Exception ex) {
                        Logger.getLogger(AddUnidades.class.getName()).log(Level.SEVERE, null, ex);
                        jsonObject.put("flag", "false");
                    }
                }


            } else {
                errorRef = "Ya existe una planta con la referencia " + ref;
                jsonObject.put("errorRef", errorRef);
                jsonObject.put("flag", "false");
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
