package modelo;

import java.sql.Date;

/**
 *
 * @author USER
 */
public class Reporte {
    private int id;
    private String nombre_archivo;
    private String tipo_archivo;
    private Date fecha_subida;
    private byte[] datos;

    // Constructor vacío
    public Reporte() {
    }

    // Constructor parametrizado
    public Reporte(int id, String nombre_archivo, String tipo_archivo, Date fecha_subida, byte[] datos) {
        this.id = id;
        this.nombre_archivo = nombre_archivo;
        this.tipo_archivo = tipo_archivo;
        this.fecha_subida = fecha_subida;
        this.datos = datos;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre_archivo() {
        return nombre_archivo;
    }

    public void setNombre_archivo(String nombre_archivo) {
        this.nombre_archivo = nombre_archivo;
    }

    public String getTipo_archivo() {
        return tipo_archivo;
    }

    public void setTipo_archivo(String tipo_archivo) {
        this.tipo_archivo = tipo_archivo;
    }

    public Date getFecha_subida() {
        return fecha_subida;
    }

    public void setFecha_subida(Date fecha_subida) {
        this.fecha_subida = fecha_subida;
    }

    public byte[] getDatos() {
        return datos;
    }

    public void setDatos(byte[] datos) {
        this.datos = datos;
    }
}
