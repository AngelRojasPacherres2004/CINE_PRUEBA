package modelo;

import Conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

public class ReporteDao {

    private final Conexion conexion;

    public ReporteDao() {
        this.conexion = new Conexion();
    }

    // ✅ Insertar un nuevo reporte
    public boolean insertarReporte(Reporte reporte) {
        String sql = "INSERT INTO reporte (nombre_archivo, tipo_archivo, fecha_subida, datos) VALUES (?, ?, ?, ?)";
        try (Connection conn = conexion.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, reporte.getNombre_archivo());
            ps.setString(2, reporte.getTipo_archivo());
            ps.setDate(3, reporte.getFecha_subida());
            ps.setBytes(4, reporte.getDatos());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error al insertar reporte: " + e.getMessage());
            return false;
        }
    }

    // ✅ Listar todos los reportes
    public List<Reporte> listarReportes() {
        List<Reporte> lista = new ArrayList<>();
        String sql = "SELECT * FROM reporte ORDER BY id DESC"; // Mostrar los últimos primero

        try (Connection conn = conexion.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reporte r = new Reporte();
                r.setId(rs.getInt("id"));
                r.setNombre_archivo(rs.getString("nombre_archivo"));
                r.setTipo_archivo(rs.getString("tipo_archivo"));
                r.setFecha_subida(rs.getDate("fecha_subida"));
                r.setDatos(rs.getBytes("datos"));

                lista.add(r);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al listar reportes: " + e.getMessage());
        }

        return lista;
    }

    // ✅ Obtener un reporte por ID (para descargar)
    public Reporte obtenerReportePorId(int id) {
        String sql = "SELECT * FROM reporte WHERE id = ?";
        try (Connection conn = conexion.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Reporte r = new Reporte();
                    r.setId(rs.getInt("id"));
                    r.setNombre_archivo(rs.getString("nombre_archivo"));
                    r.setTipo_archivo(rs.getString("tipo_archivo"));
                    r.setFecha_subida(rs.getDate("fecha_subida"));
                    r.setDatos(rs.getBytes("datos"));
                    return r;
                }
            }

        } catch (SQLException e) {
            System.err.println("❌ Error al obtener reporte por ID: " + e.getMessage());
        }
        return null;
    }

    // ✅ Eliminar un reporte por ID (opcional)
    public boolean eliminarReporte(int id) {
        String sql = "DELETE FROM reporte WHERE id = ?";
        try (Connection conn = conexion.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error al eliminar reporte: " + e.getMessage());
            return false;
        }
    }
}
