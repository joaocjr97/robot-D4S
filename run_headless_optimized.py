#!/usr/bin/env python3
"""
Script melhorado para executar testes Robot Framework em modo HEADLESS.
Configura automaticamente o tamanho da janela e outras opções do Chrome.
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

def create_output_directory():
    """Cria o diretório de saída com timestamp."""
    project_root = get_project_root()
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_dir = project_root / "results" / f"headless_run_{timestamp}"
    output_dir.mkdir(parents=True, exist_ok=True)
    return output_dir

def run_headless_tests(test_file=None, output_dir=None):
    """
    Executa os testes Robot Framework em modo HEADLESS com configurações otimizadas.
    
    Args:
        test_file: Arquivo de teste específico (opcional)
        output_dir: Diretório de saída (opcional)
    """
    project_root = get_project_root()
    smoke_test_dir = project_root / "Smoke Test - D4S"
    
    if not output_dir:
        output_dir = create_output_directory()
    
    # Configurar variáveis de ambiente para Chrome
    chrome_options = [
        "--headless",
        "--window-size=1920,1080",
        "--disable-gpu",
        "--no-sandbox",
        "--disable-dev-shm-usage",
        "--disable-extensions",
        "--disable-plugins",
        "--disable-images",
        "--disable-javascript",
        "--disable-web-security",
        "--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
    ]
    
    # Comando base do Robot Framework para modo HEADLESS
    cmd = [
        "robot",
        "--outputdir", str(output_dir),
        "--output", "output.xml",
        "--log", "log.html", 
        "--report", "report.html",
        "--variable", f"BROWSER:headlesschrome",
        "--variable", f"CHROME_OPTIONS:{';'.join(chrome_options)}",
        "--variable", "HEADLESS_MODE:true"
    ]
    
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
    
    print(f"🚀 Executando testes Robot Framework em modo HEADLESS...")
    print(f"📁 Diretório de saída: {output_dir}")
    print(f"🌐 Modo: Sem interface gráfica (headless)")
    print(f"📐 Tamanho da janela: 1920x1080")
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
    parser = argparse.ArgumentParser(description="Executa testes Robot Framework em modo HEADLESS otimizado")
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
    
    args = parser.parse_args()
    
    if args.list:
        print("📋 Arquivos de teste disponíveis para execução HEADLESS:")
        for test_file in list_available_tests():
            print(f"   - {test_file}")
        return
    
    # Configurar diretório de saída
    output_dir = None
    if args.output:
        output_dir = Path(args.output).absolute()
        output_dir.mkdir(parents=True, exist_ok=True)
    
    # Executar testes em modo headless
    success = run_headless_tests(args.test, output_dir)
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
