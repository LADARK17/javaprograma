<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ejercicio 2 - Captura de Datos</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Ejercicio 2: Captura de Datos</h1>
            <p class="subtitle">Envío de parámetros HTTP por método POST a ProcesarC.jsp</p>
        </header>

        <div class="card">
            <h2>Formulario de Persona</h2>
            <form action="ProcesarC.jsp" name="persona" method="post">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" placeholder="Ingrese nombres" required>
                </div>
                <div class="form-group">
                    <label for="apellido1">Primer Apellido:</label>
                    <input type="text" id="apellido1" name="apellido1" placeholder="Primer apellido" required>
                </div>
                <div class="form-group">
                    <label for="apellido2">Segundo Apellido:</label>
                    <input type="text" id="apellido2" name="apellido2" placeholder="Segundo apellido" required>
                </div>
                <button type="submit" class="btn">Enviar Informacion</button>
            </form>
        </div>

        <a href="index.jsp" class="back-link"><svg class="icon icon-sm" viewBox="0 0 24 24"><line x1="19" x2="5" y1="12" y2="12"/><polyline points="12 19 5 12 12 5"/></svg> <span>Volver al Menú Principal</span></a>
    </div>
</body>
</html>
