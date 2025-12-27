# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY Portfolio.API/*.csproj ./Portfolio.API/
COPY Portfolio.Infrastructure/*.csproj ./Portfolio.Infrastructure/
COPY Portfolio.Core/*.csproj ./Portfolio.Core/
RUN dotnet restore Portfolio.API/Portfolio.API.csproj

COPY . .
RUN dotnet publish Portfolio.API/Portfolio.API.csproj -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish ./

# Match the compose port mapping 5000:8080
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "Portfolio.API.dll"]