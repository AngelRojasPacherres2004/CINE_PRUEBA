package modelo;

public class Producto {

    private int id;
    private String nombre;
    private String precio;
    private String descripcion;
    private byte[] foto;
    private int stock; // Nuevo campo
    private int cantidadVendida;

    // Constructor vacío
    public Producto() {
    }

    // Constructor con todos los campos
    public Producto(int id, String nombre, String precio, String descripcion, byte[] foto, int stock, int cantidadVendida) {
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
        this.descripcion = descripcion;
        this.foto = foto;
        this.stock = stock;
        this.cantidadVendida = cantidadVendida;
    }

    // Constructor usado en actualizarProducto
    public Producto(int id, String nombre, String precio, String descripcion, byte[] foto, int stock) {
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
        this.descripcion = descripcion;
        this.foto = foto;
        this.stock = stock;
        this.cantidadVendida = 0; // Valor por defecto
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getCantidadVendida() {
        return cantidadVendida;
    }

    public void setCantidadVendida(int cantidadVendida) {
        this.cantidadVendida = cantidadVendida;
    }
}
