@echo off& call load.bat _randomColor _reverseStr _strlen _strlen2 _getLF& setlocal enabledelayedexpansion& mode 140,30
(%_randomColor%)
cd data

::��ȫ��ʹ��16X16�ĵ��󣬶԰��ʹ��8X16�ĵ���
::showStyle:  0[����]    1[���µߵ�]   2[���ҵߵ�]
set QJ=��& set BJ=��& set showStyle=0
if "%1" NEQ "" (
    for /l %%i in () do (
        for %%i in (%*) do (
            set zf=%%i
            if "!zf!" NEQ "" set zf=!zf: =!& if "!zf!" NEQ "" call :parse& call :showDrop& timeout /t 8 >nul& cls
        )    
    )
    goto :EOF
) else (
    set zf=& set /p zf=�����ַ�:
    if "!zf!" NEQ "" set zf=!zf: =!& if "!zf!" NEQ "" call :parse& call :showDrop& timeout /t 8>nul& cls
)





:parse
::�ָ��ַ���
(%_call% ("zf len") %_strlen%)
(%_call% ("zf len2") %_strlen2%)
set /a winLen=len2*16+1& if !winLen! GTR 140 mode !winLen!,30

set zf=0!zf!
for /l %%i in (1,1,!len!) do set zf_%%i=!zf:~%%i,1!
set oneLineBlank=
for /l %%i in (1,1,!winLen!) do set oneLineBlank=!oneLineBlank! 
::ȡ��ÿ���ֵ���ģ
for /l %%i in (1,1,16) do set line%%i=
for /l %%i in (1,1,!len!) do set lineIndex=0& for /f "eol=# delims=" %%j in ('mod.exe !zf_%%i!') do set /a lineIndex+=1& for %%k in (!lineIndex!) do set line%%k=!line%%k!!%%j
::����border
set /a borderLen=len2*8& set border=& for /l %%i in (1,1,!borderLen!) do set border=!border!��
goto :EOF


:showDrop
::�������������Ǳ߽�(������ƴ���ַ���ʱ����)
::x�������յ��У���һ���ǵ�16�����䣬Ȼ����15�����䣬�����ǵ�1������
::y����x��ǰ�������䵽���У�ÿ�����䶼��Ҫ�����ӵ�1���䵽�Լ�ָ���У����14�е��ַ���Ҫ�ӵ�1���䵽��14�в������
::z������ƴ��ʱ���ϵ���ƴ�ӣ����14���ַ����պ��䵽��10�У���ô��1-9���ǿհ��У���10����14����ʽ�ַ�������11-14���ǿհ��У���15-16����ʽ�ַ���
for /l %%x in (16,-1,1) do (
    for /l %%y in (1,1,%%x) do (
        cls& set showStr=
        for /l %%z in (1,1,16) do (
            if %%z LSS %%y (
                set showStr=!showStr!!oneLineBlank!!LF!
            )
            if %%z EQU %%y (
                set showStr=!showStr!!line%%x!!LF!
            )
            if %%z GTR %%y if %%z LEQ %%x (
                set showStr=!showStr!!oneLineBlank!!LF!
            )
            if %%z GTR %%y if %%z GTR %%x (
                set showStr=!showStr!!line%%z!!LF!
            )
        )
        set showStr=!showStr:1=%QJ%!& echo !border!!LF!!showStr:0=%BJ%!!border!
        sleep 100 >nul
    )
)
goto :EOF