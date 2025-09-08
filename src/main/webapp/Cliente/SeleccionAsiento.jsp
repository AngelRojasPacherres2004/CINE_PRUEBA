<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Cliente.Asiento" %>
<%@ page import="modelo.Cliente.Pelicula" %>
<%
    String idPelicula = request.getParameter("id"); // <-- ID de la película desde la URL
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <title>Seleccionar Butacas</title>
        <style>
            /* Tus estilos originales, sin cambios */
            body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }
            .custom-header {
                background-color: #004080;
                color: white;
                display: flex;
                align-items: center;
                padding: 10px 20px;
                font-family: Arial, sans-serif;
                font-weight: bold;
                font-size: 18px;
                position: sticky;
                top: 0;
                z-index: 20;
            }
            .back-link {
                color: white;
                text-decoration: none;
                margin-right: 20px;
                font-size: 16px;
            }
            .back-link:hover {
                text-decoration: underline;
            }
            .custom-header h1 {
                margin: 0;
                flex-grow: 1;
                text-align: center;
            }
            .seats-container {
                width: 90%;
                margin: auto;
                background: #f0f4f7;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px #ccc;
                font-family: Arial, sans-serif;
            }
            .screen {
                background: #ccc;
                padding: 10px;
                text-align: center;
                font-weight: bold;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            .seats-row {
                display: flex;
                justify-content: center;
                width: 100%;
            }
            .row-label {
                width: 20px;
                text-align: center;
                margin: 0 10px;
                font-weight: bold;
            }
            .seats-group {
                display: flex;
                justify-content: center;
                gap: 50px;
                flex-wrap: nowrap;
            }
            .seat {
                width: 25px;
                height: 25px;
                border-radius: 50%;
                border: 2px solid #1d4ed8;
                background-color: white;
                cursor: pointer;
                position: relative;
            }
            .seat.available:hover {
                background-color: #bfdbfe;
            }
            .seat.occupied {
                background-color: #ef4444;
                cursor: not-allowed;
                border-color: #b91c1c;
            }
            .seat.selected {
                background-color: #1d4ed8;
                border-color: #1e40af;
            }
            .seats-column {
                display: flex;
                gap: 6px;
            }
            .legend {
                display: flex;
                justify-content: space-around;
                margin-top: 20px;
                font-size: 14px;
            }
            .legend div {
                display: flex;
                align-items: center;
                gap: 6px;
            }
            .legend .box {
                width: 20px;
                height: 20px;
                border-radius: 4px;
            }
            .legend .available {
                background-color: white;
                border: 2px solid #1d4ed8;
            }
            .legend .occupied {
                background-color: #ef4444;
                border: 2px solid #b91c1c;
            }
            .legend .selected {
                background-color: #1d4ed8;
                border: 2px solid #1e40af;
            }
            .btn-link-continue {
                background-color: #ec4899;
                color: white;
                border: none;
                padding: 12px 30px;
                font-size: 16px;
                border-radius: 25px;
                cursor: pointer;
                display: inline-block;
                float: right;
                text-align: center;
                box-sizing: border-box;
                margin: 20px 0 0 0;
                width: auto;
                text-decoration: none;
            }
            .btn-link-continue:hover {
                background-color: #d63483;
            }
            footer {
                background-color: #343a40;
                color: white;
                text-align: center;
                padding: 10px;
                position: relative;
                bottom: 0;
                width: 100%;
            }
            footer a {
                color: #ffffff;
                text-decoration: none;
                margin: 0 5px;
            }
            footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <!-- Cabecera personalizada -->
        <header class="custom-header">
            <a href="DetallePelicula.jsp?id=<%= idPelicula%>" class="back-link">← Atrás</a>
            <h1>Selecciona tus butacas</h1>
        </header>

        <div class="seats-container">
            <div class="screen">Pantalla</div>

            <%-- Generador de asientos --%>
            <%
                String[] rows = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O"};
                for (String row : rows) {
            %>
            <div class="seats-row">
                <div class="row-label"><%= row%></div>
                <div class="seats-group">
                    <% for (int j = 1; j <= 17; j++) {
                            String seatId = row + j;
                            boolean occupied = seatId.equals("A3") || seatId.equals("B7") || seatId.equals("M15") || seatId.equals("A9");
                    %>
                    <% if (j == 5 || j == 14) { %><div class="seats-column"><% }%>
                        <div class="seat <%= occupied ? "occupied" : "available"%>" data-seat="<%= seatId%>" title="<%= seatId%>"></div>
                        <% if (j == 4 || j == 13 || j == 17) { %></div><% } %>
                        <% }%>
                </div>
                <div class="row-label"><%= row%></div>
            </div>
            <% }%>

            <!-- Leyenda -->
            <div class="legend">
                <div><div class="box available"></div>Disponible</div>
                <div><div class="box occupied"></div>Ocupada</div>
                <div><div class="box selected"></div>Seleccionada</div>
            </div>

            <!-- Butacas seleccionadas -->
            <div id="selected-seats" style="margin-top: 20px; font-weight: bold;">Butacas seleccionadas:</div>

            <!-- Formulario que envía al carrito -->
            <form action="${pageContext.request.contextPath}/CarritoServlet" method="post">
                <input type="hidden" name="action" value="agregarPelicula">
                <input type="hidden" name="id" value="${pelicula.id}"> <!-- o usa request.getParameter("id") -->
                <input type="hidden" name="cantidad" id="cantidad" value="1"> <!-- o set real cantidad -->
                <input type="hidden" name="asientos" id="asientosSeleccionados" value="">
                <button type="submit">Continuar</button>
            </form>
        </div>

        <!-- Pie de página -->
        <footer>
            <p>© 2025 Cine Online | Todos los derechos reservados</p>
        </footer>

        <!-- Script -->
        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const seats = document.querySelectorAll(".seat.available");
                const selectedSeats = new Set();
                const selectedSeatsText = document.getElementById("selected-seats");
                const hiddenInput = document.getElementById("asientosSeleccionados");
                const cantidadInput = document.getElementById("cantidad");

                seats.forEach(seat => {
                    seat.addEventListener("click", () => {
                        const seatId = seat.getAttribute("data-seat");
                        if (seat.classList.contains("selected")) {
                            seat.classList.remove("selected");
                            selectedSeats.delete(seatId);
                        } else {
                            seat.classList.add("selected");
                            selectedSeats.add(seatId);
                        }

                        const asientosArray = Array.from(selectedSeats);
                        selectedSeatsText.textContent = "Butacas seleccionadas: " + asientosArray.join(", ");
                        hiddenInput.value = asientosArray.join(",");
                        cantidadInput.value = asientosArray.length;  // 🔥 aquí se actualiza la cantidad
                    });
                });
            });

        </script>

    </body>
</html>
