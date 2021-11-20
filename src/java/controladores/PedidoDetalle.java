/*
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Funcionalidad;
import modelo.entidades.Abono;
import modelo.entidades.Articulo;
import modelo.entidades.Pedido;
import modelo.entidades.Planta;
import modelo.entidades.Usuario;
import org.json.JSONObject;

/**
 *
 * @author Pedro M., 19/11/2021
 */
@WebServlet(name = "PedidoDetalle", urlPatterns = {"/PedidoDetalle"})
public class PedidoDetalle extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=ISO-8859-15");
        try (PrintWriter out = response.getWriter()) {
            Long id = Long.valueOf(request.getParameter("idPedido"));
            JSONObject jO = new JSONObject();
            HttpSession sesion = request.getSession();
            ServletContext aplicacion = getServletContext();
            Funcionalidad tienda = (Funcionalidad) aplicacion.getAttribute("tienda");
            Usuario usuario = (Usuario)sesion.getAttribute("usuario");
            Pedido p = tienda.buscarPedido(id);
            Integer numArt = p.getNumArticulos();
            //sesion.setAttribute("pedidoDetalle", pedido);
            jO.put("numPed", id);
            jO.put("fecPed", p.getFecha());
            jO.put("numArt", numArt);
            jO.put("precioSin", p.getTotalSinIVA());
            jO.put("precio", p.getTotal());
            jO.put("impuestos", (p.getTotal()) - (p.getTotalSinIVA()));
            
            Integer n = 0;
            List<Articulo> articulos = tienda.pedidoUsuarioSinRepetidos(id);
            JSONObject jOArticulos = new JSONObject();
            for(Articulo a : articulos){
                JSONObject jOArt = new JSONObject();
                if(a.getCategoria().equals("planta")){
                    Planta pla = (Planta)a;
                    jOArt.put("nombre", pla.getNombre());
                } else if(a.getCategoria().equals("abono")){
                    Abono abo = (Abono)a;
                    jOArt.put("nombre", abo.getNombre());
                }
                
                jOArt.put("nomImg", a.getNombreImagen());
                jOArt.put("cant", tienda.unidadesCompradasPedido(id, a.getReferencia()));
                jOArt.put("precio", a.getPrecio());
                jOArticulos.put("art"+String.valueOf(n), jOArt);
                n++;
            }
            jO.put("articulos", jOArticulos);
            
            jO.put("flag", "true");
            out.print(jO);
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
