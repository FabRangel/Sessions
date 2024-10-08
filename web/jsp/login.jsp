<%-- 
    Document   : login
    Created on : 7 oct 2024, 19:56:54
    Author     : fgmrr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Iniciar Sesión</title>
    </head>
    <body>
        <h2>Iniciar Sesión</h2>
        <form action="${pageContext.request.contextPath}/login_servlet" method="post">
            <label for="username">Nombre del usuario:</label>
            <input type="text" id="matricula" name="matricula" required> <br>
            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" required> <br>
            <button type="submit">Iniciar Sesión</button>
            
            <%
                String error = (String)request.getAttribute("error");
                if(error!=null){
                %>
                <p style="color:red;"><%=error%></p>
                <% } %>
        </form>
    </body>
</html>
