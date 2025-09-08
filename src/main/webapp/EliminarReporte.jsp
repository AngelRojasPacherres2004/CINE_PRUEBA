<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="modelo.Reporte" %>

<%
    Reporte reporte = (Reporte) request.getAttribute("reporte");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Reporte</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <h2>¿Estás seguro que deseas eliminar este reporte?</h2>

    <p><strong>ID:</strong> <%= reporte.getId() %></p>
    <p><strong>Nombre:</strong> <%= reporte.getNombre_archivo() %></p>
    <p><strong>Tipo:</strong> <%= reporte.getTipo_archivo() %></p>
    <p><strong>Fecha de subida:</strong> <%= reporte.getFecha_subida() %></p>

    <form action="ReporteServlet?action=eliminar&id=<%= reporte.getId() %>" method="post">
        <button type="submit" class="btn btn-danger">Sí, eliminar</button>
        <a href="ReporteServlet?action=listar" class="btn btn-secondary">Cancelar</a>
    </form>
</body>
</html>
