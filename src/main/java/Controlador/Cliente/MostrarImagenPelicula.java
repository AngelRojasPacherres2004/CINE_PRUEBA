package Controlador.Cliente;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import modelo.Pelicula;
import modelo.PeliculaDao;

@WebServlet(name = "MostrarImagenPelicula", urlPatterns = {"/Imagen"})
public class MostrarImagenPelicula extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            System.out.println("🟡 Parámetro recibido (id): " + idParam);

            int id = Integer.parseInt(idParam);

            PeliculaDao dao = new PeliculaDao();
            Pelicula pelicula = dao.leer(id);

            if (pelicula != null) {
                System.out.println("🟢 Película encontrada: " + pelicula.getNombre());

                byte[] imagen = pelicula.getFoto();
                if (imagen != null && imagen.length > 0) {
                    System.out.println("🟢 Imagen encontrada. Tamaño en bytes: " + imagen.length);

                    response.setContentType("image/jpeg"); // Ajusta según tu tipo real
                    response.setContentLength(imagen.length);
                    response.getOutputStream().write(imagen);
                    response.getOutputStream().flush();
                } else {
                    System.out.println("🔴 La imagen está vacía o es null.");
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Imagen no encontrada.");
                }
            } else {
                System.out.println("🔴 Película no encontrada con ID: " + id);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Película no encontrada.");
            }

        } catch (NumberFormatException e) {
            System.out.println("🔴 ID inválido: " + request.getParameter("id"));
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido.");
        } catch (SQLException e) {
            System.out.println("🔴 Error SQL: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error al acceder a la base de datos", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Muestra una imagen de una película desde la base de datos";
    }
}
