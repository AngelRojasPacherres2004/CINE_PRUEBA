<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, modelo.Producto" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <title>Método de Pago</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"/>
        <style>
            body {
                background-color: #f0f4f7;
                font-family: Arial, sans-serif;
                padding-top: 80px;
                padding-bottom: 80px;
            }

            .custom-header {
                background-color: #004080;
                color: white;
                font-weight: bold;
                font-size: 18px;
                padding: 12px 20px;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1050;
                display: flex;
                align-items: center;
            }

            .back-link {
                color: white;
                text-decoration: none;
                margin-right: 20px;
                font-size: 16px;
            }

            .custom-header h1 {
                flex-grow: 1;
                text-align: center;
                margin: 0;
            }

            .payment-container {
                max-width: 700px;
                margin: auto;
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }

            .step-progress {
                display: flex;
                justify-content: center;
                margin-bottom: 30px;
                gap: 20px;
            }

            .step-progress .step {
                width: 40px;
                height: 40px;
                border-bottom: 3px solid #ddd;
                text-align: center;
                font-size: 24px;
                color: #ccc;
                line-height: 40px;
            }

            .step-progress .step.active {
                color: #004080;
                border-color: #004080;
                font-weight: bold;
            }

            h2 {
                color: #004080;
                font-weight: 700;
                margin-bottom: 20px;
                text-align: center;
            }

            .payment-options {
                border: 1px solid #ccc;
                border-radius: 6px;
                cursor: pointer;
                display: flex;
                align-items: center;
                padding: 12px 20px;
                margin-bottom: 10px;
                transition: border-color 0.3s ease;
            }

            .payment-options.selected {
                border-color: #004080;
                background-color: #eef4fb;
            }

            .payment-options input[type="radio"] {
                margin-right: 15px;
            }

            .payment-options label {
                margin: 0;
                flex-grow: 1;
                font-weight: 600;
                color: #004080;
            }

            .form-section {
                display: none;
                margin-top: 20px;
            }

            .form-section.active {
                display: block;
                animation: fadeIn 0.4s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .btn-continue {
                background-color: #ec4899;
                color: white;
                border: none;
                padding: 14px 40px;
                font-size: 16px;
                border-radius: 25px;
                cursor: pointer;
                box-shadow: 0 4px 10px rgba(236, 72, 153, 0.6);
                display: block;
                margin: 30px auto 0 auto;
            }

            .btn-continue:hover {
                background-color: #be1f73;
            }

            footer {
                text-align: center;
                font-size: 12px;
                color: #555;
                margin-top: 50px;
            }

            footer a {
                color: #555;
                margin: 0 5px;
                text-decoration: none;
            }

            footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <header class="custom-header">
            <a href="http://localhost:8080/CineJ3/Cliente/Carrito.jsp" class="back-link">← Atrás</a>
            <h1>Pago</h1>
        </header>

        <div class="payment-container">
            <div class="step-progress">
                <div class="step">1</div>
                <div class="step">2</div>
                <div class="step">3</div>
                <div class="step active">4</div>
            </div>

            <h2>Elige una forma de Pago</h2>

            <form action="<%= request.getContextPath()%>/ProcesarPagoServlet" method="post">

                <!-- Opciones -->
                <div class="payment-options" onclick="selectMethod(this, 'tarjeta')">
                    <input type="radio" name="metodo" value="Tarjeta" required />
                    <label>Tarjeta de Crédito / Débito</label>
                    <img src="http://localhost:8080/CineJ3/Cliente/images/pago1.png" alt="Visa" height="25"/>
                    <img src="http://localhost:8080/CineJ3/Cliente/images/pago2.png" alt="Mastercard" height="25"/>
                    <img src="http://localhost:8080/CineJ3/Cliente/images/pago3.png" alt="Amex" height="25"/>
                    <img src="http://localhost:8080/CineJ3/Cliente/images/pago4.png" alt="Diners" height="25"/>
                </div>

                <div class="payment-options" onclick="selectMethod(this, 'yape')">
                    <input type="radio" name="metodo" value="Yape" />
                    <label>Yape</label>
                    <img src="http://localhost:8080/CineJ3/Cliente/images/pago6.jpg" alt="Yape" height="25"/>
                </div>

                <div class="payment-options" onclick="selectMethod(this, 'plin')">
                    <input type="radio" name="metodo" value="Plin" />
                    <label>Plin</label>
                    <img src="http://localhost:8080/CineJ3/Cliente/images/pago7.png" alt="Plin" height="25"/>
                </div>

                <!-- Formulario tarjeta -->
                <div id="form-tarjeta" class="form-section">
                    <div class="form-group">
                        <input type="text" name="nombre" class="form-control" placeholder="Nombre en la tarjeta">
                    </div>
                    <div class="form-group">
                        <input type="text" name="numero" class="form-control" placeholder="Número de tarjeta" maxlength="16">
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <input type="text" name="vencimiento" class="form-control" placeholder="Vencimiento (MM/AA)" maxlength="5">
                        </div>
                        <div class="form-group col-md-6">
                            <input type="text" name="cvv" class="form-control" placeholder="CVV" maxlength="3">
                        </div>
                    </div>
                </div>

                <!-- Formulario yape -->
                <div id="form-yape" class="form-section">
                    <div class="form-group">
                        <input type="text" name="codigoYape" class="form-control" placeholder="Código de aprobación de Yape" maxlength="6">
                    </div>
                </div>

                <!-- Formulario plin -->
                <div id="form-plin" class="form-section">
                    <div class="form-group">
                        <input type="text" name="codigoPlin" class="form-control" placeholder="Código de aprobación de Plin" maxlength="6">
                    </div>
                </div>

                <!-- Botón continuar -->
                <button type="submit" class="btn-continue">Finalizar compra</button>

            </form>
        </div>

        <footer>
            © 2025 Cine Online | Todos los derechos reservados<br/>
            <a href="#">Política de Privacidad</a> | <a href="#">Términos y Condiciones</a>
        </footer>

        <script>
            function selectMethod(element, method) {
                document.querySelectorAll('.payment-options').forEach(el => el.classList.remove('selected'));
                element.classList.add('selected');
                element.querySelector('input').checked = true;

                document.querySelectorAll('.form-section').forEach(section => {
                    section.classList.remove('active');
                    section.querySelectorAll('input').forEach(input => input.required = false);
                });

                const selectedForm = document.getElementById('form-' + method);
                if (selectedForm) {
                    selectedForm.classList.add('active');
                    selectedForm.querySelectorAll('input').forEach(input => input.required = true);
                }
            }
        </script>

    </body>
</html>
