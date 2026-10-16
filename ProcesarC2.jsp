<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ejercicio 5 - c:choose, c:when, c:otherwise</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Ejercicio 5: Bifurcación Múltiple (c:choose)</h1>
            <p class="subtitle">Estructura switch-case con etiquetas nativas JSTL</p>
        </header>

        <div class="card">
            <h2>Seleccionar Lenguaje</h2>
            <form action="ProcesarC2.jsp" method="get">
                <div class="form-group">
                    <label for="lenguaje">Lenguaje de programación:</label>
                    <select id="lenguaje" name="lenguaje">
                        <option value="">-- Seleccione una opción --</option>
                        <option value="Java">Java</option>
                        <option value="C++">C++</option>
                        <option value="Python">Python (Otro)</option>
                    </select>
                </div>
                <button type="submit" class="btn">Evaluar Lenguaje</button>
            </form>
        </div>

        <c:if test="${not empty param.lenguaje or param.lenguaje == ''}">
            <div class="card">
                <h2>Resultado de la Selección</h2>
                <c:choose>
                    <c:when test="${param.lenguaje == 'Java'}">
                        <div class="alert alert-success">Java: El rey de los lenguajes orientados a objetos</div>
                    </c:when>
                    <c:when test="${param.lenguaje == 'C++'}">
                        <div class="alert alert-success">C++: Ideal</div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger">No se seleccionó ninguno</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <a href="index.jsp" class="back-link">&larr; Volver al Menú Principal</a>
    </div>
</body>
</html>
