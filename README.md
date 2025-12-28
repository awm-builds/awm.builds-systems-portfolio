# Portfolio

A modular .NET 8 solution demonstrating clean architecture, a Blazor front‑end, and production‑ready workflows.

## Overview
- Demonstrates my approach to building production‑ready .NET systems  
- Highlights clean architecture boundaries and modular solution structure  
- Includes reproducible workflows, automated quality gates, and containerized environments

## Highlights
- Clean architecture with strict project boundaries
- Fully containerized local environment (API + Postgres)
- Automated quality gates (Husky, commitlint, dotnet format)
- Reproducible migrations and environment setup
- Cross‑platform developer experience (Bash + PowerShell)

---

## Projects
- `Portfolio.API` — ASP.NET Core Web API
- `Portfolio.Web` — Blazor (server‑side) front‑end
- `Portfolio.Core` — domain models and business rules
- `Portfolio.Infrastructure` — EF Core + Npgsql data access and integrations

## Architecture & Stack
- Clean architecture boundaries (API ↔ Core ↔ Infrastructure)
- EF Core + PostgreSQL
- Blazor for interactive UI
- Tooling: Docker/Compose, Husky + commitlint, `dotnet format`

## Prerequisites
- Docker Desktop
- .NET 8 SDK

---

## Quickstart

### Bash / Git Bash (macOS, Linux, WSL)
```bash
git clone https://github.com/awm-builds/awm.builds-systems-portfolio.git
cd awm.builds-systems-portfolio
cp .env.example .env
docker compose up --build
```

### PowerShell (Windows)
```powershell
git clone https://github.com/awm-builds/awm.builds-systems-portfolio.git
cd awm-builds-systems-portfolio
Copy-Item .env.example .env
docker compose up --build
```

**Services**
- API: http://localhost:5000 (container 8080 → host 5000)
- Postgres: localhost:55432 (container 5432 → host 55432)
- Health: http://localhost:5000/health

---

## Stop & Clean (removes volumes)
```bash
docker compose down -v
```
Data is persisted in the `pgdata` volume.

---

## Environment
Copy `.env.example` to `.env` and adjust as needed:

- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`
- `DB_PORT_EXTERNAL` (host port for Postgres)
- `CONNECTIONSTRINGS__POSTGRES` (API connection string)

---

## Run Locally (without Docker)

1. Start Postgres and ensure the connection string (User Secrets or `appsettings.Development.json`):

```json
"ConnectionStrings": {
  "Postgres": "Host=localhost;Port=55432;Database=portfolio;Username=postgres;Password=postgres"
}
```

2. Run the API:
```bash
dotnet run --project Portfolio.API
```

3. Run the Blazor front‑end:
```bash
dotnet run --project Portfolio.Web
```

---

## Database Migrations
Run migrations from Infrastructure using the API as the startup project:

```bash
dotnet ef migrations add <Name> --project Portfolio.Infrastructure --startup-project Portfolio.API
dotnet ef database update --project Portfolio.Infrastructure --startup-project Portfolio.API
```

---

## Quality Gates
- Formatting: `dotnet format` (enforced by Husky pre‑commit)
- Commit style: Conventional Commits (commitlint)

---

## Troubleshooting
- **Port in use**: change `DB_PORT_EXTERNAL` or the API host port in `docker-compose.yml`.
- **Reset local DB volume**:
  ```bash
  docker compose down -v && docker compose up --build
  ```

  ---

  ## License
This project is licensed under the MIT License. See the `LICENSE` file for details.