/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Funcionalidad;
import modelo.entidades.Usuario;

/**
 *
 * @author Pedro
 */
@WebServlet(name = "AltaUsuario", urlPatterns = {"/AltaUsuario"})
public class AltaUsuario extends HttpServlet {

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
        {
        String error = null;
        String DNI = request.getParameter("DNI");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        //Aqui hay que hacer algo con la fecha que viene como String
        String fecha = request.getParameter("fechaNac");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date fechaNac = null;
            try {
                fechaNac = sdf.parse(fecha);
            } catch (ParseException ex) {
                Logger.getLogger(AltaUsuario.class.getName()).log(Level.SEVERE, null, ex);
            }
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Boolean admin = false;
        Usuario nuevo = new Usuario(DNI, nombre, apellidos, fechaNac, email, password, admin);
        ServletContext aplicacion = getServletContext();
        
        
        Funcionalidad funcion = new Funcionalidad();
        try {
            funcion.altaUsuario(nuevo);
        } catch (Exception ex) {
            //error = "Ya existe un usuario con el email " + email;
            error = ex.getMessage() + " ERROR";
        }
        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("DNI", DNI);
            request.setAttribute("nombre", nombre);
            request.setAttribute("apellidos", apellidos);
            request.setAttribute("fechaNac", fechaNac);
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            getServletContext().getRequestDispatcher("/registro.jsp").forward(request, response);
        } else {
            String mensaje = "Se ha dado de alta al/la usuario/a "+nombre; 
            //request.setAttribute("registroNuevo", mensaje);
            aplicacion.setAttribute("registroNuevo", true);
            //getServletContext().getRequestDispatcher("/principal.jsp").forward(request, response);
            response.sendRedirect("principal.jsp");
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
