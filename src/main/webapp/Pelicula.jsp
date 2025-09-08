<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Pelicula" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Base64" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Lista de Películas</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <style>
            body {
                min-height: 100vh;
                display: flex;
                overflow-x: hidden;
            }
            .sidebar {
                min-width: 250px;
                max-width: 250px;
                background-color: #0d6efd;
                color: white;
                min-height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                padding-top: 1rem;
            }
            .sidebar .sidebar-header {
                text-align: center;
                font-weight: bold;
                font-size: 1.5rem;
                margin-bottom: 2rem;
            }
            .sidebar .profile {
                text-align: center;
                margin-bottom: 2rem;
            }
            .sidebar .profile img {
                width: 80px;
                border-radius: 50%;
                margin-bottom: 0.5rem;
            }
            .sidebar .nav-link {
                color: white;
                padding: 1rem 1.5rem;
                font-weight: 500;
            }
            .sidebar .nav-link:hover, .sidebar .nav-link.active {
                background-color: #084298;
                color: white;
            }
            .content {
                margin-left: 250px;
                padding: 2rem;
                width: 100%;
            }
        </style>
    </head>
    <body>

        <nav class="sidebar">
            <div class="sidebar-header">CINEMAX</div>
            <div class="profile">
                <img src="Cliente/images/User.png" alt="Administrador" />
                <h5>Administrador</h5>
                <small>Admin</small>
            </div>
            <nav class="nav flex-column">
                <a href="AdminDashboard.jsp" class="nav-link active">Dashboard</a>
                <a href="UsuarioServlet?action=listar" class="nav-link">Usuarios</a>
                <a href="ProductoServlet?action=listar" class="nav-link">Productos</a>
                <a href="EmpleadoServlet?action=listar" class="nav-link">Empleados</a>
                <a href="PeliculaServlet?action=listar" class="nav-link">Películas</a>
                <a href="http://localhost:8080/CineJ3/ClienteServlet?action=listar" class="nav-link">Cerrar Sesión</a>
            </nav>
        </nav>

        <div class="content">
            <h3>Lista de Películas</h3>
            <a href="PeliculaServlet?action=nuevo" class="btn btn-success mb-3">Agregar Película</a>

            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Sinopsis</th>
                        <th>Horario</th>
                        <th>Fecha</th>
                        <th>Precio</th>
                        <th>Foto</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Pelicula> listaPeliculas = (List<Pelicula>) request.getAttribute("listaPeliculas");
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        for (Pelicula pelicula : listaPeliculas) {
                    %>
                    <tr>
                        <td><%= pelicula.getId()%></td>
                        <td><%= pelicula.getNombre()%></td>
                        <td><%= pelicula.getSinopsis()%></td>
                        <td><%= pelicula.getHorario()%></td>
                        <td><%= pelicula.getFecha() != null ? sdf.format(pelicula.getFecha()) : ""%></td>
                        <td>S/. <%= String.format("%.2f", pelicula.getPrecio())%></td>
                        <td>
                            <%
                                byte[] foto = pelicula.getFoto();
                                if (foto != null) {
                                    String base64Image = Base64.getEncoder().encodeToString(foto);
                            %>
                            <img src="data:image/jpeg;base64,<%= base64Image%>" style="width: 60px; height: auto;" />
                            <% } else { %>
                            Sin foto
                            <% }%>
                        </td>
                        <td>
                            <a href="PeliculaServlet?action=editar&id=<%= pelicula.getId()%>" class="btn btn-primary btn-sm">Editar</a>
                            <a href="PeliculaServlet?action=eliminar&id=<%= pelicula.getId()%>" class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Está seguro de eliminar esta película?');">Eliminar</a>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>

    </body>
</html>
