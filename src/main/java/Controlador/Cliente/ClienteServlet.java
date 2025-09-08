package Controlador.Cliente;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import modelo.Pelicula;
import modelo.PeliculaDao;
import modelo.Cliente.Asiento;
import modelo.Cliente.UsuarioDao;
import modelo.Cliente.Usuario;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/ClienteServlet")
public class ClienteServlet extends HttpServlet {

    private PeliculaDao peliculaDao;

    @Override
    public void init() {
        peliculaDao = new PeliculaDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("listar".equals(action)) {
            listarPeliculas(request, response);
        } else if ("reservar".equals(action)) {
            mostrarSeleccionAsiento(request, response);
        } else if ("confirmarPago".equals(action)) {
            mostrarVoucher(request, response);
        } else if ("cerrarSesion".equals(action)) {
            cerrarSesion(request, response);
        } 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("registrar".equals(action)) {
            registrarUsuario(request, response);
        } else if ("seleccionarCombo".equals(action)) {
            seleccionarCombo(request, response);
        } else if ("confirmarAsiento".equals(action)) {
            procesarSeleccionAsiento(request, response);
        } else if ("procesarPago".equals(action)) {
            procesarPago(request, response);
        }
    }

    private void listarPeliculas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Pelicula> peliculas = peliculaDao.listar();
            request.setAttribute("peliculas", peliculas);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Cliente/DashboardCliente.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void mostrarSeleccionAsiento(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idPelicula = Integer.parseInt(request.getParameter("id"));
            Pelicula pelicula = peliculaDao.leer(idPelicula);
            request.setAttribute("pelicula", pelicula);

            List<Asiento> asientos = new ArrayList<>();
            for (int i = 1; i <= 30; i++) {
                asientos.add(new Asiento(i, true));
            }
            request.setAttribute("asientos", asientos);
            request.setAttribute("idPelicula", idPelicula);

            RequestDispatcher dispatcher = request.getRequestDispatcher("Cliente/SeleccionAsiento.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void registrarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rol = "cliente";

        UsuarioDao usuarioDao = new UsuarioDao();

        try {
            if (usuarioDao.existeUsuario(username)) {
                request.setAttribute("error", "El usuario ya existe");
                RequestDispatcher dispatcher = request.getRequestDispatcher("Cliente/Registro.jsp");
                dispatcher.forward(request, response);
            } else {
                usuarioDao.insertar(new Usuario(username, password, rol));

                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("rol", rol);

                response.sendRedirect("ClienteServlet?action=listar");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void procesarSeleccionAsiento(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idPelicula = request.getParameter("idPelicula");
        String asientoSeleccionado = request.getParameter("asientoSeleccionado");

        HttpSession session = request.getSession();
        session.setAttribute("idPelicula", idPelicula);
        session.setAttribute("asientoSeleccionado", asientoSeleccionado);

        request.setAttribute("idPelicula", idPelicula);
        request.setAttribute("asientoSeleccionado", asientoSeleccionado);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Cliente/MetodoPago.jsp");
        dispatcher.forward(request, response);
    }

    private void seleccionarCombo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String selectedSeats = request.getParameter("selectedSeats");
        request.getSession().setAttribute("selectedSeats", selectedSeats);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Cliente/SeleccionarCombo.jsp");
        dispatcher.forward(request, response);
    }

    private void cerrarSesion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("ClienteServlet?action=listar");
    }

    protected void procesarPago(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");

        System.out.println("Procesando pago con tarjeta: " + cardNumber);
        response.sendRedirect(request.getContextPath() + "/Cliente/Confirmacion.jsp");
    }

    private void mostrarVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("Cliente/Voucher.jsp");
        dispatcher.forward(request, response);
    }

    private void generarVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String asientoSeleccionado = request.getParameter("asiento");
        String comboSeleccionado = request.getParameter("combo");
        String metodoPago = request.getParameter("metodoPago");

        double precioAsiento = 10.00;
        double precioCombo = 15.00;
        double total = precioAsiento + precioCombo;

        request.setAttribute("asiento", asientoSeleccionado);
        request.setAttribute("combo", comboSeleccionado);
        request.setAttribute("metodoPago", metodoPago);
        request.setAttribute("total", total);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Cliente/Voucher.jsp");
        dispatcher.forward(request, response);
    }

    
}
