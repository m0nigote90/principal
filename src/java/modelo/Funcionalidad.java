/*
 * Bean Registro
 * Nos permitirá acceder a todo el modelo de la empresa
 */
package modelo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;
import modelo.dao.AbonoJpaController;
import modelo.dao.ArticuloJpaController;
import modelo.dao.PedidoJpaController;
import modelo.dao.PlantaJpaController;
import modelo.dao.UsuarioJpaController;
import modelo.dao.exceptions.NonexistentEntityException;
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
    //Modificamos los métodos para traernos los elementos que no estén de baja
    public List<Usuario> getUsuarios() {
//      UsuarioJpaController ujc = new UsuarioJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM usuarios WHERE baja = false;", Usuario.class);

        return query.getResultList();
//        return ujc.findUsuarioEntities();
    }

    public List<Articulo> getArticulos() {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM articulos WHERE baja = false;", Articulo.class);

        return query.getResultList();
    }

    public List<Planta> getPlantas() {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM articulos WHERE DTYPE = 'Planta' AND baja = false;", Planta.class);

        return query.getResultList();
    }

    public List<Abono> getAbonos() {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM articulos WHERE DTYPE = 'Abono' AND baja = false;", Abono.class);

        return query.getResultList();
    }

    public List<Pedido> getPedidos() {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM pedidos WHERE baja = false;", Pedido.class);

        return query.getResultList();
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
    public List<Usuario> filtrarUsuariosDni(String filtro) {
        List<Usuario> usuarios = getUsuarios();
        List<Usuario> filtrados = new ArrayList();
        if (!filtro.isEmpty()) {
            for (Usuario u : usuarios) {
                if (u.getDNI().contains(filtro)) {
                    filtrados.add(u);
                }
            }
        } else {
            filtrados = usuarios;
        }
        return filtrados;
    }
    public List<Usuario> filtrarUsuariosNombreDni(String nombre, String dni) {
        List<Usuario> usuarios = getUsuarios();
        List<Usuario> filtrados = new ArrayList();
        if (!nombre.isEmpty() && !dni.isEmpty()) {
            for (Usuario u : usuarios) {
                if (u.getNombre().contains(nombre) || u.getApellidos().contains(nombre) && u.getDNI().contains(dni)) {
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

    public boolean existeUsuarioDNI(String dni) {
        boolean existe = false;
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM usuarios WHERE dni = ?1 AND baja = false;", Usuario.class).setParameter(1, dni);

        try {
            List<Usuario> usuarios = query.getResultList();
            if (!usuarios.isEmpty()) {
                existe = true;
            }
        } catch (Exception e) {
        }
        return existe;
    }

    public boolean existeUsuarioEmail(String email) {
        boolean existe = false;
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM usuarios WHERE email = ?1 AND baja = false;", Usuario.class).setParameter(1, email);

        try {
            List<Usuario> usuarios = query.getResultList();
            if (!usuarios.isEmpty()) {
                existe = true;
            }
        } catch (Exception e) {
        }
        return existe;
    }

    public boolean existePlantaRef(String ref) {
        boolean existe = false;
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM articulos WHERE Referencia = ?1 AND baja = false;", Articulo.class).setParameter(1, ref);

        try {
            List<Articulo> articulos = query.getResultList();
            if (!articulos.isEmpty()) {
                existe = true;
            }
        } catch (Exception e) {
        }
        return existe;
    }

    //Método que nos devuelve la lista de articulos pero agrupadas por diferentes
    //He usado el metodo createNativeQuery de JPA para crear un group by y devolverlos como Articulo.class
    public List<Articulo> agruparArticulosRef() {

        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();

        List<Articulo> resultados
                = em.createNativeQuery("SELECT * FROM articulos WHERE baja = false GROUP BY Referencia;", Articulo.class).getResultList();
        return resultados;
    }

    //Pasándole el tipo, nos devuelve todos esos articulos agrupados por referencia, para asi mostrar sin repetidos esos articulos de ese tipo
    //nos sirve para las tablas de articulos
    public List<Articulo> agruparArticulosPorRefTipo(String categoria) {

        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        List<Articulo> resultados
                = em.createNativeQuery("SELECT * FROM articulos WHERE DTYPE = ?1 AND baja = false GROUP BY Referencia;", Articulo.class).setParameter(1, categoria).getResultList();
        return resultados;
    }

    public List<Articulo> devuelveFabricantes(String tipo) {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        List<Articulo> resultados
                = em.createNativeQuery("SELECT * FROM articulos WHERE DTYPE = ?1 AND baja = false GROUP BY fabricante;", Articulo.class).setParameter(1, tipo).getResultList();
        return resultados;
    }

    public List<Articulo> devuelveTipos(String categoria) {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        List<Articulo> resultados
                = em.createNativeQuery("SELECT * FROM articulos WHERE DTYPE = ?1 AND baja = false GROUP BY tipo;", Articulo.class).setParameter(1, categoria).getResultList();
        return resultados;
    }

    //Filtramos los articulos por referencia haciendo nativeQuery que es mucho más eficiente siempre y cuando no esten vendidos
    public List<Articulo> filtrarArticulosReferencia(String ref) {

        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        List<Articulo> resultados
                = em.createNativeQuery("SELECT * FROM articulos WHERE vendido = false and baja = false AND Referencia = "
                        + "?1", Articulo.class).setParameter(1, ref).getResultList();
        return resultados;
    }

    //dudo si controlar los vendidos como baja = false;
    public List<Articulo> filtrarArticulosReferenciaVendidos(String ref) {

        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        List<Articulo> resultados
                = em.createNativeQuery("SELECT * FROM articulos WHERE vendido = true AND Referencia = "
                        + "?1", Articulo.class).setParameter(1, ref).getResultList();
        return resultados;
    }

    public Articulo devolverArtPorRef(String ref) {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Articulo resultado
                = (Articulo) em.createNativeQuery("SELECT * FROM articulos WHERE Referencia = ?1 AND baja = false LIMIT 1;", Articulo.class).setParameter(1, ref).getSingleResult();
        return resultado;
    }

    public List<Articulo> articulosRef(String ref) {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        List<Articulo> resultados
                = em.createNativeQuery("SELECT * FROM articulos WHERE Referencia = "
                        + "?1 AND baja = false;", Articulo.class).setParameter(1, ref).getResultList();
        return resultados;
    }

    //Devuelve el stockTotal de un articulo en concreto por su referencia
    public Integer stockTotalArticulo(String ref) {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        List<Articulo> resultados
                = em.createNativeQuery("SELECT * FROM articulos WHERE Referencia = "
                        + "?1 AND baja = false;", Articulo.class).setParameter(1, ref).getResultList();
        return resultados.size();
    }

    public Integer stockParcialArticulo(String ref, Boolean vendido) {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM articulos WHERE Referencia = "
                + "?1 AND Vendido = ?2 AND baja = false;", Articulo.class).setParameter(1, ref).setParameter(2, vendido);
        List<Articulo> resultados = query.getResultList();

        return resultados.size();
    }

    //Aqui manejamos las funciones para la cesta a de articulos
    public List<Articulo> cestaUsuarioSinRepetidos(Integer id) {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM articulos WHERE id IN (SELECT FK_ARTICULO FROM rel_usuario_articulos WHERE FK_USUARIO = ?1) AND baja = false GROUP BY Referencia;", Articulo.class).setParameter(1, id);
        List<Articulo> resultados = query.getResultList();
        return resultados;
    }

    //Cuantas unidades compradas de un mismo articulo
    public Integer unidadesCompradas(Integer id, String ref) {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Query query = em.createNativeQuery("SELECT * FROM articulos WHERE id IN (SELECT FK_ARTICULO FROM rel_usuario_articulos WHERE FK_USUARIO = ?1) AND Referencia = ?2 AND baja = false;", Articulo.class).setParameter(1, id).setParameter(2, ref);
        List<Articulo> resultados = query.getResultList();
        return resultados.size();
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

    //Editamos los articulos que sean de la misma referencia
    //Un bug de JPA me ha hecho reconstruir el método
    //Ya no uso esto
    public int editarPlantaRef(String ref, String nombre, String tipo, String fab, String des, Integer iva, Double precioSin) {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        String q = "UPDATE articulos SET referencia = '" + ref + "', nombre = '" + nombre + "', tipo = '" + tipo + "', fabricante = '" + fab + "', descripcion = '" + des + "', precioSinIVA = " + precioSin + ", Tipo_IVA = " + iva + " WHERE referencia = '" + ref + "';";

        EntityTransaction trans = em.getTransaction();
        trans.begin();
        int n = em.createNativeQuery(q).executeUpdate();

        trans.commit();

        return n;
    }

    ;
    //Podemos usar compareToIgnoreCase() para obviar coincidencia de mayúsculas
    public List<Usuario> getUsuariosAlfabeticamente() {
        List<Usuario> usuarios = getUsuarios();
        Collections.sort(usuarios, (e1, e2)
                -> (e1.getApellidos() + e1.getNombre()).compareTo(e2.getApellidos() + e2.getNombre()));
        return usuarios;
    }

    public List<Articulo> getArticulosAlfabeticamenteCategoria() {
        List<Articulo> articulos = getArticulos();
        Collections.sort(articulos, (e1, e2)
                -> (e1.getCategoria()).compareTo(e2.getCategoria()));
        return articulos;
    }

    public List<Planta> getPlantasAlfabeticamente() {
        List<Planta> plantas = getPlantas();
        Collections.sort(plantas, (e1, e2)
                -> (e1.getNombre()).compareTo(e2.getNombre()));
        return plantas;
    }

    //Altas
    public void altaUsuario(Usuario usu) throws Exception {
        UsuarioJpaController ujc = new UsuarioJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        ujc.create(usu);
    }

    public void altaPlanta(Planta pla) throws Exception {
        PlantaJpaController plajc = new PlantaJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        plajc.create(pla);
    }

    public void altaAbono(Abono abo) throws Exception {
        AbonoJpaController abojc = new AbonoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        abojc.create(abo);
    }

    public void altaPedido(Pedido ped) throws Exception {
        PedidoJpaController pedjc = new PedidoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        pedjc.create(ped);
    }

    //Búsquedas
    public Usuario buscarUsuario(Long id) {
        UsuarioJpaController ujc = new UsuarioJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ujc.findUsuario(id);
    }

    public Usuario buscarUsuarioEmail(String email) {
        EntityManager em = Persistence.createEntityManagerFactory(PERSISTENCIA).createEntityManager();
        Usuario resultado
                = (Usuario) em.createNativeQuery("SELECT * FROM usuarios WHERE email = ?1 AND baja = false;", Usuario.class).setParameter(1, email).getSingleResult();
        return resultado;
    }

    public Articulo buscarArticulo(Long id) {
        ArticuloJpaController ejc = new ArticuloJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ejc.findArticulo(id);
    }

    public void removeArticulo(Long id) {
        try {
            ArticuloJpaController ejc = new ArticuloJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
            ejc.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(Funcionalidad.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Planta buscarPlanta(Long id) {
        PlantaJpaController ejc = new PlantaJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ejc.findPlanta(id);
    }

    public Abono buscarAbono(Long id) {
        AbonoJpaController ejc = new AbonoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ejc.findAbono(id);
    }

    public Pedido buscarPedido(Long id) {
        PedidoJpaController ejc = new PedidoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        return ejc.findPedido(id);
    }

    //Actualizaciones
    public void actualizarUsuario(Usuario usu) throws Exception {
        UsuarioJpaController sjc = new UsuarioJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        sjc.edit(usu);
    }

    public void actualizarArticulo(Articulo art) throws Exception {
        ArticuloJpaController ajc = new ArticuloJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        ajc.edit(art);
    }

    public void actualizarPedido(Pedido ped) throws Exception {
        PedidoJpaController pjc = new PedidoJpaController(Persistence.createEntityManagerFactory(PERSISTENCIA));
        pjc.edit(ped);
    }

    //Método que devuelve el total con o sin IVA
    public Double getPrecioTotal(List<Articulo> lista, Boolean IVA) {
        Double total = 0.;
        if (!IVA) {
            for (Articulo a : lista) {
                if (!a.getBaja()) {
                    total += a.getPrecioSinIVA();
                }
            }
        } else {
            for (Articulo a : lista) {
                if (!a.getBaja()) {
                    total += a.getPrecio();
                }
            }
        }
        return total;
    }
}
