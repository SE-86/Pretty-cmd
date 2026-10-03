@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo === Pretty cmd 重新打包 ===

rem 自动挑选装有 PyInstaller 的解释器（优先 python，其次 py -3.14）
set PYEXE=python
%PYEXE% -c "import PyInstaller" >nul 2>&1 || set PYEXE=py -3.14
%PYEXE% -c "import PyInstaller" >nul 2>&1 || (
    echo 未找到带 PyInstaller 的 Python，请先执行： python -m pip install pyinstaller
    pause
    exit /b 1
)
echo 使用解释器： %PYEXE%

%PYEXE% -m PyInstaller --noconfirm --clean --onefile --windowed --name "PrettyCmd" --icon "assets\app.ico" --collect-all customtkinter --distpath dist --workpath build main.py

if exist "dist\PrettyCmd.exe" (
    echo 打包成功：dist\PrettyCmd.exe
) else (
    echo 打包失败，请检查上方日志
)
pause
