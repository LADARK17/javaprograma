<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ejercicio 3 - c:set y Ámbitos</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Ejercicio 3: Gestión de Ámbitos (Scopes)</h1>
            <p class="subtitle">Uso de c:set con scope page, session y application</p>
        </header>

        <c:set var="variableDePagina" scope="page"> Esta informacion se guarda en la pagina </c:set>
        <c:set var="variableDeSesion" scope="session"> Esta informacion se guarda en la sesion </c:set>
        <c:set var="variableDeAplicacion" scope="application"> Esta informacion se guarda en la aplicacion </c:set>

        <div class="card">
            <h2>Variables Almacenadas</h2>
            <div class="alert alert-success" style="margin-bottom: 0.8rem;">
                <strong>Ámbito Página (Page):</strong> <c:out value="${variableDePagina}"/>
            </div>
            <div class="alert alert-success" style="margin-bottom: 0.8rem;">
                <strong>Ámbito Sesión (Session):</strong> <c:out value="${variableDeSesion}"/>
            </div>
            <div class="alert alert-success">
                <strong>Ámbito Aplicación (Application):</strong> <c:out value="${variableDeAplicacion}"/>
            </div>
        </div>

        <a href="index.jsp" class="back-link">&larr; Volver al Menú Principal</a>
    </div>
</body>
</html>
