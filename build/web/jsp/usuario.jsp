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
    if (session_web != null){
        //Recuperar el nombre de usuario de la sesión
        matricula = (String) session_web.getAttribute("matricula");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página de bienvenida</title>
    </head>
    <body>
        <h2>Bienvenido, <%= (matricula != null) ? matricula : "Invitado" %></h2>
        <%
            if(matricula != null){%>
            <p>Has iniciado sesión correctamente. </p>
            <a href="${pageContext.request.contextPath}/login_servlet">Cerrar Sesión</a>
        <%}else{ %>
            <p>No has iniciado sesión. </p>
            <a href="login.jsp">Iniciar Sesión</a>
        <% } %>
    </body>
</html>
