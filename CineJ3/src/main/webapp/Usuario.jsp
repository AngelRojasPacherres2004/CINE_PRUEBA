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
</head>
<body>
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
