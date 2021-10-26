/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilidades;

import java.io.IOException;
import java.io.PrintWriter;
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
import modelo.dao.AbonoJpaController;
import modelo.dao.PlantaJpaController;
import modelo.dao.UsuarioJpaController;
import modelo.entidades.Abono;
import modelo.entidades.Planta;
import modelo.entidades.Usuario;

/**
 *
 * @author Pedro
 */
@WebServlet(name = "CrearUsuarioAdmin", urlPatterns = {"/CrearUsuarioAdmin"})
public class CrearUsuarioAdmin extends HttpServlet {

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
            Usuario u1 = new Usuario();
            u1.setDNI("");
            u1.setNombre("Administrador");
            u1.setApellidos("");
            u1.setEmail("admin@admin.es");
            u1.setPassword("admin");
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
            u2.setPassword("1234");
            u2.setAdmin(false);
            
//                public Planta (Integer numSerie, String referencia, String categoria ("Planta"), String tipo, 
//            String nombre, String fabricante, String descripcion, Integer tipoIVA (10), , Double precioSinIVA){

            Planta p1 = new Planta ("pla001", "","tropical", "Calathea Ornata", 
            "Fabricante de prueba", "Una planta tropical muy bonita, con unas hojas aplanadas preciosas", 10, 4.00);
            Planta p2 = new Planta ("pla001", "","tropical", "Calathea Ornata", 
            "Fabricante de prueba", "Una planta tropical muy bonita, con unas hojas aplanadas preciosas", 10, 4.00);
            Planta p3 = new Planta ("pla002", "","suculenta", "Fauces de lobo", "Fabricante de prueba", 
            "Faucaria tigrina, una suculenta cuyas hojas son en forma de rosetas. Faucaria tigrina también conocida como Faucaria, "
                    + "Fauces de lobo o Boca de tigre.", 10, 3.20); //160 caracteres
            
            

            String mensaje = "Se ha creado el Administrador";
            String mensaje2 = "Se ha creado la Planta";
            String mensaje3 = "Se ha creado el Abono";
            
            //Abono (Ingeter numSerie, String referencia, String categoria, String nombre, String fabricante, 
            //String descripcion, String tipoPlanta, Double volumen, Integer tipoIVA, Integer stock, Double precioSinIVA)
            Abono a1 = new Abono ("abo001", "", "Fertilizante Cactus", "Compo", 
            "Fertilizante líquido mineral con potasio para cactus, plantas crasas y suculentas. Muy efectivo.", "quimico", 500.0, 10, 5.40);
            Abono a2 = new Abono ("abo002", "", "Fertilizante Plantas Verdes", "Compo", 
            "Fertilizante de plantas verdes para plantas de interior, balcón y terraza, con potasio y hierro,", "quimico", 500.0, 10, 3.50);
            Abono a3 = new Abono ("abo003", "", "Fertilizante Universal", "Compo", 
            "Fertilizante de calidad para plantas ornamentales de interior o terraza, con magnesio", "quimico", 500.0, 10, 4.50);
            Abono a4 = new Abono ("abo004", "", "Fertilizante Natural Guano", "Compo", 
            "Abono de origen natural que contiene sustancias nutritivas y compuestos orgánicos ideales para plantas de interior y terraza", "natural", 1000.0, 10, 5.50);
            Abono a5 = new Abono ("abo005", "", "Fertilizante Orquídeas", "Compo", 
            "Fertilizante de fórmula suave para plantas sensibles a la salinidad: orquídeas, hortensias, azaleas, etc., Con guano y extractos.", "quimico", 500.0, 10, 4.60);
            Abono a6 = new Abono ("abo006", "", "Fertilizante Universal", "Flower", 
            "Crecimiento sano y vigoroso, complejo vitamínico y multinutrientes", "natural", 1000.0, 10, 2.70);
            Abono a7 = new Abono ("abo007", "", "Fertilizante Cítricos", "Flower", 
            "Fertilizante para cítricos que mejora su desarollo con hierro y magnesio.", "quimico", 1000.0, 10, 7.70);
            
            PlantaJpaController pjc = 
                    new PlantaJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
            AbonoJpaController ajc = 
                    new AbonoJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
            UsuarioJpaController ujc = 
                    new UsuarioJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
            try {
                ujc.create(u1);
                ujc.create(u2);
            } catch (Exception ex) {
                mensaje = "Se ha producido un error al crear el Usuario Administrador";
                System.err.println(ex.getClass().getName() + ":" + ex.getMessage());
            }
            try {
                pjc.create(p1);
                pjc.create(p2);
            } catch (Exception ex2) {
                mensaje2 = "Se ha producido un error al crear la planta";
                System.err.println(ex2.getClass().getName() + ":" + ex2.getMessage());
            }
            try {
                ajc.create(a1);
                ajc.create(a2);
                ajc.create(a3);
                ajc.create(a4);
                ajc.create(a5);
                ajc.create(a6);
                ajc.create(a7);
            } catch (Exception ex3) {
                mensaje3 = "Se ha producido un error al crear el abono";
                System.err.println(ex3.getClass().getName() + ":" + ex3.getMessage());
            }
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CrearUsuarioAdmin</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>"+mensaje+"</h1>");
            out.println("<h1>"+mensaje2+"</h1>");
            out.println("<h1>"+mensaje3+"</h1>");
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
