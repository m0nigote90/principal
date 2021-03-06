/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.entidades;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Pedro
 */

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@Table(
        name = "Articulos",
        indexes = {@Index(name = "indice_id", columnList = "id", unique = true)}
)
public abstract class Articulo implements Comparable, Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(name = "Referencia")
    protected String referencia;
    @Column(name = "Categoria")
    protected String categoria;
    @Column(name = "Fabricante")
    protected String fabricante;
    @Column(name = "Descripcion", length = 400)
    protected String descripcion;
    @Column(name = "Tipo_IVA")
    protected Integer tipoIVA;
    @Column(name = "Fecha_Alta")
    @Temporal(value = TemporalType.TIMESTAMP)
    protected Date fechaAlta = new Timestamp(new Date().getTime());
    @Column(name = "Vendido")
    protected Boolean vendido = false;
    @Column(name = "Baja")
    protected Boolean baja = false;
    @ManyToMany(mappedBy = "articulosPedido")
    protected List<Pedido> pedidos;
    
    
    
    public Articulo () {}

    public Articulo(String referencia, String categoria, String fabricante, String descripcion, Integer tipoIVA) {
        this.referencia = referencia;
        this.categoria = categoria;
        this.fabricante = fabricante;
        this.descripcion = descripcion;
        this.tipoIVA = tipoIVA;
        vendido = false;
        baja = false;
    }     
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getFabricante() {
        return fabricante;
    }

    public void setFabricante(String fabricante) {
        this.fabricante = fabricante;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Integer getTipoIVA() {
        return tipoIVA;
    }

    public void setTipoIVA(Integer tipoIVA) {
        this.tipoIVA = tipoIVA;
    }

    public Boolean getVendido() {
        return vendido;
    }

    public void setVendido(Boolean vendido) {
        this.vendido = vendido;
    }

    public List<Pedido> getPedidos() {
        return pedidos;
    }

    public void setPedidos(List<Pedido> pedidos) {
        this.pedidos = pedidos;
    }

    public Boolean getBaja() {
        return baja;
    }

    public void setBaja(Boolean baja) {
        this.baja = baja;
    }
    
    public Date getFechaAlta() {
        return fechaAlta;
    }

    public void setFechaAlta(Date fechaAlta) {
        this.fechaAlta = fechaAlta;
    }
    /**
     * Devuelve el nombre de la imagen para poder usarla como ruta.
     * Usa la referencia y la categor??a del art??culo y la extension jpg.
     * @return Nombre de la im??gen
     */
    public String getNombreImagen(){
        return this.referencia+".jpg";
    }
    
    /**
     * Cada art??culo definir?? el precio de sus componentes en caso de tener m??s de uno.
     * @return Precio sin IVA
     */
    public abstract Double getPrecioSinIVA();
    
    public Double getPrecio(){
        return this.getPrecioSinIVA()+(this.getPrecioSinIVA()*((double)tipoIVA/100));
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
        if (!(object instanceof Articulo)) {
            return false;
        }
        Articulo other = (Articulo) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public int compareTo(Object o){
        Articulo otro = (Articulo) o;
        
        return (this.getPrecio().compareTo(otro.getPrecio()));
    }
    @Override
    public String toString() {
        return "modelo.entidades.Articulo[ id=" + id + " ]";
    }
    
}
