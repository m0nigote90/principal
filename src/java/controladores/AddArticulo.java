package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Funcionalidad;
import modelo.entidades.Articulo;
import modelo.entidades.Usuario;
import org.json.JSONObject;

/**
 * En este servlet no controlaremos el stock existente ya que no podremos pulsar
 * boton comprar en caso de stock == 0;
 *
 * @author Pedro
 */
@WebServlet(name = "AddArticulo", urlPatterns = {"/AddArticulo"})
public class AddArticulo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            JSONObject jsonObject = new JSONObject();
            String ref = request.getParameter("refArticulo");
            HttpSession sesion = request.getSession();
            ServletContext aplicacion = getServletContext();
            Usuario usuario = (Usuario) sesion.getAttribute("usuario");
            Funcionalidad tienda = (Funcionalidad) aplicacion.getAttribute("tienda");
            Articulo articulo = null;
            Integer numArt = null;

            List<Articulo> articulos = tienda.getArticulos();
            boolean encontrado = false;

            for (Articulo art : articulos) {
                if (art.getReferencia().equals(ref) && !art.getVendido() && !encontrado) {
                    articulo = art;
                    encontrado = true;
                }
            }

            if (encontrado && articulo != null) {
                usuario.addArticulo(articulo);
                numArt = usuario.getArticulos().size();
                articulo.setVendido(true);

                try {
                    tienda.actualizarArticulo(articulo);
                    tienda.actualizarUsuario(usuario);
                } catch (Exception ex) {
                    Logger.getLogger(AddArticulo.class.getName()).log(Level.SEVERE, null, ex);
                }
                sesion.setAttribute("usuario", usuario);
                //System.out.println("A??adido art: " + ref);
                jsonObject.put("flag", "true");
                jsonObject.put("numArtCesta", numArt);
                //System.out.println(jsonObject);

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
