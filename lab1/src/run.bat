start "Frontend" /d "%~dp0/Frontend" dotnet frontend.dll
start "Backend" /d "%~dp0/Backend" dotnet backend.dll
start "TextListener" /d "%~dp0/TextListener" dotnet textlistener.dll

start "WebApp" "http://localhost:5001/"