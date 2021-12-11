/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilidades;

import controladores.AltaUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Cifrado;
import modelo.dao.UsuarioJpaController;
import modelo.entidades.Usuario;

/**
 *
 * @author Pedro
 */
@WebServlet(name = "CrearUsuarioAdmin", urlPatterns = {"/CrearUsuarioAdmin"})
public class CrearUsuarioAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Cifrado c = new Cifrado();
            Usuario u1 = new Usuario();
            u1.setDNI("");
            u1.setNombre("Administrador");
            u1.setApellidos("");
            u1.setEmail("admin@admin.es");
            //Encriptamos password antes de set y commit a la BD
            String pwCifradaAdmin = "";
            try {
                pwCifradaAdmin = c.encriptar("admin");
            } catch (GeneralSecurityException | UnsupportedEncodingException ex) {
                Logger.getLogger(AltaUsuario.class.getName()).log(Level.SEVERE, null, ex);
            }
            u1.setPassword(pwCifradaAdmin);
            u1.setAdmin(true);

            Usuario u2 = new Usuario();
            u2.setDNI("77818655H");
            u2.setNombre("Pedro");
            u2.setApellidos("Morales Romero");
            SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
            Date fechaFormateada = null;
            try {
                fechaFormateada = formato.parse("12/10/1990");
            } catch (ParseException ex) {
                Logger.getLogger(CrearUsuarioAdmin.class.getName()).log(Level.SEVERE, null, ex);
            }
            u2.setFechaNac(fechaFormateada);
            u2.setEmail("pedromoralesromero90@gmail.com");
            String pwCifradaMe = "";
            try {
                pwCifradaMe = c.encriptar("1234");
            } catch (GeneralSecurityException | UnsupportedEncodingException ex) {
                Logger.getLogger(CrearUsuarioAdmin.class.getName()).log(Level.SEVERE, null, ex);
            }
            u2.setPassword(pwCifradaMe);
            u2.setAdmin(false);

            String mensaje = "Se ha creado el Administrador";
            UsuarioJpaController ujc
                    = new UsuarioJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
            try {
                ujc.create(u1);
                ujc.create(u2);
            } catch (Exception ex) {
                mensaje = "Se ha producido un error al crear el Usuario Administrador";
                System.err.println(ex.getClass().getName() + ":" + ex.getMessage());
            }
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CrearUsuarioAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>" + mensaje + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
