<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, modelo.*" %>
<%@ page import="modelo.ItemCarritoBase" %>
<%@ page import="modelo.ItemCarrito" %>
<%@ page import="modelo.ItemCarritoPelicula" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Carrito de Compras - CINEMAX</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                max-width: 960px;
            }
            .table th, .table td {
                vertical-align: middle;
            }
            .btn {
                font-size: 0.9rem;
            }
            .btn-success {
                background-color: #00a650;
                border: none;
            }
            .btn-success:hover {
                background-color: #008a45;
            }
            .btn-danger {
                background-color: #e63946;
                border: none;
            }
            .btn-danger:hover {
                background-color: #c62828;
            }
            h2 {
                font-weight: bold;
                color: #2c3e50;
            }
            .empty-cart {
                background-color: #fff3cd;
                border: 1px solid #ffeeba;
                color: #856404;
                padding: 20px;
                border-radius: 5px;
            }
            .asientos {
                font-size: 0.85rem;
                color: #6c757d;
            }
        </style>
    </head>

    <body>
        <div class="container mt-5">
            <h2 class="mb-4"><i class="bi bi-cart3"></i> Tu Carrito</h2>

            <%
                List<ItemCarritoBase> carrito = (List<ItemCarritoBase>) session.getAttribute("carrito");
                double total = 0;
                if (carrito == null || carrito.isEmpty()) {
            %>
            <div class="empty-cart text-center">
                <i class="bi bi-emoji-frown" style="font-size: 2rem;"></i>
                <p class="mt-2 mb-0">No hay productos ni películas en el carrito.</p>
                <a href="<%= request.getContextPath()%>/Cliente/PaginaProductos.jsp" class="btn btn-outline-primary mt-3">
                    <i class="bi bi-arrow-left"></i> Volver a la tienda
                </a>
            </div>
            <% } else { %>

            <div class="table-responsive">
                <table class="table table-bordered bg-white">
                    <thead class="table-light">
                        <tr>
                            <th>Item</th>
                            <th>Tipo</th>
                            <th>Precio</th>
                            <th>Cantidad</th>
                            <th>Subtotal</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (ItemCarritoBase item : carrito) {
                                String tipo = item.getTipo();
                                String nombre = "";
                                double precio = 0;
                                int cantidad = 0;
                                int id = 0;
                                String asientos = "";

                                if (item instanceof ItemCarrito) {
                                    Producto p = ((ItemCarrito) item).getProducto();
                                    nombre = p.getNombre();
                                    precio = Double.parseDouble(p.getPrecio());
                                    cantidad = ((ItemCarrito) item).getCantidad();
                                    id = p.getId();
                                } else if (item instanceof ItemCarritoPelicula) {
                                    Pelicula p = ((ItemCarritoPelicula) item).getPelicula();
                                    nombre = p.getNombre();
                                    precio = p.getPrecio();
                                    cantidad = ((ItemCarritoPelicula) item).getCantidad();
                                    id = p.getId();
                                } else if (item instanceof ItemCarritoPelicula) {
                                    Pelicula p = ((ItemCarritoPelicula) item).getPelicula();
                                    nombre = p.getNombre();
                                    precio = p.getPrecio();
                                    cantidad = ((ItemCarritoPelicula) item).getCantidad();
                                    id = p.getId();
                                    asientos = String.join(", ", ((ItemCarritoPelicula) item).getAsientos());
                                }

                                double subtotal = precio * cantidad;
                                total += subtotal;
                        %>
                        <tr>
                            <td>
                                <%= nombre%>
                                <% if (!asientos.isEmpty()) {%>
                                <div class="asientos">🎟 Asientos: <%= asientos%></div>
                                <% }%>
                            </td>
                            <td><%= tipo.equals("producto") ? "Producto" : "Película"%></td>
                            <td>S/ <%= String.format("%.2f", precio)%></td>
                            <td><%= cantidad%></td>
                            <td>S/ <%= String.format("%.2f", subtotal)%></td>
                            <td>
                                <form action="<%= request.getContextPath()%>/EliminarDelCarritoServlet" method="post">
                                    <input type="hidden" name="id" value="<%= id%>">
                                    <input type="hidden" name="tipo" value="<%= tipo%>">
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i class="bi bi-trash"></i> Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="4" class="text-end">Total:</th>
                            <th>S/ <%= String.format("%.2f", total)%></th>
                            <th></th>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <div class="d-flex justify-content-between mt-4">
                <a href="<%= request.getContextPath()%>/Cliente/PaginaProductos.jsp" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left-circle"></i> Seguir comprando
                </a>
                <a href="<%= request.getContextPath()%>/Cliente/ConfirmacionPago.jsp" class="btn btn-success">
                    <i class="bi bi-credit-card-fill"></i> Continuar con el Pago
                </a>
            </div>
            <% }%>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
