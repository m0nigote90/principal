/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.entidades;

import java.io.Serializable;
import java.sql.Timestamp;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import modelo.entidades.Articulo;

/**
 *
 * @author Pedro
 */
@Entity
@Table(
        name = "Pedidos",
        indexes = {@Index(name = "indice_id", columnList = "id", unique = true)}
)
public class Pedido implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @JoinColumn(name = "Cliente")
    @ManyToOne
    private Usuario usuario;
    @Column(name = "Fecha")
    @Temporal(value = TemporalType.TIMESTAMP)
    protected Date fecha = new Timestamp(new Date().getTime());
    
    @JoinTable(
        name = "rel_pedido_articulos",
        joinColumns = @JoinColumn(name = "FK_PEDIDO", nullable = false),
        inverseJoinColumns = @JoinColumn(name="FK_ARTICULO", nullable = false)
    )
    @ManyToMany(cascade = CascadeType.MERGE)
    private List<Articulo> articulosPedido;
    
    public Pedido () {}
    
    public Pedido (Usuario usuario){
        this.usuario = usuario;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public LocalDate getFecha() {
        LocalDate fechaB = convertToLocalDateViaSqlDate(fecha);
        return fechaB;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

//    Método para convertir de Date a LocalDate para obtener la Edad
    public LocalDate convertToLocalDateViaSqlDate(java.util.Date dateToConvert) {
        return new java.sql.Date(dateToConvert.getTime()).toLocalDate();
    }
    public List<Articulo> getArticulosPedido() {
        return  articulosPedido!=null? new ArrayList<>(articulosPedido) : new ArrayList<>();
    }
    public Integer getNumArticulos(){
        return this.articulosPedido.size();   
    }
    public void setArticulosPedido(List<Articulo> articulosPedido) {
        if(this.articulosPedido==null){
            this.articulosPedido = new ArrayList<>(articulosPedido);
        } else {
            this.articulosPedido = articulosPedido;
        }
        
    }
    /**
     * Devuelve el Artículo correspondiente al índice pasado como parámetro.
     * @param i Índice
     * @return Artículo
     */
    public Articulo getArticulo(int i){
        return articulosPedido.get(i);
    }

    /**
     * Devuelve el precio total de todos los artículos.
     * @return Precio total
     */
    public double getTotal(){
        double total = 0;
        for (int i = 0; i < articulosPedido.size(); i++) {
            total += articulosPedido.get(i).getPrecio(); 
        }
        return total;
    }
    /**
     * Devuelve el precio total de todos los artículos pero sin IVA.
     * @return Precio total sin IVA.
     */
    public double getTotalSinIVA(){
        double total = 0;
        for (int i = 0; i < articulosPedido.size(); i++) {
            total += articulosPedido.get(i).getPrecioSinIVA(); 
        }
        return total;
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
        if (!(object instanceof Pedido)) {
            return false;
        }
        Pedido other = (Pedido) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString(){
        String listaArticulos="";
        
        for (int i = 0; i < articulosPedido.size(); i++) {
            listaArticulos += articulosPedido.get(i).toString()+"\n";
        }
        return "Nº Pedido: "+id+"\nCliente: "+usuario.getApellidos()+", "+usuario.getNombre()+" - "+usuario.getDNI()+"\n\nArtículos\n-----------\n"+listaArticulos+
                "\nTotal sin IVA: "+this.getTotalSinIVA()+" €\nTotal: "+this.getTotal()+" €";
    }
    /**
     * Ordena por precio ascendente los artículos de la factura
     */
    public void ordenarPorPrecioAsc(){
        Collections.sort(articulosPedido);
    }
    /**
     * Ordena por precio descendente los artículos de la factura.
     */
    public void ordenarPorPrecioDesc(){
        Collections.reverse(articulosPedido);
    }
    
}
