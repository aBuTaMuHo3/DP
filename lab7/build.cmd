@echo off
if "%~1" == "" goto error

rem Создаём папку с новой версией и две папки для компонентов
md %~1
mkdir "%~1"\"Frontend"
mkdir "%~1"\"Backend"
mkdir "%~1"\"TextRankCalc"
mkdir "%~1"\"TextListener"
mkdir "%~1"\"VowelConsCounter"
mkdir "%~1"\"VowelConsRater"
mkdir "%~1"\"TextStatistics"
mkdir "%~1"\"config"

rem Компилируем два компонента
start /wait /d src\Frontend dotnet publish
start /wait /d src\Backend dotnet publish
start /wait /d src\TextRankCalc dotnet publish
start /wait /d src\TextListener dotnet publish
start /wait /d src\VowelConsCounter dotnet publish
start /wait /d src\VowelConsRater dotnet publish
start /wait /d src\TextStatistics dotnet publish

rem Копируем компоненты в созданную папку в соответствующие директории
start /wait xcopy src\Frontend\bin\Debug\netcoreapp2.0\publish "%~1"\"Frontend"
start /wait xcopy src\Backend\bin\Debug\netcoreapp2.0\publish "%~1"\"Backend"
start /wait xcopy src\TextRankCalc\bin\Debug\netcoreapp2.0\publish "%~1"\"TextRankCalc"
start /wait xcopy src\TextListener\bin\Debug\netcoreapp2.0\publish "%~1"\"TextListener"
start /wait xcopy src\VowelConsCounter\bin\Debug\netcoreapp2.0\publish "%~1"\"VowelConsCounter"
start /wait xcopy src\VowelConsRater\bin\Debug\netcoreapp2.0\publish "%~1"\"VowelConsRater"
start /wait xcopy src\TextStatistics\bin\Debug\netcoreapp2.0\publish "%~1"\"TextStatistics"

rem Копируем папку конфига в папку с проектом
start /wait xcopy src\config "%~1"\config

rem Копируем запускатор в папку с проектом
start /wait xcopy src\run.cmd "%~1"

rem Копируем останавливатор в папку с проектом
start /wait xcopy src\stop.cmd "%~1"

echo "Project created"
exit 0

:error
echo "Empty argument"
exit 1