package Controlador;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import modelo.ItemCarritoBase;
import modelo.ItemCarrito;
import modelo.ItemCarritoPelicula;

@WebServlet(name = "EliminarDelCarritoServlet", urlPatterns = {"/EliminarDelCarritoServlet"})
public class EliminarDelCarritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String tipo = request.getParameter("tipo"); // "producto" o "pelicula"

        HttpSession session = request.getSession();
        List<ItemCarritoBase> carrito = (List<ItemCarritoBase>) session.getAttribute("carrito");

        if (carrito != null && tipo != null) {
            carrito.removeIf(item -> {
                if ("producto".equals(tipo) && item instanceof ItemCarrito) {
                    return ((ItemCarrito) item).getProducto().getId() == id;
                } else if ("pelicula".equals(tipo) && item instanceof ItemCarritoPelicula) {
                    return ((ItemCarritoPelicula) item).getPelicula().getId() == id;
                }
                return false;
            });
            session.setAttribute("carrito", carrito);
        }

        response.sendRedirect("Cliente/Carrito.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Elimina un ítem del carrito según su tipo (producto o película)";
    }
}
