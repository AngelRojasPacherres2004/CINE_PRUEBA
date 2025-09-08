/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Producto;
import modelo.ProductoDao;

/**
 *
 * @author USER
 */
@WebServlet(name = "CompraServlet", urlPatterns = {"/CompraServlet"})
public class CompraServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productoId = Integer.parseInt(request.getParameter("productoId"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        ProductoDao dao = new ProductoDao();

        try {
            Producto producto = dao.leer(productoId);

            if (producto != null && producto.getStock() >= cantidad) {
                int nuevoStock = producto.getStock() - cantidad;
                dao.actualizarStock(productoId, nuevoStock);

                // Opcional: podrías registrar aquí la venta si tienes tabla de ventas
                response.sendRedirect("Cliente/PaginaProductos.jsp?exito=1");
            } else {
                response.sendRedirect("Cliente/PaginaProductos.jsp?error=stock");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Cliente/PaginaProductos.jsp?error=bd");
        }
    }
}
