FROM eclipse-temurin:16

# CONFIGURE ARGS
###########################
ARG VERSION="latest"
ARG PORT="2333"
ARG PASSWORD="youshallnotpass"
###########################

# Install necessary tools
RUN apt update -y
RUN apt install wget -y
RUN apt update -y

# Workdir for app
WORKDIR /app

# Download official version of Lavalink
RUN if [ "$VERSION" = "latest" ]; \
    then \
        wget https://github.com/freyacodes/Lavalink/releases/latest/download/Lavalink.jar; \
    else \
        wget "https://github.com/freyacodes/Lavalink/releases/download/$VERSION/Lavalink.jar"; \
fi

# Download default config
RUN wget -O application.yml https://raw.githubusercontent.com/freyacodes/Lavalink/master/LavalinkServer/application.yml.example

# Set custom port and password
RUN sed -i "2s/.*/  port: $PORT/" application.yml
RUN sed -i "6s/.*/    password: $PASSWORD/" application.yml

# RUN Lavalink
ENTRYPOINT ["java", "-Djdk.tls.client.protocols=TLSv1.1,TLSv1.2", "-Xmx4G", "-jar", "Lavalink.jar"]
