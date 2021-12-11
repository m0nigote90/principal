
package controladores;

import java.io.File;

import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletResponse;
import java.sql.*;
import java.io.*;
import java.util.*;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpSession;
import modelo.entidades.Usuario;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.view.JasperViewer.*;
import org.json.JSONObject;

/**
 *
 * @author Pedro M., 22/11/2021
 */
@WebServlet(name = "ReportPedido", urlPatterns = {"/ReportPedido", "/admin/ReportPedido"})
public class ReportPedido extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject jsonObject = new JSONObject();
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario)sesion.getAttribute("usuario");
        try (PrintWriter out = response.getWriter()) {
            
            jsonObject.put("idUsuario", usuario.getId());
            jsonObject.put("flag", "true");
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
     * @return 
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected Connection conection(){
        Connection con = null;
        try{
                Class.forName("com.mysql.jdbc.Driver");
                con = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto_final","root","Per12345");
            }catch(ClassNotFoundException | SQLException ex){
                System.out.println("Error al conectar BD desde ReportePedido"+ex.getMessage());
            }
        return con;
    }
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
