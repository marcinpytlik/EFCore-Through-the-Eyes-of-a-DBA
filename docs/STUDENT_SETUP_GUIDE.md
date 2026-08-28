# Student Setup Guide

## Requirements
- Docker Desktop / Docker Engine
- .NET 10 SDK
- Visual Studio Code, Visual Studio or Rider
- SSMS or another SQL client with execution-plan support

## 1. Start SQL Server
```powershell
docker compose up -d
```
SQL Server: `localhost,14333`  
Login: `sa`  
Password: `LabPassword!2026`  
Database: `EfCoreDbaLab`

## 2. Build the database
```powershell
.\Setup-Lab.ps1
```

## 3. Start the API
```powershell
cd .\src\Workshop.Api
dotnet restore
dotnet run
```
Open the Swagger URL printed in the terminal.

## 4. Verify
Call `GET /` and then `GET /workshop1/customers-good`.

## 5. Reset when necessary
```powershell
.\Reset-Lab.ps1
```
