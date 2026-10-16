<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>
<fmt:requestEncoding value="UTF-8" />

<%-- Inserción de registro 100% con etiquetas JSTL SQL (Cero Scriptlets <% %>, Cero Servlets) --%>
<c:if test="${not empty param.nombres and not empty param.apellido1 and not empty param.apellido2 and not empty param.edad}">
    <c:set var="nombres" value="${param.nombres}"/>
    <c:set var="apellido1" value="${param.apellido1}"/>
    <c:set var="apellido2" value="${param.apellido2}"/>
    <c:set var="edad" value="${param.edad}"/>

    <c:catch var="errorInsert">
        <sql:update var="insertar" dataSource="${empleados}">
            insert into empleados (nombres, apellido1, apellido2, edad) values (?,?,?,?)
            <sql:param value="${nombres}"/>
            <sql:param value="${apellido1}"/>
            <sql:param value="${apellido2}"/>
            <sql:param value="${edad}"/>
        </sql:update>
    </c:catch>
</c:if>

<%-- Consulta de registros de empleados con JSTL <sql:query> --%>
<c:catch var="errorSelect">
    <sql:query var="result" scope="request" dataSource="${empleados}">
        select * from empleados order by id asc;
    </sql:query>
</c:catch>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 9 - Base de Datos con JSTL SQL</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <div class="badge-tag">JSTL SQL &bull; Cero Scriptlets &bull; Cero Servlets</div>
            <h1>Ejercicio 9: Base de Datos con JSTL SQL</h1>
            <p class="subtitle">Persistencia y lectura directa mediante &lt;sql:update&gt; y &lt;sql:query&gt;</p>
        </header>

        <%-- Notificaciones de error o éxito con JSTL Core --%>
        <c:if test="${not empty errorInsert}">
            <div class="alert alert-danger">
                <span>⚠️</span>
                <div>
                    <strong>Error en inserción:</strong> <c:out value="${errorInsert.message}" />
                </div>
            </div>
        </c:if>
        
        <c:if test="${not empty errorSelect}">
            <div class="alert alert-danger">
                <span>⚠️</span>
                <div>
                    <strong>Error al consultar base de datos:</strong> <c:out value="${errorSelect.message}" />
                    <p style="font-size: 0.85rem; margin-top: 0.4rem; opacity: 0.9;">
                        Asegúrese de haber iniciado el servicio MySQL (XAMPP) y creado la base de datos <code>database.sql</code>.
                    </p>
                </div>
            </div>
        </c:if>
        
        <c:if test="${insertar > 0}">
            <div class="alert alert-success">
                <span>🎉</span>
                <div>
                    <strong>¡Empleado registrado exitosamente en la base de datos!</strong>
                </div>
            </div>
        </c:if>

        <div class="card">
            <h2>Registrar Nuevo Empleado</h2>
            <form action="Procesarinfo.jsp" method="post" accept-charset="UTF-8">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                    <div class="form-group">
                        <label for="nombres">Nombres:</label>
                        <input type="text" id="nombres" name="nombres" placeholder="Ej: Carlos Andrés" required>
                    </div>
                    <div class="form-group">
                        <label for="apellido1">Primer Apellido:</label>
                        <input type="text" id="apellido1" name="apellido1" placeholder="Ej: Gómez" required>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                    <div class="form-group">
                        <label for="apellido2">Segundo Apellido:</label>
                        <input type="text" id="apellido2" name="apellido2" placeholder="Ej: Pérez" required>
                    </div>
                    <div class="form-group">
                        <label for="edad">Edad:</label>
                        <input type="number" id="edad" name="edad" min="1" max="120" placeholder="Ej: 28" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-accent" style="align-self: flex-start;">
                    <span>💾</span> Guardar Empleado
                </button>
            </form>
        </div>

        <div class="card">
            <h2>Lista de Empleados Registrados</h2>
            <table>
                <thead>
                    <tr>
                        <th style="width: 80px;">ID</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th style="width: 100px;">Edad</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="fila" items="${result.rows}">
                        <tr>
                            <td><span style="font-weight: 700; color: #818cf8;">#<c:out value="${fila.id}" /></span></td>
                            <td><c:out value="${fila.nombres}" /></td>
                            <td><c:out value="${fila.apellido1} ${fila.apellido2}" /></td>
                            <td><span class="token-chip" style="padding: 0.25rem 0.65rem; font-size: 0.85rem;"><c:out value="${fila.edad}" /> años</span></td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty result.rows}">
                        <tr>
                            <td colspan="4" style="text-align: center; color: var(--text-muted); padding: 2rem 1rem;">
                                No hay empleados registrados en la tabla aún.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <a href="index.jsp" class="back-link">&larr; Volver al Menú Principal</a>
    </div>
</body>
</html>
