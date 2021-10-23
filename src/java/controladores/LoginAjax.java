/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.dao.UsuarioJpaController;
import modelo.entidades.Articulo;
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
//        JSONArray jsonArray=new JSONArray();

//        jsonArray.add(0,jsonObject1);
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        ArrayList <Articulo> cestaActual = new ArrayList();
        try (PrintWriter out = response.getWriter()) {
            //System.out.println(email + "\n" + password);
            JSONObject jsonObject = null;
            String error = null;
            if (email == null || password == null) {
                error = "Debe acceder por la página de login";
            } else {
                if (email.isEmpty() || password.isEmpty()) {//Esto lo mandaré para que salga en rojo dentro de los campos del modal
                    error = "Se deben rellenar los campos usuario y contraseña";
                } else {
                    UsuarioJpaController ejc
                            = new UsuarioJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
                    List<Usuario> usuarios = ejc.findUsuarioEntities();
                    for (Usuario usu : usuarios) {
                        if (usu.getEmail().equals(email) && usu.getPassword().equals(password)) {
                            // Login correcto
                            HttpSession sesion = request.getSession();
                            sesion.setAttribute("usuario", usu);
                            sesion.setAttribute("cestaActual", cestaActual);
                            jsonObject = new JSONObject();
                            jsonObject.put("flag", "true");
                            //System.out.println("HEMOS ENCONTRADO EL USUARIO");
                            out.print(jsonObject);
                            //sesion.setAttribute("funcion", new Funcionalidad());
                            //response.sendRedirect("principal.jsp");
                            return;
                        }
                    }
                    jsonObject = new JSONObject();
                    jsonObject.put("flag", "false");
                    //System.out.println("JSONObject en false: " + jsonObject);
                    error = "Usuario o contraseña incorrectos";
                    request.setAttribute("error", error);
                }

            }
            // Tengo que cerrarlo y olvidé por qué, ¿como si no se transmitiera sin cerrar?
            out.print(jsonObject);
            out.close();
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
