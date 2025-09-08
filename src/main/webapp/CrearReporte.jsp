<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nuevo Reporte</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <h2>Subir nuevo reporte</h2>

    <form action="ReporteServlet" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>Nombre del Reporte:</label>
            <input type="text" name="nombre" class="form-control" required>
        </div>

        <div class="form-group">
            <label>Archivo:</label>
            <input type="file" name="archivo" class="form-control-file" required>
        </div>

        <button type="submit" class="btn btn-success">Subir</button>
        <a href="ReporteServlet?action=listar" class="btn btn-secondary">Cancelar</a>
    </form>
</body>
</html>
