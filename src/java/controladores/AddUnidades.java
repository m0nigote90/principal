/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Funcionalidad;
import modelo.entidades.Abono;
import modelo.entidades.Articulo;
import modelo.entidades.Planta;
import modelo.entidades.Usuario;
import org.json.JSONObject;

/**
 *
 * @author Pedro
 * Servlet que inserta el num de unidades indicada del mismo tipo al stock de la tienda
 */
@WebServlet(name = "AddUnidades", urlPatterns = {"/admin/AddUnidades"})
public class AddUnidades extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            JSONObject jsonObject = new JSONObject();
            ServletContext aplicacion = getServletContext();
            Funcionalidad tienda = (Funcionalidad) aplicacion.getAttribute("tienda");
            
            //("pla001", "","tropical", "Calathea Ornata", 
            //"Fabricante de prueba", "Una planta tropical muy bonita, con unas hojas aplanadas preciosas", 10, 4.00);
            String ref = request.getParameter("refArt");
            Integer num = Integer.parseInt(request.getParameter("numUnidades"));
            Articulo art = tienda.devolverArtPorRef(ref);
            //Si la ref es de una planta, creamos plantas.
            if(art.getCategoria().equals("planta")){
                Planta pla = (Planta) art;
                
                String nombre = pla.getNombre();
                String tipo = pla.getTipo();
                String fab = pla.getFabricante();
                String des = pla.getDescripcion();
                Integer iva = pla.getTipoIVA();
                Double pvp = pla.getPrecioSinIVA();
                       
                for(int i=0; i<num; i++){
                    Planta plaNueva = new Planta(ref, "", tipo, nombre, fab, des, iva, pvp);
                    try {
                        tienda.altaPlanta(plaNueva);
                        jsonObject.put("flag", "true");
                        
                    } catch (Exception ex) {
                        Logger.getLogger(AddUnidades.class.getName()).log(Level.SEVERE, null, ex);
                        jsonObject.put("flag", "false");
                    }
                }
                jsonObject.put("nombre", nombre);
                out.print(jsonObject);
               
                return;
                
            }
             //Comprobamos y actuamos si son abonos
            if(art.getCategoria().equals("abono")){
                Abono abo = (Abono) art;
                
                String nombre = abo.getNombre();
                String tipo = abo.getTipo();
                String fab = abo.getFabricante();
                String des = abo.getDescripcion();
                Integer iva = abo.getTipoIVA();
                Double vol = abo.getVolumen();
                Double pvp = abo.getPrecioSinIVA();
                
                // a1 = new Abono ("abo001", "", "Fertilizante Cactus", "Compo", 
            //"Fertilizante líquido mineral con potasio para cactus, plantas crasas y suculentas. Muy efectivo.", "quimico", 500.0, 10, 5.40);
                
                for(int i=0; i<num; i++){
                    Abono aboNuevo = new Abono(ref, "", nombre, fab, des, tipo, vol, iva, pvp);
                    try {
                        tienda.altaAbono(aboNuevo);
                        jsonObject.put("flag", "true");
                        
                    } catch (Exception ex) {
                        Logger.getLogger(AddUnidades.class.getName()).log(Level.SEVERE, null, ex);
                        jsonObject.put("flag", "false");
                    }
                }
                jsonObject.put("nombre", nombre);
                out.print(jsonObject);
                
                return;
            }
            
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
