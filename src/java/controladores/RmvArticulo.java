package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Funcionalidad;
import modelo.entidades.Articulo;
import org.json.JSONObject;

/**
 *
 * @author Pedro, 08/11/2021
 */
@WebServlet(name = "RmvArticulo", urlPatterns = {"/admin/RmvArticulo"})
public class RmvArticulo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String ref = request.getParameter("ref");
            Integer num = Integer.valueOf(request.getParameter("num"));
            String nombre = "";
            Integer borrados = 0;
            JSONObject jsonObject = new JSONObject();
            ServletContext aplicacion = getServletContext();
            Funcionalidad tienda = (Funcionalidad) aplicacion.getAttribute("tienda");

            List<Articulo> articulos = tienda.getArticulos();
            
            for (Articulo a : articulos) {
                if (a.getReferencia().equals(ref) && !a.getVendido()) {
                    tienda.removeArticulo(a.getId());
                    borrados++;
                    
                }
            }
            
            if (num == borrados) {
                
                jsonObject.put("flag", "true");
            } else {
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
