@echo off& call lib\load.bat _randomColor _reverseStr _strlen _strlen2 _getLF& setlocal enabledelayedexpansion& mode 140,30
(%_randomColor%)
cd data

::��ȫ��ʹ��16X16�ĵ��󣬶԰��ʹ��8X16�ĵ���
::showStyle[0:����, 1:���µߵ�, 2:���ҵߵ�]
set QJ=��& set BJ=��& set showStyle=0
if "%1" NEQ "" (
    for %%i in (%*) do (
        set zf=%%i
        if "!zf!" NEQ "" set zf=!zf: =!& if "!zf!" NEQ "" call :parse& call :show& pause>nul& cls
    )
    goto :EOF
) else (
    for /l %%i in () do (
        set zf=& set /p zf=�����ַ�:
        if "!zf!" NEQ "" set zf=!zf: =!& if "!zf!" NEQ "" call :parse& call :show& pause>nul& cls
    )
)





:parse
::�ָ��ַ���
(%_call% ("zf len") %_strlen%)
(%_call% ("zf len2") %_strlen2%)
set /a winLen=len2*16+1& if !winLen! GTR 140 mode !winLen!,30

set zf=0!zf!
for /l %%i in (1,1,!len!) do set zf_%%i=!zf:~%%i,1!& echo ��%%i���ַ�:[!zf_%%i!]
::ȡ��ÿ���ֵ���ģ
for /l %%i in (1,1,16) do set line%%i=
for /l %%i in (1,1,!len!) do set lineIndex=0& for /f "eol=# delims=" %%j in ('mod.exe !zf_%%i!') do set /a lineIndex+=1& for %%k in (!lineIndex!) do set line%%k=!line%%k!!%%j
::����border
set /a borderLen=len2*8& set border=& for /l %%i in (1,1,!borderLen!) do set border=!border!��
goto :EOF


:show
set showStr=
if !showStyle!==0 for /l %%i in (1,1,16) do set showStr=!showStr!!line%%i!!LF!
if !showStyle!==1 for /l %%i in (16,-1,1) do set showStr=!showStr!!line%%i!!LF!
if !showStyle!==2 for /l %%i in (1,1,16) do set line=!line%%i!& (%_call% ("line line") %_reverseStr%)& set showStr=!showStr!!line!!LF!
set showStr=!showStr:1=%QJ%!& echo !border!!LF!!showStr:0=%BJ%!!border!
goto :EOF