<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="UTF-8" />
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ejercicio 2 - Procesar Datos</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Ejercicio 2: Parámetros Recibidos</h1>
            <p class="subtitle">Lectura directa de request.getParameter con param y c:out</p>
        </header>

        <div class="card">
            <h2>Información Procesada</h2>
            <p style="margin-bottom: 0.8rem;">Nombre: <strong><c:out value="${param.nombre}" /></strong></p>
            <p style="margin-bottom: 0.8rem;">Primer apellido: <strong><c:out value="${param.apellido1}" /></strong></p>
            <p>Segundo apellido: <strong><c:out value="${param.apellido2}" /></strong></p>
        </div>

        <div style="display: flex; gap: 1rem;">
            <a href="Datos.jsp" class="btn btn-secondary">&larr; Volver al Formulario</a>
            <a href="index.jsp" class="btn btn-secondary">Menú Principal</a>
        </div>
    </div>
</body>
</html>
