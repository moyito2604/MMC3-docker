FROM openjdk:19-buster

VOLUME ["/data"]
WORKDIR /

RUN apt update
RUN apt install -y zip unzip wget

RUN wget https://www.curseforge.com/api/v1/mods/486989/files/4581850/download
RUN mv download medieval.zip
RUN unzip medieval.zip

RUN rm -rf medieval.zip
RUN mv "Medieval MC [FORGE] 1.19.2 Server Pack" data

EXPOSE 25565

WORKDIR /data
COPY . .
RUN chmod +x start.sh
CMD ["./start.sh"]