package modelo;


public class ItemCarrito extends ItemCarritoBase {
    private Producto producto;
    private int cantidad;

    public ItemCarrito(Producto producto, int cantidad) {
        this.producto = producto;
        this.cantidad = cantidad;
    }

    public Producto getProducto() {
        return producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    @Override
    public String getTipo() {
        return "producto";
    }

    @Override
    public double getPrecioUnitario() {
        return Double.parseDouble(producto.getPrecio());
    }
}
