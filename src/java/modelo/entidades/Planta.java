/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.entidades;

import javax.persistence.Column;
import javax.persistence.Entity;


/**
 *
 * @author Pedro
 */
@Entity

public class Planta extends Articulo implements Comparable {

    @Column(name = "Nombre")
    protected String nombre;
    @Column(name = "Tipo")
    protected String tipo;
    @Column(name = "PrecioSinIVA")
    protected Double precioSinIVA;
    
    public Planta () {}
    
    public Planta (String referencia, String categoria, String tipo, String nombre, String fabricante, String descripcion, Integer tipoIVA, Double precioSinIVA){
        super(referencia, "planta", fabricante, descripcion, tipoIVA);
        this.nombre = nombre;
        this.tipo = tipo;
        this.precioSinIVA = precioSinIVA;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTipo() {
        return tipo;
    }

    @Override
    public String getCategoria() {
        return categoria;
    }

    @Override
    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public void setPrecioSinIVA(Double precioSin){
        this.precioSinIVA = precioSin;
    }
    /**
     * Devuelve el precio sin IVA de la Planta.
     * @return Precio sin IVA.
     */
    @Override
    public Double getPrecioSinIVA(){
        return precioSinIVA;
    }
    @Override
    public String getNombreImagen(){
        return this.referencia+".jpg";
    }
//    @Override
//    public int hashCode() {
//        int hash = 0;
//        hash += (super.id != null ? super.id.hashCode() : 0);
//        return hash;
//    }
//
//    @Override
//    public boolean equals(Object object) {
//        // TODO: Warning - this method won't work in the case the id fields are not set
//        if (!(object instanceof Planta)) {
//            return false;
//        }
//        Planta other = (Planta) object;
//        if ((id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
//            return false;
//        }
//        return true;
//    }

    @Override
    public String toString(){
        return categoria+": Fabricante: "+fabricante+" "+nombre+"\", Precio sin IVA: "+precioSinIVA+" € PVP: "+super.getPrecio()+" €";
    }
    
}
