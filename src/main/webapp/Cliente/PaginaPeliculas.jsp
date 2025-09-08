<%@ page import="java.util.*" %>
<%@ page import="modelo.PeliculaDao" %>
<%@ page import="modelo.Pelicula" %>

<%
    PeliculaDao peliculaDao = new PeliculaDao();
    String filtroLetra = request.getParameter("letra");
    String filtroHorario = request.getParameter("horario");

    List<Pelicula> peliculas = peliculaDao.filtrarPeliculas(filtroLetra, filtroHorario);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Cliente</title>
        <!-- Vinculamos Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
        <style>
            /* Cabecera */
            .navbar {
                position: absolute;
                top: 0;
                width: 100%;
                z-index: 1;
                background-color: #343a40; /* gris oscuro Bootstrap */
                ;
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

            /* Películas */
            .pelicula-card {
                position: relative;
                overflow: hidden;
                margin-bottom: 25px; /* Más espacio entre películas */
            }

            .pelicula-card img {
                width: 100%;
                height: 380px; /* Altura ajustada */
                object-fit: cover;
                transition: transform 0.3s ease-in-out;
            }

            .pelicula-card:hover img {
                transform: scale(1.05);
            }

            .pelicula-card .card-body {
                display: none;
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                background-color: rgba(0, 0, 0, 0.7);
                color: white;
                padding: 15px;
            }

            .pelicula-card:hover .card-body {
                display: block;
            }

            .pelicula-card .card-title {
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }

            .pelicula-card .card-text {
                font-size: 0.9rem;
                margin-bottom: 0.75rem;
            }

            .pelicula-card .btn-primary {
                background-color: #FF5733;
                border: none;
                padding: 6px 12px;
                font-size: 0.85rem;
            }

            .pelicula-card:hover {
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            }

            /* Titulo PRINCIPAL */
            .titulo-peliculas {
                font-family: 'Montserrat', sans-serif;
                font-weight: 900;
                color: #adb5bd;
                font-size: 3rem;
                margin-bottom: 1.5rem;
            }

            /* Filtros */
            .filter-section {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
                height: 100%;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            /* Layout de dos columnas */
            .main-content {
                display: flex;
                flex-wrap: wrap;
                margin-top: 30px;
            }

            .filter-column {
                flex: 0 0 25%;
                max-width: 25%;
                padding-right: 20px;
            }

            .movies-column {
                flex: 0 0 75%;
                max-width: 75%;
                padding-left: 20px;
            }

            .filter-title {
                font-family: 'Montserrat', sans-serif;
                font-weight: 700;
                color: #343a40;
                margin-bottom: 25px;
                font-size: 1.5rem;
                border-bottom: 2px solid #FF5733;
                padding-bottom: 8px;
            }

            .filter-group {
                margin-bottom: 25px;
            }

            .filter-group-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 0;
                border-bottom: 1px solid #dee2e6;
                cursor: pointer;
                font-weight: 600;
                color: #495057;
            }

            .filter-group-title:hover {
                color: #FF5733;
            }

            .filter-group-content {
                padding: 12px 0;
            }

            .filter-item {
                padding: 8px 0;
                display: flex;
                align-items: center;
            }

            .form-check-input {
                margin-right: 10px;
            }

            /* Ajustes para pantallas medianas */
            @media (max-width: 1200px) {
                .pelicula-card img {
                    height: 320px;
                }
            }

            /* Ajustes para tablets */
            @media (max-width: 992px) {
                .filter-column, .movies-column {
                    flex: 0 0 100%;
                    max-width: 100%;
                    padding: 0;
                }

                .filter-column {
                    margin-bottom: 40px;
                }

                .pelicula-card img {
                    height: 350px;
                }
            }

            /* Ajustes para móviles */
            @media (max-width: 768px) {
                .pelicula-card img {
                    height: 300px;
                }

                .titulo-peliculas {
                    font-size: 2.5rem;
                }
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


            /* Estilos para los checkboxes/radio buttons */
            .form-check-input {
                width: 1.2em;
                height: 1.2em;
                margin-top: 0.15em;
                margin-right: 0.5em;
                border: 2px solid #6c757d;
                appearance: none;
                -webkit-appearance: none;
                position: relative;
                cursor: pointer;
            }

            .form-check-input:checked {
                background-color: #0d6efd;
                border-color: #0d6efd;
            }

            .form-check-input[type="checkbox"] {
                border-radius: 0.25em;
            }

            .form-check-input[type="radio"] {
                border-radius: 50%;
            }

            /* Estilo para el checkmark en checkboxes */
            .form-check-input[type="checkbox"]:checked::after {
                content: "";
                position: absolute;
                left: 50%;
                top: 50%;
                width: 0.4em;
                height: 0.7em;
                border: solid white;
                border-width: 0 0.15em 0.15em 0;
                transform: translate(-50%, -60%) rotate(45deg);
            }

            /* Estilo para el punto central en radio buttons */
            .form-check-input[type="radio"]:checked::after {
                content: "";
                position: absolute;
                left: 50%;
                top: 50%;
                width: 0.6em;
                height: 0.6em;
                background-color: white;
                border-radius: 50%;
                transform: translate(-50%, -50%);
            }

            /* Estilos para las etiquetas */
            .form-check-label {
                cursor: pointer;
                user-select: none;
                font-size: 0.95rem;
                color: #495057;
            }

            /* Estilo para los items de filtro */
            .filter-item {
                padding: 0.5rem 1rem;
                transition: background-color 0.2s;
            }

            .filter-item:hover {
                background-color: #f8f9fa;
            }
        </style>
    </head>
    <body>
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
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath()%>/Cliente/PaginaProductos.jsp">Dulcería</a></li>
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
                            <a class="dropdown-item" href="http://localhost:8080/CineJ3/Login.jsp">Cerrar Sesión</a>
                        </div>
                    </li>
                    <% } else {%>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath()%>/Login.jsp">Mi Cuenta</a></li>
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

        <div class="container mt-5 pt-5 pb-5">
            <div class="main-content">
                <!-- Columna de filtros -->
                <form method="get" action="PaginaPeliculas.jsp" class="filter-column">
                    <h2 class="filter-title">Filtrar Por</h2>

                    <div class="filter-section">
                        <!-- Grupo de filtro 1 - Nombre -->
                        <div class="filter-group">
                            <div class="filter-group-title">
                                <span>Rango de Nombre</span>
                                <i class="bi bi-plus"></i>
                            </div>
                            <div class="filter-group-content" style="display: none;">
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="letra" id="letraTodos" value="" checked>
                                    <label class="form-check-label" for="letraTodos">Todos</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="letra" id="letraAD" value="A-D">
                                    <label class="form-check-label" for="letraAD">A - D</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="letra" id="letraEH" value="E-H">
                                    <label class="form-check-label" for="letraEH">E - H</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="letra" id="letraIL" value="I-L">
                                    <label class="form-check-label" for="letraIL">I - L</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="letra" id="letraMP" value="M-P">
                                    <label class="form-check-label" for="letraMP">M - P</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="letra" id="letraQT" value="Q-T">
                                    <label class="form-check-label" for="letraQT">Q - T</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="letra" id="letraUZ" value="U-Z">
                                    <label class="form-check-label" for="letraUZ">U - Z</label>
                                </div>
                            </div>
                        </div>

                        <!-- Grupo de filtro 2 - Horario -->
                        <div class="filter-group">
                            <div class="filter-group-title">
                                <span>Horario</span>
                                <i class="bi bi-plus"></i>
                            </div>
                            <div class="filter-group-content" style="display: none;">
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="horario" id="horarioTodos" value="" checked>
                                    <label class="form-check-label" for="horarioTodos">Todos</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="horario" id="horario10" value="10:00" <%= "10:00".equals(filtroHorario) ? "checked" : ""%>>
                                    <label class="form-check-label" for="horario10">10:00 AM</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="horario" id="horario1030" value="10:30" <%= "10:30".equals(filtroHorario) ? "checked" : ""%>>
                                    <label class="form-check-label" for="horario1030">10:30 AM</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="horario" id="horario11" value="11:00" <%= "11:00".equals(filtroHorario) ? "checked" : ""%>>
                                    <label class="form-check-label" for="horario11">11:00 AM</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="horario" id="horario12" value="12:00" <%= "12:00".equals(filtroHorario) ? "checked" : ""%>>
                                    <label class="form-check-label" for="horario12">12:00 PM</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="horario" id="horario13" value="13:00" <%= "13:00".equals(filtroHorario) ? "checked" : ""%>>
                                    <label class="form-check-label" for="horario13">1:00 PM</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="horario" id="horario14" value="14:00" <%= "14:00".equals(filtroHorario) ? "checked" : ""%>>
                                    <label class="form-check-label" for="horario14">2:00 PM</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="horario" id="horario15" value="15:00" <%= "15:00".equals(filtroHorario) ? "checked" : ""%>>
                                    <label class="form-check-label" for="horario15">3:00 PM</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="horario" id="horario16" value="16:00" <%= "16:00".equals(filtroHorario) ? "checked" : ""%>>
                                    <label class="form-check-label" for="horario16">4:00 PM</label>
                                </div>
                                <div class="form-check filter-item">
                                    <input class="form-check-input" type="radio" name="horario" id="horario17" value="17:00" <%= "17:00".equals(filtroHorario) ? "checked" : ""%>>
                                    <label class="form-check-label" for="horario17">5:00 PM</label>
                                </div>
                            </div>
                        </div>

                        <!-- Botón de aplicar filtros -->
                        <div class="filter-group">
                            <button type="submit" class="btn btn-primary btn-apply-filters">Aplicar Filtros</button>
                        </div>
                    </div>
                </form>

                <!-- Columna de películas -->
                <div class="movies-column">
                    <h3 class="titulo-peliculas">Películas en Cartelera</h3>
                    <div class="row">
                        <% for (Pelicula pelicula : peliculas) {%>
                        <div class="col-md-4">
                            <div class="card pelicula-card">
                                <img src="<%= request.getContextPath()%>/StreamingImagen?id=<%= pelicula.getId()%>" 
                                     class="card-img-top" 
                                     alt="<%= pelicula.getNombre()%>">
                                <div class="card-body">
                                    <h5 class="card-title"><%= pelicula.getNombre()%></h5>
                                    <p class="card-text">
                                        <%= pelicula.getSinopsis().length() > 80
                                                ? pelicula.getSinopsis().substring(0, 80) + "..."
                                                : pelicula.getSinopsis()%>
                                    </p>
                                    <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=<%= pelicula.getId()%>" class="btn btn-primary">Ver más</a>
                                </div>
                            </div>
                        </div>
                        <% }%>
                    </div>
                </div>
            </div>
        </div>


        <!-- Bootstrap JS -->
        <script>
            document.getElementById("busqueda").addEventListener("input", function () {
                const query = this.value.trim();
                const resultados = document.getElementById("resultados");

                if (query.length === 0) {
                    resultados.innerHTML = "";
                    return;
                }

                fetch("BusquedaAjaxServlet?query=" + encodeURIComponent(query))
                        .then(response => response.json())
                        .then(data => {
                            resultados.innerHTML = "";

                            if (data.length === 0) {
                                resultados.innerHTML = "<p class='text-muted'>No se encontraron resultados.</p>";
                                return;
                            }

                            data.forEach(pelicula => {
                                const div = document.createElement("div");
                                div.className = "card mb-2 p-2";

                                div.innerHTML = `
                    <h5 class="mb-1">${pelicula.nombre}</h5>
                    <a href="DetallePelicula.jsp?id=${pelicula.id}" class="btn btn-sm btn-primary">Ver Detalles</a>
                `;
                                resultados.appendChild(div);
                            });
                        })
                        .catch(error => {
                            console.error("Error al buscar:", error);
                        });
            });
        </script>

        <!-- Script para los filtros - Versión corregida -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Seleccionamos todos los títulos de los filtros
                const filterTitles = document.querySelectorAll('.filter-group-title');

                // Añadimos el evento click a cada uno
                filterTitles.forEach(title => {
                    title.addEventListener('click', function () {
                        // Encontramos el contenido asociado
                        const content = this.nextElementSibling;
                        const icon = this.querySelector('i');

                        // Alternamos la visualización
                        if (content.style.display === 'none') {
                            content.style.display = 'block';
                            icon.classList.remove('bi-plus');
                            icon.classList.add('bi-dash');
                        } else {
                            content.style.display = 'none';
                            icon.classList.remove('bi-dash');
                            icon.classList.add('bi-plus');
                        }
                    });
                });

                // Mostramos los filtros que tengan opciones seleccionadas
                document.querySelectorAll('.filter-group input[checked]').forEach(input => {
                    if (input.value !== "") {
                        const content = input.closest('.filter-group-content');
                        const title = input.closest('.filter-group').querySelector('.filter-group-title');
                        const icon = title.querySelector('i');

                        content.style.display = 'block';
                        icon.classList.remove('bi-plus');
                        icon.classList.add('bi-dash');
                    }
                });
            });
        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
