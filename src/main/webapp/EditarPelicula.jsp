<%@page import="modelo.Pelicula"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Película</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    </head>
    <body>

        <div class="container mt-5">
            <h3>Editar Película</h3>

            <!-- Formulario para editar una película -->
            <form action="PeliculaServlet?action=actualizar" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${pelicula.id}">

                <div class="form-group">
                    <label for="nombre">Nombre de la Película:</label>
                    <input type="text" name="nombre" id="nombre" class="form-control" value="${pelicula.nombre}" required>
                </div>

                <div class="form-group">
                    <label for="sinopsis">Sinopsis:</label>
                    <textarea name="sinopsis" id="sinopsis" class="form-control" rows="4" required>${pelicula.sinopsis}</textarea>
                </div>

                <div class="form-group">
                    <label for="horario">Horario:</label>
                    <input type="text" name="horario" id="horario" class="form-control" value="${pelicula.horario}" required>
                </div>

                <div class="form-group">
                    <label for="fecha">Fecha:</label>
                    <fmt:formatDate value="${pelicula.fecha}" pattern="yyyy-MM-dd" var="fechaFormateada" />
                    <input type="date" name="fecha" id="fecha" class="form-control" value="${fechaFormateada}" required>
                </div>

                <div class="form-group">
                    <label for="precio">Precio:</label>
                    <input type="number" step="0.01" name="precio" id="precio" class="form-control" value="${pelicula.precio}" required>
                </div>

                <div class="form-group">
                    <label for="foto">Foto de película:</label>
                    <input type="file" class="form-control-file" name="foto" id="foto" accept="image/*">
                    <small class="form-text text-muted">Déjalo vacío si no deseas cambiar la imagen.</small>
                </div>

                <button type="submit" class="btn btn-primary">Actualizar Película</button>
                <a href="PeliculaServlet?action=listar" class="btn btn-secondary">Cancelar</a>
            </form>
        </div>

    </body>
</html>
