ARG SERVICE
FROM debian:bullseye-slim

# Instala las dependencias básicas comunes
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    && apt-get clean

# Manejo de configuraciones específicas
RUN if [ -d "./config/$SERVICE" ]; then \
      cp -r ./config/$SERVICE /etc/$SERVICE; \
    else \
      echo "No hay configuraciones específicas para $SERVICE."; \
    fi

# Exponer los puertos comunes
EXPOSE 80 1514 1515 9200

# Comando por defecto
CMD ["sh", "-c", "echo Configuración lista para $SERVICE"]


