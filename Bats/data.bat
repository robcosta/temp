echo off
cls

rem Cria o nome da pasta a ser copiada
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

rem pasta=%pasta%

rem pause