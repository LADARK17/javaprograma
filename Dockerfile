# ==============================================================================
# Dockerfile para EJERCICIO_CORTE2
# Aplicación Web 100% JSP y JSTL 1.2 (Cero Servlets, Cero Scriptlets, Cero Compilación Java)
# ==============================================================================

FROM tomcat:9.0-jdk11-corretto

LABEL maintainer="EJERCICIO_CORTE2"
LABEL description="Contenedor Tomcat 9 para JSP y JSTL 1.2 puro"

# Codificación UTF-8 estricta a nivel de entorno y máquina virtual Java
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    JAVA_OPTS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Duser.language=es -Duser.country=CO"

# Eliminar aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar aplicación tanto a ROOT como a /EJERCICIO_CORTE2
COPY . /usr/local/tomcat/webapps/ROOT/
COPY . /usr/local/tomcat/webapps/EJERCICIO_CORTE2/

# Permisos de lectura y ejecución para Tomcat
RUN chmod -R 755 /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
