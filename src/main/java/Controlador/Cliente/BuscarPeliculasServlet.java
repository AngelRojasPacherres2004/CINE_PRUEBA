/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador.Cliente;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Pelicula;
import modelo.PeliculaDao;

/**
 *
 * @author USER
 */
@WebServlet("/BuscarPeliculasServlet")
public class BuscarPeliculasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");
        PeliculaDao dao = new PeliculaDao();
        List<Pelicula> peliculas = dao.buscarPorNombre(query);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        out.print("[");

        for (int i = 0; i < peliculas.size(); i++) {
            Pelicula p = peliculas.get(i);
            String fotoBase64 = Base64.getEncoder().encodeToString(p.getFoto());

            out.print("{\"nombre\":\"" + p.getNombre() + "\", \"foto\":\"" + fotoBase64 + "\"}");

            if (i < peliculas.size() - 1) {
                out.print(",");
            }
        }

        out.print("]");
        out.flush();
    }
}
