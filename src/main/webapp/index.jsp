<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="modelo.Empleado" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lista de Empleados</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                min-height: 100vh;
                display: flex;
                overflow-x: hidden;
            }
            .sidebar {
                min-width: 250px;
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

            @media print {
                body * {
                    visibility: hidden;
                }
                #reporteDiv, #reporteDiv * {
                    visibility: visible;
                }
                #reporteDiv {
                    position: absolute;
                    left: 0;
                    top: 0;
                    width: 100%;
                    padding: 20px;
                }
            }

            .table th, .table td {
                vertical-align: middle !important;
                text-align: center;
            }

            .table-hover tbody tr:hover {
                background-color: #f1f1f1;
            }

            .btn-outline-primary:hover {
                background-color: #0d6efd;
                color: white;
            }

            .btn-outline-danger:hover {
                background-color: #dc3545;
                color: white;
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

        <div class="container-fluid mt-5" style="margin-left: 250px;">
            <h3>Empleados</h3>
            <a href="EmpleadoServlet?action=nuevo" class="btn btn-success mb-3">Agregar Empleado</a>
            <a href="#" class="btn btn-danger mb-3 ml-2" onclick="mostrarYGenerarGrafico();">
                <i class="fas fa-file-pdf"></i> Generar Reporte PDF
            </a>

            <%
                List<Empleado> lista = (List<Empleado>) request.getAttribute("listaEmpleados");

                double totalSueldos = 0.0;
                StringBuilder nombres = new StringBuilder("[");
                StringBuilder sueldos = new StringBuilder("[");

                if (lista != null && !lista.isEmpty()) {
            %>
            <table class="table table-hover shadow-sm rounded border">
                <thead style="background: linear-gradient(to right, #0d6efd, #0a58ca); color: white;">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                        <th>Cargo</th>
                        <th>Sueldo</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Empleado empleado : lista) {
                            String salarioStr = empleado.getSalario().replace("S/.", "").replace(",", "").trim();
                            double salario = 0.0;
                            try {
                                salario = Double.parseDouble(salarioStr);
                                totalSueldos += salario;
                            } catch (NumberFormatException e) {
                                salario = 0.0;
                            }

                            nombres.append("\"").append(empleado.getNombre()).append("\",");
                            sueldos.append(salario).append(",");
                    %>
                    <tr>
                        <td><%= empleado.getId()%></td>
                        <td><%= empleado.getNombre()%></td>
                        <td><%= empleado.getDireccion()%></td>
                        <td><%= empleado.getTelefono()%></td>
                        <td><%= empleado.getCargo()%></td>
                        <td><strong>S/. <%= String.format("%.2f", salario)%></strong></td>
                        <td>
                            <a href='EmpleadoServlet?action=editar&id=<%= empleado.getId()%>' class='btn btn-sm btn-outline-primary'>
                                ✏️ Editar
                            </a>
                            <a href='EmpleadoServlet?action=eliminar&id=<%= empleado.getId()%>' class='btn btn-sm btn-outline-danger' onclick='return confirm("¿Está seguro de eliminar este empleado?");'>
                                🗑️ Eliminar
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <%
                nombres.setLength(nombres.length() - 1);
                sueldos.setLength(sueldos.length() - 1);
                nombres.append("]");
                sueldos.append("]");
            } else {
            %>
            <p>No hay empleados disponibles.</p>
            <% }%>

            <!-- REPORTE -->
            <div id="reporteDiv" style="display:none;">
                <div class="text-center mb-4">
                    <h2>REPORTE DE SUELDOS - CINEMAX</h2>
                    <p>Fecha de generación: <%= new java.util.Date()%></p>
                </div>

                <table class="table table-bordered">
                    <thead class="thead-dark text-center">
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Cargo</th>
                            <th>Sueldo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Empleado empleado : lista) {%>
                        <tr class="text-center">
                            <td><%= empleado.getId()%></td>
                            <td><%= empleado.getNombre()%></td>
                            <td><%= empleado.getCargo()%></td>
                            <td><%= empleado.getSalario()%></td>
                        </tr>
                        <% }%>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="3" class="text-right">Total Sueldos:</th>
                            <th>S/. <%= String.format("%.2f", totalSueldos)%></th>
                        </tr>
                    </tfoot>
                </table>

                <div class="mt-5">
                    <h5 class="text-center">Gráfico de Sueldos</h5>
                    <canvas id="sueldoChart" width="400" height="200"></canvas>
                </div>
            </div>
        </div>

        <script>
            function mostrarYGenerarGrafico() {
                const reporteDiv = document.getElementById('reporteDiv');
                reporteDiv.style.display = 'block';

                const ctx = document.getElementById('sueldoChart').getContext('2d');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: <%= nombres.toString()%>,
                        datasets: [{
                                label: 'Sueldo (S/.)',
                                data: <%= sueldos.toString()%>,
                                backgroundColor: 'rgba(54, 162, 235, 0.7)',
                                borderColor: 'rgba(54, 162, 235, 1)',
                                borderWidth: 1
                            }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function (value) {
                                        return 'S/. ' + value;
                                    }
                                }
                            }
                        }
                    }
                });

                setTimeout(() => {
                    window.print();
                }, 500);
            }
        </script>

    </body>
</html>
