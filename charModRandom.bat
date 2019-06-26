@echo off& call load.bat _randomColor _reverseStr _strlen _strlen2 _getLF& call loadE.bat CurS fontSize& setlocal enabledelayedexpansion& mode 140,30
(%_randomColor%)& %fontSize% 6 12& %CurS% /crv 0& cd data

::随机展示一个字符格子，直至完全展示完整
::对全角使用16X16的点阵，对半角使用8X16的点阵
::showStyle:  0[正常]    1[上下颠倒]   2[左右颠倒]
set QJ=█& set BJ=  & set showStyle=0
if "%1" NEQ "" (
    set zf=%*
) else (
    set zf=& set /p zf=输入字符:
)
if "!zf!" NEQ "" set zf=!zf: =!
if "!zf!" NEQ "" (
    call :parse
    for /l %%j in () do call :showRandom
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
(%_call% ("line1 lineLen") %_strlen%)
set /a lineLenMaxIndex=lineLen-1
set eleHideIndex=1
for /l %%i in (1,1,16) do (
    set lineTmp=!line%%i!
    for /l %%j in (0,1,!lineLenMaxIndex!) do (
        set ele=!lineTmp:~%%j,1!
        if !ele!==1 set eleHide!eleHideIndex!=%%i_%%j& set /a eleHideIndex+=1
    )
)
set /a eleHideMaxIndex=eleHideIndex-1
::计算border
set /a borderLen=len2*8& set border=& for /l %%i in (1,1,!borderLen!) do set border=!border!━
goto :EOF


:showRandom
::一开始所有字符格子都是隐藏的
::在这里取随机一个从列表中移除，真正show的时候遍历所有隐藏格子
(%_call% ("1 !eleHideMaxIndex! eleHideRemoveIndex") %_getRandomNum%)
set eleHide!eleHideRemoveIndex!=
set /a eleHideRemoveIndex+=1
for /l %%i in (!eleHideRemoveIndex!,1,!eleHideMaxIndex!) do (
    set /a newIndex=%%i-1& set eleHide!newIndex!=!eleHide%%i!
)
set eleHide!eleHideMaxIndex!=
set /a eleHideMaxIndex-=1
for /l %%i in (1,1,16) do set lineShow%%i=!line%%i!
for /l %%i in (1,1,!eleHideMaxIndex!) do (
    for /f "tokens=1,2 delims=_" %%j in ("!eleHide%%i!") do (
        set /a inlineIndex=%%k+1& set lineShow=!lineShow%%j!
        for %%a in (!inlineIndex!) do set lineShow%%j=!lineShow:~0,%%k!0!lineShow:~%%a!
    )
)

set showStr=
for /l %%i in (1,1,16) do set showStr=!showStr!!lineShow%%i!!LF!
set showStr=!showStr:1=%QJ%!& echo !LF!!LF!!border!!LF!!showStr:0=%BJ%!!border!
if !eleHideMaxIndex! LEQ 0 (
    pause>nul& exit
) else (
    sleep 10 >nul& cls
)
goto :EOF