<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Dashboard Administrador</title>

    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Bootstrap 4 CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />

    <!-- FontAwesome para iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

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
            position: fixed;
            height: 100vh;
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
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background-color: #084298;
        }
        .content {
            margin-left: 250px;
            padding: 2rem;
            width: 100%;
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
        <a href="AdminDashboard.jsp" class="nav-link active"><i class="fas fa-th-large mr-2"></i>Dashboard</a>
        <a href="UsuarioServlet?action=listar" class="nav-link"><i class="fas fa-users mr-2"></i>Usuarios</a>
        <a href="ProductoServlet?action=listar" class="nav-link"><i class="fas fa-box mr-2"></i>Productos</a>
        <a href="EmpleadoServlet?action=listar" class="nav-link"><i class="fas fa-user-tie mr-2"></i>Empleados</a>
        <a href="PeliculaServlet?action=listar" class="nav-link"><i class="fas fa-film mr-2"></i>Películas</a>
        <a href="Login.jsp" class="nav-link"><i class="fas fa-sign-out-alt mr-2"></i>Cerrar Sesión</a>
    </nav>
</nav>

<main class="content">
    <h2>Dashboard</h2>

    <div class="row text-center">
        <div class="col-md-3 mb-3">
            <div class="stats-card">
                <h5>Total Ventas</h5>
                <p id="total-ventas">S/ 0.00</p>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card">
                <h5>Total Productos</h5>
                <p id="total-productos">0</p>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card">
                <h5>Total Empleados</h5>
                <p id="total-empleados">0</p>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card">
                <h5>Películas en Inventario</h5>
                <p id="total-peliculas">0</p>
            </div>
        </div>
    </div>

    <div class="mt-5">
        <canvas id="ventasChart" height="120"></canvas>
    </div>
</main>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // Cargar estadísticas
    fetch('EstadisticasServlet')
        .then(res => res.json())
        .then(data => {
            document.getElementById('total-ventas').textContent = "S/ " + data.ventas.toFixed(2);
            document.getElementById('total-productos').textContent = data.productos;
            document.getElementById('total-empleados').textContent = data.empleados;
            document.getElementById('total-peliculas').textContent = data.peliculas;
        })
        .catch(err => console.error("Error estadísticas:", err));

    // Cargar datos para gráfico
    fetch('GraficoServlet')
        .then(res => res.json())
        .then(data => {
            const labels = data.map(d => d.metodo);
            const values = data.map(d => d.total);

            const ctx = document.getElementById('ventasChart').getContext('2d');
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Ventas por Método de Pago',
                        data: values,
                        borderColor: '#0d6efd',
                        backgroundColor: 'rgba(13,110,253,0.2)',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { position: 'top' },
                        title: {
                            display: true,
                            text: 'Distribución de Ventas por Método de Pago'
                        }
                    }
                }
            });
        })
        .catch(err => console.error("Error gráfico:", err));
</script>

</body>
</html>
