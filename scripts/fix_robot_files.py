#!/usr/bin/env python3
"""
Script melhorado para corrigir todos os arquivos de teste Robot Framework
"""

import os
import re
from pathlib import Path

def fix_robot_file(file_path):
    """Corrige um arquivo .robot com problemas de formatação"""
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Dividir em linhas
    lines = content.split('\n')
    new_lines = []
    
    # Estado da máquina
    in_settings = False
    in_test_cases = False
    settings_done = False
    
    for line in lines:
        stripped = line.strip()
        
        # Detectar seções
        if stripped.startswith('*** Settings ***'):
            in_settings = True
            in_test_cases = False
            new_lines.append(line)
            continue
        elif stripped.startswith('*** Test Cases ***'):
            in_settings = False
            in_test_cases = True
            new_lines.append(line)
            continue
        elif stripped.startswith('***'):
            in_settings = False
            in_test_cases = False
            new_lines.append(line)
            continue
        
        # Processar seção Settings
        if in_settings:
            if stripped.startswith('Library') or stripped.startswith('Resource'):
                new_lines.append(line)
            elif stripped == '':
                new_lines.append(line)
            else:
                # Pular linhas que não são Library ou Resource
                continue
        
        # Processar seção Test Cases
        elif in_test_cases:
            new_lines.append(line)
        
        # Processar outras seções
        else:
            new_lines.append(line)
    
    # Reconstruir conteúdo
    new_content = '\n'.join(new_lines)
    
    # Escrever arquivo corrigido
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print(f"✅ Corrigido: {file_path}")

def main():
    """Função principal"""
    test_dir = Path("Smoke Test - D4S")
    
    # Arquivos que precisam ser corrigidos
    files_to_fix = [
        "06-envio-cofre.robot",
        "07-envio-assinatura.robot", 
        "08-envio-grupo-assinatura.robot",
        "09-envio-template-html.robot",
        "10-envio-template-word.robot",
        "12-envio-powerform.robot",
        "13-assinatura-lote.robot"
    ]
    
    for filename in files_to_fix:
        file_path = test_dir / filename
        if file_path.exists():
            fix_robot_file(file_path)
        else:
            print(f"❌ Arquivo não encontrado: {file_path}")

if __name__ == "__main__":
    main()
