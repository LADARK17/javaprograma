<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal de Ejercicios Académicos - JSTL 1.2</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <!-- Encabezado Principal -->
        <header>
            <div class="badge-tag">
                <span class="pulse-dot"></span>
                <span>Laboratorio Web &bull; JSTL 1.2 Java EE</span>
            </div>
            <h1>Portal de Ejercicios Académicos</h1>
            <p class="subtitle">
                Arquitectura web dinámica sin servlets ni scriptlets (&lt;% %&gt;), con etiquetas JSTL puras,
                persistencia en Supabase Cloud y base de datos relacional.
            </p>
        </header>

        <!-- Módulo de Ejercicios Prácticos -->
        <div class="card">
            <h2>
                <svg class="icon" viewBox="0 0 24 24"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>
                <span>Ejercicios de la Guía Práctica</span>
            </h2>

            <div class="exercises-grid">
                <!-- Ejercicio 1 -->
                <a href="Eje1.jsp" class="exercise-item">
                    <div class="exercise-content">
                        <div class="exercise-icon-box c-indigo">
                            <svg class="icon icon-md" viewBox="0 0 24 24"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
                        </div>
                        <div class="exercise-text">
                            <span class="exercise-title">Ejercicio 1: Expresiones JSTL</span>
                            <span class="exercise-desc">Sintaxis estándar de Expression Language (EL)</span>
                        </div>
                    </div>
                    <svg class="icon icon-sm exercise-arrow" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>

                <!-- Ejercicio 2 -->
                <a href="Datos.jsp" class="exercise-item">
                    <div class="exercise-content">
                        <div class="exercise-icon-box c-sky">
                            <svg class="icon icon-md" viewBox="0 0 24 24"><rect width="8" height="4" x="8" y="2" rx="1" ry="1"/><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/><path d="M12 11h4"/><path d="M12 16h4"/><path d="M8 11h.01"/><path d="M8 16h.01"/></svg>
                        </div>
                        <div class="exercise-text">
                            <span class="exercise-title">Ejercicio 2: Formulario & Parámetros</span>
                            <span class="exercise-desc">Captura y procesamiento con param</span>
                        </div>
                    </div>
                    <svg class="icon icon-sm exercise-arrow" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>

                <!-- Ejercicio 3 -->
                <a href="set1.jsp" class="exercise-item">
                    <div class="exercise-content">
                        <div class="exercise-icon-box c-violet">
                            <svg class="icon icon-md" viewBox="0 0 24 24"><path d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"/><path d="m3.3 7 8.7 5 8.7-5"/><path d="M12 22V12"/></svg>
                        </div>
                        <div class="exercise-text">
                            <span class="exercise-title">Ejercicio 3: Ámbitos con c:set</span>
                            <span class="exercise-desc">Variables en page, request y session</span>
                        </div>
                    </div>
                    <svg class="icon icon-sm exercise-arrow" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>

                <!-- Ejercicio 4 -->
                <a href="Datosif.jsp" class="exercise-item">
                    <div class="exercise-content">
                        <div class="exercise-icon-box c-amber">
                            <svg class="icon icon-md" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="12" x2="12" y1="8" y2="12"/><line x1="12" x2="12.01" y1="16" y2="16"/></svg>
                        </div>
                        <div class="exercise-text">
                            <span class="exercise-title">Ejercicio 4: Control de Flujo c:if</span>
                            <span class="exercise-desc">Condicionales lógicas y validaciones</span>
                        </div>
                    </div>
                    <svg class="icon icon-sm exercise-arrow" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>

                <!-- Ejercicio 5 -->
                <a href="ProcesarC2.jsp" class="exercise-item">
                    <div class="exercise-content">
                        <div class="exercise-icon-box c-rose">
                            <svg class="icon icon-md" viewBox="0 0 24 24"><circle cx="18" cy="18" r="3"/><circle cx="6" cy="6" r="3"/><circle cx="18" cy="6" r="3"/><path d="M6 9v12"/><path d="M9 6h6"/><path d="M18 9v6"/></svg>
                        </div>
                        <div class="exercise-text">
                            <span class="exercise-title">Ejercicio 5: Bifurcación c:choose</span>
                            <span class="exercise-desc">Estructuras when y otherwise múltiples</span>
                        </div>
                    </div>
                    <svg class="icon icon-sm exercise-arrow" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>

                <!-- Ejercicio 6 -->
                <a href="catch.jsp" class="exercise-item">
                    <div class="exercise-content">
                        <div class="exercise-icon-box c-emerald">
                            <svg class="icon icon-md" viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                        </div>
                        <div class="exercise-text">
                            <span class="exercise-title">Ejercicio 6: Excepciones c:catch</span>
                            <span class="exercise-desc">Gestión robusta y aislamiento de errores</span>
                        </div>
                    </div>
                    <svg class="icon icon-sm exercise-arrow" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>

                <!-- Ejercicio 7 -->
                <a href="foreach.jsp" class="exercise-item">
                    <div class="exercise-content">
                        <div class="exercise-icon-box c-cyan">
                            <svg class="icon icon-md" viewBox="0 0 24 24"><polyline points="23 4 23 10 17 10"/><polyline points="1 20 1 14 7 14"/><path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"/></svg>
                        </div>
                        <div class="exercise-text">
                            <span class="exercise-title">Ejercicio 7: Iteración c:forEach</span>
                            <span class="exercise-desc">Ciclos con step, begin, end y colecciones</span>
                        </div>
                    </div>
                    <svg class="icon icon-sm exercise-arrow" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>

                <!-- Ejercicio 8 -->
                <a href="ResultTokens.jsp" class="exercise-item">
                    <div class="exercise-content">
                        <div class="exercise-icon-box c-pink">
                            <svg class="icon icon-md" viewBox="0 0 24 24"><path d="m21.44 11.05-9.19 9.19a6 6 0 0 1-8.49-8.49l8.57-8.57A4 4 0 1 1 18 8.84l-8.59 8.57a2 2 0 0 1-2.83-2.83l8.49-8.48"/></svg>
                        </div>
                        <div class="exercise-text">
                            <span class="exercise-title">Ejercicio 8: Tokens c:forTokens</span>
                            <span class="exercise-desc">Segmentación de cadenas por delimitador</span>
                        </div>
                    </div>
                    <svg class="icon icon-sm exercise-arrow" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>

                <!-- Ejercicio 9: Flagship Supabase Cloud (Destacado) -->
                <a href="supabase.jsp" class="exercise-featured">
                    <div class="exercise-content">
                        <div class="exercise-icon-box">
                            <svg class="icon icon-lg" viewBox="0 0 24 24"><path d="M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"/></svg>
                        </div>
                        <div class="exercise-text">
                            <span class="exercise-title">
                                <span>Ejercicio 9: Persistencia con Supabase Cloud</span>
                                <span class="featured-pill">PostgreSQL Cloud</span>
                            </span>
                            <span class="exercise-desc">
                                CRUD en tiempo real con API REST oficial, sin servlets y diseño responsive.
                            </span>
                        </div>
                    </div>
                    <div class="exercise-arrow">
                        <span>Explorar</span>
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                    </div>
                </a>
            </div>
        </div>

        <!-- Módulo de Arquitectura (Grilla 2x2 Simétrica y Equilibrada) -->
        <div class="card">
            <h2>
                <svg class="icon" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="2" x2="22" y1="12" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>
                <span>Arquitectura y Entorno de Ejecución</span>
            </h2>

            <div class="arch-grid">
                <!-- Tarjeta 1 -->
                <div class="arch-card">
                    <div class="arch-header" style="color: #38bdf8;">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                        <span>Estándar JSTL 1.2</span>
                    </div>
                    <p class="arch-desc">
                        Biblioteca <code>jstl-1.2.jar</code> cargada en <code>WEB-INF/lib</code> para resolución declarativa de flujos y control de vistas.
                    </p>
                </div>

                <!-- Tarjeta 2 -->
                <div class="arch-card">
                    <div class="arch-header" style="color: #34d399;">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"/></svg>
                        <span>Supabase Cloud PostgreSQL</span>
                    </div>
                    <p class="arch-desc">
                        Conexión en la nube a <code>eiowutpdlvsmfxejreyu.supabase.co</code> con políticas de seguridad RLS y SDK REST oficial.
                    </p>
                </div>

                <!-- Tarjeta 3 -->
                <div class="arch-card">
                    <div class="arch-header" style="color: #a78bfa;">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><rect width="7" height="9" x="3" y="3" rx="1"/><rect width="7" height="5" x="14" y="3" rx="1"/><rect width="7" height="9" x="14" y="12" rx="1"/><rect width="7" height="5" x="3" y="16" rx="1"/></svg>
                        <span>Conexión Modular JSPF</span>
                    </div>
                    <p class="arch-desc">
                        Fragmento centralizado en <code>WEB-INF/jspf/conexion.jspf</code> reutilizable mediante directivas de inclusión estática.
                    </p>
                </div>

                <!-- Tarjeta 4 -->
                <div class="arch-card">
                    <div class="arch-header" style="color: #fbbf24;">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="4.93" x2="19.07" y1="4.93" y2="19.07"/></svg>
                        <span>Cero Scriptlets (&lt;% %&gt;)</span>
                    </div>
                    <p class="arch-desc">
                        Código 100% puro en etiquetas JSTL y Expression Language (EL), garantizando separación estricta de responsabilidades.
                    </p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
