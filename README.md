# MMC3-docker
A dockerfile used to build the Medieval Minecraft Server V3 for use in containerized environments

To build the container and run it, use the following commands

To Build:
```
docker build -t imagename .
```
To Run:
```
docker run -p <port>:25565 -v '/path/to/files':'/data':'rw' imagename
```

A prebuilt container can be made and run using the following command
```
docker run -p <port>:25565 -v '/path/to/files':'/data':'rw' moyito2604/mmc3-docker:latest
```
