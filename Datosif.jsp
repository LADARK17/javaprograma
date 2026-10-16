<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ejercicio 4 - Formulario con Validación</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Ejercicio 4: Control de Flujo con c:if y c:redirect</h1>
            <p class="subtitle">Validación condicional en JSP sin Servlets</p>
        </header>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">
                <strong>Atención:</strong> <c:out value="${param.error}" />
            </div>
        </c:if>

        <div class="card">
            <h2>Ingreso de Nombre (Obligatorio)</h2>
            <form action="Procesarif.jsp" method="get">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" placeholder="Deja vacío para probar la redirección">
                </div>
                <button type="submit" class="btn">Validar con c:if</button>
            </form>
        </div>

        <a href="index.jsp" class="back-link"><svg class="icon icon-sm" viewBox="0 0 24 24"><line x1="19" x2="5" y1="12" y2="12"/><polyline points="12 19 5 12 12 5"/></svg> <span>Volver al Menú Principal</span></a>
    </div>
</body>
</html>
