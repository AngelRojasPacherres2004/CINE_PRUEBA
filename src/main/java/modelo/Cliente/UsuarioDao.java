/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.Cliente;

/**
 *
 * @author Proyecto
 */
import java.sql.*;

public class UsuarioDao {
    private String jdbcURL = "jdbc:mysql://localhost:3306/empleados1";
    private String jdbcUsername = "root";   // ajusta si tienes otro usuario
    private String jdbcPassword = "";       // tu contraseña

    private static final String SQL_INSERT = "INSERT INTO usuario (username, password, rol) VALUES (?, ?, ?)";
    private static final String SQL_EXISTE = "SELECT id FROM usuario WHERE username = ?";
    private static final String SQL_GETROL = "SELECT rol FROM usuario WHERE username = ?";

    // Método para insertar un usuario nuevo
    public void insertar(Usuario usuario) throws SQLException {
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement(SQL_INSERT)) {
            stmt.setString(1, usuario.getUsername());
            stmt.setString(2, usuario.getPassword());
            stmt.setString(3, usuario.getRol());
            stmt.executeUpdate();
        }
    }

    // Verificar si existe usuario con ese username
    public boolean existeUsuario(String username) throws SQLException {
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement(SQL_EXISTE)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    // Obtener rol de un usuario por username
    public String getRolByUsername(String username) throws SQLException {
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement(SQL_GETROL)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("rol");
            }
            return null;
        }
    }
}