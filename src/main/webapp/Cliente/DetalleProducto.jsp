<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Producto" %>
<%@ page import="modelo.ProductoDao" %>
<%@ page import="java.sql.SQLException" %>

<%
    String productoId = request.getParameter("id");
    int id = Integer.parseInt(productoId);
    ProductoDao productoDao = new ProductoDao();
    Producto producto = null;
    try {
        producto = productoDao.leer(id);
    } catch (SQLException e) {
        out.println("<h2>Error al recuperar el producto: " + e.getMessage() + "</h2>");
        return;
    }

    if (producto == null) {
        out.println("<h2>Producto no encontrado.</h2>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Detalle del Producto</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .product-details-container {
                margin-top: 100px;
                margin-bottom: 100px;
            }

            .product-details {
                padding: 30px;
                background-color: #fff;
                box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            }

            .product-details img {
                width: 100%;
                height: auto;
                box-shadow: 0 0 30px 5px rgba(200, 200, 200, 0.7);
            }

            .product-details h1 {
                margin-bottom: 20px;
            }

            .product-details .btn {
                margin-top: 20px;
            }

            .navbar {
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 10;
                background-color: #343a40;
                height: 80px;
                padding-top: 10px;
            }

            .navbar-brand, .nav-link {
                color: white !important;
            }

            .nav-link:hover {
                color: #FF5733 !important;
            }

            footer {
                background-color: #343a40;
                color: white;
                text-align: center;
                padding: 10px;
                position: relative;
                bottom: 0;
                width: 100%;
            }

            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            body {
                padding-top: 80px;
            }
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <%@ page session="true" %>
        <%
            String username = (String) session.getAttribute("username");
        %>
        <nav class="navbar navbar-expand-lg navbar-dark">
            <a class="navbar-brand" href="#">CINEMAX</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item active"><a class="nav-link" href="#">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Películas</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Dulcería</a></li>
                        <% if (username != null) {%>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="cuenta" data-toggle="dropdown">Hola, <%= username%></a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Mis Compras</a>
                            <a class="dropdown-item" href="#">Cerrar Sesión</a>
                        </div>
                    </li>
                    <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="#">Mi Cuenta</a></li>
                        <% }%>
                </ul>
            </div>
        </nav>

        <!-- Contenido principal -->
        <div class="container product-details-container">
            <div class="row">
                <!-- Texto -->
                <div class="col-md-6 product-details">
                    <h1><%= producto.getNombre()%></h1>
                    <h3>Descripción</h3>
                    <p><%= producto.getDescripcion()%></p>
                    <h4>Precio: S/ <%= producto.getPrecio()%></h4>
                    <a href="#" class="btn btn-primary">Agregar al carrito</a>
                </div>

                <!-- Imagen -->
                <div class="col-md-6 product-details d-flex align-items-center justify-content-center">
                    <img src="<%= request.getContextPath()%>/ImagenProducto?id=<%= producto.getId()%>" alt="<%= producto.getNombre()%>" class="img-fluid">
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer>
            <p>© 2025 Cine Online | Todos los derechos reservados</p>
        </footer>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
