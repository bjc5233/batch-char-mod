@echo off
set words=助手MM:关窗户嘛 关显示器 推拿凳子 打卡！
if "%date:~-2%"=="周三" set words=助手MM:报销嘛! %words%
if "%date:~-2%"=="周四" set words=助手MM:报销嘛! %words%
call charMod.bat %words%