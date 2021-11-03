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
import modelo.entidades.Pedido;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import modelo.dao.exceptions.NonexistentEntityException;
import modelo.entidades.Abono;

/**
 *
 * @author Pedro
 */
public class AbonoJpaController implements Serializable {

    public AbonoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Abono abono) {
        if (abono.getPedidos() == null) {
            abono.setPedidos(new ArrayList<Pedido>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Pedido> attachedPedidos = new ArrayList<Pedido>();
            for (Pedido pedidosPedidoToAttach : abono.getPedidos()) {
                pedidosPedidoToAttach = em.getReference(pedidosPedidoToAttach.getClass(), pedidosPedidoToAttach.getId());
                attachedPedidos.add(pedidosPedidoToAttach);
            }
            abono.setPedidos(attachedPedidos);
            em.persist(abono);
            for (Pedido pedidosPedido : abono.getPedidos()) {
                pedidosPedido.getArticulosPedido().add(abono);
                pedidosPedido = em.merge(pedidosPedido);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Abono abono) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Abono persistentAbono = em.find(Abono.class, abono.getId());
            List<Pedido> pedidosOld = persistentAbono.getPedidos();
            List<Pedido> pedidosNew = abono.getPedidos();
            List<Pedido> attachedPedidosNew = new ArrayList<Pedido>();
            for (Pedido pedidosNewPedidoToAttach : pedidosNew) {
                pedidosNewPedidoToAttach = em.getReference(pedidosNewPedidoToAttach.getClass(), pedidosNewPedidoToAttach.getId());
                attachedPedidosNew.add(pedidosNewPedidoToAttach);
            }
            pedidosNew = attachedPedidosNew;
            abono.setPedidos(pedidosNew);
            abono = em.merge(abono);
            for (Pedido pedidosOldPedido : pedidosOld) {
                if (!pedidosNew.contains(pedidosOldPedido)) {
                    pedidosOldPedido.getArticulosPedido().remove(abono);
                    pedidosOldPedido = em.merge(pedidosOldPedido);
                }
            }
            for (Pedido pedidosNewPedido : pedidosNew) {
                if (!pedidosOld.contains(pedidosNewPedido)) {
                    pedidosNewPedido.getArticulosPedido().add(abono);
                    pedidosNewPedido = em.merge(pedidosNewPedido);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Long id = abono.getId();
                if (findAbono(id) == null) {
                    throw new NonexistentEntityException("The abono with id " + id + " no longer exists.");
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
            Abono abono;
            try {
                abono = em.getReference(Abono.class, id);
                abono.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The abono with id " + id + " no longer exists.", enfe);
            }
            List<Pedido> pedidos = abono.getPedidos();
            for (Pedido pedidosPedido : pedidos) {
                pedidosPedido.getArticulosPedido().remove(abono);
                pedidosPedido = em.merge(pedidosPedido);
            }
            em.remove(abono);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Abono> findAbonoEntities() {
        return findAbonoEntities(true, -1, -1);
    }

    public List<Abono> findAbonoEntities(int maxResults, int firstResult) {
        return findAbonoEntities(false, maxResults, firstResult);
    }

    private List<Abono> findAbonoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Abono.class));
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

    public Abono findAbono(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Abono.class, id);
        } finally {
            em.close();
        }
    }

    public int getAbonoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Abono> rt = cq.from(Abono.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
