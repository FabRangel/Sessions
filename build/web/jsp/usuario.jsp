<%-- 
    Document   : usuario
    Created on : 7 oct 2024, 19:56:59
    Author     : fgmrr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //Obtener la sesión actual
    HttpSession session_web = request.getSession(false);
    //No crear una nueva sessión si existe

    String matricula = null;
    if (session_web != null) {
        //Recuperar el nombre de usuario de la sesión
        matricula = (String) session_web.getAttribute("matricula");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página de bienvenida</title>
        <style>
            #timer {
                font-family: 'Courier New', Courier, monospace;
                font-size: 30px;
                color: #ffffff;
                background-color: #333;
                border-radius: 10px;
                padding: 10px 20px;
                text-align: center;
                width: 150px;
                position: fixed;
                top: 20px;
                right: 20px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
                z-index: 1000;
            }
        </style>
        <script type="text/javascript">
            window.onload = function () {
                var sessionDuration = <%= session_web.getAttribute("sessionDuration")%>;  
                var conteoRegresivo = sessionDuration;

                function actualizarConteo() {
                    var minutos = Math.floor(conteoRegresivo / 60);
                    var segundos = conteoRegresivo % 60;

                    // Agrega un 0 si los segundos son menos de 10
                    segundos = segundos < 10 ? '0' + segundos : segundos;

                    document.getElementById("timer").innerHTML = minutos + ":" + segundos;

                    // Si el contador llega a cero, redirigir al usuario
                    if (conteoRegresivo <= 0) {
                        clearInterval(intervaloTiempo);
                        alert("Tu sesión ha expirado.");
                        window.location.href = "/http_session/jsp/login.jsp"; // Redirigir al login
                    } else {
                        conteoRegresivo--; // Reducir el contador
                    }
                }

                // Actualizar el contador cada segundo
                var intervaloTiempo = setInterval(actualizarConteo, 1000);
            }
        </script>
    </head>
    <body>
        <h2>Bienvenido, <%= (matricula != null) ? matricula : "Invitado"%></h2>
        <%
            if (matricula != null) {%>
        <p>Has iniciado sesión correctamente. </p>
        <a href="${pageContext.request.contextPath}/login_servlet">Cerrar Sesión</a>
        <span id="timer"></span> 
        <%} else { %>
        <p>No has iniciado sesión. </p>
        <a href="login.jsp">Iniciar Sesión</a>
        <% }%>

    </body>
</html>
