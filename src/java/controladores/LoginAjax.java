/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.GeneralSecurityException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Cifrado;
import modelo.Funcionalidad;
import modelo.entidades.Usuario;
import org.json.JSONObject;

/**
 *
 * @author Pedro
 */
@WebServlet(name = "LoginAjax", urlPatterns = {"/LoginAjax"})
public class LoginAjax extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        Funcionalidad tienda = (Funcionalidad) getServletContext().getAttribute("tienda");
        JSONObject jsonObject = new JSONObject();
        Cifrado c = new Cifrado();

        String email = request.getParameter("email");
        String passwordR = request.getParameter("password");
        //ArrayList <Articulo> cestaActual = new ArrayList();
        try (PrintWriter out = response.getWriter()) {
            
            
            if(tienda.existeUsuarioEmail(email)){
                Usuario usuario = tienda.buscarUsuarioEmail(email);
                String pwCifrada = usuario.getPassword();
                String pwDescifrada = "";
                try {
                    pwDescifrada = c.desencriptar(pwCifrada);
                } catch (GeneralSecurityException ex) {
                    Logger.getLogger(LoginAjax.class.getName()).log(Level.SEVERE, null, ex);
                }
                if(pwDescifrada.equals(passwordR)){ //Login correcto
                    
                    HttpSession sesion = request.getSession();
                    sesion.setAttribute("usuario", usuario);
                    jsonObject.put("flag", "true");
                } else {
                    jsonObject.put("flag", "false");
                    jsonObject.put("pass", "false");
                    jsonObject.put("email", "true");
                }
            } else {
                jsonObject.put("flag", "false");
                jsonObject.put("email", "false");
            }
            
            out.print(jsonObject);
            out.close();
         
            
//                    List<Usuario> usuarios = tienda.getUsuarios();
//                    for (Usuario usu : usuarios) {
//                        if (usu.getEmail().equals(email) && usu.getPassword().equals(password)) {
//                            // Login correcto
//                            HttpSession sesion = request.getSession();
//                            sesion.setAttribute("usuario", usu);
//                            
//                            jsonObject = new JSONObject();
//                            jsonObject.put("flag", "true");
//                            out.print(jsonObject);
//                            
//                            return;
//                        }
//                    }                    
//                    jsonObject.put("flag", "false");
            
            // Tengo que cerrarlo y olvidé por qué, ¿como si no se transmitiera sin cerrar?
            
            System.out.println("JSONObject al final: " + jsonObject);
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
