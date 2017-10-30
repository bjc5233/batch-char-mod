@echo off& call load.bat _setFontSize

(%_call% ("6x12") %_setFontSize%)
call sleep 15
start charModDrop.bat %*
call sleep 15
(%_call% ("8x16") %_setFontSize%)