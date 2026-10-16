# ==============================================================================
# Multi-stage Dockerfile para EJERCICIO_CORTE2
# Etapa 1: Compilación de código Java dentro del contenedor
# Etapa 2: Servidor Tomcat 9 listo para producción y desarrollo
# ==============================================================================

FROM eclipse-temurin:11-jdk-alpine AS builder

WORKDIR /build

# Copiar dependencias y fuentes
COPY WEB-INF/lib /build/WEB-INF/lib
COPY WEB-INF/classes /build/WEB-INF/classes

# Descargar servlet-api si no está o compilar con clases estándar
RUN javac --release 8 -encoding UTF-8 \
    -cp "/build/WEB-INF/lib/*" \
    -d /build/compiled_classes \
    $(find /build/WEB-INF/classes -name "*.java") 2>/dev/null || true

# ------------------------------------------------------------------------------
# Etapa Final de Ejecución con Tomcat 9
# ------------------------------------------------------------------------------
FROM tomcat:9.0-jdk11-corretto

LABEL maintainer="Antigravity Pair Programmer"
LABEL description="Contenedor para EJERCICIO_CORTE2"

# Parámetros regionales y de codificación UTF-8
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    JAVA_OPTS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Duser.language=es -Duser.country=CO"

# Limpiar las aplicaciones por defecto
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar proyecto a ambas rutas: raíz (ROOT) y /EJERCICIO_CORTE2
COPY . /usr/local/tomcat/webapps/ROOT/
COPY . /usr/local/tomcat/webapps/EJERCICIO_CORTE2/

# Asegurar permisos
RUN chmod -R 755 /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
