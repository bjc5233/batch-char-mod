@echo off
set words=����MM:�ش����� ����ʾ�� ���õ��� �򿨣�
if "%date:~-2%"=="����" set words=����MM:������! %words%
if "%date:~-2%"=="����" set words=����MM:������! %words%
call charMod.bat %words%