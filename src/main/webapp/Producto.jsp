<%@page import="java.util.Base64"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Producto" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <title>Lista de Productos</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
                min-height: 100vh;
                display: flex;
                overflow-x: hidden;
                margin: 0;
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
                display: block;
                text-decoration: none;
            }
            .sidebar .nav-link:hover, .sidebar .nav-link.active {
                background-color: #084298;
                color: white;
            }
            .content {
                margin-left: 250px;
                padding: 2rem;
                width: calc(100% - 250px);
            }
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
            @media print {
                body * {
                    visibility: hidden;
                }
                #reportePDF, #reportePDF * {
                    visibility: visible;
                }
                #reportePDF {
                    position: absolute;
                    left: 0;
                    top: 0;
                    width: 100%;
                    padding: 20px;
                }
                canvas#graficoStock {
                    width: 300px !important;
                    height: 300px !important;
                    display: block;
                    margin: auto;
                }
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
            <h3 class="text-center">Lista de Productos</h3>
            <a href="ProductoServlet?action=nuevo" class="btn btn-primary mb-3">Agregar Producto</a>
            <a href="#" class="btn btn-danger mb-3 ml-2" onclick="generarReportePDF();">📄 Generar Reporte PDF</a>

            <%
                List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProductos");
                double totalVentas = 0;
                String productoTop = "";
                int maxVendidos = 0;
                StringBuilder stockLabels = new StringBuilder("[");
                StringBuilder stockData = new StringBuilder("[");
                if (listaProductos != null && !listaProductos.isEmpty()) {
                    for (Producto p : listaProductos) {
                        int vendidos = p.getCantidadVendida();
                        double precio = Double.parseDouble(p.getPrecio().replace("S/", "").replace(",", "").trim());
                        totalVentas += precio * vendidos;
                        if (vendidos > maxVendidos) {
                            maxVendidos = vendidos;
                            productoTop = p.getNombre();
                        }
                        stockLabels.append("\"").append(p.getNombre()).append("\",");
                        stockData.append(p.getStock()).append(",");
                    }
                    if (stockLabels.length() > 1) {
                        stockLabels.setLength(stockLabels.length() - 1);
                    }
                    if (stockData.length() > 1) {
                        stockData.setLength(stockData.length() - 1);
                    }
                    stockLabels.append("]");
                    stockData.append("]");
                }
            %>

            <!-- CRUD Tabla -->
            <table class="table table-striped table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Stock</th>
                        <th>Imagen</th> <!-- AGREGADO -->
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (listaProductos != null) {
                            for (Producto p : listaProductos) {
                                String base64Image = "";
                                if (p.getFoto() != null && p.getFoto().length > 0) {
                                    base64Image = Base64.getEncoder().encodeToString(p.getFoto());
                                }
                    %>
                    <tr>
                        <td><%= p.getId()%></td>
                        <td><%= p.getNombre()%></td>
                        <td>S/. <%= String.format("%.2f", Double.parseDouble(p.getPrecio().replace("S/", "").replace(",", "").trim()))%></td>
                        <td><%= p.getStock()%></td>
                        <td>
                            <% if (!base64Image.isEmpty()) {%>
                            <img src="data:image/png;base64,<%= base64Image%>" width="80" height="80" style="object-fit: cover;" />
                            <% } else { %>
                            <small>Sin imagen</small>
                            <% }%>
                        </td>
                        <td>
                            <a href="ProductoServlet?action=editar&id=<%= p.getId()%>" class="btn btn-warning btn-sm">Editar</a>
                            <a href="ProductoServlet?action=eliminar&id=<%= p.getId()%>" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de eliminar este producto?');">Eliminar</a>
                        </td>
                    </tr>
                    <% }
                        }%>
                </tbody>
            </table>

            <!-- Reporte PDF -->
            <div id="reportePDF" style="display: none;">
                <div class="text-center mb-4">
                    <h2>REPORTE DE PRODUCTOS - CINEMAX</h2>
                    <p>Fecha: <%= new java.util.Date()%></p>
                </div>
                <div class="row text-center mb-4">
                    <div class="col-md-4 stats-card">
                        <h5>Producto más vendido</h5>
                        <p>Cancha Grande</p>
                    </div>
                    <div class="col-md-4 stats-card">
                        <h5>Ventas totales</h5>
                        <p>S/. <%= String.format("%.2f", totalVentas)%></p>
                    </div>
                    <div class="col-md-4 stats-card">
                        <h5>Total de productos</h5>
                        <p><%= listaProductos != null ? listaProductos.size() : 0%></p>
                    </div>
                </div>
                <table class="table table-bordered">
                    <thead class="thead-dark">
                        <tr><th>ID</th><th>Nombre</th><th>Precio</th><th>Stock</th></tr>
                    </thead>
                    <tbody>
                        <% if (listaProductos != null) {
                                for (Producto p : listaProductos) {%>
                        <tr>
                            <td><%= p.getId()%></td>
                            <td><%= p.getNombre()%></td>
                            <td>S/. <%= String.format("%.2f", Double.parseDouble(p.getPrecio().replace("S/", "").replace(",", "").trim()))%></td>
                            <td><%= p.getStock()%></td>
                        </tr>
                        <% }
                            }%>
                    </tbody>
                </table>
                <h5 class="text-center mt-4">Distribución de Stock</h5>
                <canvas id="graficoStock" width="400" height="200"></canvas>
            </div>

            <script>
                function generarReportePDF() {
                    document.getElementById("reportePDF").style.display = 'block';
                    const ctx = document.getElementById("graficoStock").getContext("2d");
                    new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            labels: <%= stockLabels.toString()%>,
                            datasets: [{
                                    label: 'Stock',
                                    data: <%= stockData.toString()%>,
                                    backgroundColor: ['#0d6efd', '#198754', '#ffc107', '#dc3545', '#6f42c1', '#20c997'],
                                    borderColor: '#fff',
                                    borderWidth: 1
                                }]
                        },
                        options: {
                            responsive: true,
                            plugins: {legend: {position: 'right'}}
                        }
                    });
                    setTimeout(() => window.print(), 600);
                }
            </script>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </body>
</html>
