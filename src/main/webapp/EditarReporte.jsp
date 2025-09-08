<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="modelo.Reporte" %>

<%
    Reporte reporte = (Reporte) request.getAttribute("reporte");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Reporte</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <h2>Editar Reporte</h2>

    <form action="ReporteServlet?action=actualizar&id=<%= reporte.getId() %>" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>Nombre del Reporte:</label>
            <input type="text" name="nombre" class="form-control" value="<%= reporte.getNombre_archivo() %>" required>
        </div>

        <div class="form-group">
            <label>Reemplazar archivo (opcional):</label>
            <input type="file" name="archivo" class="form-control-file">
        </div>

        <button type="submit" class="btn btn-primary">Actualizar</button>
        <a href="ReporteServlet?action=listar" class="btn btn-secondary">Cancelar</a>
    </form>
</body>
</html>
