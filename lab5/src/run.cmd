@echo off
setlocal enabledelayedexpansion

start "Frontend"  /d Frontend dotnet Frontend.dll
start "Backend"  /d Backend dotnet Backend.dll 
start "TextRankCalc"  /d TextRankCalc dotnet TextRankCalc.dll
start "TextListener" /d TextListener dotnet TextListener.dll

set file=config\components_config.txt
for /f "tokens=1,2 delims=:" %%a in (%file%) do (
for /l %%i in (1, 1, %%b) do start "%%a" /d %%a dotnet %%a.dll
)

start http://127.0.0.1:5001/home/upload

