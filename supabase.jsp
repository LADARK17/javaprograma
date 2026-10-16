<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="UTF-8" />
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Persistencia Supabase Cloud - Cero Servlets, Cero Scriptlets</title>
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
                <span>☁️</span> Supabase Cloud &bull; Cero Servlets &bull; Cero Scriptlets
            </div>
            <h1>Gestión en la Nube con Supabase</h1>
            <p class="subtitle">
                Persistencia directa en PostgreSQL Cloud en tiempo real con REST API y SDK oficial.
                Interfaz 100% responsive optimizada para dispositivos móviles, tablets y escritorio.
            </p>
        </header>

        <!-- Contenedor de Alertas Dinámicas -->
        <div id="alertBox"></div>

        <!-- Métricas y Estadísticas en Vivo -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon primary">👥</div>
                <div class="stat-info">
                    <span class="stat-value" id="statTotal">--</span>
                    <span class="stat-label">Total Empleados</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon accent">🎂</div>
                <div class="stat-info">
                    <span class="stat-value" id="statPromedio">--</span>
                    <span class="stat-label">Edad Promedio</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon info">⚡</div>
                <div class="stat-info">
                    <span class="stat-value" id="statUltimo">--</span>
                    <span class="stat-label">Último Ingreso</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon warning">🌐</div>
                <div class="stat-info">
                    <span class="stat-value" style="font-size: 1.15rem; color: #34d399;" id="statConexion">Activo</span>
                    <span class="stat-label">Supabase Cloud</span>
                </div>
            </div>
        </div>

        <!-- Formulario de Registro de Nuevo Empleado -->
        <div class="card">
            <h2>
                <span>📝</span> Registrar Nuevo Empleado
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
                        <span>💾</span> Guardar en Supabase
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="cargarEmpleados()">
                        <span id="spinReload">🔄</span> Sincronizar
                    </button>
                </div>
            </form>
        </div>

        <!-- Tabla de Registros en Supabase -->
        <div class="card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.15rem; flex-wrap: wrap; gap: 0.75rem;">
                <h2 style="margin: 0; border: none; padding: 0;">
                    <span>📋</span> Empleados en Supabase Cloud
                </h2>
                <div id="statusIndicator" class="live-status connected">
                    <span class="pulse-dot"></span>
                    <span>Conectado a PostgreSQL</span>
                </div>
            </div>

            <!-- Toolbar: Búsqueda, Filtro y Exportación -->
            <div class="toolbar">
                <div class="toolbar-search">
                    <span class="search-icon">🔍</span>
                    <input type="search" id="busquedaInput" placeholder="Buscar por nombre o apellido..." oninput="filtrarEmpleados()">
                </div>
                <div class="toolbar-actions">
                    <select id="ordenSelect" onchange="aplicarOrden()" style="width: auto; min-width: 160px; padding: 0.6rem 0.9rem; font-size: 0.88rem;">
                        <option value="id_asc">Ordenar por: ID (Asc)</option>
                        <option value="id_desc">Ordenar por: ID (Desc)</option>
                        <option value="nombre_asc">Nombres (A-Z)</option>
                        <option value="edad_asc">Edad (Menor a Mayor)</option>
                        <option value="edad_desc">Edad (Mayor a Menor)</option>
                    </select>
                    <button type="button" class="btn btn-secondary btn-sm" onclick="exportarCSV()" title="Descargar como CSV">
                        <span>📥</span> Exportar
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
                            <th style="width: 120px;">Edad</th>
                            <th style="width: 130px; text-align: center;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="tablaCuerpo">
                        <tr>
                            <td colspan="5" style="text-align: center; color: var(--text-muted); padding: 2.5rem 1rem;">
                                <span>⏳ Conectando y cargando registros desde Supabase...</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Detalles de Conexión del Proyecto Activo -->
        <div class="card">
            <h2>
                <span>⚙️</span> Configuración de Proyecto Supabase
            </h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 1rem; font-size: 0.9rem;">
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #38bdf8; font-weight: 700; margin-bottom: 0.35rem;">🌐 Supabase Project URL</div>
                    <code style="word-break: break-all; color: var(--text-muted);">https://eiowutpdlvsmfxejreyu.supabase.co</code>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #10b981; font-weight: 700; margin-bottom: 0.35rem;">🔑 Anon Public Key</div>
                    <code style="word-break: break-all; color: var(--text-muted); font-size: 0.8rem;">eyJhbGci...Nyu30</code>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 1rem;">
                    <div style="color: #a855f7; font-weight: 700; margin-bottom: 0.35rem;">🛡️ Cumplimiento Académico</div>
                    <span style="color: var(--text-muted);">0 Servlets &bull; 0 Scriptlets (&lt;% %&gt;) &bull; 100% Puro</span>
                </div>
            </div>
        </div>

        <!-- Enlace al Menú Principal -->
        <a href="index.jsp" class="back-link">&larr; Volver al Menú Principal</a>
    </div>

    <!-- Modal para Edición de Empleado -->
    <div id="modalEditar" class="modal-overlay">
        <div class="modal-card">
            <div class="modal-header">
                <h3><span>✏️</span> Editar Empleado</h3>
                <button type="button" class="modal-close" onclick="cerrarModalEditar()">&times;</button>
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
                        <span>💾</span> Guardar Cambios
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Script de Integración con Supabase Cloud -->
    <script>
        // Credenciales Oficiales de Supabase Cloud
        const SUPABASE_URL = "https://eiowutpdlvsmfxejreyu.supabase.co";
        const SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVpb3d1dHBkbHZzbWZ4ZWpyZXl1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTIxNzIwNzAsImV4cCI6MjEwNzc0ODA3MH0.wpyZ1Uygh4WtH3xoBFR6JYI8gPn534dWsDxwdfNyu30";

        // Instancia del cliente Supabase
        const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

        // Estado local para búsqueda y ordenación
        let todosLosEmpleados = [];

        function mostrarAlerta(tipo, mensaje) {
            const box = document.getElementById("alertBox");
            const icono = tipo === "success" ? "🎉" : tipo === "danger" ? "⚠️" : "ℹ️";
            box.innerHTML = '<div class="alert alert-' + tipo + '">' +
                            '<span style="font-size: 1.25rem;">' + icono + '</span>' +
                            '<div><strong>' + mensaje + '</strong></div>' +
                            '</div>';
            setTimeout(() => {
                box.innerHTML = "";
            }, 6000);
        }

        // Obtener iniciales para avatar
        function obtenerIniciales(nombre, apellido) {
            const n = (nombre || "").trim().charAt(0).toUpperCase();
            const a = (apellido || "").trim().charAt(0).toUpperCase();
            return (n + a) || "EMP";
        }

        // Actualizar tarjetas de métricas
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

        // Cargar empleados desde Supabase
        async function cargarEmpleados() {
            const tbody = document.getElementById("tablaCuerpo");
            const spin = document.getElementById("spinReload");
            if (spin) spin.style.display = "inline-block";

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
                tbody.innerHTML = '<tr><td colspan="5" style="text-align: center; color: #f87171; padding: 2rem 1rem;">❌ No se pudo conectar a Supabase. ' + escapeHtml(err.message || err) + '</td></tr>';
            }
        }

        // Renderizar filas de la tabla
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
                        <td><span class="token-chip">🎂 \${emp.edad} años</span></td>
                        <td style="text-align: center;">
                            <div style="display: inline-flex; gap: 0.4rem; justify-content: center;">
                                <button type="button" class="btn-icon" onclick="abrirModalEditar(\${emp.id})" title="Editar empleado" style="background: rgba(99, 102, 241, 0.15); color: #818cf8; border-color: rgba(99, 102, 241, 0.3);">
                                    ✏️
                                </button>
                                <button type="button" class="btn-icon" onclick="eliminarEmpleado(\${emp.id}, '\${escapeHtml(emp.nombres)}')" title="Eliminar empleado" style="background: rgba(239, 68, 68, 0.15); color: #f87171; border-color: rgba(239, 68, 68, 0.3);">
                                    🗑️
                                </button>
                            </div>
                        </td>
                    </tr>
                `;
            }).join('');
        }

        // Búsqueda en vivo
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

        // Ordenar registros
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

        // Guardar nuevo empleado en Supabase
        async function guardarEmpleado(e) {
            e.preventDefault();
            const btn = document.getElementById("btnGuardar");
            btn.disabled = true;
            btn.innerHTML = "<span>⏳</span> Guardando en Supabase...";

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

                mostrarAlerta("success", "¡Empleado " + nombres + " registrado exitosamente en Supabase Cloud!");
                document.getElementById("formEmpleado").reset();
                cargarEmpleados();
            } catch (err) {
                console.error("Error al guardar:", err);
                mostrarAlerta("danger", "Error al registrar en Supabase: " + (err.message || err));
            } finally {
                btn.disabled = false;
                btn.innerHTML = "<span>💾</span> Guardar en Supabase";
            }
        }

        // Abrir modal de edición
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

        // Guardar edición de empleado
        async function guardarEdicionEmpleado(e) {
            e.preventDefault();
            const btn = document.getElementById("btnGuardarEdit");
            btn.disabled = true;
            btn.innerHTML = "<span>⏳</span> Actualizando...";

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
                btn.innerHTML = "<span>💾</span> Guardar Cambios";
            }
        }

        // Eliminar empleado
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

        // Exportar a CSV
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

        // Cerrar modal al hacer clic afuera
        window.addEventListener("click", function(event) {
            const modal = document.getElementById("modalEditar");
            if (event.target === modal) {
                cerrarModalEditar();
            }
        });

        // Cargar registros al iniciar
        document.addEventListener("DOMContentLoaded", cargarEmpleados);
    </script>
</body>
</html>
