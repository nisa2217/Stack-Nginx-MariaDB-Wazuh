# Nginx-MariaDB-Wazuh 🤖
En este repositorio podemos encontrar los archivos y configuraciones para poder realizar un stack completo con docker-compose, además de integrar un CI/CD para cualquier cambio en los archivos de configuración se cree una imagen en nuestro repositorio de DockerHub.

# ENTORNO 🔃
El entorno en el cual se ha realizado el despliegue es mediante Docker y Docker-compose en un servidor en la nube. Los requisitos mínimos para el correcto funcionamiento es 4GB de RAM  minimo en el servidor, MV o en el entorno elegido por el usuario para realizar las pruebas pertinentes.

# PASOS A REALIZAR 
Una vez preparado el entorno, lo que debemos de hacer es crear una carpeta y dentro crear nuestros ficheros docker-compose y Dockerfile además de tener la carpeta config con las configuraciones de Wazuh.
Terminada la creación de los ficheros debemos hacer el comando 

