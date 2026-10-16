<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ejercicio 1 - JSTL Core Out</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Ejercicio 1: Expresiones y c:out</h1>
            <p class="subtitle">Evaluación literal vs Expresión EL con JSTL 1.2</p>
        </header>

        <div class="card">
            <h2>Resultados de Evaluación</h2>
            <p style="margin-bottom: 1rem;">Cadena de caracteres: <strong><c:out value="1+2+3" /></strong></p>
            <p>Suma de valores: <strong><c:out value="${1+2+3}" /></strong></p>
        </div>

        <a href="index.jsp" class="back-link">&larr; Volver al Menú Principal</a>
    </div>
</body>
</html>
