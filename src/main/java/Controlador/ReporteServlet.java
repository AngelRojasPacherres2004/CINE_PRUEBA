package Controlador;


import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.Reporte;
import modelo.ReporteDao;

@WebServlet("/ReporteServlet")
@MultipartConfig
public class ReporteServlet extends HttpServlet {

    private final ReporteDao dao = new ReporteDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("listar".equals(action)) {
            List<Reporte> lista = dao.listarReportes();
            request.setAttribute("listaReportes", lista);
            request.getRequestDispatcher("Reporte.jsp").forward(request, response);

        } else if ("descargar".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Reporte r = dao.obtenerReportePorId(id);

            if (r != null) {
                response.setContentType(r.getTipo_archivo());
                response.setHeader("Content-Disposition", "attachment; filename=\"" + r.getNombre_archivo() + "\"");
                response.getOutputStream().write(r.getDatos());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String nombreManual = request.getParameter("nombre"); // Este lo das tú por input
            Part archivo = request.getPart("archivo");

            String nombreReal = archivo.getSubmittedFileName();
            String tipo = archivo.getContentType();
            InputStream input = archivo.getInputStream();
            byte[] datos = input.readAllBytes();

            Reporte r = new Reporte();
            r.setNombre_archivo(nombreManual != null ? nombreManual : nombreReal); // puedes elegir cuál mostrar
            r.setTipo_archivo(tipo);
            r.setFecha_subida(new Date(System.currentTimeMillis()));
            r.setDatos(datos);

            dao.insertarReporte(r);
            response.sendRedirect("ReporteServlet?action=listar");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al subir el reporte");
            request.getRequestDispatcher("Reporte.jsp").forward(request, response);
        }
    }
}
