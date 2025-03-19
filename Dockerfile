# Usar a imagem oficial do OpenJDK 17
FROM openjdk:17-jdk-slim

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o JAR do projeto para dentro do container
COPY target/pass-backend-1.0-SNAPSHOT.jar app.jar

# Expõe a porta 8080 para comunicação externa
EXPOSE 8080

# Comando que será executado ao iniciar o container
CMD ["java", "-jar", "app.jar"]
