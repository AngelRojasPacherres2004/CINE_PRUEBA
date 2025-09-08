package Controlador;

import modelo.*;
import java.io.IOException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CarritoServlet")
public class CarritoServlet extends HttpServlet {

    private final ProductoDao productoDao = new ProductoDao();
    private final PeliculaDao peliculaDao = new PeliculaDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        // Obtener o inicializar el carrito de sesión
        List<ItemCarritoBase> carrito = (List<ItemCarritoBase>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
            session.setAttribute("carrito", carrito);
        }

        try {
            switch (action) {
                case "agregarProducto": {
                    int idProd = Integer.parseInt(request.getParameter("id"));
                    int cantidadProd = Integer.parseInt(request.getParameter("cantidad"));

                    Producto producto = productoDao.leer(idProd);
                    if (producto != null) {
                        carrito.add(new ItemCarrito(producto, cantidadProd));
                    }
                    break;
                }

                case "agregarPelicula": {
                    int idPeli = Integer.parseInt(request.getParameter("id"));
                    String asientosSeleccionados = request.getParameter("asientos"); // Ej: "A1,A2,B5"

                    Pelicula pelicula = peliculaDao.leer(idPeli);
                    if (pelicula != null) {
                        List<String> listaAsientos = new ArrayList<>();
                        if (asientosSeleccionados != null && !asientosSeleccionados.trim().isEmpty()) {
                            listaAsientos = Arrays.asList(asientosSeleccionados.split(","));
                        }

                        ItemCarritoPelicula itemPeli = new ItemCarritoPelicula(pelicula, listaAsientos.size());
                        itemPeli.setAsientos(listaAsientos);
                        carrito.add(itemPeli);
                    }
                    break;
                }

                default:
                    System.out.println("Acción no reconocida: " + action);
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("Cliente/Carrito.jsp");
    }
}
