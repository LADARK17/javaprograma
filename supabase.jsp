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
        <header>
            <div class="badge-tag">☁️ Supabase Cloud &bull; Cero Servlets &bull; Cero Scriptlets</div>
            <h1>Persistencia con Supabase Cloud</h1>
            <p class="subtitle">Conexión directa en tiempo real a PostgreSQL con API Rest &amp; SDK oficial sin código Java</p>
        </header>

        <div id="alertBox"></div>

        <div class="card">
            <h2>Registrar Nuevo Empleado en Supabase</h2>
            <form id="formEmpleado" onsubmit="guardarEmpleado(event)">
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

                <div style="display: flex; gap: 0.75rem; flex-wrap: wrap; align-items: center;">
                    <button type="submit" id="btnGuardar" class="btn btn-accent">
                        <span>💾</span> Guardar en Supabase
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="cargarEmpleados()">
                        <span>🔄</span> Recargar Datos
                    </button>
                </div>
            </form>
        </div>

        <div class="card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem; flex-wrap: wrap; gap: 0.5rem;">
                <h2 style="margin: 0;">Lista de Empleados en Supabase Cloud</h2>
                <span id="statusIndicator" class="token-chip" style="background: rgba(16, 185, 129, 0.15); color: #34d399; border: 1px solid rgba(16, 185, 129, 0.3);">
                    🟢 Conectado
                </span>
            </div>

            <table>
                <thead>
                    <tr>
                        <th style="width: 80px;">ID</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th style="width: 110px;">Edad</th>
                        <th style="width: 90px; text-align: center;">Acción</th>
                    </tr>
                </thead>
                <tbody id="tablaCuerpo">
                    <tr>
                        <td colspan="5" style="text-align: center; color: var(--text-muted); padding: 2rem 1rem;">
                            Cargando registros de Supabase...
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="card">
            <h2>Detalles de Conexión Configurados</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 1rem; font-size: 0.9rem;">
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 0.85rem;">
                    <div style="color: #38bdf8; font-weight: 700;">🌐 Supabase Project URL</div>
                    <code style="word-break: break-all; color: var(--text-muted);">https://fzxikusnodngkvlztrgv.supabase.co</code>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 0.85rem;">
                    <div style="color: #10b981; font-weight: 700;">🔑 Publishable Key</div>
                    <code style="word-break: break-all; color: var(--text-muted);">sb_publishable_uqnfSi6712C3X4JS6ziqUg_1t5qbCS0</code>
                </div>
                <div style="background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-subtle); border-radius: 0.75rem; padding: 0.85rem;">
                    <div style="color: #a855f7; font-weight: 700;">🛡️ Cumplimiento Académico</div>
                    <span style="color: var(--text-muted);">0 Servlets &bull; 0 Scriptlets (&lt;% %&gt;) &bull; 100% Puro</span>
                </div>
            </div>
        </div>

        <a href="index.jsp" class="back-link">&larr; Volver al Menú Principal</a>
    </div>

    <script>
        const SUPABASE_URL = "https://fzxikusnodngkvlztrgv.supabase.co";
        const SUPABASE_KEY = "sb_publishable_uqnfSi6712C3X4JS6ziqUg_1t5qbCS0";

        const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

        function mostrarAlerta(tipo, mensaje) {
            const box = document.getElementById("alertBox");
            const icono = tipo === "success" ? "🎉" : "⚠️";
            box.innerHTML = '<div class="alert alert-' + tipo + '">' +
                            '<span>' + icono + '</span>' +
                            '<div><strong>' + mensaje + '</strong></div>' +
                            '</div>';
            setTimeout(() => {
                box.innerHTML = "";
            }, 6000);
        }

        async function cargarEmpleados() {
            const tbody = document.getElementById("tablaCuerpo");
            try {
                const { data, error } = await supabaseClient
                    .from('empleados')
                    .select('*')
                    .order('id', { ascending: true });

                if (error) throw error;

                if (!data || data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="5" style="text-align: center; color: var(--text-muted); padding: 2rem 1rem;">No hay empleados registrados en Supabase.</td></tr>';
                    return;
                }

                tbody.innerHTML = data.map(emp => `
                    <tr>
                        <td><span style="font-weight: 700; color: #818cf8;">#\${emp.id}</span></td>
                        <td>\${escapeHtml(emp.nombres)}</td>
                        <td>\${escapeHtml(emp.apellido1 + ' ' + (emp.apellido2 || ''))}</td>
                        <td><span class="token-chip" style="padding: 0.25rem 0.65rem; font-size: 0.85rem;">\${emp.edad} años</span></td>
                        <td style="text-align: center;">
                            <button type="button" onclick="eliminarEmpleado(\${emp.id})" style="background: rgba(239, 68, 68, 0.15); color: #f87171; border: 1px solid rgba(239, 68, 68, 0.3); border-radius: 0.375rem; padding: 0.3rem 0.6rem; cursor: pointer; font-size: 0.8rem;">
                                🗑️
                            </button>
                        </td>
                    </tr>
                `).join('');
            } catch (err) {
                console.error("Error al cargar empleados:", err);
                mostrarAlerta("danger", "Error al consultar Supabase: " + (err.message || err));
            }
        }

        async function guardarEmpleado(e) {
            e.preventDefault();
            const btn = document.getElementById("btnGuardar");
            btn.disabled = true;
            btn.innerHTML = "<span>⏳</span> Guardando...";

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

                mostrarAlerta("success", "¡Empleado registrado exitosamente en Supabase!");
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

        async function eliminarEmpleado(id) {
            if (!confirm("¿Está seguro de eliminar el empleado #" + id + "?")) return;
            try {
                const { error } = await supabaseClient
                    .from('empleados')
                    .delete()
                    .eq('id', id);

                if (error) throw error;

                mostrarAlerta("success", "Empleado #" + id + " eliminado.");
                cargarEmpleados();
            } catch (err) {
                mostrarAlerta("danger", "Error al eliminar: " + (err.message || err));
            }
        }

        function escapeHtml(text) {
            if (!text) return "";
            const div = document.createElement("div");
            div.innerText = text;
            return div.innerHTML;
        }

        // Cargar registros al iniciar
        document.addEventListener("DOMContentLoaded", cargarEmpleados);
    </script>
</body>
</html>
