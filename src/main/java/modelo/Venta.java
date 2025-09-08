package modelo;

import java.sql.Date;

public class Venta {

    private int id;
    private Date fecha;
    private String metodoPago;
    private double total;
    
    public double getTotal() {
        return total;
    }

    // Getters y Setters
    public void setTotal(double total) {    
        this.total = total;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }
}
