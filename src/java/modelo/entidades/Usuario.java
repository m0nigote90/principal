/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.entidades;

import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Pedro
 */
@Entity
@Table(
        name = "Usuarios",
        indexes = {@Index(name = "indice_id", columnList = "id", unique = true)}
)
public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(name = "DNI", length = 9, unique = true)
    protected String dni;
    @Column(name = "Nombre")
    protected String nombre;
    @Column(name = "Apellidos")
    protected String apellidos;
    @Column(name = "Fecha_Nacimiento")
    @Temporal(value = TemporalType.DATE)
    protected Date fechaNac;
    @Column(name = "eMail", unique = true)
    protected String email;
    @Column(name = "Password", length = 20)
    protected String password;
    @Column(name = "Admin")
    protected Boolean admin;
    @Column(name = "Fecha_Alta")
    @Temporal(value = TemporalType.TIMESTAMP)
    protected Date fechaAlta = new Timestamp(new Date().getTime());
    @Column(name = "Baja")
    protected Boolean baja = false;
    @JoinColumn(name = "Pedidos")
    @OneToMany(mappedBy = "usuario", orphanRemoval = false, cascade = CascadeType.MERGE)
    private List<Pedido> pedidos;
    @JoinTable(
        name = "rel_usuario_articulos",
        joinColumns = @JoinColumn(name = "FK_USUARIO", nullable = false),
        inverseJoinColumns = @JoinColumn(name="FK_ARTICULO", nullable = false)
    )
    @ManyToMany(cascade = CascadeType.MERGE)
    protected List<Articulo> articulos = new ArrayList<>();

    public Usuario () { }

    public Usuario(String dni, String nombre, String apellidos, Date fechaNac, 
            String email, String password, Boolean admin) {
        this.dni = dni;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.fechaNac = fechaNac;
        this.email = email;
        this.password = password;
        this.admin = admin;
               
    }

      public Long getId() {
        return id;
    }

    public String getDNI() {
        return dni;
    }

    public void setDNI(String dni) {
        this.dni = dni;
    }

    public Date getFechaAlta() {
        return fechaAlta;
    }

    public void setId(Long id) {
        this.id = id;
    }
  

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public LocalDate getFechaNac() {
        LocalDate fechaN = convertToLocalDateViaSqlDate(fechaNac);
        return fechaN;
    }

    public void setFechaNac(Date fechaNac) {
        this.fechaNac = fechaNac;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public Boolean esAdmin() {
        return admin;
    }
    public void setAdmin(Boolean admin) {
        this.admin = admin;
    }
    
    public List<Pedido> getPedidos() {
        return pedidos;
    }
    public Pedido getPedido(Long id) {
        Pedido pedido = null;
        if(pedidos != null && !pedidos.isEmpty()){
            for(Pedido p : this.getPedidos()){
                if(p.getId() == id){
                    pedido = p;
                }
            }
        }
        return pedido;
    };
    public void setPedidos(List<Pedido> pedidos) {
        this.pedidos = pedidos;
    }
    
    public void addPedido(Pedido p){
        pedidos.add(p);
    }
    public List<Articulo> getArticulos() {
        List<Articulo> lista = new ArrayList<>();
        for(Articulo a: articulos){
            if(!a.getBaja()){
                lista.add(a);
            }
        }
        return lista;
    }
    public void addArticulo(Articulo a){
        articulos.add(a);
    }
    public void vaciarCesta(){
        articulos.clear();
    }
    public void setArticulos(List<Articulo> articulos) {
        this.articulos = articulos;
    }

    public Boolean getBaja() {
        return baja;
    }

    public void setBaja(Boolean baja) {
        this.baja = baja;
    }
    
    public Integer getEdad(){
        LocalDate ahora = LocalDate.now();
        LocalDate fechaN = convertToLocalDateViaSqlDate(fechaNac);
        Period periodo = Period.between(fechaN, ahora);
        return periodo.getYears();
    }
    //Método para convertir de Date a LocalDate para obtener la Edad
    public LocalDate convertToLocalDateViaSqlDate(Date dateToConvert) {
        return new java.sql.Date(dateToConvert.getTime()).toLocalDate();
    }   
    
    public void quitarArticuloCesta(Articulo a){
        articulos.remove(a);
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
        if (!(object instanceof Usuario)) {
            return false;
        }
        Usuario other = (Usuario) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.entidades.Usuario[ id=" + id + " ]";
    }
    
}
