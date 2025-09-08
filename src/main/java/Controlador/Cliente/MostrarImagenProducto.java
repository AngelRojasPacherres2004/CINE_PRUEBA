package Controlador.Cliente;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import modelo.Producto;
import modelo.ProductoDao;

@WebServlet(name = "MostrarImagenProducto", urlPatterns = {"/ImagenProducto"})
public class MostrarImagenProducto extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            int id = Integer.parseInt(idParam);

            ProductoDao dao = new ProductoDao();
            Producto producto = dao.leer(id); // ya lo tienes en tu DAO

            if (producto != null && producto.getFoto() != null) {
                byte[] imagen = producto.getFoto();
                response.setContentType("image/jpeg");
                response.setContentLength(imagen.length);
                response.getOutputStream().write(imagen);
                response.getOutputStream().flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Imagen no encontrada.");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al acceder a la base de datos");
        }
    }
}

