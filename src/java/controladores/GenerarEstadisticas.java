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
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Funcionalidad;
import modelo.entidades.*;
import org.json.JSONObject;


/**
 *
 * @author Pedro
 */
@WebServlet(name = "GenerarEstadisticas", urlPatterns = {"/admin/GenerarEstadisticas"})
public class GenerarEstadisticas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            JSONObject JO = new JSONObject();
            ServletContext aplicacion = getServletContext();
            Funcionalidad tienda = (Funcionalidad) aplicacion.getAttribute("tienda");
            //Cálculos ******************************
            List<Articulo> articulos = tienda.getArticulos();
            List<Pedido> pedidos = tienda.getPedidos();
            List<Usuario> usuarios = tienda.getUsuarios();
            List<Planta> plantas = tienda.getPlantas();
            List<Abono> abonos = tienda.getAbonos();

            Integer numArt = articulos.size();
            Integer numPed = pedidos.size();
            Integer numUsu = usuarios.size();
            Integer numPla = plantas.size();
            Integer numAbo = abonos.size();
            Double totalDineroPedSin = 0.;
            Double totalDineroPed = 0.;
            Integer totalArtVen = 0;
            Integer totalPlaVen = 0;
            Integer totalAboVen = 0;
            
            for (Pedido p : pedidos) {
                totalDineroPedSin += p.getTotalSinIVA();
                totalDineroPed += p.getTotal();
                
            }

            Double totalDineroArtSin = 0.;
            Double totalDineroArt = 0.;

            for (Articulo a : articulos) {
                totalDineroArtSin += a.getPrecioSinIVA();
                totalDineroArt += a.getPrecio();
                if(a.getVendido()){
                    totalArtVen ++;
                    if(a.getCategoria().equals("planta")){
                        totalPlaVen ++;
                    } else if(a.getCategoria().equals("abono")){
                        totalAboVen ++;
                    }
                }
                
            }
            Double totalDineroArtInvertido = (totalDineroArtSin - (totalDineroArtSin * 0.3));//suponiendo un margen de beneficio del 30%

            Integer totalUsu = usuarios.size();
            Integer totalAdmin = tienda.getAdministradores().size();
            Integer usuPedidos = 0;
            Double edadUsu = 0.;
            Double edadMediaUsu = 0.;
            ArrayList<Usuario> mejoresUsu = new ArrayList<>();
            Integer maxNumPed = 0;
            for (Usuario u : usuarios) {
                if(u.getPedidos().size() > maxNumPed){
                    maxNumPed = u.getPedidos().size();
                }
                edadUsu += u.getEdad();
                if (!u.getPedidos().isEmpty()) {
                    usuPedidos++;
                }          
            }
            for (Usuario u : usuarios) {
                if((u.getPedidos().size() == maxNumPed) && maxNumPed != 0){
                    mejoresUsu.add(u);
                }
            }
            edadMediaUsu = edadUsu / totalUsu;
            
            String nombres = "";
            for(int i = 0; i < mejoresUsu.size(); i++){
                
                nombres += mejoresUsu.get(i).getNombre()+" "+mejoresUsu.get(i).getApellidos()+" - ";
                
            }
            Integer totalArtDif = tienda.getArticulosGroupByRef().size();
            Integer totalPlaDif = tienda.getPlantasGroupByRef().size();
            Integer totalAboDif = tienda.getAbonosGroupByRef().size();
            
            Articulo artMasVendido = tienda.articuloMasVendido();
            String bestSeller = "";
            if(artMasVendido != null && artMasVendido.getCategoria().equals("planta")){
                Planta p = (Planta)artMasVendido;
                
                bestSeller = p.getCategoria()+" "+p.getNombre()+", Fab: "+p.getFabricante()+" (REF: "+p.getReferencia()+")";
            }
            
            JO.put("mejoresUsu", nombres);
            JO.put("numMejoresUsu", mejoresUsu.size());
            JO.put("maxNumPed", maxNumPed);
            JO.put("numArt", numArt);
            JO.put("numUsu", numUsu);
            JO.put("numPed", numPed);
            JO.put("numPla", numPla);
            JO.put("numAbo", numAbo);
            JO.put("totalDineroArtSin", totalDineroArtSin);
            JO.put("totalDineroArt", totalDineroArt);
            JO.put("totalDineroPedSin", totalDineroPedSin);
            JO.put("totalDineroPed", totalDineroPed);
            JO.put("totalDineroArtInvertido", totalDineroArtInvertido);
            JO.put("beneficio", (totalDineroPed - totalDineroArtInvertido));
            JO.put("beneficioNeto", (totalDineroPedSin - totalDineroArtInvertido));
            JO.put("totalUsu", totalUsu);
            JO.put("totalAdmin", totalAdmin);
            JO.put("usuPedidos", usuPedidos);
            edadMediaUsu = (double)Math.round(edadMediaUsu * 100d) / 100d;
            JO.put("edadMediaUsu", edadMediaUsu);
            JO.put("flag", "true");

            JO.put("totalArtDif", totalArtDif);
            JO.put("totalArtVen", totalArtVen);

            JO.put("totalPlaDif", totalPlaDif);
            JO.put("totalPlaVen", totalPlaVen);
           
            JO.put("totalAboDif", totalAboDif);
            JO.put("totalAboVen", totalAboVen);
            JO.put("bestSeller", bestSeller);
            JO.put("estTotalPed", numPed);
            if(numPed != 0){
                JO.put("gastoMedPed", totalDineroPed/numPed);
            } else {
                JO.put("gastoMedPed", totalDineroPed);
            }
               
            
            out.print(JO);
            out.close();

        }
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
