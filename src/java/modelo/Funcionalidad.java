/*
 * Bean Registro
 * Nos permitirá acceder a todo el modelo de la empresa
 */
package modelo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.Persistence;
import modelo.dao.AbonoJpaController;
import modelo.dao.ArticuloJpaController;
import modelo.dao.PedidoJpaController;
import modelo.dao.PlantaJpaController;
import modelo.dao.UsuarioJpaController;
import modelo.entidades.Abono;
import modelo.entidades.Articulo;
import modelo.entidades.Pedido;
import modelo.entidades.Planta;
import modelo.entidades.Usuario;

/**
 *
 * @author Pedro
 */
public class Funcionalidad implements Serializable {
    
    // Unidad de Persistencia
    public static final String PERSISTENCIA = "Proyecto_FINALPU";
    
    
    
    //Obtener listas
    public List<Usuario> getUsuarios() {
        UsuarioJpaController ujc = new 
            UsuarioJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ujc.findUsuarioEntities();
    }
    
    public List<Articulo> getArticulos() {
        ArticuloJpaController ajc = new 
            ArticuloJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ajc.findArticuloEntities();
    }
    
    public List<Planta> getPlantas() {
        PlantaJpaController pjc = new 
           PlantaJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return pjc.findPlantaEntities();
    }
    
    public List<Abono> getAbonos() {
        AbonoJpaController ajc = new 
           AbonoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ajc.findAbonoEntities();
    }
    
    public List<Pedido> getPedidos() {
        PedidoJpaController pjc = new 
            PedidoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return pjc.findPedidoEntities();
    }
    
    //Filtros
     public List<Usuario> filtrarUsuariosNombre(String filtro) {
        List<Usuario> usuarios = getUsuarios();
        List<Usuario> filtrados = new ArrayList();
        if (!filtro.isEmpty()) {
            for (Usuario u : usuarios) {
                if (u.getNombre().contains(filtro) || u.getApellidos().contains(filtro)) {
                    filtrados.add(u);
                }
            }
        } else {
            filtrados = usuarios;
        }
        return filtrados;
    }
     
     public List<Articulo> filtrarArticulosCategoria(String filtro) {
        List<Articulo> articulos = getArticulos();
        List<Articulo> filtrados = new ArrayList();
        if (!filtro.isEmpty()) {
            for (Articulo u : articulos) {
                if (u.getCategoria().contains(filtro)) {
                    filtrados.add(u);
                }
            }
        } else {
            filtrados = articulos;
        }
        return filtrados;
    }
     
     public List<Planta> filtrarPlantasTipo(String filtro) {
        List<Planta> plantas = getPlantas();
        List<Planta> filtrados = new ArrayList();
        if (!filtro.isEmpty()) {
            for (Planta p : plantas) {
                if (p.getTipo().contains(filtro)) {
                    filtrados.add(p);
                }
            }
        } else {
            filtrados = plantas;
        }
        return filtrados;
    }
     
     public List<Abono> filtrarAbonosTipoPlanta(String filtro) {
        List<Abono> abonos = getAbonos();
        List<Abono> filtrados = new ArrayList();
        if (!filtro.isEmpty()) {
            for (Abono a : abonos) {
                if (a.getTipo().contains(filtro)) {
                    filtrados.add(a);
                }
            }
        } else {
            filtrados = abonos;
        }
        return filtrados;
    }
    
     //Podemos usar compareToIgnoreCase() para obviar coincidencia de mayúsculas
    public List<Usuario> getUsuariosAlfabeticamente() {
        List<Usuario> usuarios = getUsuarios();
        Collections.sort(usuarios, (e1, e2) ->
                (e1.getApellidos() + e1.getNombre()).compareTo(e2.getApellidos() + e2.getNombre()));
        return usuarios;
    }
    
    public List<Articulo> getArticulosAlfabeticamenteCategoria() {
        List<Articulo> articulos = getArticulos();
        Collections.sort(articulos, (e1, e2) ->
                (e1.getCategoria()).compareTo(e2.getCategoria()));
        return articulos;
    }
    
    public List<Planta> getPlantasAlfabeticamente() {
        List<Planta> plantas = getPlantas();
        Collections.sort(plantas, (e1, e2) ->
                (e1.getNombre()).compareTo(e2.getNombre()));
        return plantas;
    }
    
    //Altas
    public void altaUsuario(Usuario usu) throws Exception {
        UsuarioJpaController ujc = new 
            UsuarioJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
            ujc.create(usu);
    }
    
    public void altaPlanta(Planta pla) throws Exception {
        PlantaJpaController plajc = new 
            PlantaJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
            plajc.create(pla);
    }
    
    public void altaAbono(Abono abo) throws Exception {
        AbonoJpaController abojc = new 
            AbonoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
            abojc.create(abo);
    }
    public void altaPedido(Pedido ped) throws Exception {
        PedidoJpaController pedjc = new 
            PedidoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
            pedjc.create(ped);
    }
    
    //Búsquedas
    public Usuario buscarUsuario(Long id) {
        UsuarioJpaController ujc = new 
            UsuarioJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ujc.findUsuario(id);
    }
    
    public Articulo buscarArticulo(Long id) {
        ArticuloJpaController ejc = new 
            ArticuloJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ejc.findArticulo(id);
    }
    
    public Planta buscarPlanta(Long id) {
        PlantaJpaController ejc = new 
            PlantaJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ejc.findPlanta(id);
    }
    
    public Abono buscarAbono(Long id) {
        AbonoJpaController ejc = new 
            AbonoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ejc.findAbono(id);
    }
    
    public Pedido buscarPedido(Long id) {
        PedidoJpaController ejc = new 
            PedidoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ejc.findPedido(id);
    }
    
    //Actualizaciones
    public void actualizarUsuario(Usuario usu) throws Exception {
        UsuarioJpaController sjc = new 
            UsuarioJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
            sjc.edit(usu);
    }

    public void actualizarArticulo(Articulo art) throws Exception{
        ArticuloJpaController ajc = new ArticuloJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        ajc.edit(art);
    }

    public void actualizarPedido(Pedido ped) throws Exception{
        PedidoJpaController pjc = new PedidoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        pjc.edit(ped);
    }
}