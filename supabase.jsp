<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="UTF-8" />
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Persistencia Supabase Cloud - JSTL & SDK</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- Cliente oficial Supabase local y fallback CDN -->
    <script src="js/supabase.js"></script>
    <script>
        if (!window.supabase) {
            document.write('<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"><\/script>');
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- Encabezado Principal -->
        <header>
            <div class="badge-tag">
                <svg class="icon icon-xs" viewBox="0 0 24 24"><path d="M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"/></svg>
                <span>Supabase Cloud &bull; Cero Servlets &bull; Cero Scriptlets</span>
            </div>
            <h1>Persistencia con Supabase Cloud</h1>
            <p class="subtitle">
                Conexión directa a PostgreSQL en tiempo real mediante API REST y SDK oficial.
                Interfaz corporativa sin emojis con iconografía vectorial de alta precisión.
            </p>
        </header>

        <!-- Contenedor de Alertas Dinámicas -->
        <div id="alertBox"></div>

        <!-- Métricas y Estadísticas en Vivo -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon primary">
                    <svg class="icon icon-md" viewBox="0 0 24 24">
                        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                        <circle cx="9" cy="7" r="4"/>
                        <path d="M22 21v-2a4 4 0 0 0-3-3.87"/>
                        <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                    </svg>
                </div>
                <div class="stat-info">
                    <span class="stat-value" id="statTotal">--</span>
                    <span class="stat-label">Total Empleados</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon accent">
                    <svg class="icon icon-md" viewBox="0 0 24 24">
                        <rect width="18" height="18" x="3" y="4" rx="2" ry="2"/>
                        <line x1="16" x2="16" y1="2" y2="6"/>
                        <line x1="8" x2="8" y1="2" y2="6"/>
                        <line x1="3" x2="21" y1="10" y2="10"/>
                    </svg>
                </div>
                <div class="stat-info">
                    <span class="stat-value" id="statPromedio">--</span>
                    <span class="stat-label">Edad Promedio</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon info">
                    <svg class="icon icon-md" viewBox="0 0 24 24">
                        <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
                    </svg>
                </div>
                <div class="stat-info">
                    <span class="stat-value" id="statUltimo">--</span>
                    <span class="stat-label">Último Ingreso</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon warning">
                    <svg class="icon icon-md" viewBox="0 0 24 24">
                        <ellipse cx="12" cy="5" rx="9" ry="3"/>
                        <path d="M3 5V19A9 3 0 0 0 21 19V5"/>
                        <path d="M3 12A9 3 0 0 0 21 12"/>
                    </svg>
                </div>
                <div class="stat-info">
                    <span class="stat-value" style="font-size: 1.15rem; color: #34d399;" id="statConexion">Activo</span>
                    <span class="stat-label">PostgreSQL Cloud</span>
                </div>
            </div>
        </div>

        <!-- Formulario de Registro de Nuevo Empleado -->
        <div class="card">
            <h2>
                <svg class="icon" viewBox="0 0 24 24"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                <span>Registrar Nuevo Empleado</span>
            </h2>
            <form id="formEmpleado" onsubmit="guardarEmpleado(event)">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="nombres">Nombres <span class="required-dot">*</span></label>
                        <input type="text" id="nombres" name="nombres" placeholder="Ej: Carlos Andrés" required autocomplete="given-name">
                    </div>
                    <div class="form-group">
                        <label for="apellido1">Primer Apellido <span class="required-dot">*</span></label>
                        <input type="text" id="apellido1" name="apellido1" placeholder="Ej: Gómez" required autocomplete="family-name">
                    </div>
                    <div class="form-group">
                        <label for="apellido2">Segundo Apellido</label>
                        <input type="text" id="apellido2" name="apellido2" placeholder="Ej: Pérez" autocomplete="additional-name">
                    </div>
                    <div class="form-group">
                        <label for="edad">Edad <span class="required-dot">*</span></label>
                        <input type="number" id="edad" name="edad" min="1" max="120" placeholder="Ej: 28" required>
                    </div>
                </div>

                <div style="display: flex; gap: 0.75rem; flex-wrap: wrap; align-items: center; margin-top: 0.5rem;">
                    <button type="submit" id="btnGuardar" class="btn btn-accent">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
                        <span>Guardar en Supabase</span>
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="cargarEmpleados()">
                        <svg id="syncIcon" class="icon icon-sm" viewBox="0 0 24 24"><path d="M21 12a9 9 0 0 0-9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"/><path d="M3 3v5h5"/><path d="M3 12a9 9 0 0 0 9 9 9.75 9.75 0 0 0 6.74-2.74L21 16"/><path d="M16 21h5v-5"/></svg>
                        <span>Sincronizar</span>
                    </button>
                </div>
            </form>
        </div>

        <!-- Tabla de Registros en Supabase -->
        <div class="card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.15rem; flex-wrap: wrap; gap: 0.75rem;">
                <h2 style="margin: 0; border: none; padding: 0;">
                    <svg class="icon" viewBox="0 0 24 24"><rect width="8" height="4" x="8" y="2" rx="1" ry="1"/><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/><path d="M12 11h4"/><path d="M12 16h4"/><path d="M8 11h.01"/><path d="M8 16h.01"/></svg>
                    <span>Lista de Empleados en Supabase Cloud</span>
                </h2>
                <div id="statusIndicator" class="live-status connected">
                    <span class="pulse-dot"></span>
                    <span>Conectado a PostgreSQL</span>
                </div>
            </div>

            <!-- Toolbar: Búsqueda, Filtro y Exportación -->
            <div class="toolbar">
                <div class="toolbar-search">
                    <svg class="icon icon-sm search-icon" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><line x1="21" x2="16.65" y1="21" y2="16.65"/></svg>
                    <input type="search" id="busquedaInput" placeholder="Buscar por nombre o apellido..." oninput="filtrarEmpleados()">
                </div>
                <div class="toolbar-actions">
                    <select id="ordenSelect" onchange="aplicarOrden()" style="width: auto; min-width: 170px; padding: 0.6rem 0.9rem; font-size: 0.88rem;">
                        <option value="id_asc">Ordenar por: ID (Asc)</option>
                        <option value="id_desc">Ordenar por: ID (Desc)</option>
                        <option value="nombre_asc">Nombres (A-Z)</option>
                        <option value="edad_asc">Edad (Menor a Mayor)</option>
                        <option value="edad_desc">Edad (Mayor a Menor)</option>
                    </select>
                    <button type="button" class="btn btn-secondary btn-sm" onclick="exportarCSV()" title="Descargar como CSV">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" x2="12" y1="15" y2="3"/></svg>
                        <span>Exportar CSV</span>
                    </button>
                </div>
            </div>

            <!-- Contenedor scrollable responsivo de la tabla -->
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 70px;">ID</th>
                            <th>Empleado</th>
                            <th>Apellidos</th>
                            <th style="width: 130px;">Edad</th>
                            <th style="width: 120px; text-align: center;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="tablaCuerpo">
                        <tr>
                            <td colspan="5" style="text-align: center; color: var(--text-muted); padding: 2.5rem 1rem;">
                                <span>Cargando registros desde Supabase...</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Detalles de Conexión del Proyecto Activo -->
        <div class="card">
            <h2>
                <svg class="icon" viewBox="0 0 24 24"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>
                <span>Configuración de Proyecto Supabase</span>
            </h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 1rem; font-size: 0.9rem;">
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #38bdf8; font-weight: 700; margin-bottom: 0.35rem;">Supabase Project URL</div>
                    <code style="word-break: break-all; color: var(--text-muted);">https://eiowutpdlvsmfxejreyu.supabase.co</code>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #10b981; font-weight: 700; margin-bottom: 0.35rem;">Anon Public Key</div>
                    <code style="word-break: break-all; color: var(--text-muted); font-size: 0.8rem;">eyJhbGci...Nyu30</code>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #818cf8; font-weight: 700; margin-bottom: 0.35rem;">Cumplimiento Académico</div>
                    <span style="color: var(--text-muted);">0 Servlets &bull; 0 Scriptlets (&lt;% %&gt;) &bull; 100% Puro</span>
                </div>
            </div>
        </div>

        <!-- Enlace al Menú Principal -->
        <a href="index.jsp" class="back-link">
            <svg class="icon icon-sm" viewBox="0 0 24 24"><line x1="19" x2="5" y1="12" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
            <span>Volver al Menú Principal</span>
        </a>
    </div>

    <!-- Modal para Edición de Empleado -->
    <div id="modalEditar" class="modal-overlay">
        <div class="modal-card">
            <div class="modal-header">
                <h3>
                    <svg class="icon" viewBox="0 0 24 24"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"/></svg>
                    <span>Editar Empleado</span>
                </h3>
                <button type="button" class="modal-close" onclick="cerrarModalEditar()" title="Cerrar modal">
                    <svg class="icon icon-sm" viewBox="0 0 24 24"><line x1="18" x2="6" y1="6" y2="18"/><line x1="6" x2="18" y1="6" y2="18"/></svg>
                </button>
            </div>
            <form id="formEditar" onsubmit="guardarEdicionEmpleado(event)">
                <input type="hidden" id="edit_id">
                <div class="form-group">
                    <label for="edit_nombres">Nombres <span class="required-dot">*</span></label>
                    <input type="text" id="edit_nombres" required>
                </div>
                <div class="form-group">
                    <label for="edit_apellido1">Primer Apellido <span class="required-dot">*</span></label>
                    <input type="text" id="edit_apellido1" required>
                </div>
                <div class="form-group">
                    <label for="edit_apellido2">Segundo Apellido</label>
                    <input type="text" id="edit_apellido2">
                </div>
                <div class="form-group">
                    <label for="edit_edad">Edad <span class="required-dot">*</span></label>
                    <input type="number" id="edit_edad" min="1" max="120" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="cerrarModalEditar()">Cancelar</button>
                    <button type="submit" id="btnGuardarEdit" class="btn btn-accent">
                        <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
                        <span>Guardar Cambios</span>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Script de Integración con Supabase Cloud -->
    <script>
        const SUPABASE_URL = "https://eiowutpdlvsmfxejreyu.supabase.co";
        const SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVpb3d1dHBkbHZzbWZ4ZWpyZXl1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTIxNzIwNzAsImV4cCI6MjEwNzc0ODA3MH0.wpyZ1Uygh4WtH3xoBFR6JYI8gPn534dWsDxwdfNyu30";

        const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

        let todosLosEmpleados = [];

        function mostrarAlerta(tipo, mensaje) {
            const box = document.getElementById("alertBox");
            let iconSvg = '';
            if (tipo === "success") {
                iconSvg = '<svg class="icon" viewBox="0 0 24 24"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>';
            } else if (tipo === "danger") {
                iconSvg = '<svg class="icon" viewBox="0 0 24 24"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/><line x1="12" x2="12" y1="9" y2="13"/><line x1="12" x2="12.01" y1="17" y2="17"/></svg>';
            } else {
                iconSvg = '<svg class="icon" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="12" x2="12" y1="16" y2="12"/><line x1="12" x2="12.01" y1="8" y2="8"/></svg>';
            }

            box.innerHTML = '<div class="alert alert-' + tipo + '">' +
                            iconSvg +
                            '<div><strong>' + mensaje + '</strong></div>' +
                            '</div>';
            setTimeout(() => {
                box.innerHTML = "";
            }, 6000);
        }

        function obtenerIniciales(nombre, apellido) {
            const n = (nombre || "").trim().charAt(0).toUpperCase();
            const a = (apellido || "").trim().charAt(0).toUpperCase();
            return (n + a) || "EMP";
        }

        function actualizarMetricas(empleados) {
            const total = empleados.length;
            document.getElementById("statTotal").innerText = total;

            if (total === 0) {
                document.getElementById("statPromedio").innerText = "--";
                document.getElementById("statUltimo").innerText = "--";
                return;
            }

            const sumaEdades = empleados.reduce((acc, emp) => acc + (parseInt(emp.edad, 10) || 0), 0);
            const promedio = (sumaEdades / total).toFixed(1);
            document.getElementById("statPromedio").innerText = promedio + " años";

            const ultimo = empleados[empleados.length - 1];
            document.getElementById("statUltimo").innerText = (ultimo.nombres || "").split(" ")[0] || "#" + ultimo.id;
        }

        async function cargarEmpleados() {
            const tbody = document.getElementById("tablaCuerpo");
            const syncIcon = document.getElementById("syncIcon");
            if (syncIcon) syncIcon.classList.add("spinning");

            try {
                const { data, error } = await supabaseClient
                    .from('empleados')
                    .select('*')
                    .order('id', { ascending: true });

                if (error) throw error;

                todosLosEmpleados = data || [];
                actualizarMetricas(todosLosEmpleados);
                renderizarTabla(todosLosEmpleados);
            } catch (err) {
                console.error("Error al consultar Supabase:", err);
                mostrarAlerta("danger", "Error al consultar Supabase: " + (err.message || err));
                tbody.innerHTML = '<tr><td colspan="5" style="text-align: center; color: var(--danger-light); padding: 2rem 1rem;">No se pudo conectar a Supabase. ' + escapeHtml(err.message || err) + '</td></tr>';
            } finally {
                if (syncIcon) {
                    setTimeout(() => syncIcon.classList.remove("spinning"), 500);
                }
            }
        }

        function renderizarTabla(empleados) {
            const tbody = document.getElementById("tablaCuerpo");

            if (!empleados || empleados.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" style="text-align: center; color: var(--text-muted); padding: 2.5rem 1rem;">No se encontraron registros de empleados en Supabase.</td></tr>';
                return;
            }

            tbody.innerHTML = empleados.map(emp => {
                const iniciales = obtenerIniciales(emp.nombres, emp.apellido1);
                const apellidos = (emp.apellido1 || '') + (emp.apellido2 ? ' ' + emp.apellido2 : '');
                return `
                    <tr>
                        <td><span style="font-weight: 700; color: #818cf8;">#\${emp.id}</span></td>
                        <td>
                            <div class="avatar-cell">
                                <div class="avatar-initials">\${iniciales}</div>
                                <div style="font-weight: 600; color: var(--text-pure);">\${escapeHtml(emp.nombres)}</div>
                            </div>
                        </td>
                        <td>\${escapeHtml(apellidos)}</td>
                        <td>
                            <span class="token-chip">
                                <svg class="icon icon-xs" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                                \${emp.edad} años
                            </span>
                        </td>
                        <td style="text-align: center;">
                            <div style="display: inline-flex; gap: 0.4rem; justify-content: center;">
                                <button type="button" class="btn-icon" onclick="abrirModalEditar(\${emp.id})" title="Editar empleado" style="color: #818cf8; background: rgba(99, 102, 241, 0.12); border-color: rgba(99, 102, 241, 0.25);">
                                    <svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"/></svg>
                                </button>
                                <button type="button" class="btn-icon" onclick="eliminarEmpleado(\${emp.id}, '\${escapeHtml(emp.nombres)}')" title="Eliminar empleado" style="color: #f87171; background: rgba(239, 68, 68, 0.12); border-color: rgba(239, 68, 68, 0.25);">
                                    <svg class="icon icon-sm" viewBox="0 0 24 24"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
                                </button>
                            </div>
                        </td>
                    </tr>
                `;
            }).join('');
        }

        function filtrarEmpleados() {
            const query = (document.getElementById("busquedaInput").value || "").toLowerCase().trim();
            if (!query) {
                aplicarOrden();
                return;
            }

            const filtrados = todosLosEmpleados.filter(emp => {
                const nombreCompleto = (emp.nombres + " " + (emp.apellido1 || "") + " " + (emp.apellido2 || "")).toLowerCase();
                return nombreCompleto.includes(query) || String(emp.id).includes(query);
            });

            renderizarTabla(filtrados);
        }

        function aplicarOrden() {
            const orden = document.getElementById("ordenSelect").value;
            let copia = [...todosLosEmpleados];

            if (orden === "id_asc") {
                copia.sort((a, b) => a.id - b.id);
            } else if (orden === "id_desc") {
                copia.sort((a, b) => b.id - a.id);
            } else if (orden === "nombre_asc") {
                copia.sort((a, b) => (a.nombres || "").localeCompare(b.nombres || ""));
            } else if (orden === "edad_asc") {
                copia.sort((a, b) => a.edad - b.edad);
            } else if (orden === "edad_desc") {
                copia.sort((a, b) => b.edad - a.edad);
            }

            const query = (document.getElementById("busquedaInput").value || "").toLowerCase().trim();
            if (query) {
                copia = copia.filter(emp => {
                    const nombreCompleto = (emp.nombres + " " + (emp.apellido1 || "") + " " + (emp.apellido2 || "")).toLowerCase();
                    return nombreCompleto.includes(query) || String(emp.id).includes(query);
                });
            }

            renderizarTabla(copia);
        }

        async function guardarEmpleado(e) {
            e.preventDefault();
            const btn = document.getElementById("btnGuardar");
            btn.disabled = true;
            btn.innerHTML = '<svg class="icon icon-sm spinning" viewBox="0 0 24 24"><line x1="12" x2="12" y1="2" y2="6"/><line x1="12" x2="12" y1="18" y2="22"/><line x1="4.93" x2="7.76" y1="4.93" y2="7.76"/><line x1="16.24" x2="19.07" y1="16.24" y2="19.07"/><line x1="2" x2="6" y1="12" y2="12"/><line x1="18" x2="22" y1="12" y2="12"/></svg> <span>Guardando...</span>';

            const nombres = document.getElementById("nombres").value.trim();
            const apellido1 = document.getElementById("apellido1").value.trim();
            const apellido2 = document.getElementById("apellido2").value.trim();
            const edad = parseInt(document.getElementById("edad").value, 10);

            try {
                const { data, error } = await supabaseClient
                    .from('empleados')
                    .insert([
                        { nombres: nombres, apellido1: apellido1, apellido2: apellido2, edad: edad }
                    ]);

                if (error) throw error;

                mostrarAlerta("success", "Empleado " + nombres + " registrado correctamente en Supabase Cloud.");
                document.getElementById("formEmpleado").reset();
                cargarEmpleados();
            } catch (err) {
                console.error("Error al guardar:", err);
                mostrarAlerta("danger", "Error al registrar en Supabase: " + (err.message || err));
            } finally {
                btn.disabled = false;
                btn.innerHTML = '<svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg> <span>Guardar en Supabase</span>';
            }
        }

        function abrirModalEditar(id) {
            const emp = todosLosEmpleados.find(e => e.id === id);
            if (!emp) return;

            document.getElementById("edit_id").value = emp.id;
            document.getElementById("edit_nombres").value = emp.nombres || "";
            document.getElementById("edit_apellido1").value = emp.apellido1 || "";
            document.getElementById("edit_apellido2").value = emp.apellido2 || "";
            document.getElementById("edit_edad").value = emp.edad || "";

            document.getElementById("modalEditar").classList.add("active");
        }

        function cerrarModalEditar() {
            document.getElementById("modalEditar").classList.remove("active");
        }

        async function guardarEdicionEmpleado(e) {
            e.preventDefault();
            const btn = document.getElementById("btnGuardarEdit");
            btn.disabled = true;
            btn.innerHTML = '<svg class="icon icon-sm spinning" viewBox="0 0 24 24"><line x1="12" x2="12" y1="2" y2="6"/><line x1="12" x2="12" y1="18" y2="22"/><line x1="4.93" x2="7.76" y1="4.93" y2="7.76"/><line x1="16.24" x2="19.07" y1="16.24" y2="19.07"/><line x1="2" x2="6" y1="12" y2="12"/><line x1="18" x2="22" y1="12" y2="12"/></svg> <span>Actualizando...</span>';

            const id = parseInt(document.getElementById("edit_id").value, 10);
            const nombres = document.getElementById("edit_nombres").value.trim();
            const apellido1 = document.getElementById("edit_apellido1").value.trim();
            const apellido2 = document.getElementById("edit_apellido2").value.trim();
            const edad = parseInt(document.getElementById("edit_edad").value, 10);

            try {
                const { error } = await supabaseClient
                    .from('empleados')
                    .update({
                        nombres: nombres,
                        apellido1: apellido1,
                        apellido2: apellido2,
                        edad: edad
                    })
                    .eq('id', id);

                if (error) throw error;

                mostrarAlerta("success", "Empleado #" + id + " actualizado correctamente.");
                cerrarModalEditar();
                cargarEmpleados();
            } catch (err) {
                console.error("Error al actualizar:", err);
                mostrarAlerta("danger", "Error al actualizar en Supabase: " + (err.message || err));
            } finally {
                btn.disabled = false;
                btn.innerHTML = '<svg class="icon icon-sm" viewBox="0 0 24 24"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg> <span>Guardar Cambios</span>';
            }
        }

        async function eliminarEmpleado(id, nombre) {
            if (!confirm("¿Está seguro de que desea eliminar a " + (nombre || "el empleado #" + id) + " de Supabase?")) return;
            try {
                const { error } = await supabaseClient
                    .from('empleados')
                    .delete()
                    .eq('id', id);

                if (error) throw error;

                mostrarAlerta("success", "Empleado #" + id + " eliminado correctamente.");
                cargarEmpleados();
            } catch (err) {
                console.error("Error al eliminar:", err);
                mostrarAlerta("danger", "Error al eliminar de Supabase: " + (err.message || err));
            }
        }

        function exportarCSV() {
            if (!todosLosEmpleados || todosLosEmpleados.length === 0) {
                alert("No hay registros para exportar.");
                return;
            }

            let csvContent = "data:text/csv;charset=utf-8,ID,Nombres,Primer Apellido,Segundo Apellido,Edad\n";
            todosLosEmpleados.forEach(e => {
                csvContent += `\${e.id},"\${e.nombres}","\${e.apellido1}","\${e.apellido2 || ''}",\${e.edad}\n`;
            });

            const encodedUri = encodeURI(csvContent);
            const link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "empleados_supabase.csv");
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function escapeHtml(text) {
            if (!text) return "";
            const div = document.createElement("div");
            div.innerText = String(text);
            return div.innerHTML;
        }

        window.addEventListener("click", function(event) {
            const modal = document.getElementById("modalEditar");
            if (event.target === modal) {
                cerrarModalEditar();
            }
        });

        document.addEventListener("DOMContentLoaded", cargarEmpleados);
    </script>
</body>
</html>
