@echo off
chcp 65001 > nul

set NODE_BIN_PATH=node_modules\.bin
set OUT_DIR=.\src\stores\proto

REM 使用另一种语法来获取命令行参数，并确保参数被正确转义
set "API_PROTO_FILES=.\src\stores\proto\%~1"
set "API_PROTO_FILES=%API_PROTO_FILES:/=\%"

REM 获取脚本目录的绝对路径
for %%I in ("%~dp0") do set "SCRIPT_DIR=%%~fI"

REM 设置当前目录为脚本目录
cd /d "%SCRIPT_DIR%"

REM 打印一些信息，包括中文字符
echo NODE_BIN_PATH: %NODE_BIN_PATH%
echo OUT_DIR: %OUT_DIR%
echo API_PROTO_FILES: %API_PROTO_FILES%
echo SCRIPT_DIR: %SCRIPT_DIR%
echo.

REM 使用 `FOR` 循环遍历文件
for /r "%API_PROTO_FILES%" %%G in (*.proto) do (
    echo 编译 "%%~dpnxG"...

    REM 使用 UTF-8 编码输出中文字符
    %NODE_BIN_PATH%\protoc ^
    --proto_path=D:\AkitaCode\cloneProject\xenith-ui\src\stores\proto ^
    --proto_path=D:\AkitaCode\cloneProject\xenith-ui\src\stores\proto\third_party ^
    --ts_out=%OUT_DIR% ^
    "%%~dpnxG"

    REM 检查上一个命令的退出代码
    if %errorlevel% equ 0 (
        echo 编译成功.
    ) else (
        echo 编译失败.
    )
    echo.
)

REM 恢复原始目录
cd /d "%SCRIPT_DIR%"
