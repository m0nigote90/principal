/*
 * 
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
import modelo.entidades.Articulo;
import org.json.JSONObject;

/**
 *
 * @author Pedro M., 18/11/2021
 */
@WebServlet(name = "ArticuloDetalle", urlPatterns = {"/ArticuloDetalle"})
public class ArticuloDetalle extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=ISO-8859-15");
        try (PrintWriter out = response.getWriter()) {
            HttpSession sesion = request.getSession();
            ServletContext aplicacion = getServletContext();
            JSONObject jsonObject = new JSONObject();
            Funcionalidad tienda = (Funcionalidad) aplicacion.getAttribute("tienda");
            
            String ref = request.getParameter("ref");
            Articulo articulo = tienda.devolverArtPorRef(ref);
            
            sesion.setAttribute("articuloDetalle", articulo);
            jsonObject.put("flag", "true");
            out.print(jsonObject);
            out.close();
            //response.sendRedirect("producto.jsp");
            
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
