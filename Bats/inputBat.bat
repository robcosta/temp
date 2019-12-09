echo off
cls
:ano
echo.
set /p ano=Digite o ano [2019~2030]:

if %ano% lss 2019 goto ano
if %ano% gtr 2030 goto ano	
goto mes

pause
exit

:mes
set /P mes=Digite o mes [01~12]:
if %mes% lss 1 goto mes
if %mes% gtr 12 goto mes
goto pasta

:pasta
set pasta=%ano%%mes%
echo Voce digitou %pasta%
set /p opcao=Correto? [s] ou [n] ? 
if "%opcao%" == "s" goto copia

if EXIST "C:\SGBR\Master\Arquivos SAT\CF-e\%pasta%/*.*" (goto copia)
else (goto mensagem)

goto ano




rem Copiando pastas CFE

:copia
cd c:\temp
md %pasta%
xcopy /S/E "C:\SGBR\Master\Arquivos SAT\CF-e\%pasta%"\*.* c:\temp\%pasta%

cd C:\SGBR\Master\Arquivos SAT\CF-e\%pasta%
dir
pause
exit


:mensagem
echo Arquivo inexistente!
goto ano
