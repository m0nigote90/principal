/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.entidades.Usuario;
import modelo.entidades.Articulo;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import modelo.dao.exceptions.NonexistentEntityException;
import modelo.entidades.Pedido;

/**
 *
 * @author Pedro
 */
public class PedidoJpaController implements Serializable {

    public PedidoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Pedido pedido) {
        if (pedido.getArticulosPedido() == null) {
            pedido.setArticulosPedido(new ArrayList<Articulo>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Usuario usuario = pedido.getUsuario();
            if (usuario != null) {
                usuario = em.getReference(usuario.getClass(), usuario.getId());
                pedido.setUsuario(usuario);
            }
            List<Articulo> attachedArticulosPedido = new ArrayList<Articulo>();
            for (Articulo articulosPedidoArticuloToAttach : pedido.getArticulosPedido()) {
                articulosPedidoArticuloToAttach = em.getReference(articulosPedidoArticuloToAttach.getClass(), articulosPedidoArticuloToAttach.getId());
                attachedArticulosPedido.add(articulosPedidoArticuloToAttach);
            }
            pedido.setArticulosPedido(attachedArticulosPedido);
            em.persist(pedido);
            if (usuario != null) {
                usuario.getPedidos().add(pedido);
                usuario = em.merge(usuario);
            }
            for (Articulo articulosPedidoArticulo : pedido.getArticulosPedido()) {
                articulosPedidoArticulo.getPedidos().add(pedido);
                articulosPedidoArticulo = em.merge(articulosPedidoArticulo);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Pedido pedido) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Pedido persistentPedido = em.find(Pedido.class, pedido.getId());
            Usuario usuarioOld = persistentPedido.getUsuario();
            Usuario usuarioNew = pedido.getUsuario();
            List<Articulo> articulosPedidoOld = persistentPedido.getArticulosPedido();
            List<Articulo> articulosPedidoNew = pedido.getArticulosPedido();
            if (usuarioNew != null) {
                usuarioNew = em.getReference(usuarioNew.getClass(), usuarioNew.getId());
                pedido.setUsuario(usuarioNew);
            }
            List<Articulo> attachedArticulosPedidoNew = new ArrayList<Articulo>();
            for (Articulo articulosPedidoNewArticuloToAttach : articulosPedidoNew) {
                articulosPedidoNewArticuloToAttach = em.getReference(articulosPedidoNewArticuloToAttach.getClass(), articulosPedidoNewArticuloToAttach.getId());
                attachedArticulosPedidoNew.add(articulosPedidoNewArticuloToAttach);
            }
            articulosPedidoNew = attachedArticulosPedidoNew;
            pedido.setArticulosPedido(articulosPedidoNew);
            pedido = em.merge(pedido);
            if (usuarioOld != null && !usuarioOld.equals(usuarioNew)) {
                usuarioOld.getPedidos().remove(pedido);
                usuarioOld = em.merge(usuarioOld);
            }
            if (usuarioNew != null && !usuarioNew.equals(usuarioOld)) {
                usuarioNew.getPedidos().add(pedido);
                usuarioNew = em.merge(usuarioNew);
            }
            for (Articulo articulosPedidoOldArticulo : articulosPedidoOld) {
                if (!articulosPedidoNew.contains(articulosPedidoOldArticulo)) {
                    articulosPedidoOldArticulo.getPedidos().remove(pedido);
                    articulosPedidoOldArticulo = em.merge(articulosPedidoOldArticulo);
                }
            }
            for (Articulo articulosPedidoNewArticulo : articulosPedidoNew) {
                if (!articulosPedidoOld.contains(articulosPedidoNewArticulo)) {
                    articulosPedidoNewArticulo.getPedidos().add(pedido);
                    articulosPedidoNewArticulo = em.merge(articulosPedidoNewArticulo);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Long id = pedido.getId();
                if (findPedido(id) == null) {
                    throw new NonexistentEntityException("The pedido with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Long id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Pedido pedido;
            try {
                pedido = em.getReference(Pedido.class, id);
                pedido.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The pedido with id " + id + " no longer exists.", enfe);
            }
            Usuario usuario = pedido.getUsuario();
            if (usuario != null) {
                usuario.getPedidos().remove(pedido);
                usuario = em.merge(usuario);
            }
            List<Articulo> articulosPedido = pedido.getArticulosPedido();
            for (Articulo articulosPedidoArticulo : articulosPedido) {
                articulosPedidoArticulo.getPedidos().remove(pedido);
                articulosPedidoArticulo = em.merge(articulosPedidoArticulo);
            }
            em.remove(pedido);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Pedido> findPedidoEntities() {
        return findPedidoEntities(true, -1, -1);
    }

    public List<Pedido> findPedidoEntities(int maxResults, int firstResult) {
        return findPedidoEntities(false, maxResults, firstResult);
    }

    private List<Pedido> findPedidoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Pedido.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Pedido findPedido(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Pedido.class, id);
        } finally {
            em.close();
        }
    }

    public int getPedidoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Pedido> rt = cq.from(Pedido.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
