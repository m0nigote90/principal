/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Funcionalidad;
import modelo.dao.UsuarioJpaController;
import modelo.entidades.Usuario;

/**
 *
 * @author Pedro
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String error = null;
        if (email == null || password == null) {
            error = "Debe acceder por la página de login";
        } else {
            if (email.isEmpty() || password.isEmpty()) {//Esto lo mandaré para que salga en rojo dentro de los campos del modal
                error = "Se deben rellenar los campos usuario y contraseña";
            } else {
                UsuarioJpaController ejc = new 
                    UsuarioJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
                List<Usuario> usuarios = ejc.findUsuarioEntities();
                for (Usuario usu : usuarios) {
                    if (usu.getEmail().equals(email) && usu.getPassword().equals(password)) {
                        // Login correcto
                        HttpSession sesion = request.getSession();
                        sesion.setAttribute("usuario", usu);
                        //sesion.setAttribute("funcion", new Funcionalidad());
                        response.sendRedirect("principal.jsp");
                        
                        return;
                    }
                }
                error = "Usuario o contraseña incorrectos";
            }
            
        }
        // Guardar el error y saltar a la vista de login
        
        request.setAttribute("error", error);
        getServletContext().getRequestDispatcher("/principal.jsp").forward(request, response);
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
