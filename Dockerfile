#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
#COPY ["helloworld-web/helloworld-web.csproj", "helloworld-web/"]
RUN ls -la
COPY . .
RUN echo "****************************************************"
RUN ls -la
RUN dotnet restore
RUN dotnet build -c Release -o /app/build
RUN ls -la

FROM build AS publish
RUN dotnet publish -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "helloworld-web.dll"]
