package modelo.Cliente;

public class Pelicula {
    private int id;
    private String nombre;
    private String sinopsis;
    private String horario;
    private byte[] foto;

    public Pelicula() {}

    // Getters
    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getSinopsis() {
        return sinopsis;
    }

    public String getHorario() {
        return horario;
    }

    public byte[] getFoto() {
        return foto;
    }

    // Setters (opcional pero recomendado)
    public void setId(int id) {
        this.id = id;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setSinopsis(String sinopsis) {
        this.sinopsis = sinopsis;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }
}
