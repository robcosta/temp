:: INICIO DO ARQUIVO EM LOTES
@echo off
color 1F
title colocando texto em variavel
set LOG1=LOG1.txt
set LOG2=LOG2.txt
cls
:: RÓTULO INICIAL
:begin
cls
echo.
echo.
systeminfo >%LOG1%
if exist %LOG1% (goto :gr) else (echo. nao gerado o LOG 1 & pause & exit)
:gr
cls
mode 50,10
FIND /I "Nome do sistema operacional:" %LOG1% > %LOG2%
FOR /F "TOKENS=5-9 DELIMS= " %%B IN (%LOG2%) DO SET B=%%B %%C %%D %%E %%F
ECHO.&ECHO.&ECHO SISTEMA OPERACIONAL:&ECHO.%B%
:CLEAR
DEL /Q /F %LOG1% %LOG2%
PAUSE>NUL
EXIT
