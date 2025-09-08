package modelo;

import java.util.List;

public class ItemCarritoPelicula extends ItemCarritoBase {
    private Pelicula pelicula;
    private int cantidad;
    private List<String> asientos;

    public ItemCarritoPelicula(Pelicula pelicula, int cantidad) {
        this.pelicula = pelicula;
        this.cantidad = cantidad;
    }

    public Pelicula getPelicula() {
        return pelicula;
    }

    public void setPelicula(Pelicula pelicula) {
        this.pelicula = pelicula;
    }

    @Override
    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    @Override
    public double getPrecioUnitario() {
        return pelicula.getPrecio();
    }

    @Override
    public String getTipo() {
        return "pelicula";
    }

    public List<String> getAsientos() {
        return asientos;
    }

    public void setAsientos(List<String> asientos) {
        this.asientos = asientos;
    }
}
