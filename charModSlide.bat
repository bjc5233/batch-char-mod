@echo off& call load.bat _randomColor _reverseStr _strlen _strlen2 _getLF& call loadE.bat CurS fontSize& setlocal enabledelayedexpansion& mode 140,30
(%_randomColor%)& %fontSize% 6 12& %CurS% /crv 0& cd data
::������Ч��


::��ȫ��ʹ��16X16�ĵ��󣬶԰��ʹ��8X16�ĵ���
::showStyle:  0[����]    1[���µߵ�]   2[���ҵߵ�]
set QJ=��& set BJ=��& set showStyle=0
if "%1" NEQ "" (
    for /l %%i in () do (
        for %%i in (%*) do (
            set zf=%%i
            if "!zf!" NEQ "" set zf=!zf: =!& if "!zf!" NEQ "" call :parse& call :showSlideStyle2
        )    
    )
    goto :EOF
) else (
    set zf=& set /p zf=�����ַ�:
    if "!zf!" NEQ "" set zf=!zf: =!& if "!zf!" NEQ "" call :parse& call :showSlideStyle2
)
goto :EOF




:parse
::�ָ��ַ���
(%_call% ("zf len") %_strlen%)
(%_call% ("zf len2") %_strlen2%)
set /a winLen=len2*16+1& if !winLen! GTR 140 mode !winLen!,30

set zf=0!zf!
for /l %%i in (1,1,!len!) do set zf_%%i=!zf:~%%i,1!
set oneLineBlank=& set oneLineBlankZero=
for /l %%i in (1,1,!winLen!) do set oneLineBlank=!oneLineBlank! & set oneLineBlankZero=!oneLineBlankZero!0
::ȡ��ÿ���ֵ���ģ
for /l %%i in (1,1,16) do set line%%i=
for /l %%i in (1,1,!len!) do set lineIndex=0& for /f "eol=# delims=" %%j in ('mod.exe !zf_%%i!') do set /a lineIndex+=1& for %%k in (!lineIndex!) do set line%%k=!line%%k!!%%j
(%_call% ("line1 lineLen") %_strlen%)
::����border
set /a borderLen=len2*8& set border=& for /l %%i in (1,1,!borderLen!) do set border=!border!��
goto :EOF


:showSlideStyle1
::�����һ�У�ÿ������һ�У�ֱ����ȫչʾ
set /a lineLenIndex=lineLen-1
for /l %%x in (0,1,%lineLenIndex%) do (
    cls& set showStr=
    for /l %%y in (1,1,16) do (
        set showStr=!showStr!!line%%y:~0,%%x!!LF!
    )
    set showStr=!showStr:1=%QJ%!& echo !border!!LF!!showStr:0=%BJ%!!border!
    sleep 30 >nul
)
pause>nul& cls
goto :EOF

:showSlideStyle2
set /a lineLenIndex=lineLen-1
for /l %%x in (%lineLenIndex%,-1,0) do (
    cls& set showStr=
    for /l %%y in (1,1,16) do (
        set showStr=!showStr!!line%%y:~%%x!!LF!
    )
    set showStr=!showStr:1=%QJ%!& echo !LF!!LF!!border!!LF!!showStr:0=%BJ%!!border!
    sleep 30 >nul
)
pause>nul& cls
goto :EOF