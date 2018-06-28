@echo off
setlocal enabledelayedexpansion

start "Frontend"  /d Frontend dotnet Frontend.dll
start "Backend"  /d Backend dotnet Backend.dll 
start "TextRankCalc"  /d TextRankCalc dotnet TextRankCalc.dll
start "TextListener" /d TextListener dotnet TextListener.dll

start http://127.0.0.1:5001/home/upload

