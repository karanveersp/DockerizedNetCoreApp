# Dockerized .NET Core 5 CLI App

This project is a demo of how to build and run a .NET Core 5 app in a docker container.

The `Dockerfile` defines an image which can be used by docker to start a container.

```Dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:5.0

COPY bin/Release/net5.0/publish/ DockerizedApp/
WORKDIR /DockerizedApp
ENTRYPOINT ["dotnet", "NetCoreDocker.dll"]
```

The `FROM mcr.microsoft.com/dotnet/aspnet:5.0` command is to pull an image containing the dotnet 5.0 runtime.

The `COPY` command tells docker to copy the specified folder on your computer to a folder on the container.
Here, the _publish_ folder is copied to a folder named _DockerizedApp_ inside the container.

The `WORKDIR` command changes the **current directory** inside the container to _DockerizedApp_.

The `ENTRYPOINT` command tells docker to configure the container to run as an executable.
When the container starts, the `ENTRYPOINT` command runs. When the command ends, the container
automatically stops.

## Publish the App

Use the local dotnet runtime to build and publish the release artifacts.

```
dotnet publish -c Release
```

The `-c` flag is the configuration to publish for. By default it is `Debug`. The `Relase` config has fewer artifacts.


## Create Image

To convert the `Dockerfile` into an Image:

```
docker build -t counter-image -f Dockerfile .
```

## Create Container

To create a Container from the Image:

```
docker create --name core-counter counter-image
```

To see all the containers, `docker ps -a`


## Start Container 

To start the container:

```
docker start core-counter
```

## Connect to a Container

Connect to see container output.

```
docker attach --sig-proxy=false core-counter
```

## Delete Container

```
docker stop core-counter
docker rm core-counter
```

## Single Run

Docker provides the `docker run` command to create and start the container in a single command.

You can also set this command to automatically delete the container when the container stops. 

For example, use `docker run -it --rm` to:

- Use current terminal to connect to the container
- When container finishes, remove it

```
docker run -it --rm counter-image
```

Pass CLI args after the image name
```
docker run -it --rm counter-image 3
```
