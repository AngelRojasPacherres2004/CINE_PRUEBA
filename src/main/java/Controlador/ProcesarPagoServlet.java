package Controlador;

import Conexion.Conexion;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import modelo.*;

@WebServlet("/ProcesarPagoServlet")
public class ProcesarPagoServlet extends HttpServlet {

    private final VentaDao ventaDao = new VentaDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<ItemCarritoBase> carrito = (List<ItemCarritoBase>) session.getAttribute("carrito");

        // Recibe el método de pago desde el formulario (name="metodo")
        String metodoPago = request.getParameter("metodo");

        if (carrito == null || carrito.isEmpty()) {
            System.out.println("El carrito está vacío al procesar pago.");
            response.sendRedirect("Cliente/Carrito.jsp");
            return;
        }

        if (metodoPago == null || metodoPago.trim().isEmpty()) {
            metodoPago = "no especificado";
        }
        double totalVentas = 0;
        for (ItemCarritoBase item : carrito) {
            totalVentas += item.getPrecioUnitario() * item.getCantidad();
        }

        try {
            // 1. Insertar la venta principal
            Venta venta = new Venta();
            venta.setFecha(new java.sql.Date(System.currentTimeMillis())); // <- corrección importante
            venta.setMetodoPago(metodoPago);
            venta.setTotal(totalVentas); // 💡 aquí está la clave

            int ventaId = ventaDao.insertarVenta(venta);

            // 2. Insertar detalles de la venta
            for (ItemCarritoBase item : carrito) {
                DetalleVenta detalle = new DetalleVenta();
                detalle.setVentaId(ventaId);
                detalle.setCantidad(item.getCantidad());
                detalle.setPrecioUnitario(item.getPrecioUnitario());

                if (item instanceof ItemCarrito) {
                    detalle.setTipo("producto");
                    detalle.setProductoId(((ItemCarrito) item).getProducto().getId());
                    detalle.setPeliculaId(null);
                } else if (item instanceof ItemCarritoPelicula) {
                    detalle.setTipo("pelicula");
                    detalle.setPeliculaId(((ItemCarritoPelicula) item).getPelicula().getId());
                    detalle.setProductoId(null);
                }

                ventaDao.insertarDetalle(detalle);
            }

            // 3. Limpiar carrito y redirigir a agradecimiento
            session.setAttribute("detalleCompra", carrito);
            session.removeAttribute("carrito");

            response.sendRedirect("Cliente/PagoExitoso.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Error al procesar el pago", e);
        }
    }
}
