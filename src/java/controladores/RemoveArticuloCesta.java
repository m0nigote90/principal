/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Persistence;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Funcionalidad;
import modelo.dao.ArticuloJpaController;
import modelo.dao.UsuarioJpaController;
import modelo.entidades.Articulo;
import modelo.entidades.Usuario;
import org.json.JSONObject;

/**
 *
 * @author Pedro
 */
@WebServlet(name = "RemoveArticuloCesta", urlPatterns = {"/RemoveArticuloCesta"})
public class RemoveArticuloCesta extends HttpServlet {

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

            ArticuloJpaController ajc = new ArticuloJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
            UsuarioJpaController ujc = new UsuarioJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));

            //Lista de articulos que se han decidido borrar, aqui tenemos en cuenta que sean varias unidades
            List<Articulo> artBorrar = tienda.filtrarArticulosReferenciaVendidos(ref);
            Double precioSinEliminado = 0.;
            Double precioEliminado = 0.;

            for(Articulo a: artBorrar){
                precioSinEliminado += a.getPrecioSinIVA();
                precioEliminado += a.getPrecio();
                usuario.quitarArticuloCesta(a);
                a.setVendido(false);
                try {
                    ajc.edit(a);
                } catch (Exception ex) {
                    Logger.getLogger(RemoveArticuloCesta.class.getName()).log(Level.SEVERE, null, ex);
                }
                       
            }
            try {

                ujc.edit(usuario);

            } catch (Exception ex) {
                Logger.getLogger(RemoveArticuloCesta.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            sesion.setAttribute("usuario", usuario);
            System.out.println("Eliminado de cesta art: " + ref);
            jsonObject.put("precioSinEliminado", precioSinEliminado);
            jsonObject.put("precioEliminado", precioEliminado);
            jsonObject.put("numArtRmv", artBorrar.size());
            jsonObject.put("flag", "true");
            System.out.println(jsonObject);
            //System.out.println("HEMOS ENCONTRADO EL USUARIO");
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
