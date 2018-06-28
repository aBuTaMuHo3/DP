@echo off
if "%~1" == "" goto error

rem ������ ����� � ����� ������� � ��� ����� ��� �����������
md %~1
mkdir "%~1"\"Frontend"
mkdir "%~1"\"Backend"
mkdir "%~1"\"TextRankCalc"
mkdir "%~1"\"TextListener"
mkdir "%~1"\"config"

rem ����������� ��� ����������
start /wait /d src\Frontend dotnet publish
start /wait /d src\Backend dotnet publish
start /wait /d src\TextRankCalc dotnet publish
start /wait /d src\TextListener dotnet publish

rem �������� ���������� � ��������� ����� � ��������������� ����������
start /wait xcopy src\Frontend\bin\Debug\netcoreapp2.0\publish "%~1"\"Frontend"
start /wait xcopy src\Backend\bin\Debug\netcoreapp2.0\publish "%~1"\"Backend"
start /wait xcopy src\TextRankCalc\bin\Debug\netcoreapp2.0\publish "%~1"\"TextRankCalc"
start /wait xcopy src\TextListener\bin\Debug\netcoreapp2.0\publish "%~1"\"TextListener"

rem �������� ����� ������� � ����� � ��������
start /wait xcopy src\config "%~1"\config

rem �������� ���������� � ����� � ��������
start /wait xcopy src\run.cmd "%~1"

rem �������� �������������� � ����� � ��������
start /wait xcopy src\stop.cmd "%~1"

echo "Project created"
exit 0

:error
echo "Empty argument"
exit 1