<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Pelicula" %>
<%@ page import="modelo.PeliculaDao" %>
<%@ page import="java.sql.SQLException" %>

<%
    String peliculaId = request.getParameter("id");
    int id = Integer.parseInt(peliculaId);
    PeliculaDao peliculaDao = new PeliculaDao();
    Pelicula pelicula = null;
    try {
        pelicula = peliculaDao.leer(id);
    } catch (SQLException e) {
        out.println("<h2>Error al recuperar la película: " + e.getMessage() + "</h2>");
        return;
    }

    if (pelicula == null) {
        out.println("<h2>Película no encontrada.</h2>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Detalle de la Película</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .movie-video {
                width: 100%;
                height: 60vh; /* 60% del viewport height */
                min-height: 400px; /* Altura mínima para dispositivos pequeños */
                position: relative;
                margin-top: 80px; /* Para que no quede detrás de la navbar */
                margin-bottom: 30px;
                background-color: #000; /* Fondo negro para mientras carga */
            }

            .movie-video iframe {
                width: 100%;
                height: 100%;
                border: none;
                display: block;
            }



            /* Contenedor debajo del video (para detalles) */
            .movie-details-container {
                position: relative;
                z-index: 2;
                padding-top: 20px; /* Espaciado para no solaparse con el video */
            }

            /* Detalles de la película */
            .movie-details {
                padding: 30px;
                background-color: #fff;
                box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
                margin-top: 80px; /* Empuja los detalles hacia abajo, para no solaparse con el navbar */
            }


            /* Imagen de la película */
            .movie-details img {
                width: 100%; /* Ajusta el valor según el tamaño deseado */
                height: auto; /* Mantiene la proporción de la imagen */

            }



            .movie-details h3 {
                margin-bottom: 20px;
            }

            /* Estilos para los botones en el navbar */

            button.btn {
                margin: 5px; /* Espaciado entre botones */
            }


            /* Cabecera */
            .navbar {
                position: absolute;
                top: 0;
                width: 100%;
                z-index: 1;
                background-color: #343a40; /* gris oscuro Bootstrap */
                ;
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

            .nav-link:hover {
                color: #FF5733 !important;
            }

            .nav-link:active {
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


            /* Pie de página pegado hacia abajo */
            footer {
                background-color: #343a40;
                color: white;
                text-align: center;
                padding: 10px;
                position: relative;
                bottom: 0;
                width: 100%;
            }

            /* Asegura que el pie de página se quede pegado al fondo */
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            /* Cuerpo de la página */
            body {
                padding-top: 0px; /* Altura de la navbar */
            }



            /* Espacio entre el contenedor de detalles de la película y el pie de página */
            .movie-details-container {
                margin-bottom: 100px; /* Ajusta el valor a tu preferencia */
            }

            /* Estilos para el overlay de búsqueda */
            .search-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.95);
                z-index: 9999;
                display: none;
                color: white;
            }

            .search-container {
                padding: 20px;
                max-width: 800px;
                margin: 0 auto;
                padding-top: 80px;
            }

            .search-header {
                margin-bottom: 30px;
            }

            .back-button {
                background: none;
                border: none;
                color: white;
                font-size: 1.2rem;
                cursor: pointer;
                padding: 10px 0;
            }

            .back-button i {
                margin-right: 10px;
            }

            .search-content {
                text-align: center;
            }

            .search-input-container {
                position: relative;
                margin-bottom: 30px;
            }

            .search-icon {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 1.5rem;
                color: #aaa;
            }

            .search-input {
                width: 100%;
                padding: 15px 20px 15px 50px;
                font-size: 1.2rem;
                border: none;
                border-bottom: 2px solid #FF5733;
                background-color: transparent;
                color: white;
                outline: none;
            }

            .search-input::placeholder {
                color: #aaa;
            }

            .search-description {
                color: #aaa;
                font-size: 1rem;
                max-width: 500px;
                margin: 0 auto;
            }

            /* Estilos para el icono de búsqueda en el navbar */
            .search-trigger {
                font-size: 1.2rem;
                color: white !important;
                padding: 8px 12px !important;
            }

            .search-trigger:hover {
                color: #FF5733 !important;
            }

        </style>
    </head>
    <body>

        <!-- Video -->
        <div class="movie-video">
            <iframe src="https://www.youtube.com/embed/HeTE7j9dcGg" frameborder="0"
                    allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen></iframe>
        </div>

        <!-- Detalles -->
        <div class="container movie-details-container">
            <div class="row">
                <div class="col-md-6 movie-details">
                    <h1><%= pelicula.getNombre()%></h1>
                    <h3>Sinopsis</h3>
                    <p><%= pelicula.getSinopsis()%></p>
                    <h3>Horarios</h3>
                    <%
                        if (pelicula.getHorario() != null && !pelicula.getHorario().isEmpty()) {
                            String[] horarios = pelicula.getHorario().split(",");
                            for (String hora : horarios) {
                    %>
                    <button class="btn btn-primary"><%= hora.trim()%></button>
                    <%
                        }
                    } else {
                    %>
                    <p>No hay horarios disponibles.</p>
                    <%
                        }
                    %>
                    <a href="<%= request.getContextPath()%>/ClienteServlet?action=reservar&id=<%= pelicula.getId()%>" class="btn btn-dark mt-3">Reservar</a>
                </div>

                <!-- Imagen -->
                <div class="col-md-6 movie-details d-flex align-items-center justify-content-center">
                    <img src="<%= request.getContextPath()%>/StreamingImagen?id=<%= pelicula.getId()%>" 
                         class="img-fluid" 
                         alt="<%= pelicula.getNombre()%>" 
                         style="max-width: 90%; height: auto; box-shadow: 0 0 30px 5px rgba(200, 200, 200, 0.7);">
                </div>
            </div>
        </div>

        <!-- Funcion para buscador navbar -->
        <%@ page session="true" %>
        <%
            String username = (String) session.getAttribute("username");
        %>

        <!-- Barra de navegación -->
        <nav class="navbar navbar-expand-lg navbar-dark">
            <a class="navbar-brand" href="#">CINEMAX</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" 
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item active"><a class="nav-link" href="<%= request.getContextPath()%>/Cliente/DashboardCliente.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath()%>/Cliente/PaginaPeliculas.jsp">Películas</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath()%>/Cliente/CompraDulceria.jsp">Dulcería</a></li>
                        <% if (username != null) {%>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="miCuentaDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Hola, <%= username%>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="miCuentaDropdown">
                            <a class="dropdown-item" href="#">Mis Beneficios</a>
                            <a class="dropdown-item" href="#">Mis Compras</a>
                            <a class="dropdown-item" href="#">Mis Datos</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="http://localhost:8080/CineJ3/Views/Admin/Login.jsp">Cerrar Sesión</a>
                        </div>
                    </li>
                    <% } else {%>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath()%>/Admin/Login.jsp">Mi Cuenta</a></li>
                        <% }%>
                </ul>

                <!-- Icono de búsqueda -->
                <div class="ml-auto">
                    <a href="#" class="nav-link search-trigger" id="searchTrigger">
                        <i class="bi bi-search"></i>
                    </a>
                </div>
            </div>
        </nav>

        <!-- Overlay de búsqueda full screen -->
        <div class="search-overlay" id="searchOverlay">
            <div class="search-container">
                <div class="search-header">
                    <button class="back-button" id="backButton">
                        <i class="bi bi-arrow-left"></i> Atrás
                    </button>
                </div>
                <div class="search-content">
                    <div class="search-input-container">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" class="search-input" placeholder="Buscador..." autofocus>
                    </div>
                    <div class="search-description">
                        <p>Encuentra las mejores películas, actores, salas, formatos (3D, Xtreme, Prime) y todo sobre el planeta del cine.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer>
            <p>© 2025 Cine Online | Todos los derechos reservados</p>
            <p><a href="#" class="text-white">Política de Privacidad</a> | <a href="#" class="text-white">Términos y Condiciones</a></p>
        </footer>

        <!-- Scripts -->
        <script>
            // Mostrar/ocultar el buscador full screen
            document.getElementById('searchTrigger').addEventListener('click', function (e) {
                e.preventDefault();
                document.getElementById('searchOverlay').style.display = 'block';
                document.querySelector('.search-input').focus();
            });

            document.getElementById('backButton').addEventListener('click', function (e) {
                e.preventDefault();
                document.getElementById('searchOverlay').style.display = 'none';
            });

            // Cerrar al presionar ESC
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    document.getElementById('searchOverlay').style.display = 'none';
                }
            });
        </script>


        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    </body>
</html>
