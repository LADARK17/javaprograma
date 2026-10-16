<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%-- Inserción de registro con Supabase API REST (Fallback a MySQL si falla) --%>
<c:if test="${not empty param.nombres and not empty param.apellido1 and not empty param.apellido2 and not empty param.edad}">
    <c:set var="nombres" value="${param.nombres}"/>
    <c:set var="apellido1" value="${param.apellido1}"/>
    <c:set var="apellido2" value="${param.apellido2}"/>
    <c:set var="edad" value="${param.edad}"/>

    <c:catch var="errorInsert">
        <%
            String nom = request.getParameter("nombres");
            String ap1 = request.getParameter("apellido1");
            String ap2 = request.getParameter("apellido2");
            int ed = Integer.parseInt(request.getParameter("edad"));
            boolean exito = com.ejercicio.supabase.SupabaseClient.insertarEmpleado(nom, ap1, ap2, ed);
            request.setAttribute("insertarExito", exito);
        %>
    </c:catch>

    <%-- Si la inserción HTTP en Supabase arroja error, intentamos con DataSource local --%>
    <c:if test="${not empty errorInsert and not empty empleados}">
        <c:catch var="errorInsertLocal">
            <sql:update var="insertarLocal" dataSource="${empleados}">
                insert into empleados (nombres, apellido1, apellido2, edad) values (?,?,?,?)
                <sql:param value="${nombres}"/>
                <sql:param value="${apellido1}"/>
                <sql:param value="${apellido2}"/>
                <sql:param value="${edad}"/>
            </sql:update>
        </c:catch>
    </c:if>
</c:if>

<%-- Consulta de registros de empleados desde Supabase Cloud --%>
<c:catch var="errorSelect">
    <%
        java.util.List<java.util.Map<String, Object>> lista = com.ejercicio.supabase.SupabaseClient.getEmpleados();
        request.setAttribute("listaEmpleados", lista);
    %>
</c:catch>

<%-- Fallback a MySQL local si falla Supabase o no hay conexión a internet --%>
<c:if test="${not empty errorSelect and not empty empleados}">
    <c:catch var="errorSelectLocal">
        <sql:query var="resultLocal" scope="request" dataSource="${empleados}">
            select * from empleados;
        </sql:query>
    </c:catch>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 9 - Base de Datos Supabase Cloud & JSTL</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <div class="badge-tag">☁️ Supabase Cloud &bull; PostgreSQL REST API</div>
            <h1>Ejercicio 9: Base de Datos con Supabase Cloud</h1>
            <p class="subtitle">Conexión en la nube con API REST de Supabase &amp; Soporte Híbrido JSTL SQL</p>
        </header>

        <%-- Notificaciones de error o éxito --%>
        <c:if test="${not empty errorInsert and not empty errorInsertLocal}">
            <div class="alert alert-danger">
                <span>⚠️</span>
                <div>
                    <strong>Error en inserción:</strong> <c:out value="${errorInsert.message}" />
                </div>
            </div>
        </c:if>
        
        <c:if test="${not empty errorSelect and not empty errorSelectLocal}">
            <div class="alert alert-danger">
                <span>⚠️</span>
                <div>
                    <strong>Error al consultar base de datos:</strong> <c:out value="${errorSelect.message}" />
                    <p style="font-size: 0.85rem; margin-top: 0.4rem; opacity: 0.9;">
                        Verifique la conectividad de red con Supabase (<code>https://fzxikusnodngkvlztrgv.supabase.co</code>).
                    </p>
                </div>
            </div>
        </c:if>
        
        <c:if test="${insertarExito == true or insertarLocal > 0}">
            <div class="alert alert-success">
                <span>🎉</span>
                <div>
                    <strong>¡Empleado registrado exitosamente en la base de datos de Supabase!</strong>
                </div>
            </div>
        </c:if>

        <div class="card">
            <h2>Registrar Nuevo Empleado en Supabase</h2>
            <form action="Procesarinfo.jsp" method="post">
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
                    <span>💾</span> Guardar Empleado en Supabase
                </button>
            </form>
        </div>

        <div class="card">
            <h2>Lista de Empleados Registrados (Supabase Cloud)</h2>
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
                    <%-- Iteración sobre lista de Supabase --%>
                    <c:forEach var="fila" items="${listaEmpleados}">
                        <tr>
                            <td><span style="font-weight: 700; color: #818cf8;">#<c:out value="${fila.id}" /></span></td>
                            <td><c:out value="${fila.nombres}" /></td>
                            <td><c:out value="${fila.apellido1} ${fila.apellido2}" /></td>
                            <td><span class="token-chip" style="padding: 0.25rem 0.65rem; font-size: 0.85rem;"><c:out value="${fila.edad}" /> años</span></td>
                        </tr>
                    </c:forEach>
                    
                    <%-- Si se usó fallback local --%>
                    <c:if test="${empty listaEmpleados and not empty resultLocal.rows}">
                        <c:forEach var="fila" items="${resultLocal.rows}">
                            <tr>
                                <td><span style="font-weight: 700; color: #818cf8;">#<c:out value="${fila.id}" /></span></td>
                                <td><c:out value="${fila.nombres}" /></td>
                                <td><c:out value="${fila.apellido1} ${fila.apellido2}" /></td>
                                <td><span class="token-chip" style="padding: 0.25rem 0.65rem; font-size: 0.85rem;"><c:out value="${fila.edad}" /> años</span></td>
                            </tr>
                        </c:forEach>
                    </c:if>

                    <c:if test="${empty listaEmpleados and empty resultLocal.rows}">
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
