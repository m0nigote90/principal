/*
 * Pedro, 09/11/2021
 */
package controladores;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.Cifrado;
import modelo.Funcionalidad;
import modelo.entidades.Abono;
import modelo.entidades.Planta;
import modelo.entidades.Usuario;
import org.json.JSONObject;

/**
 *
 * @author Pedro, 09/11/2021
 */
@WebServlet(name = "Importar", urlPatterns = {"/admin/Importar"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class Importar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/json;charset=ISO-8859-15");
        try (PrintWriter out = response.getWriter()) {
            JSONObject jsonObject = new JSONObject();
            Funcionalidad tienda = (Funcionalidad) getServletContext().getAttribute("tienda");
            Part filePlantas = request.getPart("filePlantas");
            Part fileAbonos = request.getPart("fileAbonos");
            Part fileUsuarios = request.getPart("fileUsuarios");

            System.out.println("FILE PLANTAS name: " + filePlantas.getName());
            System.out.println("FILE ABONOS: " + fileAbonos.getSubmittedFileName());
            System.out.println("FILE SIZE USUARIOS: " + fileUsuarios.getSize());

            //getSize() num bytes siempre, mayor si está cargado
            //getName() devuelve nombre del Part siempre
            //getSubmittedFileName devuelve nombre archivo local y null si no se ha cargado
            if (filePlantas.getSubmittedFileName() == null || !filePlantas.getSubmittedFileName().equals("plantas.txt")) {
                jsonObject.put("plantas", "No");
            } else {
                BufferedReader brp = new BufferedReader(new InputStreamReader(filePlantas.getInputStream(), "UTF-8"));
                String linea;

                while ((linea = brp.readLine()) != null) {
                    Planta p = new Planta();
                    String[] partes = linea.split(":");
                    p.setCategoria("planta");
                    p.setReferencia(partes[0]);
                    p.setNombre(partes[1]);
                    p.setTipo(partes[2]);
                    p.setFabricante(partes[3]);
                    p.setTipoIVA(Integer.valueOf(partes[4]));
                    p.setPrecioSinIVA(Double.valueOf(partes[5]));
                    p.setDescripcion(partes[6]);

                    try {
                        tienda.altaPlanta(p);
                    } catch (Exception ex) {

                    }

                }
                jsonObject.put("plantas", "Si");
            }
            if (fileAbonos.getSubmittedFileName() == null || !fileAbonos.getSubmittedFileName().equals("abonos.txt")) {
                jsonObject.put("abonos", "No");
            } else {
                BufferedReader bra = new BufferedReader(new InputStreamReader(fileAbonos.getInputStream(), "UTF-8"));
                String linea;

                while ((linea = bra.readLine()) != null) {
                    Abono a = new Abono();
                    String[] partes = linea.split(":");
                    a.setCategoria("abono");
                    a.setReferencia(partes[0]);
                    a.setNombre(partes[1]);
                    a.setFabricante(partes[2]);
                    a.setDescripcion(partes[3]);
                    a.setTipo(partes[4]);
                    a.setVolumen(Double.valueOf(partes[5]));
                    a.setTipoIVA(Integer.valueOf(partes[6]));
                    a.setPrecioSinIVA(Double.valueOf(partes[7]));

                    try {
                        tienda.altaAbono(a);
                    } catch (Exception ex) {

                    }
                }
                jsonObject.put("abonos", "Si");
            }
            if (fileUsuarios.getSubmittedFileName() == null || !fileUsuarios.getSubmittedFileName().equals("usuarios.txt")) {
                jsonObject.put("usuarios", "No");
            } else {
                BufferedReader bru = new BufferedReader(new InputStreamReader(fileUsuarios.getInputStream(), "UTF-8"));
                String linea;
                DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

                while ((linea = bru.readLine()) != null) {

                    String[] partes = linea.split(":");
                    //si no existe ya un usuario con ese DNI o email, se añade
                    if (!tienda.existeUsuarioDNI(partes[0]) && !tienda.existeUsuarioEmail(partes[4])) {
                        Usuario u = new Usuario();
                        u.setDNI(partes[0]);
                        u.setNombre(partes[1]);
                        u.setApellidos(partes[2]);
                        try {
                            u.setFechaNac(df.parse(partes[3]));
                        } catch (ParseException pe) {
                            System.err.println("Error parse fecha");
                        }
                        u.setEmail(partes[4]);
                        //Encriptamos password antes de set y commit a la BD
                        Cifrado c = new Cifrado();
                        String pwCifrada = "";
                        try {
                            pwCifrada = c.encriptar(partes[5]);
                        } catch (GeneralSecurityException | UnsupportedEncodingException ex) {
                            Logger.getLogger(AltaUsuario.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        u.setPassword(pwCifrada);

                        u.setAdmin(Boolean.valueOf(partes[6]));
                        try {
                            tienda.altaUsuario(u);
                        } catch (Exception ex) {

                        }

                    }
                }
                jsonObject.put("usuarios", "Si");
            }

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
