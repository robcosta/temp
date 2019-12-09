set pasta=201911


rem Deletando arquivos e pasta CF-e
del "C:\Temp\CF-e\%pasta%\*.*" /q
rd "C:\Temp\CF-e\%pasta%"

rem Deletando arquivos e pasta CF-e Cancelados
del "C:\Temp\CF-e Cancelados\%pasta%\*.*" /q
rd "C:\Temp\CF-e Cancelados\%pasta%"

rem deletando arquivos .rar
del C:\Temp\*.rar