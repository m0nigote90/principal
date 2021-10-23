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
import javax.servlet.http.HttpSession;
import modelo.Funcionalidad;
import org.json.JSONObject;

/**
 *
 * @author Pedro
 */
@WebServlet(name = "CargarPortafolio", urlPatterns = {"/CargarPortafolio"})
public class CargarPortafolio extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String numFiltro = request.getParameter("numFiltro");
        String categoria = "";
        Boolean isFiltroCategoria = false;
        ServletContext aplicacion = getServletContext();
        JSONObject jsonObject = null;
        
        response.setContentType("application/json;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        switch (numFiltro) {
            case "0":
                categoria = "todas";
                isFiltroCategoria = false;
                break;
            case "1":
                categoria = "planta";
                isFiltroCategoria = true;
                break;
            case "2":
                categoria = "abono";
                isFiltroCategoria = true;
                break;
            default:
                categoria = "todas";
                isFiltroCategoria = false;
        }

        aplicacion.setAttribute("filtroCategoria", categoria);
        aplicacion.setAttribute("isFiltroCategoria", isFiltroCategoria);

        try (PrintWriter out = response.getWriter()) {
            System.out.println("Filtro categoría: " + categoria);
            System.out.println("Filtro activo? " + isFiltroCategoria);
            response.sendRedirect("principal.jsp");
            jsonObject = new JSONObject();
            jsonObject.put("filtroCategoria", categoria);
            jsonObject.put("isFiltroCategoria", isFiltroCategoria);
            jsonObject.put("flag", "true");
            
                            //System.out.println("HEMOS ENCONTRADO EL USUARIO");
            out.print(jsonObject);
            out.close();
            System.out.println("JSONObject al final: " + jsonObject);
            //System.out.println(email + "\n" + password);
            //Agregamos y mandamos el tipo de lista a mostrar en portafolio
            //filtroCategoria y isAFiltroCategoria
            //aplicacion.setAttribute("tienda", tienda);
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
