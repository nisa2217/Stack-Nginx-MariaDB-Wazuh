ARG SERVICE
FROM debian:bullseye-slim

# Instala las dependencias básicas comunes
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
      apt-get update && apt-get install -y wget gnupg && \
      wget -qO - https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --dearmor -o /usr/share/keyrings/wazuh-archive-keyring.gpg && \
      echo "deb [signed-by=/usr/share/keyrings/wazuh-archive-keyring.gpg] https://packages.wazuh.com/4.x/apt/ stable main" > /etc/apt/sources.list.d/wazuh.list && \
      apt-get update && apt-get install -y wazuh-manager && apt-get clean; \
    elif [ "$SERVICE" = "nginx" ]; then \
      apt-get update && apt-get install -y nginx && apt-get clean; \
    else \
      echo "Servicio desconocido: $SERVICE" && exit 1; \
    fi

# Copia configuraciones específicas del servicio
COPY ./config/$SERVICE /etc/$SERVICE || echo "No hay configuraciones específicas para $SERVICE."

# Exponer los puertos comunes
EXPOSE 80 1514 1515 9200

# Comando por defecto
CMD ["sh", "-c", "echo Configuración lista para $SERVICE"]

