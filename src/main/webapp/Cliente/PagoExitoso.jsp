<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, modelo.*" %>
<%@ page import="modelo.ItemCarritoBase" %>
<%@ page import="modelo.ItemCarrito" %>
<%@ page import="modelo.ItemCarritoPelicula" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Pago Exitoso</title>

        <!-- Bootstrap y FontAwesome -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

        <!-- PDF -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }

            .voucher-container {
                max-width: 850px;
                background: white;
                margin: 90px auto 40px;
                padding: 40px;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }

            .voucher-header {
                background-color: #003366;
                color: white;
                height: 50px;
                display: flex;
                align-items: center;
                padding: 0 20px;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1050;
            }

            .voucher-header .back-link {
                color: white;
                text-decoration: none;
                font-weight: bold;
            }

            .voucher-header .title {
                flex-grow: 1;
                text-align: center;
                font-size: 18px;
                font-weight: 600;
            }

            .qr-code img {
                width: 160px;
            }

            .footer-thanks {
                margin-top: 40px;
                text-align: center;
                font-weight: bold;
                font-size: 1.2rem;
                color: #003366;
            }

            .btns {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 30px;
            }

            .table th {
                background-color: #e9ecef;
            }
        </style>
    </head>
    <body>

        <!-- Header -->
        <div class="voucher-header">
            <a href="<%= request.getContextPath()%>/" class="back-link"><i class="fas fa-home"></i> Inicio</a>
            <div class="title">🎟️ Comprobante de Compra</div>
            <i class="fas fa-check-circle"></i>
        </div>

        <!-- Contenido -->
        <div class="voucher-container" id="comprobante">

            <h2 class="text-success text-center">✅ ¡Gracias por tu compra!</h2>
            <p class="text-center lead">Tu pago fue aprobado correctamente.</p>

            <hr>

            <h4>🛍️ Detalles de la compra:</h4>

            <%
                List<ItemCarritoBase> detalleCompra = (List<ItemCarritoBase>) session.getAttribute("detalleCompra");
                double total = 0;

                if (detalleCompra == null || detalleCompra.isEmpty()) {
            %>
            <div class="alert alert-danger mt-3">
                ⚠️ [ERROR] No se encontraron detalles de la compra. Revisa tu sesión.
            </div>
            <%
            } else {
            %>
            <table class="table table-bordered mt-3">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Tipo</th>
                        <th>Precio (S/)</th>
                        <th>Cantidad</th>
                        <th>Subtotal (S/)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (ItemCarritoBase item : detalleCompra) {
                            String nombre = "";
                            String tipo = item.getTipo();
                            double precio = 0;
                            int cantidad = item.getCantidad();

                            if (item instanceof ItemCarrito) {
                                Producto p = ((ItemCarrito) item).getProducto();
                                nombre = p.getNombre();
                                precio = Double.parseDouble(p.getPrecio());
                            } else if (item instanceof ItemCarritoPelicula) {
                                Pelicula p = ((ItemCarritoPelicula) item).getPelicula();
                                nombre = p.getNombre();
                                precio = p.getPrecio();
                            }

                            double subtotal = cantidad * precio;
                            total += subtotal;
                    %>
                    <tr>
                        <td><%= nombre%></td>
                        <td><%= tipo.equals("producto") ? "Producto" : "Película"%></td>
                        <td><%= String.format("%.2f", precio)%></td>
                        <td><%= cantidad%></td>
                        <td><%= String.format("%.2f", subtotal)%></td>
                    </tr>
                    <% }%>
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="4" class="text-right">Total:</th>
                        <th>S/ <%= String.format("%.2f", total)%></th>
                    </tr>
                </tfoot>
            </table>
            <% }%>

            <div class="qr-code text-center mt-4">
                <p>📲 Escanea este código para validar tu compra:</p>
                <img src="<%= request.getContextPath()%>/Cliente/images/qr.png" alt="Código QR">
            </div>

            <div class="footer-thanks">Gracias por tu preferencia 🎬</div>

        </div>

        <!-- Botones -->
        <div class="btns">
            <button class="btn btn-outline-secondary" onclick="descargarPDF()">
                <i class="fas fa-file-pdf"></i> Descargar PDF
            </button>
            <a href="<%= request.getContextPath()%>/" class="btn btn-primary">
                <i class="fas fa-home"></i> Volver al inicio
            </a>
        </div>

        <!-- Scripts -->
        <script>
            function descargarPDF() {
                const element = document.getElementById("comprobante");
                const opt = {
                    margin: 0.5,
                    filename: 'comprobante_pago.pdf',
                    image: {type: 'jpeg', quality: 0.98},
                    html2canvas: {scale: 2},
                    jsPDF: {unit: 'in', format: 'letter', orientation: 'portrait'}
                };
                html2pdf().from(element).set(opt).save();
            }
        </script>

    </body>
</html>
