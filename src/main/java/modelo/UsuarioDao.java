/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Conexion.Conexion;

public class UsuarioDao implements DaoCrud<Usuario> {

    @Override
    public List<Usuario> listar() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String query = "SELECT * FROM usuarios";
        
        try (Connection con = Conexion.getConnection();
             PreparedStatement pst = con.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {
            
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword(rs.getString("password"));
                usuario.setRol(rs.getString("rol"));
                usuarios.add(usuario);
            }
        }
        return usuarios;
    }

    @Override
    public void insertar(Usuario usuario) throws SQLException {
        String query = "INSERT INTO usuarios (username, password, rol) VALUES (?, ?, ?)";
        try (Connection con = Conexion.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            
            pst.setString(1, usuario.getUsername());
            pst.setString(2, usuario.getPassword());
            pst.setString(3, usuario.getRol());
            pst.executeUpdate();
        }
    }

    @Override
    public Usuario leer(int id) throws SQLException {
        String query = "SELECT * FROM usuarios WHERE id = ?";
        try (Connection con = Conexion.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            
            pst.setInt(1, id);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setUsername(rs.getString("username"));
                    usuario.setPassword(rs.getString("password"));
                    usuario.setRol(rs.getString("rol"));
                    return usuario;
                }
            }
        }
        return null;
    }

    @Override
    public void editar(Usuario usuario) throws SQLException {
        String query = "UPDATE usuarios SET username = ?, password = ?, rol = ? WHERE id = ?";
        try (Connection con = Conexion.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            
            pst.setString(1, usuario.getUsername());
            pst.setString(2, usuario.getPassword());
            pst.setString(3, usuario.getRol());
            pst.setInt(4, usuario.getId());
            pst.executeUpdate();
        }
    }

    @Override
    public void eliminar(int id) throws SQLException {
        String query = "DELETE FROM usuarios WHERE id = ?";
        try (Connection con = Conexion.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            
            pst.setInt(1, id);
            pst.executeUpdate();
        }
    }
    
   
      public boolean validateUser(String username, String password) throws SQLException {
        String query = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
        
        try (Connection con = Conexion.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {

            pst.setString(1, username);
            pst.setString(2, password);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next(); // Si encuentra al menos un usuario, la validación es exitosa
            }
        }
    }
      
      
      public String getRolByUsername(String username) throws SQLException {
    String query = "SELECT rol FROM usuarios WHERE username = ?";
    try (Connection con = Conexion.getConnection();
         PreparedStatement pst = con.prepareStatement(query)) {
        
        pst.setString(1, username);
        try (ResultSet rs = pst.executeQuery()) {
            if (rs.next()) {
                return rs.getString("rol"); // Devuelve el rol (admin o cliente)
            }
        }
    }
    return null; // Si no encuentra el usuario, devuelve null
}
   
}

    

