@echo off& call load.bat _randomColor _reverseStr _strlen _strlen2 _getLF& setlocal enabledelayedexpansion& mode 140,30
(%_randomColor%)
cd data

::对全角使用16X16的点阵，对半角使用8X16的点阵
::showStyle:  0[正常]    1[上下颠倒]   2[左右颠倒]
set QJ=█& set BJ=□& set showStyle=0
if "%1" NEQ "" (
    for /l %%i in () do (
        for %%i in (%*) do (
            set zf=%%i
            if "!zf!" NEQ "" set zf=!zf: =!& if "!zf!" NEQ "" call :parse& call :showDrop& timeout /t 8 >nul& cls
        )    
    )
    goto :EOF
) else (
    set zf=& set /p zf=输入字符:
    if "!zf!" NEQ "" set zf=!zf: =!& if "!zf!" NEQ "" call :parse& call :showDrop& timeout /t 8>nul& cls
)





:parse
::分割字符串
(%_call% ("zf len") %_strlen%)
(%_call% ("zf len2") %_strlen2%)
set /a winLen=len2*16+1& if !winLen! GTR 140 mode !winLen!,30

set zf=0!zf!
for /l %%i in (1,1,!len!) do set zf_%%i=!zf:~%%i,1!
set oneLineBlank=
for /l %%i in (1,1,!winLen!) do set oneLineBlank=!oneLineBlank! 
::取得每个字的字模
for /l %%i in (1,1,16) do set line%%i=
for /l %%i in (1,1,!len!) do set lineIndex=0& for /f "eol=# delims=" %%j in ('mod.exe !zf_%%i!') do set /a lineIndex+=1& for %%k in (!lineIndex!) do set line%%k=!line%%k!!%%j
::计算border
set /a borderLen=len2*8& set border=& for /l %%i in (1,1,!borderLen!) do set border=!border!━
goto :EOF


:showDrop
::最上最下两行是边界(在最终拼接字符串时考虑)
::x代表最终的行，第一次是第16行下落，然后是15行下落，最终是第1行下落
::y代表x当前正好下落到哪行，每行下落都需要经历从第1行落到自己指定行，如第14行的字符需要从第1行落到第14行才算完成
::z代表画布拼接时从上到下拼接，如第14行字符，刚好落到第10行，那么第1-9行是空白行，第10行是14行正式字符串，第11-14行是空白行，第15-16是正式字符串
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