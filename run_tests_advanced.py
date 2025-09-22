#!/usr/bin/env python3
"""
Script avançado para executar testes Robot Framework com opções de modo.
Permite escolher entre modo normal (com navegador) e headless (sem navegador).
"""

import os
import sys
import subprocess
import argparse
from datetime import datetime
from pathlib import Path

def get_project_root():
    """Retorna o diretório raiz do projeto."""
    return Path(__file__).parent.absolute()

def create_output_directory(mode="normal"):
    """Cria o diretório de saída com timestamp e modo."""
    project_root = get_project_root()
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_dir = project_root / "results" / f"{mode}_run_{timestamp}"
    output_dir.mkdir(parents=True, exist_ok=True)
    return output_dir

def run_tests(test_file=None, output_dir=None, headless=False):
    """
    Executa os testes Robot Framework.
    
    Args:
        test_file: Arquivo de teste específico (opcional)
        output_dir: Diretório de saída (opcional)
        headless: Se True, executa em modo headless
    """
    project_root = get_project_root()
    smoke_test_dir = project_root / "Smoke Test - D4S"
    
    if not output_dir:
        mode = "headless" if headless else "normal"
        output_dir = create_output_directory(mode)
    
    # Comando base do Robot Framework
    cmd = [
        "robot",
        "--outputdir", str(output_dir),
        "--output", "output.xml",
        "--log", "log.html", 
        "--report", "report.html"
    ]
    
    # Adicionar configurações específicas do modo
    if headless:
        cmd.extend([
            "--variable", "BROWSER:headlesschrome",
            "--variable", "HEADLESS_MODE:true",
            "--variable", "CHROME_OPTIONS:--window-size=1920,1080;--disable-gpu;--no-sandbox"
        ])
    else:
        cmd.extend([
            "--variable", "BROWSER:chrome",
            "--variable", "HEADLESS_MODE:false",
            "--variable", "CHROME_OPTIONS:--window-size=1920,1080"
        ])
    
    if test_file:
        # Executa um arquivo específico
        test_path = smoke_test_dir / test_file
        if not test_path.exists():
            print(f"❌ Arquivo de teste não encontrado: {test_path}")
            return False
        cmd.append(str(test_path))
    else:
        # Executa todos os testes
        cmd.append(str(smoke_test_dir))
    
    mode_text = "HEADLESS (sem navegador)" if headless else "NORMAL (com navegador)"
    print(f"🚀 Executando testes Robot Framework em modo {mode_text.upper()}...")
    print(f"📁 Diretório de saída: {output_dir}")
    print(f"🌐 Modo: {mode_text}")
    print(f"📋 Comando: {' '.join(cmd)}")
    print("-" * 60)
    
    try:
        result = subprocess.run(cmd, check=False, capture_output=False)
        print("-" * 60)
        if result.returncode == 0:
            print(f"✅ Testes executados com sucesso!")
        else:
            print(f"⚠️  Testes executados com falhas (código: {result.returncode})")
        print(f"📊 Relatórios disponíveis em: {output_dir}")
        print(f"   - Relatório HTML: {output_dir / 'report.html'}")
        print(f"   - Log HTML: {output_dir / 'log.html'}")
        return True
    except KeyboardInterrupt:
        print("-" * 60)
        print(f"⏹️  Execução interrompida pelo usuário")
        return False
    except Exception as e:
        print("-" * 60)
        print(f"❌ Erro na execução dos testes: {e}")
        return False
    except FileNotFoundError:
        print("❌ Robot Framework não encontrado. Certifique-se de que está instalado e no PATH.")
        return False

def list_available_tests():
    """Lista os arquivos de teste disponíveis."""
    project_root = get_project_root()
    smoke_test_dir = project_root / "Smoke Test - D4S"
    
    test_files = []
    for file in smoke_test_dir.glob("*.robot"):
        if file.name not in ["variables.robot", "config_sensitive.robot"]:
            test_files.append(file.name)
    
    return sorted(test_files)

def main():
    parser = argparse.ArgumentParser(description="Executa testes Robot Framework com opções de modo")
    parser.add_argument(
        "--test", "-t", 
        help="Arquivo de teste específico para executar"
    )
    parser.add_argument(
        "--output", "-o",
        help="Diretório de saída personalizado"
    )
    parser.add_argument(
        "--list", "-l",
        action="store_true",
        help="Lista os arquivos de teste disponíveis"
    )
    parser.add_argument(
        "--headless", "-h",
        action="store_true",
        help="Executa em modo headless (sem navegador)"
    )
    parser.add_argument(
        "--normal", "-n",
        action="store_true",
        help="Executa em modo normal (com navegador) - padrão"
    )
    
    args = parser.parse_args()
    
    if args.list:
        print("📋 Arquivos de teste disponíveis:")
        for test_file in list_available_tests():
            print(f"   - {test_file}")
        return
    
    # Determinar modo de execução
    headless_mode = args.headless
    if args.normal:
        headless_mode = False
    
    # Configurar diretório de saída
    output_dir = None
    if args.output:
        output_dir = Path(args.output).absolute()
        output_dir.mkdir(parents=True, exist_ok=True)
    
    # Executar testes
    success = run_tests(args.test, output_dir, headless_mode)
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
