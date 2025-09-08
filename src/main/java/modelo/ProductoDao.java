package modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Conexion.Conexion;

public class ProductoDao implements DaoCrud<Producto> {

    // Listar productos
    @Override
    public List<Producto> listar() throws SQLException {
        List<Producto> lista = new ArrayList<>();
        Connection conn = Conexion.getConnection();
        String sql = "SELECT * FROM productos";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Producto p = new Producto();
            p.setId(rs.getInt("id"));
            p.setNombre(rs.getString("nombre"));
            p.setPrecio(rs.getString("precio"));
            p.setDescripcion(rs.getString("descripcion"));
            p.setFoto(rs.getBytes("foto"));
            p.setStock(rs.getInt("stock")); // Nuevo campo
            lista.add(p);
        }
        rs.close();
        stmt.close();
        conn.close();
        return lista;
    }

    // Insertar un producto
    @Override
    public void insertar(Producto producto) throws SQLException {
        String query = "INSERT INTO productos (nombre, precio, descripcion, foto, stock) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, producto.getNombre());
            pst.setString(2, producto.getPrecio());
            pst.setString(3, producto.getDescripcion());
            pst.setBytes(4, producto.getFoto());
            pst.setInt(5, producto.getStock()); // Nuevo campo
            pst.executeUpdate();
        }
    }

    // Leer un producto por su ID
    @Override
    public Producto leer(int id) throws SQLException {
        String query = "SELECT * FROM productos WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
            pst.setInt(1, id);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setPrecio(rs.getString("precio"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setFoto(rs.getBytes("foto"));
                    producto.setStock(rs.getInt("stock")); // Nuevo campo
                    return producto;
                }
            }
        }
        return null;
    }

    // Actualizar un producto
    @Override
    public void editar(Producto producto) throws SQLException {
        String query = "UPDATE productos SET nombre = ?, precio = ?, descripcion = ?, foto = ?, stock = ? WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, producto.getNombre());
            pst.setString(2, producto.getPrecio());
            pst.setString(3, producto.getDescripcion());
            pst.setBytes(4, producto.getFoto());
            pst.setInt(5, producto.getStock()); // Nuevo campo
            pst.setInt(6, producto.getId());
            pst.executeUpdate();
        }
    }

    // Eliminar un producto
    @Override
    public void eliminar(int id) throws SQLException {
        String query = "DELETE FROM productos WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
            pst.setInt(1, id);
            pst.executeUpdate();
        }
    }

    // Método adicional (actualizar, puede ser redundante con editar)
    public void actualizar(Producto producto) throws SQLException {
        String query = "UPDATE productos SET nombre = ?, precio = ?, descripcion = ?, foto = ?, stock = ? WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, producto.getNombre());
            pst.setString(2, producto.getPrecio());
            pst.setString(3, producto.getDescripcion());
            pst.setBytes(4, producto.getFoto());
            pst.setInt(5, producto.getStock()); // Nuevo campo
            pst.setInt(6, producto.getId());
            pst.executeUpdate();
        }
    }

    //Metodo actualizar stock
    public void actualizarStock(int idProducto, int nuevoStock) throws SQLException {
        String sql = "UPDATE productos SET stock = ? WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, nuevoStock);
            pst.setInt(2, idProducto);
            pst.executeUpdate();
        }
    }

    //Metodo para calcular total de ventas de cada producto:
    public List<Producto> listarConVentas() throws SQLException {
        List<Producto> lista = new ArrayList<>();
        Connection conn = Conexion.getConnection();

        String sql = 
    "SELECT p.*, " +
    "       COALESCE(SUM(dv.cantidad), 0) AS cantidad_vendida " +
    "FROM productos p " +
    "LEFT JOIN detalle_venta dv ON p.id = dv.id_producto " +
    "GROUP BY p.id, p.nombre, p.precio, p.descripcion, p.foto, p.stock";

        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Producto p = new Producto();
            p.setId(rs.getInt("id"));
            p.setNombre(rs.getString("nombre"));
            p.setPrecio(rs.getString("precio"));
            p.setDescripcion(rs.getString("descripcion"));
            p.setFoto(rs.getBytes("foto"));
            p.setStock(rs.getInt("stock"));
            p.setCantidadVendida(rs.getInt("cantidad_vendida")); // 👈 Nuevo dato
            lista.add(p);
        }

        rs.close();
        stmt.close();
        conn.close();
        return lista;
    }

}
