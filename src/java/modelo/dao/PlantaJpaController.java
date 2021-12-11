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
import modelo.entidades.Planta;

/**
 *
 * @author Pedro
 */
public class PlantaJpaController implements Serializable {

    public PlantaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Planta planta) {
        if (planta.getPedidos() == null) {
            planta.setPedidos(new ArrayList<Pedido>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Pedido> attachedPedidos = new ArrayList<Pedido>();
            for (Pedido pedidosPedidoToAttach : planta.getPedidos()) {
                pedidosPedidoToAttach = em.getReference(pedidosPedidoToAttach.getClass(), pedidosPedidoToAttach.getId());
                attachedPedidos.add(pedidosPedidoToAttach);
            }
            planta.setPedidos(attachedPedidos);
            em.persist(planta);
            for (Pedido pedidosPedido : planta.getPedidos()) {
                pedidosPedido.getArticulosPedido().add(planta);
                pedidosPedido = em.merge(pedidosPedido);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Planta planta) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Planta persistentPlanta = em.find(Planta.class, planta.getId());
            List<Pedido> pedidosOld = persistentPlanta.getPedidos();
            List<Pedido> pedidosNew = planta.getPedidos();
            List<Pedido> attachedPedidosNew = new ArrayList<Pedido>();
            for (Pedido pedidosNewPedidoToAttach : pedidosNew) {
                pedidosNewPedidoToAttach = em.getReference(pedidosNewPedidoToAttach.getClass(), pedidosNewPedidoToAttach.getId());
                attachedPedidosNew.add(pedidosNewPedidoToAttach);
            }
            pedidosNew = attachedPedidosNew;
            planta.setPedidos(pedidosNew);
            planta = em.merge(planta);
            for (Pedido pedidosOldPedido : pedidosOld) {
                if (!pedidosNew.contains(pedidosOldPedido)) {
                    pedidosOldPedido.getArticulosPedido().remove(planta);
                    pedidosOldPedido = em.merge(pedidosOldPedido);
                }
            }
            for (Pedido pedidosNewPedido : pedidosNew) {
                if (!pedidosOld.contains(pedidosNewPedido)) {
                    pedidosNewPedido.getArticulosPedido().add(planta);
                    pedidosNewPedido = em.merge(pedidosNewPedido);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Long id = planta.getId();
                if (findPlanta(id) == null) {
                    throw new NonexistentEntityException("The planta with id " + id + " no longer exists.");
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
            Planta planta;
            try {
                planta = em.getReference(Planta.class, id);
                planta.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The planta with id " + id + " no longer exists.", enfe);
            }
            List<Pedido> pedidos = planta.getPedidos();
            for (Pedido pedidosPedido : pedidos) {
                pedidosPedido.getArticulosPedido().remove(planta);
                pedidosPedido = em.merge(pedidosPedido);
            }
            em.remove(planta);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Planta> findPlantaEntities() {
        return findPlantaEntities(true, -1, -1);
    }

    public List<Planta> findPlantaEntities(int maxResults, int firstResult) {
        return findPlantaEntities(false, maxResults, firstResult);
    }

    private List<Planta> findPlantaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Planta.class));
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

    public Planta findPlanta(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Planta.class, id);
        } finally {
            em.close();
        }
    }

    public int getPlantaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Planta> rt = cq.from(Planta.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
