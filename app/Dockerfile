FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj file and restore dependencies
COPY src/App.csproj ./
RUN dotnet restore App.csproj

# Copy remaining source code and publish
COPY src/. ./
RUN dotnet publish App.csproj -c Release -o /app/publish /p:UseAppHost=false

# Production runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

# Non-root user for K8s security best practice
USER app

# Copy compiled binaries and static files from build stage
COPY --from=build /app/publish .

# Expose non-privileged HTTP port
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT [ "dotnet", "App.dll" ]