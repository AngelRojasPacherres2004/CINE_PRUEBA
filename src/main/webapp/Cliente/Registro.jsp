<%-- 
    Document   : Registro
    Created on : 31 may. 2025, 14:41:30
    Author     : Proyecto
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Registro de Usuario - CINEMAX</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            background: #8B0000; /* rojo oscuro */
            background-image: url('Cliente/images/cine-background.jpg'); /* o video si quieres */
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .registro-form {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 8px;
            width: 350px;
            box-shadow: 0 0 15px rgba(0,0,0,0.4);
        }
        .registro-form h3 {
            text-align: center;
            margin-bottom: 25px;
            color: #8B0000;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="registro-form">
        <h3>Registro CINEMAX</h3>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="ClienteServlet?action=registrar" method="POST">
            <div class="form-group">
                <label for="username">Usuario</label>
                <input type="text" name="username" id="username" class="form-control" required autofocus/>
            </div>
            <div class="form-group">
                <label for="password">Contraseña</label>
                <input type="password" name="password" id="password" class="form-control" required/>
            </div>
            <button type="submit" class="btn btn-danger btn-block font-weight-bold">Unirme</button>
        </form>

        <div class="mt-3 text-center">
            <a href="Login.jsp" style="color:#8B0000;">¿Ya tienes cuenta? Inicia sesión</a>
        </div>
    </div>
</body>
</html>