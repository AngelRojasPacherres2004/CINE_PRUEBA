<%@page import="modelo.Reporte"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Reportes - CINEMAX</title>
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

            .sidebar .nav-link:hover,
            .sidebar .nav-link.active {
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

        <!-- Menú lateral -->
        <nav class="sidebar">
            <div class="sidebar-header">CINEMAX</div>
            <div class="profile">
                <img src="Cliente/images/User.png" alt="Administrador" />
                <h5>Administrador</h5>
                <small>Admin</small>
            </div>
            <nav class="nav flex-column">
                <a href="AdminDashboard.jsp" class="nav-link">Dashboard</a>
                <a href="UsuarioServlet?action=listar" class="nav-link">Usuarios</a>
                <a href="ProductoServlet?action=listar" class="nav-link">Productos</a>
                <a href="EmpleadoServlet?action=listar" class="nav-link">Empleados</a>
                <a href="PeliculaServlet?action=listar" class="nav-link">Películas</a>
                <a href="ReporteServlet?action=listar" class="nav-link active">Reportes</a>
                <a href="http://localhost:8080/CineJ3/ClienteServlet?action=listar" class="nav-link">Cerrar Sesión</a>
            </nav>
        </nav>

        <!-- Contenido principal -->
        <div class="content">
            <h3>Lista de Reportes</h3>

            <!-- Formulario de subida -->
            <form action="ReporteServlet" method="post" enctype="multipart/form-data" class="mb-4">
                <div class="form-row">
                    <div class="col-md-4">
                        <input type="text" name="nombre" class="form-control" placeholder="Nombre del reporte" required>
                    </div>
                    <div class="col-md-4">
                        <input type="file" name="archivo" class="form-control-file" required>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary">Subir Reporte</button>
                    </div>
                </div>
            </form>

            <!-- Tabla de reportes -->
            <table class="table table-bordered table-hover">
                <thead class="thead-dark text-center">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Tipo</th>
                        <th>Fecha</th>
                        <th>Descargar</th>
                    </tr>
                </thead>
                <tbody class="text-center">
                    <%
                        List<Reporte> listaReportes = (List<Reporte>) request.getAttribute("listaReportes");
                        if (listaReportes != null && !listaReportes.isEmpty()) {
                            for (Reporte r : listaReportes) {
                    %>
                    <tr>
                        <td><%= r.getId()%></td>
                        <td><%= r.getNombre_archivo()%></td>
                        <td><%= r.getTipo_archivo()%></td>
                        <td><%= r.getFecha_subida()%></td>
                        <td>
                            <a href="ReporteServlet?action=descargar&id=<%= r.getId()%>" class="btn btn-sm btn-success">Descargar</a>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="5">No hay reportes disponibles.</td></tr>
                    <% }%>
                </tbody>
            </table>
        </div>

    </body>
</html>
