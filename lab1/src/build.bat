@echo off
if "%~1" == "" goto ARGUMENT_ERROR
set ver="%~1"

cd../
if exist %ver% goto ALREADY_EXIST_ERROR

mkdir %ver%
mkdir %ver%/config

echo Building frontend
cd src/frontend
dotnet publish -c Release
if %ERRORLEVEL% EQU 1 goto FRONTEND_BUILDING_ERROR
xcopy "bin\release\netcoreapp2.0\publish" "../../%ver%/Frontend" /E /I
cd ../

echo Building backend
cd backend
dotnet publish -c Release
if %ERRORLEVEL% EQU 1 goto BACKEND_BUILDING_ERROR
xcopy "bin\release\netcoreapp2.0\publish" "../../%ver%/Backend" /E /I
cd ../


xcopy "run.bat" "../%ver%"
xcopy "stop.bat" "../%ver%"

goto END

:ARGUMENT_ERROR
echo Invalid argument
echo Usage: build ^<semVer^>
goto END

:ALREADY_EXIST_ERROR
echo Version %ver% already exist
goto END

:FRONTEND_BUILDING_ERROR
echo Frontend build failure
goto END

:BACKEND_BUILDING_ERROR
echo Backend build failure
goto END


:END