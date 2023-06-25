FROM openjdk:19-buster

#Sets up the workspace
VOLUME ["/data"]
WORKDIR /data

#Updates the container and installs dependencies
RUN apt update
RUN apt install -y zip unzip wget

#Retrieves the modpack
RUN wget https://www.curseforge.com/api/v1/mods/486989/files/4581850/download
RUN mv download medievalv16.zip

#Exposes the port and copies scripts
EXPOSE 25565/tcp
COPY . .

#Sets default java arguments
ENV JAVA_ARGS="-Xms4096m -Xmx6144m"

#Sets permissions for scripts and runs prep.sh
RUN chmod +x prep.sh
CMD ["./prep.sh"]