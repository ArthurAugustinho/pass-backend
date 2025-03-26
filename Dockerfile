# Build stage
FROM eclipse-temurin:17-jdk-jammy as builder

WORKDIR /workspace
COPY . .
RUN ./mvnw clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre-jammy

# Argumentos de build
ARG APP_VERSION=unknown
ENV APP_VERSION=${APP_VERSION}

# Configuração de segurança
RUN groupadd -r springuser && \
    useradd -r -g springuser springuser && \
    mkdir -p /app && \
    chown springuser:springuser /app

WORKDIR /app
USER springuser

# Copia o JAR da fase de build
COPY --from=builder --chown=springuser:springuser /workspace/target/pass-backend-*.jar app.jar

# Configurações recomendadas para containers Java
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -XX:InitialRAMPercentage=50.0 -XX:+AlwaysPreTouch -Djava.security.egd=file:/dev/./urandom"

# Porta exposta
EXPOSE 8081

# Metadata
LABEL org.opencontainers.image.version="${APP_VERSION}" \
      org.opencontainers.image.title="PASS Auth Service" \
      org.opencontainers.image.description="Authentication Service for PASS System"

# Entrypoint otimizado
ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar app.jar"]