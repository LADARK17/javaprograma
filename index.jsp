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
            <div class="badge-tag">JSTL 1.2</div>
            <h1>Portal de Ejercicios Académicos</h1>
            <p class="subtitle">Arquitectura Web Dinámica sin Servlets &bull; Cero Scriptlets (&lt;% %&gt;) &bull; MySQL & JSTL SQL</p>
        </header>

        <div class="card">
            <h2>Ejercicios de la Guía Práctica</h2>
            <div class="btn-grid">
                <a href="Eje1.jsp" class="btn">
                    <span>⚡</span> Ejercicio 1: Expresiones JSTL
                </a>
                <a href="Datos.jsp" class="btn">
                    <span>📋</span> Ejercicio 2: Formulario & Parámetros
                </a>
                <a href="set1.jsp" class="btn">
                    <span>📦</span> Ejercicio 3: Ámbitos con c:set
                </a>
                <a href="Datosif.jsp" class="btn">
                    <span>🚦</span> Ejercicio 4: Control de Flujo c:if
                </a>
                <a href="ProcesarC2.jsp" class="btn">
                    <span>🔀</span> Ejercicio 5: Bifurcación c:choose
                </a>
                <a href="catch.jsp" class="btn">
                    <span>🛡️</span> Ejercicio 6: Excepciones c:catch
                </a>
                <a href="foreach.jsp" class="btn">
                    <span>🔁</span> Ejercicio 7: Iteración c:forEach
                </a>
                <a href="ResultTokens.jsp" class="btn">
                    <span>🧩</span> Ejercicio 8: Tokens c:forTokens
                </a>
                <a href="supabase.jsp" class="btn btn-accent" style="grid-column: 1 / -1;">
                    <span>☁️</span> Ejercicio 9: Persistencia con Supabase Cloud (PostgreSQL REST API)
                </a>
            </div>
        </div>

        <div class="card">
            <h2>Información de Arquitectura y Dependencias</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.2rem; margin-top: 0.5rem;">
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #38bdf8; font-weight: 700; margin-bottom: 0.35rem;">✨ Estándar JSTL 1.2</div>
                    <div style="color: var(--text-muted); font-size: 0.9rem;">
                        Biblioteca <code>jstl-1.2.jar</code> activa en <code>WEB-INF/lib</code> para resolución de etiquetas y flujos.
                    </div>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #10b981; font-weight: 700; margin-bottom: 0.35rem;">☁️ Supabase Cloud &amp; PostgreSQL</div>
                    <div style="color: var(--text-muted); font-size: 0.9rem;">
                        Conexión en la nube a <code>fzxikusnodngkvlztrgv.supabase.co</code> con REST API y driver PostgreSQL.
                    </div>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #a855f7; font-weight: 700; margin-bottom: 0.35rem;">🧩 Conexión Modular JSPF</div>
                    <div style="color: var(--text-muted); font-size: 0.9rem;">
                        Fragmento centralizado en <code>WEB-INF/jspf/conexion.jspf</code> incluido mediante directiva JSPF.
                    </div>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #f59e0b; font-weight: 700; margin-bottom: 0.35rem;">🚫 Cero Scriptlets</div>
                    <div style="color: var(--text-muted); font-size: 0.9rem;">
                        Código 100% puro en etiquetas JSTL y Expression Language (EL), sin bloques <code>&lt;% %&gt;</code>.
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
