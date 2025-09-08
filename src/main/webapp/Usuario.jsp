<%-- 
    Document   : Usuario
    Created on : 26 may. 2025, 17:21:56
    Author     : Proyecto
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.Usuario" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Usuarios</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <style>
        /* Barra lateral fija */
        body {
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
        }
        .sidebar {
            min-width: 250px;
            max-width: 250px;
            background-color: #0d6efd; /* azul bootstrap */
            color: white;
            min-height: 100vh;
            position: fixed;
            top: 0; left: 0;
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
        .sidebar .profile h5, .sidebar .profile small {
            margin: 0;
        }
        .sidebar .nav-link {
            color: white;
            padding: 1rem 1.5rem;
            font-weight: 500;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background-color: #084298; /* azul más oscuro */
            color: white;
        }

        /* Contenido principal */
        .content {
            margin-left: 250px;
            padding: 2rem;
            width: 100%;
        }

        /* Tarjetas resumen */
        .stats-card {
            border-radius: 0.5rem;
            padding: 1.5rem;
            background: #f8f9fa;
            box-shadow: 0 0 10px rgb(0 0 0 / 0.05);
            text-align: center;
        }
        .stats-card h5 {
            font-weight: 600;
        }
        .stats-card p {
            font-size: 1.2rem;
            font-weight: bold;
            margin: 0;
        }

        /* Gráfico simulado */
        #chart-placeholder {
            height: 300px;
            background: #ffe5e5;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-top: 2rem;
            color: #b30000;
            font-weight: bold;
            text-align: center;
            line-height: 300px;
            font-size: 1.25rem;
            user-select: none;
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
            <a href="AdminDashboard.jsp" class="nav-link active">
                <i class="fas fa-th-large mr-2"></i>Dashboard
            </a>
            <a href="UsuarioServlet?action=listar" class="nav-link">
                <i class="fas fa-users mr-2"></i>Usuarios
            </a>
            <a href="ProductoServlet?action=listar" class="nav-link">
                <i class="fas fa-box mr-2"></i>Productos
            </a>
            <a href="EmpleadoServlet?action=listar" class="nav-link">
                <i class="fas fa-user-tie mr-2"></i>Empleados
            </a>
            <a href="PeliculaServlet?action=listar" class="nav-link">
                <i class="fas fa-film mr-2"></i>Películas
            </a>
            <a href="http://localhost:8080/CineJ3/ClienteServlet?action=listar" class="nav-link">
                <i class="fas fa-sign-out-alt mr-2"></i>Cerrar Sesión
            </a>
        </nav>
    </nav>
<div class="container mt-5">
    <h3>Gestión de Usuarios</h3>
    
    <!-- Formulario para agregar nuevo usuario -->
    <form action="UsuarioServlet?action=insertar" method="post">
        <div class="form-group">
            <label for="username">Nombre de Usuario:</label>
            <input type="text" id="username" name="username" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="rol">Rol:</label>
            <select name="rol" id="rol" class="form-control">
                <option value="admin">Administrador</option>
                <option value="cliente">Cliente</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Agregar Usuario</button>
    </form>
    
    <!-- Mostrar lista de usuarios -->
    <h4 class="mt-4">Usuarios Registrados</h4>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre de Usuario</th>
                <th>Rol</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
                if (listaUsuarios != null && listaUsuarios.size() > 0) {
                    for (Usuario usuario : listaUsuarios) {
            %>
            <tr>
                <td><%= usuario.getId() %></td>
                <td><%= usuario.getUsername() %></td>
                <td><%= usuario.getRol() %></td>
                <td>
                    <a href="UsuarioServlet?action=editar&id=<%= usuario.getId() %>" class="btn btn-primary btn-sm">Editar</a>
                    <a href="UsuarioServlet?action=eliminar&id=<%= usuario.getId() %>" class="btn btn-danger btn-sm" 
                       onclick="return confirm('¿Está seguro de eliminar este usuario?');">Eliminar</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="4">No hay usuarios disponibles.</td>
            </tr>
            <% 
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html>