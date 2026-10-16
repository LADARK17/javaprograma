<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ejercicio 7 - Iteraciones con c:forEach</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Ejercicio 7: Iteraciones con c:forEach</h1>
            <p class="subtitle">Control de bucles y metadatos con varStatus</p>
        </header>

        <div class="card">
            <h2>Secuencia del 1 al 24 (Paso 2)</h2>
            <table>
                <thead>
                    <tr>
                        <th>Hora / Valor</th>
                        <th>Estado / Mensaje Especial</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach begin="1" end="24" step="2" var="hour" varStatus="status">
                        <tr>
                            <td><strong><c:out value="${hour}" /></strong></td>
                            <td>
                                <c:if test="${status.first}">
                                    <span style="color: #38bdf8; font-weight: bold;">Estoy en uno</span>
                                </c:if>
                                <c:if test="${status.count == 5}">
                                    <span style="color: #a855f7; font-weight: bold;">Estoy en la iteración número 5</span>
                                </c:if>
                                <c:if test="${not status.first and status.count != 5}">
                                    <span style="color: #64748b;">Iteración ${status.count}</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <a href="index.jsp" class="back-link">&larr; Volver al Menú Principal</a>
    </div>
</body>
</html>
