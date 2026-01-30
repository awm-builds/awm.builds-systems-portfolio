# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY Portfolio.Web/*.csproj ./Portfolio.Web/
RUN dotnet restore Portfolio.Web/Portfolio.Web.csproj

COPY . .
RUN dotnet publish Portfolio.Web/Portfolio.Web.csproj -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish ./

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "Portfolio.Web.dll"]