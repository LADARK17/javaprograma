<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty param.nombre}">
    <c:redirect url="Datosif.jsp">
        <c:param name="error" value="Nombre obligatorio"/>
    </c:redirect>
</c:if>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ejercicio 4 - Validación Exitosa</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Ejercicio 4: Validación Superada</h1>
        </header>

        <div class="card">
            <div class="alert alert-success">
                <strong>¡Éxito!</strong> El parámetro 'nombre' no estaba vacío.
            </div>
            <p>Nombre ingresado: <strong><c:out value="${param.nombre}" /></strong></p>
        </div>

        <div style="display: flex; gap: 1rem;">
            <a href="Datosif.jsp" class="btn btn-secondary">&larr; Volver a Probar</a>
            <a href="index.jsp" class="btn btn-secondary">Menú Principal</a>
        </div>
    </div>
</body>
</html>
