package modelo;

import Conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import modelo.DetalleVenta;
import modelo.Venta;

public class VentaDao {

    public int insertarVenta(Venta venta) throws SQLException {
        String sql = "INSERT INTO ventas (fecha, metodo_pago, total) VALUES (?, ?, ?)";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pst.setDate(1, new java.sql.Date(venta.getFecha().getTime()));
            pst.setString(2, venta.getMetodoPago());
            pst.setDouble(3, venta.getTotal());

            pst.executeUpdate();

            ResultSet rs = pst.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // retorna el ID generado
            }
        }
        return -1;
    }

    public void insertarDetalle(DetalleVenta detalle) throws SQLException {
        String sql = "INSERT INTO detalle_venta (venta_id, tipo, producto_id, pelicula_id, cantidad, precio_unitario) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, detalle.getVentaId());
            pst.setString(2, detalle.getTipo());

            if (detalle.getProductoId() != null) {
                pst.setInt(3, detalle.getProductoId());
            } else {
                pst.setNull(3, java.sql.Types.INTEGER);
            }

            if (detalle.getPeliculaId() != null) {
                pst.setInt(4, detalle.getPeliculaId());
            } else {
                pst.setNull(4, java.sql.Types.INTEGER);
            }

            pst.setInt(5, detalle.getCantidad());
            pst.setDouble(6, detalle.getPrecioUnitario());

            pst.executeUpdate();
        }
    }
}
