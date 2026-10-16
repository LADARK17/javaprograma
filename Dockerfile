# Imagen base oficial de Apache Tomcat 9 con Java JDK 11 (soporte estándar para Servlet 3.1 / JSTL 1.2)
FROM tomcat:9.0-jdk11-corretto

LABEL maintainer="Antigravity Pair Programmer"
LABEL description="Contenedor para EJERCICIO_CORTE2 (JSP, JSTL 1.2, UTF-8 y Supabase)"

# Forzar codificación UTF-8 en el entorno de Java y Tomcat
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    JAVA_OPTS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Duser.language=es -Duser.country=CO"

# Limpiar las aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar todo el contenido del proyecto como la aplicación por defecto (ROOT)
# o como /EJERCICIO_CORTE2 según conveniencia. Lo configuramos como ROOT y EJERCICIO_CORTE2
COPY . /usr/local/tomcat/webapps/ROOT/
COPY . /usr/local/tomcat/webapps/EJERCICIO_CORTE2/

# Puerto estándar de Tomcat
EXPOSE 8080

# Comando de arranque
CMD ["catalina.sh", "run"]
