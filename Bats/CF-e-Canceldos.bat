echo off
cls
set pasta=201911
set flag=0
rem Copia pasta de CF-e Cancelados cajo existam
IF EXIST "C:\SGBR\Master\Arquivos SAT\CF-e Cancelados\%pasta%\" (
	set flag=0
	rem verifica se a pasta temp existe, caso contrário cria
	IF EXIST "c:\temp" (cd c:\temp) ELSE (md c:\temp)

	rem Verifica se a pasta CF-e Cancelados existe, caso contrário cria
	IF EXIST "c:\temp\CF-e Cancelados" (cd "c:\temp\CF-e Cancelados") ELSE (md "c:\temp\CF-e Cancelados")

	rem Verifica se a pasta relacionada por ano e mes existe
	IF EXIST "c:\temp\CF-e Cancelados\%pasta%" (cd "c:\temp\CF-e Cancelados\%pasta%") ELSE (md "c:\temp\CF-e Cancelados\%pasta%")

	rem copia os arquivos
	xcopy /S/E "C:\SGBR\Master\Arquivos SAT\CF-e Cancelados\%pasta%"\*.* "c:\temp\CF-e Cancelados\%pasta%" /y
)ELSE (
	echo Nao foram encontradas NF-e caneladas no mes:%pasta:~4,2% ano:%pasta:~0,4%
	set flag=1
)
echo flag=%flag%
pause