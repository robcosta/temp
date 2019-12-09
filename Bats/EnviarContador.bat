echo off
cls

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


rem verifica se a pasta de NFe a ser enviadas existem
IF EXIST "C:\SGBR\Master\Arquivos SAT\CF-e\%pasta%\" (goto copia_CF-e
)ELSE (
echo Nao foram encontradas NF-e para o mes:%pasta:~4,2% ano:%pasta:~0,4%

pause
exit

rem Copiando pastas CF-e
:copia_CF-e
rem verifica se a pasta temp existe, caso contrário cria
IF EXIST "c:\temp" (cd c:\temp) ELSE (md c:\temp)

rem Verifica se a pasta CF-e existe, caso contrário cria
IF EXIST c:\temp\CF-e (cd c:\temp\CF-e) ELSE (md c:\temp\CF-e)

rem cria a pasta relacionada por ano e mes
cd c:\temp\CF-e
md %pasta%
echo on
rem Copia a pasta CF-e
xcopy /S/E "C:\SGBR\Master\Arquivos SAT\CF-e\%pasta%"\*.* c:\temp\CF-e\%pasta% /y

rem Compactando a pasta CF-e
rar a c:\temp\CF-e c:\temp\CF-e\%pasta%\*.*

rem Verifica se existem CF-e-Cancelados existe
IF EXIST "C:\SGBR\Master\Arquivos SAT\CF-e Cancelados\%pasta%\" (xcopy /S/E "C:\SGBR\Master\Arquivos SAT\CF-e\%pasta%"\*.* c:\temp\CF-e-Cancelaodos\%pasta% /y
)ELSE (
echo Não foram encontradas NF-e caneladas no mes:%pasta:~6,4" ano:%pasta:0,4
)






rem Enviando e-mail para o contador
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Temp\Notas_Fiscais2.ps1" -Verb RunAs

pause
exit


