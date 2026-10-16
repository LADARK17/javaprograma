<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laboratorio Corte 2 - JSTL 1.2 Java EE</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <div class="badge-tag">
                <svg class="icon icon-xs" viewBox="0 0 24 24"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
                <span>JSTL 1.2 Java EE</span>
            </div>
            <h1>Portal de Ejercicios Académicos</h1>
            <p class="subtitle">Arquitectura Web Dinámica sin Servlets &bull; Cero Scriptlets (&lt;% %&gt;) &bull; MySQL & JSTL SQL</p>
        </header>

        <div class="card">
            <h2>
                <svg class="icon" viewBox="0 0 24 24"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>
                <span>Ejercicios de la Guía Práctica</span>
            </h2>
            <div class="btn-grid">
                <a href="Eje1.jsp" class="btn">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
                    <span>Ejercicio 1: Expresiones JSTL</span>
                </a>
                <a href="Datos.jsp" class="btn">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><rect width="8" height="4" x="8" y="2" rx="1" ry="1"/><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/><path d="M12 11h4"/><path d="M12 16h4"/><path d="M8 11h.01"/><path d="M8 16h.01"/></svg>
                    <span>Ejercicio 2: Formulario & Parámetros</span>
                </a>
                <a href="set1.jsp" class="btn">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"/><path d="m3.3 7 8.7 5 8.7-5"/><path d="M12 22V12"/></svg>
                    <span>Ejercicio 3: Ámbitos con c:set</span>
                </a>
                <a href="Datosif.jsp" class="btn">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path d="M12 16v-4"/><path d="M12 8h.01"/></svg>
                    <span>Ejercicio 4: Control de Flujo c:if</span>
                </a>
                <a href="ProcesarC2.jsp" class="btn">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><circle cx="18" cy="18" r="3"/><circle cx="6" cy="6" r="3"/><circle cx="18" cy="6" r="3"/><path d="M6 9v12"/><path d="M9 6h6"/><path d="M18 9v6"/></svg>
                    <span>Ejercicio 5: Bifurcación c:choose</span>
                </a>
                <a href="catch.jsp" class="btn">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                    <span>Ejercicio 6: Excepciones c:catch</span>
                </a>
                <a href="foreach.jsp" class="btn">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><polyline points="23 4 23 10 17 10"/><polyline points="1 20 1 14 7 14"/><path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"/></svg>
                    <span>Ejercicio 7: Iteración c:forEach</span>
                </a>
                <a href="ResultTokens.jsp" class="btn">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="m21.44 11.05-9.19 9.19a6 6 0 0 1-8.49-8.49l8.57-8.57A4 4 0 1 1 18 8.84l-8.59 8.57a2 2 0 0 1-2.83-2.83l8.49-8.48"/></svg>
                    <span>Ejercicio 8: Tokens c:forTokens</span>
                </a>
                <a href="supabase.jsp" class="btn btn-accent" style="grid-column: 1 / -1;">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"/></svg>
                    <span>Ejercicio 9: Persistencia con Supabase Cloud (PostgreSQL REST API)</span>
                </a>
            </div>
        </div>

        <div class="card">
            <h2>
                <svg class="icon" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="2" x2="22" y1="12" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>
                <span>Información de Arquitectura y Dependencias</span>
            </h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.2rem; margin-top: 0.5rem;">
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #38bdf8; font-weight: 700; margin-bottom: 0.35rem; display: flex; align-items: center; gap: 0.45rem;">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                        <span>Estándar JSTL 1.2</span>
                    </div>
                    <div style="color: var(--text-muted); font-size: 0.9rem;">
                        Biblioteca <code>jstl-1.2.jar</code> activa en <code>WEB-INF/lib</code> para resolución de etiquetas y flujos.
                    </div>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #10b981; font-weight: 700; margin-bottom: 0.35rem; display: flex; align-items: center; gap: 0.45rem;">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"/></svg>
                        <span>Supabase Cloud &amp; PostgreSQL</span>
                    </div>
                    <div style="color: var(--text-muted); font-size: 0.9rem;">
                        Conexión en la nube a <code>eiowutpdlvsmfxejreyu.supabase.co</code> con REST API y driver PostgreSQL.
                    </div>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #818cf8; font-weight: 700; margin-bottom: 0.35rem; display: flex; align-items: center; gap: 0.45rem;">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><rect width="7" height="9" x="3" y="3" rx="1"/><rect width="7" height="5" x="14" y="3" rx="1"/><rect width="7" height="9" x="14" y="12" rx="1"/><rect width="7" height="5" x="3" y="16" rx="1"/></svg>
                        <span>Conexión Modular JSPF</span>
                    </div>
                    <div style="color: var(--text-muted); font-size: 0.9rem;">
                        Fragmento centralizado en <code>WEB-INF/jspf/conexion.jspf</code> incluido mediante directiva JSPF.
                    </div>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #f59e0b; font-weight: 700; margin-bottom: 0.35rem; display: flex; align-items: center; gap: 0.45rem;">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="4.93" x2="19.07" y1="4.93" y2="19.07"/></svg>
                        <span>Cero Scriptlets</span>
                    </div>
                    <div style="color: var(--text-muted); font-size: 0.9rem;">
                        Código 100% puro en etiquetas JSTL y Expression Language (EL), sin bloques <code>&lt;% %&gt;</code>.
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
