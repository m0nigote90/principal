/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.entidades;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

/**
 *
 * @author Pedro
 */
@Entity
@Table(
        name = "Abonos",
        indexes = {@Index(name = "indice_id", columnList = "id", unique = true)}
)
public class Abono extends Articulo implements Comparable, Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(name = "Nombre")
    protected String nombre;
    @Column(name = "Tipo_Planta")
    protected String tipo;
    @Column(name = "Volumen")
    protected Double volumen;
    @Column(name = "PrecioSinIVA")
    protected Double precioSinIVA;
    
    public Abono () {}
    
    public Abono (String referencia, String categoria, String nombre, String fabricante, 
            String descripcion, String tipo, Double volumen, Integer tipoIVA, Integer stock, Double precioSinIVA){
        super(referencia, "abono", fabricante, descripcion, tipoIVA, stock);
        this.nombre = nombre;
        this.tipo = tipo;
        this.volumen = volumen;
        this.precioSinIVA = precioSinIVA;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    /**
     * Devuelve el precio sin IVA del Abono.
     * @return Precio sin IVA.
     */
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    @Override
    public Double getPrecioSinIVA(){
        return precioSinIVA;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Double getVolumen() {
        return volumen;
    }

    public void setVolumen(Double volumen) {
        this.volumen = volumen;
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
        if (!(object instanceof Abono)) {
            return false;
        }
        Abono other = (Abono) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString(){
        return categoria+": Fabricante: "+fabricante+", Tipo: "+tipo+
                "\", Precio sin IVA: "+precioSinIVA+" € PVP: "+super.getPrecio()+" €";
    }
    
}
