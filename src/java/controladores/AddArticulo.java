package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.dao.ArticuloJpaController;
import modelo.dao.UsuarioJpaController;
import modelo.entidades.Articulo;
import modelo.entidades.Usuario;
import org.json.JSONObject;

/**
 * En este servlet no controlaremos el stock existente ya que no podremos pulsar boton comprar en caso de stock == 0;
 * @author Pedro
 */
@WebServlet(name = "AddArticulo", urlPatterns = {"/AddArticulo"})
public class AddArticulo extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
             
        JSONObject jsonObject = null;
        String ref = request.getParameter("refArticulo");
        HttpSession sesion = request.getSession();
        ArrayList <Articulo> cesta = (ArrayList)sesion.getAttribute("cestaActual");
        
        ArticuloJpaController ajc
                            = new ArticuloJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
                    List<Articulo> articulos = ajc.findArticuloEntities();
                    for (Articulo art : articulos) {
                        if (art.getReferencia().equals(ref)) {
                            cesta.add(art);
                            art.quitarStock(1);
                            try {
                                ajc.edit(art);
                            } catch (Exception ex) {
                                Logger.getLogger(AddArticulo.class.getName()).log(Level.SEVERE, null, ex);
                            }
                            sesion.setAttribute("cestaActual", cesta);
                            System.out.println("Añadido art: "+ref);
                        }
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
