<%@page import="modelo.Producto"%>
<%@page import="java.util.List"%>
<%@page import="modelo.ProductoDao"%>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    ProductoDao productoDao = new ProductoDao();
    List<Producto> productos = productoDao.listar();
    double min = 0;
    double max = 999;
    try {
        if (request.getParameter("min") != null) {
            min = Double.parseDouble(request.getParameter("min"));
        }
        if (request.getParameter("max") != null) {
            max = Double.parseDouble(request.getParameter("max"));
        }
    } catch (Exception e) {
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dulcería</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@900&display=swap" rel="stylesheet">
        <style>
            body {
                padding-top: 90px;
                background-color: #f5f5f5;
            }
            .main-content {
                display: flex;
                flex-wrap: wrap;
                margin-top: 30px;
            }
            .filter-column {
                flex: 0 0 25%;
                max-width: 25%;
                padding: 20px;
                background-color: #f1f3f5;
                border-radius: 12px;
                height: fit-content;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                margin-right: 15px;
            }
            .filter-column h5 {
                font-family: 'Montserrat', sans-serif;
                font-weight: 700;
                margin-bottom: 20px;
                color: #343a40;
            }
            .products-column {
                flex: 1;
                max-width: 73%;
                padding-left: 10px;
            }
            .producto-card {
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                transition: transform 0.2s;
                overflow: hidden;
            }
            .producto-card:hover {
                transform: scale(1.02);
            }
            .producto-card img {
                width: 100%;
                height: 220px;
                object-fit: cover;
            }
            .producto-card .card-body {
                padding: 15px;
            }
            .producto-card .btn {
                border-radius: 20px;
            }
            .simple-filter input[type="number"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border-radius: 8px;
                border: 1px solid #ced4da;
            }
            .simple-filter button {
                font-weight: bold;
            }
            .navbar {
                position: absolute;
                top: 0;
                width: 100%;
                z-index: 1;
                background-color: #343a40;
                border-bottom: 1px solid white;
                height: 80px;
                padding-top: 10px;
            }
            .navbar-brand, .nav-link {
                color: white !important;
            }
            .navbar-nav {
                width: 100%;
                display: flex;
                justify-content: center;
            }
            .nav-item {
                margin: 0 15px;
                position: relative;
            }
            .nav-link:hover, .nav-link:active {
                color: #FF5733 !important;
            }
            .nav-item.active::after {
                content: '';
                position: absolute;
                width: 100%;
                height: 3px;
                background-color: #FF5733;
                bottom: 0;
                left: 0;
            }
            .titulo-productos {
                font-family: 'Montserrat', sans-serif;
                font-weight: 900;
                color: #adb5bd;
                font-size: 2.5rem;
                margin-bottom: 1.5rem;
            }
            @media (max-width: 992px) {
                .filter-column, .products-column {
                    flex: 0 0 100%;
                    max-width: 100%;
                    padding: 0 15px;
                }
                .filter-column {
                    margin-bottom: 30px;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark">
            <a class="navbar-brand" href="#">CINEMAX</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath()%>/Cliente/DashboardCliente.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath()%>/Cliente/PaginaPeliculas.jsp">Películas</a></li>
                    <li class="nav-item active"><a class="nav-link" href="<%= request.getContextPath()%>/Cliente/PaginaProductos.jsp">Dulcería</a></li>
                        <% if (username != null) {%>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown">
                            Hola, <%= username%>
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Mis Beneficios</a>
                            <a class="dropdown-item" href="#">Mis Compras</a>
                            <a class="dropdown-item" href="#">Mis Datos</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="http://localhost:8080/CineJ3/Login.jsp">Cerrar Sesión</a>
                        </div>
                    </li>
                    <% } else {%>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath()%>/Login.jsp">Mi Cuenta</a></li>
                        <% }%>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath()%>/Cliente/Carrito.jsp"><i class="bi bi-cart4"></i> Carrito</a></li>
                </ul>
            </div>
        </nav>

        <div class="container mt-5 pt-4 pb-5">
            <div class="main-content">
                <div class="filter-column">
                    <h5>Filtrar por precio</h5>
                    <form method="get">
                        <div class="simple-filter">
                            <label>Mínimo (S/)</label>
                            <input type="number" name="min" min="0" value="<%= request.getParameter("min") != null ? request.getParameter("min") : "0"%>">
                            <label>Máximo (S/)</label>
                            <input type="number" name="max" min="1" value="<%= request.getParameter("max") != null ? request.getParameter("max") : "999"%>">
                            <button type="submit" class="btn btn-primary btn-block mt-2">Aplicar</button>
                        </div>
                    </form>
                </div>
                <div class="products-column">
                    <h3 class="titulo-productos">Productos de la Dulcería</h3>
                    <div class="row">
                        <% for (Producto producto : productos) {
                                double precio = Double.parseDouble(producto.getPrecio());
                                if (precio >= min && precio <= max) {
                        %>
                        <div class="col-md-4 mb-4">
                            <div class="card producto-card">
                                <img src="<%= request.getContextPath()%>/ImagenProducto?id=<%= producto.getId()%>" alt="<%= producto.getNombre()%>">
                                <div class="card-body">
                                    <h5 class="card-title"><%= producto.getNombre()%></h5>
                                    <p class="card-text text-primary font-weight-bold">S/ <%= producto.getPrecio()%></p>
                                    <form action="<%= request.getContextPath()%>/CarritoServlet" method="post">
                                        <input type="hidden" name="action" value="agregarProducto">
                                        <input type="hidden" name="id" value="<%= producto.getId()%>">
                                        <input type="hidden" name="cantidad" value="1"> <%-- o un input editable --%>

                                        <button type="submit" class="btn btn-primary">Agregar al carrito</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <% }
                    }%>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
