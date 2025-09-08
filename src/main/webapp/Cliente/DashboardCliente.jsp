<%-- 
    Document   : DashboardCliente
    Created on : 28 may. 2025, 11:38:38
    Author     : Proyecto
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Cliente.Pelicula" %>
<%@ page import="javax.servlet.RequestDispatcher" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard Cliente</title>
        <!-- Vinculamos Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">

        <style >
            /* Slider */
            .carousel-item img {
                width: 100%;
                height: 100vh;
                max-height: 700px;
                object-fit: cover;
            }

            /* Cabecera */
            .navbar {
                position: absolute;
                top: 0;
                width: 100%;
                z-index: 1;
                background-color: rgba(0, 0, 0, 0.3); /* Sombra más suave */
                border-bottom: 1px solid white; /* Línea blanca debajo de la cabecera */
                height: 80px;
                padding-top: 10px;
            }

            .navbar-brand, .nav-link {
                color: white !important;
            }

            .navbar-nav {
                width: 100%;
                display: flex;
                justify-content: center; /* Centra los elementos de la cabecera */
            }

            .nav-item {
                margin: 0 15px; /* Espaciado entre los items */
                position: relative; /* Necesario para la línea roja */
            }

            /* Línea roja al hacer clic en el item de la cabecera */
            .nav-link:hover {
                color: #FF5733 !important; /* Color del texto al pasar el mouse */
            }

            .nav-link:active {
                color: #FF5733 !important; /* Color del texto al hacer clic */
            }

            .nav-item.active::after {
                content: '';
                position: absolute;
                width: 100%;
                height: 3px;
                background-color: #FF5733; /* Línea roja */
                bottom: 0;
                left: 0;
            }

            /* Películas */
            .pelicula-card {
                position: relative;
                overflow: hidden;
            }

            .pelicula-card img {
                width: 100%;
                height: 400px;
                object-fit: cover;
                transition: transform 0.3s ease-in-out;
            }

            /* Efecto de agrandado al pasar el mouse sobre la imagen */
            .pelicula-card:hover img {
                transform: scale(1.05);
            }

            .pelicula-card .card-body {
                display: none;
            }

            /* Mostrar la información y el botón al hacer hover */
            .pelicula-card:hover .card-body {
                display: block;
                position: absolute;
                bottom: 10px;
                left: 10px;
                background-color: rgba(0, 0, 0, 0.6);  /* Fondo oscuro con opacidad */
                color: white;
                padding: 10px;
                width: 100%;
                box-sizing: border-box;  /* Asegura que el contenido no se desborde */
                transition: background-color 0.3s ease;
            }

            .pelicula-card .card-body a {
                background-color: #FF5733;
                color: white;
                padding: 8px 15px;
                text-decoration: none;
                border-radius: 5px;
                margin-top: 10px;
            }

            /* Efecto hover sobre la tarjeta (sombra y transformación) */
            .pelicula-card:hover {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); /* Sombra que aparece al pasar el mouse */
            }

            /* Espacio entre las filas de las películas */
            .container .row.mb-4 {
                margin-bottom: 30px !important;
            }

            /* Estilos para los filtros horizontales */
            .horizontal-filters-container {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .filter-title {
                font-family: 'Montserrat', sans-serif;
                font-weight: 700;
                color: #343a40;
                margin-bottom: 20px;
                font-size: 1.5rem;
                border-bottom: 2px solid #FF5733;
                padding-bottom: 8px;
            }

            .filter-row {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
            }

            .horizontal-filter-group {
                flex: 1;
                min-width: 180px;
                position: relative;
            }

            .horizontal-filter-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 15px;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 600;
                color: #495057;
                transition: all 0.2s ease;
            }

            .horizontal-filter-header:hover {
                border-color: #FF5733;
                color: #FF5733;
            }

            .horizontal-filter-content {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background-color: #fff;
                border: 1px solid #ddd;
                border-top: none;
                border-radius: 0 0 4px 4px;
                padding: 10px;
                z-index: 10;
                display: none;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            .filter-select {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }

            .filter-button-container {
                display: flex;
                align-items: flex-end;
            }

            .filter-btn {
                background-color: #FF5733;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                height: 42px;
            }

            .filter-btn:hover {
                background-color: #e04a2d;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(255, 87, 51, 0.3);
            }

            /* Responsivo */
            @media (max-width: 992px) {
                .filter-row {
                    flex-direction: column;
                    gap: 10px;
                }

                .horizontal-filter-group {
                    min-width: 100%;
                }

                .filter-button-container {
                    margin-top: 10px;
                }
            }

            /*Titulo PRINCIPAL*/

            .titulo-peliculas {
                font-family: 'Montserrat', sans-serif;
                font-weight: 900;
                color: #adb5bd; /* gris Bootstrap (equivalente a text-secondary) */
                font-size: 4rem; /* opcional: tamaño del texto */
            }

            /* Estilos para la barra de búsqueda */
            .navbar .form-inline {
                margin-left: auto; /* Empuja la búsqueda a la derecha */
            }

            .navbar .input-group {
                width: 250px; /* Ancho ajustable */
            }

            .navbar .form-control {
                background-color: rgba(255, 255, 255, 0.1);
                border-color: rgba(255, 255, 255, 0.3);
                color: white;
            }

            .navbar .form-control::placeholder {
                color: rgba(255, 255, 255, 0.6);
            }

            .navbar .btn-outline-light {
                border-color: rgba(255, 255, 255, 0.3);
                color: white;
            }

            .navbar .btn-outline-light:hover {
                background-color: rgba(255, 255, 255, 0.1);
            }

            @media (max-width: 992px) {
                .navbar .input-group {
                    width: 100%;
                    margin-top: 10px;
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
            }

            .search-trigger:hover {
                color: #FF5733 !important;
            }

            .resultados-container {
                margin-top: 1rem;
                background-color: white;
                border-radius: 5px;
                max-height: 300px;
                overflow-y: auto;
            }

            .resultado-item {
                display: flex;
                align-items: center;
                padding: 0.5rem;
                border-bottom: 1px solid #ddd;
            }

            .resultado-item img {
                margin-right: 10px;
            }

            .resultado-item:hover {
                background-color: #f0f0f0;
                cursor: pointer;
            }

        </style>
    </head>
    <body>

        <!-- Slider -->
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>


            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="<%= request.getContextPath()%>/Cliente/images/slide9.jpg" class="d-block w-100" alt="Jurasic">
                    <div class="carousel-caption d-none d-md-block text-left" style="bottom: 15%; left: 10%; right: auto;">
                        <h2 style="font-size: 3.5rem; margin: 0; font-weight: bold;">
                            <span style="background-color: #e50055; color: white; padding: 10px 10px; border-radius: 3px; display: inline-block;">
                                Jurassic 
                            </span>
                            <br>
                            World Renacer
                        </h2>
                        <p style="color: white; font-size: 1.1rem; margin-top: 15px; max-width: 600px;">
                            En este nuevo capítulo lleno de acción ve a un equipo de extracción correr hacia el lugar más peligroso de la Tierra.                         
                        </p>
                        <a href="http://localhost:8080/CineJ3/Cliente/DetallePelicula.jsp?id=16" class="btn" style="margin-top: 15px; background-color: #e50055; color: white; font-weight: 100; border-radius: 50px; padding: 10px 25px; font-size: 1.3rem;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ticket-fill mr-2" viewBox="0 0 16 16" style="margin-right: 8px;">
                            <path d="M0 4.5A1.5 1.5 0 0 1 1.5 3H2v2a1 1 0 1 0 0 2V9a1 1 0 1 0 0 2v2h-.5A1.5 1.5 0 0 1 0 11.5v-7zm16 0v7a1.5 1.5 0 0 1-1.5 1.5H14v-2a1 1 0 1 0 0-2V7a1 1 0 1 0 0-2V3h.5A1.5 1.5 0 0 1 16 4.5zM3 3h10v10H3V3z"/>
                            </svg>
                            COMPRAR
                        </a>
                    </div>                
                </div>
                <div class="carousel-item">
                    <img src="<%= request.getContextPath()%>/Cliente/images/slide7.jpg" class="d-block w-100" alt="F1">
                    <div class="carousel-caption d-none d-md-block text-left" style="bottom: 15%; left: 10%; right: auto;">
                        <h2 style="font-size: 3.5rem; margin: 0; font-weight: bold;">
                            <span style="background-color: #e50055; color: white; padding: 10px 10px; border-radius: 3px; display: inline-block;">
                                F1: La 
                            </span>
                            Película
                        </h2>
                        <p style="color: white; font-size: 1.1rem; margin-top: 15px; max-width: 600px;">
                            Apodado "el más grande que nunca fue", Sonny Hayes (Brad Pitt) fue el fenómeno más prometedor de la FÓRMULA 1 de los años 90 hasta que sufrió un espectacular accidente.
                        </p>
                        <a href="http://localhost:8080/CineJ3/Cliente/DetallePelicula.jsp?id=13" class="btn" style="margin-top: 15px; background-color: #e50055; color: white; font-weight: 100; border-radius: 50px; padding: 10px 25px; font-size: 1.3rem;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ticket-fill mr-2" viewBox="0 0 16 16" style="margin-right: 8px;">
                            <path d="M0 4.5A1.5 1.5 0 0 1 1.5 3H2v2a1 1 0 1 0 0 2V9a1 1 0 1 0 0 2v2h-.5A1.5 1.5 0 0 1 0 11.5v-7zm16 0v7a1.5 1.5 0 0 1-1.5 1.5H14v-2a1 1 0 1 0 0-2V7a1 1 0 1 0 0-2V3h.5A1.5 1.5 0 0 1 16 4.5zM3 3h10v10H3V3z"/>
                            </svg>
                            COMPRAR
                        </a>
                    </div>            
                </div>
                <div class="carousel-item">
                    <img src="<%= request.getContextPath()%>/Cliente/images/slide4.jpg" class="d-block w-100" alt="Elio">
                    <div class="carousel-caption d-none d-md-block text-left" style="bottom: 15%; left: 10%; right: auto;">
                        <div style="background-color: #e50055; display: inline-block; padding: 10px 20px; border-radius: 3px;">
                            <h2 style="color: white; font-weight: bold; font-size: 3.5rem; margin: 0;">Elio</h2>
                        </div>
                        <p style="color: white; font-size: 1.1rem; margin-top: 15px; max-width: 600px;">
                            Elio, un niño con una gran obsesión por los alienígenas, descubre la respuesta a esa pregunta cuando es transportado al Comuniverso.
                        </p>
                        <a href="http://localhost:8080/CineJ3/Cliente/DetallePelicula.jsp?id=15" class="btn" style="margin-top: 15px; background-color: #e50055; color: white; font-weight: 100; border-radius: 50px; padding: 10px 25px; font-size: 1.3rem;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ticket-fill mr-2" viewBox="0 0 16 16" style="margin-right: 8px;">
                            <path d="M0 4.5A1.5 1.5 0 0 1 1.5 3H2v2a1 1 0 1 0 0 2V9a1 1 0 1 0 0 2v2h-.5A1.5 1.5 0 0 1 0 11.5v-7zm16 0v7a1.5 1.5 0 0 1-1.5 1.5H14v-2a1 1 0 1 0 0-2V7a1 1 0 1 0 0-2V3h.5A1.5 1.5 0 0 1 16 4.5zM3 3h10v10H3V3z"/>
                            </svg>
                            COMPRAR
                        </a>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="<%= request.getContextPath()%>/Cliente/images/slide8.jpg" class="d-block w-100" alt="superman">
                    <div class="carousel-caption d-none d-md-block text-left" style="bottom: 15%; left: 10%; right: auto;">
                        <h2 style="font-size: 3.5rem; margin: 0; font-weight: bold;">
                            <span style="background-color: #e50055; color: white; padding: 10px 10px; border-radius: 3px; display: inline-block;">
                                Super
                            </span>
                            man
                        </h2>
                        <p style="color: white; font-size: 1.1rem; margin-top: 15px; max-width: 600px;">
                            En su estilo característico, James Gunn asume el papel del superhéroe original en el nuevo universo de DC.                        
                        </p>
                        <a href="http://localhost:8080/CineJ3/Cliente/DetallePelicula.jsp?id=17" class="btn" style="margin-top: 15px; background-color: #e50055; color: white; font-weight: 100; border-radius: 50px; padding: 10px 25px; font-size: 1.3rem;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ticket-fill mr-2" viewBox="0 0 16 16" style="margin-right: 8px;">
                            <path d="M0 4.5A1.5 1.5 0 0 1 1.5 3H2v2a1 1 0 1 0 0 2V9a1 1 0 1 0 0 2v2h-.5A1.5 1.5 0 0 1 0 11.5v-7zm16 0v7a1.5 1.5 0 0 1-1.5 1.5H14v-2a1 1 0 1 0 0-2V7a1 1 0 1 0 0-2V3h.5A1.5 1.5 0 0 1 16 4.5zM3 3h10v10H3V3z"/>
                            </svg>
                            COMPRAR
                        </a>
                    </div>
                </div>

            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

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
                    <li class="nav-item active"><a class="nav-link" href="#">Inicio</a></li>
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
                    <form action="ClienteServlet" method="get" class="search-form">
                        <input type="hidden" name="action" value="buscar">
                        <input type="text" name="query" class="search-input" placeholder="Buscador..." autofocus>
                    </form>

                    <!-- RESULTADOS en tiempo real -->
                    <div id="resultadosBusqueda" class="resultados-container"></div>

                    <div class="search-description">
                        <p>Encuentra las mejores películas, actores, salas, formatos (3D, Xtreme, Prime) y todo sobre el planeta del cine.</p>
                    </div>
                </div>
            </div>
        </div>
        <div id="resultadosBusqueda" class="resultados-container"></div>



        <!-- Películas Disponibles -->
        <div class="container mt-5">
            <h3 class="titulo-peliculas " >
                Películas
            </h3>            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/pelicula2.jpg" >
                        <div class="card-body">
                            <h5 class="card-title">Destino Final Lazos de Sangre</h5>
                            <p class="card-text">16+ | 2h 44m | trata sobre Stefanie, una joven universitaria...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=21" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/avengers.avif" >
                        <div class="card-body">
                            <h5 class="card-title">Avengers</h5>
                            <p class="card-text">Cuando un enemigo inesperado surge como...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=20" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/lilo.jpg" >
                        <div class="card-body">
                            <h5 class="card-title">Lilo & Stitch</h5>
                            <p class="card-text">Remake live‑action/animación de Disney....</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=10" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/mision.jpg" >
                        <div class="card-body">
                            <h5 class="card-title">Misión: Imposible – Sentencia Final</h5>
                            <p class="card-text">Ethan Hunt (Tom Cruise) enfrenta su misión más...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=11" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/thunder.jpg" >
                        <div class="card-body">
                            <h5 class="card-title">Thunderbolts</h5>
                            <p class="card-text">16+ | 2h 28m | Un thriller Equipo de antihéroes del MCU que se convierte en ...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=12" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/f1.jpeg" >
                        <div class="card-body">
                            <h5 class="card-title">F1: La Película</h5>
                            <p class="card-text">Drama adrenalínico con Brad Pitt como piloto de...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=13" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/dragon.jpg" >
                        <div class="card-body">
                            <h5 class="card-title">Cómo entrenar a tu dragón</h5>
                            <p class="card-text">Adaptación live‑action de DreamWorks, con Hipo...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=14" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/elio.jpg" >
                        <div class="card-body">
                            <h5 class="card-title">Elio</h5>
                            <p class="card-text">Película animada de Pixar: un niño se convierte en...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=15" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Proximos estrenos -->

            <h3 class="titulo-peliculas " >
                Próximos estrenos
            </h3>            
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/jurasic.jpg"  class="card-img-top" alt="Blade Runner">
                        <div class="card-body">
                            <h5 class="card-title">Jurassic World: El Renacer</h5>
                            <p class="card-text">16+ | 2h 44m | Nueva expedición científica liderada por Scarlett ...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=16" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/superman.jpg"  class="card-img-top" alt="Frozen">
                        <div class="card-body">
                            <h5 class="card-title">Superman</h5>
                            <p class="card-text">Reinicio audiovisual de DC con David Corenswet ...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=17" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/4fantasticos.jpeg"  class="card-img-top" alt="Mario Bros">
                        <div class="card-body">
                            <h5 class="card-title">Los Cuatro Fantásticos: Primeros Pasos</h5>
                            <p class="card-text">La primera Fase Seis del MCU: los Cuatro Fantásti...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=18" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card pelicula-card">
                        <img src="<%= request.getContextPath()%>/Cliente/images/avatar.jpg" class="card-img-top" alt="Spiderman">
                        <div class="card-body">
                            <h5 class="card-title">Avatar: Fuego y Ceniza</h5>
                            <p class="card-text">La cuarta entrega de Avatar de James Cameron...</p>
                            <a href="/CineJ3/Cliente/DetallePelicula.jsp?id=19" class="btn btn-primary">Seleccionar</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>


        <!-- Pie de página -->
        <footer class="bg-dark text-white text-center py-4 mt-5">
            <p>© 2025 Cine Online | Todos los derechos reservados</p>
            <p><a href="" class="text-white">Política de Privacidad</a> | <a href="#" class="text-white">Términos y Condiciones</a></p>
        </footer>

        <!-- Scripts en el orden correcto -->
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

        <script>
            const searchInput = document.querySelector('.search-input');
            const resultadosDiv = document.getElementById('resultadosBusqueda');

            searchInput.addEventListener('input', function () {
                const query = this.value;

                if (query.length < 2) {
                    resultadosDiv.innerHTML = "";
                    return;
                }

                fetch('<%= request.getContextPath()%>/BuscarPeliculasServlet?query=' + encodeURIComponent(query))
                        .then(response => response.json())
                        .then(data => {
                            resultadosDiv.innerHTML = "";

                            if (data.length === 0) {
                                resultadosDiv.innerHTML = "<p>No se encontraron películas.</p>";
                                return;
                            }

                            data.forEach(pelicula => {
                                const item = document.createElement("div");
                                item.classList.add("resultado-item");

                                item.innerHTML = `
                         <img src="data:image/jpeg;base64,${pelicula.foto}" width="60" height="80" />
                         <span>${pelicula.nombre}</span>
                     `;

                                resultadosDiv.appendChild(item);
                            });
                        })
                        .catch(error => {
                            console.error("Error:", error);
                            resultadosDiv.innerHTML = "<p>Error al buscar películas.</p>";
                        });
            });
        </script>


        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </body>
</html>
