/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
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
import org.json.JSONObject;

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

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
            String fechaNac = request.getParameter("fechaNac");
            String dni = request.getParameter("dni");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            //Tratamos la fecha
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaNacDATE = null;
            try {
                fechaNacDATE = sdf.parse(fechaNac);
            } catch (ParseException ex) {
                Logger.getLogger(AltaUsuario.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            String errorDNI = null;
            String errorEmail = null;
            
            
            JSONObject jsonObject = new JSONObject();
            ServletContext aplicacion = getServletContext();
            Funcionalidad tienda = (Funcionalidad) aplicacion.getAttribute("tienda");
            
            
            if(!tienda.existeUsuarioDNI(dni)){
                //jsonObject.put("flag", "true");
                if(!tienda.existeUsuarioEmail(email)){
                    Usuario u = new Usuario();
                    u.setNombre(nombre);
                    u.setApellidos(apellidos);
                    u.setDNI(dni);
                    u.setFechaNac(fechaNacDATE);
                    u.setEmail(email);
                    u.setPassword(password);
                    u.setAdmin(false);
                    try {
                        tienda.altaUsuario(u);
                    } catch (Exception ex) {
                        Logger.getLogger(AltaUsuario.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    jsonObject.put("flag", "true");
                    jsonObject.put("nombre", nombre);
                    
                } else {
                    errorEmail = "Ya existe un usuario registrado con ese Email";
                    jsonObject.put("errorEmail", errorEmail);
                    jsonObject.put("flag", "false");
                }
            } else {
                errorDNI = "Ya existe un usuario registrado con ese DNI";
                jsonObject.put("errorDNI", errorDNI);
                jsonObject.put("flag", "false");
                //out.print(jsonObject);
                
            }
            
            out.print(jsonObject);
            out.close();

        } //Termina el out
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
