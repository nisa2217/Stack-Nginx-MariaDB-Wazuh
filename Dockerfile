ARG SERVICE
FROM debian:bullseye-slim

# Instala las dependencias básicas comunes a todos los servicios
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    && apt-get clean

# Configuración específica por servicio
RUN echo "SERVICE=$SERVICE" && \
    if [ "$SERVICE" = "mariadb" ]; then \
        apt-get update && apt-get install -y mariadb-server && apt-get clean; \
    elif [ "$SERVICE" = "wazuh-manager" ]; then \
        wget -qO - https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --dearmor -o /usr/share/keyrings/wazuh-archive-keyring.gpg && \
        echo "deb [signed-by=/usr/share/keyrings/wazuh-archive-keyring.gpg] https://packages.wazuh.com/4.x/apt/ stable main" > /etc/apt/sources.list.d/wazuh.list && \
        apt-get update && apt-get install -y wazuh-manager && apt-get clean; \
    elif [ "$SERVICE" = "nginx" ]; then \
        apt-get update && apt-get install -y nginx && apt-get clean; \
    else \
        echo "Servicio desconocido: $SERVICE" && exit 1; \
    fi

# Copiar archivos específicos (opcional)
COPY ./config/$SERVICE /etc/$SERVICE

# Exponer puertos según el servicio
EXPOSE 80 1514 1515 9200

# Comando predeterminado (puedes cambiarlo según el servicio)
CMD ["sh", "-c", "echo Configuración lista para $SERVICE"]


