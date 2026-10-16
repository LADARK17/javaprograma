package com.ejercicio.supabase;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SupabaseClient {
    public static final String SUPABASE_URL = "https://fzxikusnodngkvlztrgv.supabase.co";
    public static final String API_KEY = "sb_publishable_uqnfSi6712C3X4JS6ziqUg_1t5qbCS0";
    public static final String SERVICE_ROLE = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6eGlrdXNub2RuZ2t2bHp0cmd2Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc5MDk2NjE0NywiZXhwIjoyMTA2NTQyMTQ3fQ.oKIiTRNJUA-BJJF8y4FZdj8viWVfy98atnYpD054vxs";

    public static List<Map<String, Object>> getEmpleados() throws Exception {
        URL url = new URL(SUPABASE_URL + "/rest/v1/empleados?select=*&order=id.asc");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("apikey", API_KEY);
        conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
        conn.setRequestProperty("Accept", "application/json");

        int status = conn.getResponseCode();
        if (status >= 400) {
            throw new RuntimeException("Error consultando Supabase HTTP status: " + status);
        }

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            return parseJsonArray(sb.toString().trim());
        }
    }

    public static boolean insertarEmpleado(String nombres, String apellido1, String apellido2, int edad) throws Exception {
        URL url = new URL(SUPABASE_URL + "/rest/v1/empleados");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("apikey", API_KEY);
        conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setRequestProperty("Prefer", "return=minimal");

        String payload = "{"
            + "\"nombres\":\"" + escapeJson(nombres) + "\","
            + "\"apellido1\":\"" + escapeJson(apellido1) + "\","
            + "\"apellido2\":\"" + escapeJson(apellido2) + "\","
            + "\"edad\":" + edad
            + "}";

        byte[] input = payload.getBytes(StandardCharsets.UTF_8);
        try (OutputStream os = conn.getOutputStream()) {
            os.write(input, 0, input.length);
        }

        int status = conn.getResponseCode();
        return (status == 200 || status == 201 || status == 204);
    }

    private static String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    private static String unescapeJson(String s) {
        if (s == null) return "";
        StringBuilder sb = new StringBuilder();
        int len = s.length();
        for (int i = 0; i < len; i++) {
            char c = s.charAt(i);
            if (c == '\\' && i + 1 < len) {
                char next = s.charAt(i + 1);
                if (next == 'u' && i + 5 < len) {
                    try {
                        String hex = s.substring(i + 2, i + 6);
                        int code = Integer.parseInt(hex, 16);
                        sb.append((char) code);
                        i += 5;
                        continue;
                    } catch (NumberFormatException ignored) {
                    }
                } else if (next == 'n') {
                    sb.append('\n'); i++; continue;
                } else if (next == 'r') {
                    sb.append('\r'); i++; continue;
                } else if (next == 't') {
                    sb.append('\t'); i++; continue;
                } else if (next == '\"' || next == '\\' || next == '/') {
                    sb.append(next); i++; continue;
                }
            }
            sb.append(c);
        }
        return sb.toString();
    }

    /**
     * Parseador JSON liviano nativo en Java estándar sin dependencias externas.
     */
    private static List<Map<String, Object>> parseJsonArray(String json) {
        List<Map<String, Object>> list = new ArrayList<>();
        if (json == null || !json.startsWith("[")) {
            return list;
        }

        // Extraer objetos individuales {...}
        Pattern objPattern = Pattern.compile("\\{([^\\}]+)\\}");
        Matcher objMatcher = objPattern.matcher(json);

        Pattern pairPattern = Pattern.compile("\"([^\"]+)\"\\s*:\\s*(\"[^\"]*\"|\\d+|true|false|null)");

        while (objMatcher.find()) {
            String objContent = objMatcher.group(1);
            Map<String, Object> map = new HashMap<>();
            Matcher pairMatcher = pairPattern.matcher(objContent);
            while (pairMatcher.find()) {
                String key = pairMatcher.group(1);
                String rawVal = pairMatcher.group(2).trim();
                if (rawVal.startsWith("\"") && rawVal.endsWith("\"")) {
                    String strVal = rawVal.substring(1, rawVal.length() - 1);
                    map.put(key, unescapeJson(strVal));
                } else if ("null".equalsIgnoreCase(rawVal)) {
                    map.put(key, null);
                } else {
                    try {
                        if (rawVal.contains(".")) {
                            map.put(key, Double.parseDouble(rawVal));
                        } else {
                            map.put(key, Long.parseLong(rawVal));
                        }
                    } catch (Exception e) {
                        map.put(key, rawVal);
                    }
                }
            }
            list.add(map);
        }
        return list;
    }

    public static void main(String[] args) throws Exception {
        System.out.println("Supabase empleados: " + getEmpleados());
    }
}
