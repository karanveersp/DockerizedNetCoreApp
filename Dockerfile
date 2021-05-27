FROM mcr.microsoft.com/dotnet/aspnet:5.0

COPY bin/Release/net5.0/publish/ DockerizedApp/
WORKDIR /DockerizedApp
ENTRYPOINT ["dotnet", "NetCoreDocker.dll"]
