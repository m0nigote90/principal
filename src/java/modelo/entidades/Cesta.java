/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.entidades;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

/**
 *
 * @author Pedro
 */
@Entity
public class Cesta implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @JoinColumn(name = "Usuario")
    @OneToOne
    protected Usuario usuario;
    
//    @JoinTable(
//        name = "Cestas",
//        joinColumns = @JoinColumn(name = "FK_CESTA", nullable = false),
//        inverseJoinColumns = @JoinColumn(name="FK_ARTICULO", nullable = false)
//    )
    @JoinColumn(name = "Articulos")
    @ManyToMany(cascade = CascadeType.MERGE)
    private List<Articulo> articulosCesta = new ArrayList<>();
    
    
    public Cesta(){}
    
    public Cesta(Usuario usuario, List<Articulo> articulosCesta){
        this.usuario = usuario;
        this.articulosCesta = new ArrayList<>();
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public List<Articulo> getArticulosCesta() {
        return articulosCesta;
    }

    public void setArticulosCesta(List<Articulo> articulosCesta) {
        this.articulosCesta = articulosCesta;
    }
    
    
    public void addArticuloCesta(Articulo art){
        articulosCesta.add(art);
    }
    public void rmvArticuloCesta(Articulo art) {
        articulosCesta.remove(art);
    }
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cesta)) {
            return false;
        }
        Cesta other = (Cesta) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.entidades.ArticulosUsuarios[ id=" + id + " ]";
    }
    
}
