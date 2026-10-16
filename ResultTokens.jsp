<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ejercicio 8 - Separación de Tokens (c:forTokens)</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Ejercicio 8: Separador de Tokens (c:forTokens)</h1>
            <p class="subtitle">Tokenización de cadenas de texto con delimitadores dinámicos</p>
        </header>

        <div class="card">
            <h2>Ingresar Texto y Delimitador</h2>
            <form action="ResultTokens.jsp" method="get">
                <div class="form-group">
                    <label for="delimText">Texto a dividir:</label>
                    <input type="text" id="delimText" name="delimText" 
                           value="<c:out value="${empty param.delimText ? 'Java,JSP,JSTL,MySQL,Tomcat' : param.delimText}"/>" required>
                </div>
                <div class="form-group">
                    <label for="delim">Delimitador:</label>
                    <input type="text" id="delim" name="delim" 
                           value="<c:out value="${empty param.delim ? ',' : param.delim}"/>" required>
                </div>
                <button type="submit" class="btn">Tokenizar</button>
            </form>
        </div>

        <c:if test="${not empty param.delimText and not empty param.delim}">
            <div class="card">
                <h2>Tokens Obtenidos</h2>
                <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                    <c:forTokens items="${param.delimText}" delims="${param.delim}" var="myToken">
                        <div class="alert alert-success" style="margin-bottom: 0;">
                            Elemento: <strong><c:out value="${myToken}"/></strong>
                        </div>
                    </c:forTokens>
                </div>
            </div>
        </c:if>

        <a href="index.jsp" class="back-link"><svg class="icon icon-sm" viewBox="0 0 24 24"><line x1="19" x2="5" y1="12" y2="12"/><polyline points="12 19 5 12 12 5"/></svg> <span>Volver al Menú Principal</span></a>
    </div>
</body>
</html>
