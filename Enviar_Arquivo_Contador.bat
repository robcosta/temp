echo off
cls
echo ***************************************
echo ****                               ****
echo ****  ENVIO DE DOCUMENTOS FISCAIS  ****
echo ****                               ****
echo ***************************************
rem Verifica se existem arquivos a serem enviados [0->nao existe 1->existe]
set flag=0

rem Variavel que compora a mensagem do log.txt
set cfe=0
set cfeCancelado=0

rem Cria o nome da pasta a ser enviada
rem composto por ano e mes anterior 

SET ano=%date:~6,4%
SET mes=%date:~3,2%
SET /A anoAnterior=ano-1

IF %mes% EQU 01 SET pasta=%anoAnterior%12
IF %mes% EQU 02 SET pasta=%ano%01
IF %mes% EQU 03 SET pasta=%ano%02
IF %mes% EQU 04 SET pasta=%ano%03
IF %mes% EQU 05 SET pasta=%ano%04
IF %mes% EQU 06 SET pasta=%ano%05
IF %mes% EQU 07 SET pasta=%ano%06
IF %mes% EQU 08 SET pasta=%ano%07
IF %mes% EQU 09 SET pasta=%ano%08
IF %mes% EQU 10 SET pasta=%ano%09
IF %mes% EQU 11 SET pasta=%ano%10
IF %mes% EQU 12 SET pasta=%ano%11

rem Copia pasta de CF-e caso existam
IF EXIST "C:\SGBR\Master\Arquivos SAT\CF-e\%pasta%\" (
	set flag=1
	rem verifica se a pasta temp existe, caso contrário cria
	IF EXIST "c:\temp" (cd c:\temp) ELSE (md c:\temp)

	rem Verifica se a pasta CF-e existe, caso contrário cria
	IF EXIST "c:\temp\CF-e" (cd "c:\temp\CF-e") ELSE (md "c:\temp\CF-e")

	rem Verifica se a pasta relacionada por ano e mes existe
	IF EXIST "c:\temp\CF-e\%pasta%" (cd "c:\temp\CF-e\%pasta%") ELSE (md "c:\temp\CF-e\%pasta%")

	rem copia os arquivos
	echo Copiando CFe
	xcopy /S/E/V/Y/Q "C:\SGBR\Master\Arquivos SAT\CF-e\%pasta%"\*.* "c:\temp\CF-e\%pasta%"

	rem zipando NF-e
	echo.                                          
	echo Compactando CFe
	rar a -as c:\temp\CF-e c:\temp\CF-e\%pasta%\*.*
	set cfe=1

) ELSE (
	echo Nao foram encontradas NF-e no mes:%pasta:~4,2% ano:%pasta:~0,4%
	set flag=0
)

rem pause

rem Copia pasta de CF-e Cancelados cajo existam
IF EXIST "C:\SGBR\Master\Arquivos SAT\CF-e Cancelados\%pasta%\" (
	set flag=1
	rem verifica se a pasta temp existe, caso contrário cria
	IF EXIST "c:\temp" (cd c:\temp) ELSE (md c:\temp)

	rem Verifica se a pasta CF-e Cancelados existe, caso contrário cria
	IF EXIST "c:\temp\CF-e Cancelados" (cd "c:\temp\CF-e Cancelados") ELSE (md "c:\temp\CF-e Cancelados")

	rem Verifica se a pasta relacionada por ano e mes existe
	IF EXIST "c:\temp\CF-e Cancelados\%pasta%" (cd "c:\temp\CF-e Cancelados\%pasta%") ELSE (md "c:\temp\CF-e Cancelados\%pasta%")

	rem copia os arquivos
	echo Copiando CFe Cancelados
	xcopy /S/E/V/y/Q "C:\SGBR\Master\Arquivos SAT\CF-e Cancelados\%pasta%"\*.* "c:\temp\CF-e Cancelados\%pasta%"

	rem zipando NF-e Cancelados
	echo.                                          
	echo Compactando CFe
	rar a -as "c:\temp\CF-e Cancelados"  "c:\temp\CF-e Cancelados\%pasta%\*.*"
	set cfeCancelado=1
) ELSE (
	echo Nao foram encontradas NF-e canceladas no mes:%pasta:~4,2% ano:%pasta:~0,4%
	rem Necessario criar um arquivo CF-e Cncelado.zip para anexar ao email
	rem rar a "c:\temp\CF-e Cancelados"  "c:\temp\CF-e Cancelados\*.*"
	IF %flag% equ 0 set flag=0
)

rem pause

rem echo *************** FLAG = %flag%  *************************

rem pause

rem Enviando ao contador
IF %flag% == 1 (
	rem chama o PowerShell para proceder o envio dos arquivos
	echo.
	echo Enviando email...
	echo.
	PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Temp\Notas_Fiscais.ps1" -Verb RunAs	>> C:\temp\log.txt
	echo.
	rem preenchendo o log.txt
	echo Em %date% as %time%. Anexos: CFe: %cfe%  CFe Cancelado: %cfeCancelado% >> c:\temp\log.txt
) else (
	echo Nao existem arquivos para serem enviados ao contador
	pause
	exit
)



rem deletando as pastas e arquivos
ECHO Deletando arquivos e pasta CF-e
IF EXIST "C:\Temp\CF-e\%pasta%\*.*" del "C:\Temp\CF-e\%pasta%\*.*" /q
IF EXIST "C:\Temp\CF-e\%pasta%" rd "C:\Temp\CF-e\%pasta%"

rem Deletando arquivos e pasta CF-e Cancelados
IF EXIST "C:\Temp\CF-e Cancelados\%pasta%\*.*" del "C:\Temp\CF-e Cancelados\%pasta%\*.*" /q
IF EXIST "C:\Temp\CF-e Cancelados\%pasta%" rd "C:\Temp\CF-e Cancelados\%pasta%"

rem deletando arquivos .rar
IF EXIST "C:\Temp\*.rar" del "C:\Temp\*.rar"

echo Pasta(s) "%pasta%" e seus arquivos foram deletados
echo.
pause
exit




