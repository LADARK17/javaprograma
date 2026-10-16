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
                <svg class="icon" viewBox="0 0 24 24"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/><line x1="12" x2="12" y1="9" y2="13"/><line x1="12" x2="12.01" y1="17" y2="17"/></svg>
                <div>
                    <strong>Error en inserción:</strong> <c:out value="${errorInsert.message}" />
                </div>
            </div>
        </c:if>
        
        <c:if test="${not empty errorSelect}">
            <div class="alert alert-danger">
                <svg class="icon" viewBox="0 0 24 24"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/><line x1="12" x2="12" y1="9" y2="13"/><line x1="12" x2="12.01" y1="17" y2="17"/></svg>
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
                <svg class="icon" viewBox="0 0 24 24"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                <div>
                    <strong>Empleado registrado exitosamente en la base de datos.</strong>
                </div>
            </div>
        </c:if>

        <div class="card">
            <h2>
                <svg class="icon" viewBox="0 0 24 24"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                <span>Registrar Nuevo Empleado</span>
            </h2>
            <form action="Procesarinfo.jsp" method="post" accept-charset="UTF-8">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="nombres">Nombres <span class="required-dot">*</span></label>
                        <input type="text" id="nombres" name="nombres" placeholder="Ej: Carlos Andrés" required>
                    </div>
                    <div class="form-group">
                        <label for="apellido1">Primer Apellido <span class="required-dot">*</span></label>
                        <input type="text" id="apellido1" name="apellido1" placeholder="Ej: Gómez" required>
                    </div>
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="apellido2">Segundo Apellido</label>
                        <input type="text" id="apellido2" name="apellido2" placeholder="Ej: Pérez">
                    </div>
                    <div class="form-group">
                        <label for="edad">Edad <span class="required-dot">*</span></label>
                        <input type="number" id="edad" name="edad" min="1" max="120" placeholder="Ej: 28" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-accent" style="align-self: flex-start;">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
                    <span>Guardar Empleado</span>
                </button>
            </form>
        </div>

        <div class="card">
            <h2>
                <svg class="icon" viewBox="0 0 24 24"><rect width="8" height="4" x="8" y="2" rx="1" ry="1"/><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/><path d="M12 11h4"/><path d="M12 16h4"/><path d="M8 11h.01"/><path d="M8 16h.01"/></svg>
                <span>Lista de Empleados Registrados</span>
            </h2>
            <div class="table-container">
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
        </div>

        <a href="index.jsp" class="back-link">
            <svg class="icon icon-sm" viewBox="0 0 24 24"><line x1="19" x2="5" y1="12" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
            <span>Volver al Menú Principal</span>
        </a>
    </div>
</body>
</html>
