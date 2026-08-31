# Workshop Software Requirements

**EF Core Through the Eyes of a DBA — v1.0.0**

Use this checklist before the workshop. The goal is to have the complete environment installed and verified before LAB01 starts.

## Recommended workstation

- Windows 11, macOS or Linux
- 64-bit CPU with hardware virtualization enabled
- **8 GB RAM minimum; 16 GB recommended**
- at least **10 GB free disk space** for Docker images, NuGet packages and workshop files
- Internet access for the initial setup
- local ports **5000** and **14333** available

## Required software

### 1. Git

Install Git and verify:

```powershell
git --version
```

Git is required to clone and update the workshop repository.

### 2. .NET 10 SDK

Install the **.NET 10 SDK**. The runtime alone is not sufficient.

Verify:

```powershell
dotnet --version
```

The command should report a `10.x` SDK.

Also verify installed SDKs:

```powershell
dotnet --list-sdks
```

### 3. Docker

#### Windows / macOS

Install **Docker Desktop**.

On Windows, use the WSL 2 backend and make sure hardware virtualization is enabled in BIOS/UEFI.

#### Linux

Install **Docker Engine** with the Docker Compose plugin.

Verify:

```powershell
docker --version
docker compose version
```

Docker must be running before the workshop starts.

The workshop uses Docker to run **SQL Server 2022 Developer**. A separate local SQL Server installation is not required.

### 4. Development environment

The recommended environment for the workshop is **Visual Studio Code**. Visual Studio or JetBrains Rider can also be used for the C# project, but the workshop instructions and demonstrations assume VS Code where practical.

## Visual Studio Code — recommended extensions

Install Visual Studio Code and the following extensions:

### Required

1. **C# Dev Kit** — Microsoft
   - C# project navigation
   - debugging
   - IntelliSense
   - solution/project support

2. **C#** — Microsoft
   - normally installed together with C# Dev Kit
   - language support for the workshop API

3. **SQL Server (mssql)** — Microsoft
   - connect to SQL Server
   - run T-SQL scripts
   - inspect result sets and Messages
   - work with execution plans

4. **REST Client** — Huachao Mao
   - executes requests from `src/Workshop.Api/Workshop.Api.http`
   - required for the timing-sensitive blocking, isolation and deadlock labs

### Recommended

5. **Docker** — Microsoft
   - container and image visibility from VS Code
   - useful for troubleshooting the SQL Server container

6. **PowerShell** — Microsoft
   - syntax support for setup/reset scripts and the deadlock helper scripts

After installation, restart VS Code before the workshop.

## Visual Studio — alternative

If you prefer full Visual Studio, install a version that supports **.NET 10** and include:

### Required workload

- **ASP.NET and web development**

### Recommended components / workloads

- .NET 10 SDK
- Git for Windows / Git integration
- **Data storage and processing** if you want Visual Studio database tooling

Visual Studio can be used to edit and debug the ASP.NET Core application. For the SQL diagnostics in this workshop, VS Code with the Microsoft `mssql` extension remains the reference workflow.

## SQL client

At least one SQL client capable of running T-SQL and displaying execution plans is required.

Recommended:

- **VS Code + SQL Server (mssql)** extension

Optional alternatives:

- SQL Server Management Studio (SSMS)
- Azure Data Studio only if already installed and suitable for your environment

The workshop documentation does not require SSMS.

## PowerShell

### Windows

Windows PowerShell can execute the basic setup scripts, but **PowerShell 7** is recommended.

Verify:

```powershell
pwsh --version
```

PowerShell 7 is especially useful for the workshop helper scripts.

### macOS / Linux

PowerShell 7 is optional if you use the `.sh` setup/reset scripts.

## Web browser

Install a current version of one of the following:

- Microsoft Edge
- Google Chrome
- Firefox

The browser is used for Swagger and the workshop presentation.

## Repository

Clone the instructor/student repository provided for the workshop and open its root folder in VS Code.

Example:

```powershell
git clone <repository-url>
cd EFCore-Through-the-Eyes-of-a-DBA
code .
```

## Required local ports

The following ports must be free:

| Port | Purpose |
|---:|---|
| `5000` | ASP.NET Core workshop API |
| `14333` | SQL Server container |

On Windows you can check them with:

```powershell
Get-NetTCPConnection -LocalPort 5000,14333 -ErrorAction SilentlyContinue
```

No result normally means the ports are free.

## Verify the complete environment

Run these commands before the workshop:

```powershell
git --version
dotnet --version
docker --version
docker compose version
```

Then start the lab environment from the repository root:

```powershell
docker compose up -d --wait
.\Setup-Lab.ps1
```

On macOS / Linux:

```bash
docker compose up -d --wait
./Setup-Lab.sh
```

Start the API:

```powershell
cd src/Workshop.Api
dotnet restore
dotnet run
```

Verify in a browser:

```text
http://localhost:5000/swagger
```

Verify SQL Server connectivity:

```text
Server: localhost,14333
Database: EfCoreDbaLab
Login: sa
Password: LabPassword!2026
```

## Final pre-workshop checklist

Before attending the workshop, confirm that:

- [ ] Git is installed and `git --version` works
- [ ] .NET 10 SDK is installed and visible in `dotnet --list-sdks`
- [ ] Docker is installed and running
- [ ] `docker compose version` works
- [ ] VS Code is installed
- [ ] C# Dev Kit is installed
- [ ] SQL Server (`mssql`) extension is installed
- [ ] REST Client is installed
- [ ] PowerShell extension is installed (recommended)
- [ ] ports 5000 and 14333 are free
- [ ] `docker compose up -d --wait` succeeds
- [ ] `Setup-Lab.ps1` or `Setup-Lab.sh` succeeds
- [ ] `dotnet run` starts the API
- [ ] Swagger opens at `http://localhost:5000/swagger`
- [ ] you can connect to `EfCoreDbaLab` from the SQL editor
- [ ] `src/Workshop.Api/Workshop.Api.http` can execute an HTTP request

If all checks pass, the workstation is ready for LAB01.
