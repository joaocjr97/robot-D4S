@echo off
REM Script para executar testes Robot Framework em modo HEADLESS no Windows
REM Este script executa todos os testes sem abrir o navegador visualmente

echo ========================================
echo   Executor de Testes HEADLESS (Windows)
echo ========================================
echo.

REM Verificar se Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python não encontrado. Instale o Python e tente novamente.
    pause
    exit /b 1
)

REM Verificar se Robot Framework está instalado
python -c "import robot" >nul 2>&1
if errorlevel 1 (
    echo ❌ Robot Framework não encontrado. Instale com: pip install robotframework
    pause
    exit /b 1
)

REM Executar o script Python em modo headless
echo 🚀 Iniciando execução dos testes em modo HEADLESS...
echo 🌐 Navegador será executado sem interface gráfica
echo.
python run_headless.py %*

REM Verificar se a execução foi bem-sucedida
if errorlevel 1 (
    echo.
    echo ❌ Erro na execução dos testes.
    pause
    exit /b 1
) else (
    echo.
    echo ✅ Execução concluída com sucesso!
    echo 📊 Verifique os relatórios na pasta 'results'
)

pause
