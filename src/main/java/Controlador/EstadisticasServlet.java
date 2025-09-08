/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
@WebServlet(name = "EstadisticasServlet", urlPatterns = {"/EstadisticasServlet"})
public class EstadisticasServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EstadisticasServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EstadisticasServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String totalVentasQuery = "SELECT SUM(total) AS totalVentas FROM ventas";
        String totalProductosQuery = "SELECT COUNT(id) AS totalProductos FROM productos";
        String totalEmpleadosQuery = "SELECT COUNT(id) AS totalEmpleados FROM empleados";
        String totalPeliculasQuery = "SELECT COUNT(id) AS totalPeliculas FROM peliculas";

        try (Connection conn = Conexion.getConnection()) {

            double totalVentas = getSingleDouble(conn, totalVentasQuery, "totalVentas");
            int totalProductos = getSingleInt(conn, totalProductosQuery, "totalProductos");
            int totalEmpleados = getSingleInt(conn, totalEmpleadosQuery, "totalEmpleados");
            int totalPeliculas = getSingleInt(conn, totalPeliculasQuery, "totalPeliculas");

            String json = "{"
                    + "\"ventas\":" + totalVentas + ","
                    + "\"productos\":" + totalProductos + ","
                    + "\"empleados\":" + totalEmpleados + ","
                    + "\"peliculas\":" + totalPeliculas
                    + "}";

            out.print(json);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            out.print("{\"error\":\"Error al obtener estadísticas\"}");
        }
    }

    private double getSingleDouble(Connection conn, String sql, String column) throws Exception {
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(column);
            }
        }
        return 0;
    }

    private int getSingleInt(Connection conn, String sql, String column) throws Exception {
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(column);
            }
        }
        return 0;
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
