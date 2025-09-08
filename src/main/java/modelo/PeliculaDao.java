/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Conexion.Conexion;

public class PeliculaDao implements DaoCrud<Pelicula> {

    @Override
    public List<Pelicula> listar() throws SQLException {
        List<Pelicula> peliculas = new ArrayList<>();
        String query = "SELECT * FROM peliculas";  // Consulta para listar todas las películas
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query); ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                Pelicula pelicula = new Pelicula();
                pelicula.setId(rs.getInt("id"));
                pelicula.setNombre(rs.getString("nombre"));
                pelicula.setSinopsis(rs.getString("sinopsis"));
                pelicula.setHorario(rs.getString("horario"));
                pelicula.setFoto(rs.getBytes("foto"));
                pelicula.setFecha(rs.getDate("fecha"));
                pelicula.setPrecio(rs.getDouble("precio"));

                peliculas.add(pelicula);
            }
        }
        return peliculas;
    }

    @Override
    public void insertar(Pelicula pelicula) throws SQLException {
        String query = "INSERT INTO peliculas (nombre, sinopsis, horario, foto, fecha, precio) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, pelicula.getNombre());
            pst.setString(2, pelicula.getSinopsis());
            pst.setString(3, pelicula.getHorario());
            pst.setBytes(4, pelicula.getFoto());
            pst.setDate(5, pelicula.getFecha());
            pst.setDouble(6, pelicula.getPrecio());
            pst.executeUpdate();  // Ejecuta la inserción en la base de datos
        }
    }

    @Override
    public Pelicula leer(int id) throws SQLException {
        String query = "SELECT * FROM peliculas WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
            pst.setInt(1, id);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    Pelicula pelicula = new Pelicula();
                    pelicula.setId(rs.getInt("id"));
                    pelicula.setNombre(rs.getString("nombre"));
                    pelicula.setSinopsis(rs.getString("sinopsis"));
                    pelicula.setHorario(rs.getString("horario"));
                    pelicula.setFoto(rs.getBytes("foto"));
                    pelicula.setFecha(rs.getDate("fecha"));
                    pelicula.setPrecio(rs.getDouble("precio"));

                    return pelicula;  // Devuelve la película con los datos obtenidos de la base de datos
                }
            }
        }
        return null;  // Si no se encuentra la película, retorna null
    }

    @Override
    public void editar(Pelicula pelicula) throws SQLException {
        String query = "UPDATE peliculas SET nombre = ?, sinopsis = ?, horario = ?, foto = ?, fecha = ?, precio = ? WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, pelicula.getNombre());
            pst.setString(2, pelicula.getSinopsis());
            pst.setString(3, pelicula.getHorario());
            pst.setBytes(4, pelicula.getFoto());
            pst.setDate(5, pelicula.getFecha());
            pst.setDouble(6, pelicula.getPrecio());
            pst.setInt(7, pelicula.getId());
            pst.executeUpdate();  // Ejecuta la actualización en la base de datos
        }
    }

    @Override
    public void eliminar(int id) throws SQLException {
        String query = "DELETE FROM peliculas WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
            pst.setInt(1, id);
            pst.executeUpdate();  // Ejecuta la eliminación de la película
        }
    }

    public void actualizar(Pelicula pelicula) throws SQLException {
        String query = "UPDATE  peliculas SET nombre = ?, sinopsis = ?, horario = ?, foto = ?  WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, pelicula.getNombre());
            pst.setString(2, pelicula.getSinopsis());
            pst.setString(3, pelicula.getHorario());
            pst.setBytes(4, pelicula.getFoto());
            pst.setInt(5, pelicula.getId());
            pst.executeUpdate();  // Ejecuta la actualización en la base de datos
        }
    }

    public List<Pelicula> filtrarPeliculas(String letra, String horario) throws SQLException {
        List<Pelicula> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM peliculas WHERE 1=1");

        List<Object> parametros = new ArrayList<>();

        if (letra != null && !letra.isEmpty()) {
            sql.append(" AND UPPER(SUBSTRING(nombre, 1, 1)) BETWEEN ? AND ?");
            switch (letra) {
                case "A-D":
                    parametros.add("A");
                    parametros.add("D");
                    break;
                case "E-H":
                    parametros.add("E");
                    parametros.add("H");
                    break;
                case "I-L":
                    parametros.add("I");
                    parametros.add("L");
                    break;
                case "M-P":
                    parametros.add("M");
                    parametros.add("P");
                    break;
                case "Q-T":
                    parametros.add("Q");
                    parametros.add("T");
                    break;
                case "U-Z":
                    parametros.add("U");
                    parametros.add("Z");
                    break;
            }
        }

        if (horario != null && !horario.isEmpty()) {
            sql.append(" AND horario LIKE ?");
            parametros.add("%" + horario + "%");
        }

        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < parametros.size(); i++) {
                pst.setObject(i + 1, parametros.get(i));
            }

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    Pelicula p = new Pelicula();
                    p.setId(rs.getInt("id"));
                    p.setNombre(rs.getString("nombre"));
                    p.setSinopsis(rs.getString("sinopsis"));
                    p.setHorario(rs.getString("horario"));
                    p.setFoto(rs.getBytes("foto"));
                    lista.add(p);
                }
            }
        }

        return lista;
    }

    public List<Pelicula> buscarPorNombre(String nombre) {
        List<Pelicula> lista = new ArrayList<>();
        String sql = "SELECT nombre, foto FROM pelicula WHERE nombre LIKE ?";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + nombre + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Pelicula p = new Pelicula();
                p.setNombre(rs.getString("nombre"));
                p.setFoto(rs.getBytes("foto")); // la columna debe ser tipo BLOB
                lista.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

}
