/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Funcionalidad;
import modelo.entidades.Planta;

/**
 *
 * @author Pedro
 */
@WebServlet(name = "AltaPlanta", urlPatterns = {"/admin/AltaPlanta"})
public class AltaPlanta extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //public Planta (String referencia, String categoria, String tipo, String nombre, String fabricante, String descripcion, Integer tipoIVA, Integer stock, Double precioSinIVA){
        //super(referencia, "planta", fabricante, descripcion, 10, stock);
        String error = null;
        String referencia = request.getParameter("referencia");
        String tipo = request.getParameter("tipo");
//        String tipoAux = null;
//        if(tipo.equals("default")){
//            tipoAux = "Desconocida";
//        } else {
//            tipoAux = tipo;
//        }
        String nombre = request.getParameter("nombre");
        String fabricante = request.getParameter("fabricante");
        String descripcion = request.getParameter("descripcion");
        String tipoIVA = request.getParameter("tipoIVA");
        Integer tipoIVAaux = null;
        if(tipoIVA != null){
            tipoIVAaux = Integer.valueOf(tipoIVA);
        } else {
            System.out.println("Error en tipoIVA");
        }
        
        String stock = request.getParameter("stock");
        Integer stockaux = null;
        if(stock != null){
            stockaux = Integer.valueOf(stock);
        } else {
            System.out.println("Error en cast Stock");
        }
        
        String precioSinIVA = request.getParameter("precioSinIVA");
        Double precioSinIVAaux = null;
        if(precioSinIVA != null){
            precioSinIVAaux = Double.valueOf(precioSinIVA);
        } else {
            System.out.println("Error en cast precioSinIVA");
        }
        
        
        
        Planta planta = new Planta(referencia, "", tipo, nombre, fabricante, descripcion, tipoIVAaux, stockaux, precioSinIVAaux);
        
        Funcionalidad tienda = new Funcionalidad();
        //Usamos tienda
        try {
            tienda.altaPlanta(planta);
        } catch (Exception ex) {
            //error = "Ya existe una planta con e;
            error = ex.getMessage() + " ERROR";
        }
        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("referencia", referencia);
            request.setAttribute("tipo", tipo);
            request.setAttribute("nombre", nombre);
            request.setAttribute("fabricante", fabricante);
            request.setAttribute("descripcion", descripcion);
            request.setAttribute("tipoIVA", tipoIVA);
            request.setAttribute("stock", stock);
            request.setAttribute("precioSinIVA", precioSinIVA);
            getServletContext().getRequestDispatcher("/gestion.jsp").forward(request, response);
        } else {
            String mensaje = "Se ha dado de alta la planta "+nombre; 
            response.sendRedirect(response.encodeRedirectURL("gestion.jsp?mensaje=" + mensaje));
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
