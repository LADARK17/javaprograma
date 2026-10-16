<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 6 - Manejo de Excepciones con c:catch</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <div class="badge-tag">JSTL Core &bull; c:catch</div>
            <h1>Ejercicio 6: Captura de Excepciones</h1>
            <p class="subtitle">Refactorización con Cero Scriptlets (&lt;% %&gt;) y tratamiento robusto de errores</p>
        </header>

        <div class="card">
            <h2>Probar Conversión Numérica</h2>
            <form action="catch.jsp" method="get">
                <div class="form-group">
                    <label for="parametro">Parámetro (Ingrese un número o caracteres alfabéticos para forzar excepción):</label>
                    <input type="text" id="parametro" name="parametro" value="<c:out value="${param.parametro}"/>" placeholder="Ejemplo: 450 (éxito) ó abc (error)">
                </div>
                <div style="display: flex; gap: 0.75rem; flex-wrap: wrap;">
                    <button type="submit" class="btn">
                        <span>⚡</span> Procesar con c:catch
                    </button>
                    <a href="catch.jsp?parametro=999" class="btn btn-secondary">
                        Probar con "999" (Válido)
                    </a>
                    <a href="catch.jsp?parametro=error_test" class="btn btn-secondary">
                        Probar con "error_test" (Forzar Error)
                    </a>
                </div>
            </form>
        </div>

        <c:if test="${not empty param.parametro}">
            <div class="card">
                <h2>Resultado de la Operación</h2>
                <%-- REFACTORIZACIÓN CERO SCRIPTLETS: 
                     En JSTL y EL estándar, forzar la conversión u operación numérica en EL dentro de <c:catch> 
                     dispara NumberFormatException / IllegalArgumentException si no es numérico, 
                     almacenando la excepción en 'error01' sin usar <% %> --%>
                <c:catch var="error01">
                    <c:set var="valor" value="${param.parametro + 0}" />
                    <div class="alert alert-success">
                        <span>✔️</span>
                        <div>
                            <strong>Valor numérico procesado exitosamente:</strong>
                            <span style="font-size: 1.15rem; font-weight: 700; margin-left: 0.35rem;"><c:out value="${valor}" /></span>
                        </div>
                    </div>
                </c:catch>

                <c:if test="${not empty error01}">
                    <div class="alert alert-danger">
                        <span>⚠️</span>
                        <div>
                            <strong>Se produjo un error al convertir el valor:</strong>
                            <div style="margin-top: 0.35rem; font-family: 'JetBrains Mono', monospace; font-size: 0.85rem; opacity: 0.9;">
                                <c:out value="${error01}" />
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </c:if>

        <a href="index.jsp" class="back-link">&larr; Volver al Menú Principal</a>
    </div>
</body>
</html>
