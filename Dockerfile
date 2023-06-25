FROM eclipse-temurin:18-jdk-alpine

#Sets up the workspace
VOLUME ["/data"]
WORKDIR /data

#Updates the container and installs dependencies
RUN apk update
RUN apk add --no-cache zip unzip wget bash curl

#Exposes the port and copies scripts
EXPOSE 25565/tcp
COPY . .

#Sets default java arguments
ENV JAVA_ARGS="-Xms6144m -Xmx8192m"

#Sets permissions for scripts and runs prep.sh
RUN chmod +x prep.sh
CMD ["./prep.sh"]