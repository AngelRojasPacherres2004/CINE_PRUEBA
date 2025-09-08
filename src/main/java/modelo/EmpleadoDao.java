package modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Conexion.Conexion;

public class EmpleadoDao implements DaoCrud<Empleado> {

    @Override
    public List<Empleado> listar() throws SQLException {
        List<Empleado> empleados = new ArrayList<>();
        String query = "SELECT * FROM empleados";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query); ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                Empleado empleado = new Empleado();
                empleado.setId(rs.getInt("id"));
                empleado.setNombre(rs.getString("nombre"));
                empleado.setDireccion(rs.getString("direccion"));
                empleado.setTelefono(rs.getString("telefono"));
                empleado.setCargo(rs.getString("cargo"));
                empleado.setSalario(rs.getString("salario"));
                empleados.add(empleado);
            }
        }
        return empleados;
    }

    @Override
    public void insertar(Empleado emp) throws SQLException {
        String query = "INSERT INTO empleados (nombre, direccion, telefono, cargo, salario) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {

            pst.setString(1, emp.getNombre());
            pst.setString(2, emp.getDireccion());
            pst.setString(3, emp.getTelefono());
            pst.setString(4, emp.getCargo());
            pst.setString(5, emp.getSalario());
            pst.executeUpdate();
        }
    }

    @Override
    public Empleado leer(int id) throws SQLException {
        String query = "SELECT * FROM empleados WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {

            pst.setInt(1, id);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    Empleado empleado = new Empleado();
                    empleado.setId(rs.getInt("id"));
                    empleado.setNombre(rs.getString("nombre"));
                    empleado.setDireccion(rs.getString("direccion"));
                    empleado.setTelefono(rs.getString("telefono"));
                    empleado.setCargo(rs.getString("cargo"));
                    empleado.setSalario(rs.getString("salario"));
                    return empleado;
                }
            }
        }
        return null;
    }

    @Override
    public void editar(Empleado emp) throws SQLException {
        String query = "UPDATE empleados SET nombre = ?, direccion = ?, telefono = ?, cargo = ?, salario = ? WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {

            pst.setString(1, emp.getNombre());
            pst.setString(2, emp.getDireccion());
            pst.setString(3, emp.getTelefono());
            pst.setString(4, emp.getCargo());
            pst.setString(5, emp.getSalario());
            pst.setInt(6, emp.getId());
            pst.executeUpdate();
        }
    }

    @Override
    public void eliminar(int id) throws SQLException {
        String query = "DELETE FROM empleados WHERE id = ?";
        try (Connection con = Conexion.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {

            pst.setInt(1, id);
            pst.executeUpdate();
        }
    }
}
