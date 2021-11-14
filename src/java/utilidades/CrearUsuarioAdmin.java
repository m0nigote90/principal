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
            
////                public Planta (Integer numSerie, String referencia, String categoria ("Planta"), String tipo, 
////            String nombre, String fabricante, String descripcion, Integer tipoIVA (10), , Double precioSinIVA){nta muy popular caracterizada por unas grandes hojas verdes rasgadas como si se tratase de unas costillas.:10
//            Planta p1 = new Planta ("pla001", "","tropical", "Calathea Ornata", "Distribuidor 1", 
//            "Planta tropical de hojas muy ornamentales de color verde oscuro con nervios laterales blancos rosado en el haz y purpúreas en el envés.", 10, 4.00);
//            Planta p2 = new Planta ("pla002", "","suculenta", "Senecio Rowleyanus", "Distribuidor 2", 
//            "También conocida como planta rosario, sus hojas son unas pequeñas bolitas carnosas que almacenan gran cantidad de agua.", 10, 3.63);
//            Planta p3 = new Planta ("pla003", "","tropical", "Monstera Deliciosa", "Hojasverdes", 
//            "La costilla de Adán es una planta muy popular caracterizada por unas grandes hojas verdes rasgadas como si se tratase de unas costillas.", 10, 5.67); //160 caracteres
//            Planta p4 = new Planta("pla004", "", "suculenta", "Sansevieria", "Hojasverdes", 
//            "También conocida como lengua de suegra, fácil de cultivar y una superviviente nata. Purifica el aire de nuestro hogar.", 10, 5.9);
//            Planta p5 = new Planta("pla005", "", "tropical", "Alocasia Amazonica", "Hojasverdes",
//            "La oreja de elefante, con hojas espectaculares, de un verde oscuro intenso con nervios blancos bien marcados y forma triangular.", 10, 8.60);
//            
//            
//
            String mensaje = "Se ha creado el Administrador";
//            String mensaje2 = "Se ha creado la Planta";
//            String mensaje3 = "Se ha creado el Abono";
//            
//            //Abono (Ingeter numSerie, String referencia, String categoria, String nombre, String fabricante, 
//            //String descripcion, String tipoPlanta, Double volumen, Integer tipoIVA, Double precioSinIVA)
//            Abono a1 = new Abono ("abo001", "", "Fertilizante Cactus", "Compo", 
//            "Fertilizante líquido mineral con potasio para cactus, plantas crasas y suculentas. Muy efectivo.", "quimico", 500.0, 10, 5.40);
//            Abono a2 = new Abono ("abo002", "", "Fertilizante Plantas Verdes", "Compo", 
//            "Fertilizante de plantas verdes para plantas de interior, balcón y terraza, con potasio y hierro,", "quimico", 500.0, 10, 3.50);
//            Abono a3 = new Abono ("abo003", "", "Fertilizante Universal", "Compo", 
//            "Fertilizante de calidad para plantas ornamentales de interior o terraza, con magnesio", "quimico", 500.0, 10, 4.50);
//            Abono a4 = new Abono ("abo004", "", "Fertilizante Natural Guano", "Compo", 
//            "Abono de origen natural que contiene sustancias nutritivas y compuestos orgánicos ideales para plantas de interior y terraza", "natural", 1000.0, 10, 5.50);
//            Abono a5 = new Abono ("abo005", "", "Fertilizante Orquídeas", "Compo", 
//            "Fertilizante de fórmula suave para plantas sensibles a la salinidad: orquídeas, hortensias, azaleas, etc., Con guano y extractos.", "quimico", 500.0, 10, 4.60);
//            Abono a6 = new Abono ("abo006", "", "Fertilizante Universal", "Flower", 
//            "Crecimiento sano y vigoroso, complejo vitamínico y multinutrientes", "natural", 1000.0, 10, 2.70);
//            Abono a7 = new Abono ("abo007", "", "Fertilizante Cítricos", "Flower", 
//            "Fertilizante para cítricos que mejora su desarollo con hierro y magnesio.", "quimico", 1000.0, 10, 7.70);
//            
//            PlantaJpaController pjc = 
//                    new PlantaJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
//            AbonoJpaController ajc = 
//                    new AbonoJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
            UsuarioJpaController ujc = 
                    new UsuarioJpaController(Persistence.createEntityManagerFactory("Proyecto_FINALPU"));
            try {
                ujc.create(u1);
                ujc.create(u2);
            } catch (Exception ex) {
                mensaje = "Se ha producido un error al crear el Usuario Administrador";
                System.err.println(ex.getClass().getName() + ":" + ex.getMessage());
            }
//            try {
//                pjc.create(p1);
//                pjc.create(p2);
//            } catch (Exception ex2) {
//                mensaje2 = "Se ha producido un error al crear la planta";
//                System.err.println(ex2.getClass().getName() + ":" + ex2.getMessage());
//            }
//            try {
//                ajc.create(a1);
//                ajc.create(a2);
//                ajc.create(a3);
//                ajc.create(a4);
//                ajc.create(a5);
//                ajc.create(a6);
//                ajc.create(a7);
//            } catch (Exception ex3) {
//                mensaje3 = "Se ha producido un error al crear el abono";
//                System.err.println(ex3.getClass().getName() + ":" + ex3.getMessage());
//            }
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CrearUsuarioAdmin</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>"+mensaje+"</h1>");
//            out.println("<h1>"+mensaje2+"</h1>");
//            out.println("<h1>"+mensaje3+"</h1>");
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
