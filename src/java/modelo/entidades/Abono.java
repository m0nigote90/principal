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

public class Abono extends Articulo implements Comparable {
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
            String descripcion, String tipo, Double volumen, Integer tipoIVA, Double precioSinIVA){
        super(referencia, "abono", fabricante, descripcion, tipoIVA);
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
    public String toString(){
        return categoria+": Fabricante: "+fabricante+", Tipo: "+tipo+
                "\", Precio sin IVA: "+precioSinIVA+" € PVP: "+super.getPrecio()+" €";
    }
    
}
