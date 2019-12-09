echo off
cls
set flag=0
echo *************** FLAG = %flag%  *************************

pause

if %flag% == 1 (echo flagou) else (echo nao flagou)
pause



rem Enviando ao contador
IF %flag% == 1 (
	rem chama o PowerShell para proceder o envio dos arquivos
	echo PowerShell ...
	PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Temp\Notas_Fiscais2.ps1" -Verb RunAs
	pause
	exit
) else (
	echo Nao existem arquivos para serem enviados ao contador
	pause
	exit
)
