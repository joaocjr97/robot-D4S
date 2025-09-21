#!/usr/bin/env python3
"""
Script para atualizar todos os arquivos de teste Robot Framework
para usar Resource em vez de variáveis locais
"""

import os
import re
from pathlib import Path

def update_robot_file(file_path):
    """Atualiza um arquivo .robot para usar Resource"""
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Padrão para encontrar a seção *** Settings ***
    settings_pattern = r'(\*\*\* Settings \*\*\*.*?)(?=\*\*\* Variables \*\*\*|\*\*\* Test Cases \*\*\*|\*\*\* Keywords \*\*\*|$)'
    
    # Encontrar a seção Settings
    settings_match = re.search(settings_pattern, content, re.DOTALL)
    
    if settings_match:
        settings_section = settings_match.group(1)
        
        # Verificar se já tem Resource
        if 'Resource' not in settings_section:
            # Adicionar Resource após as bibliotecas
            lines = settings_section.strip().split('\n')
            new_lines = []
            
            for line in lines:
                new_lines.append(line)
                # Adicionar Resource após a última Library
                if line.strip().startswith('Library'):
                    new_lines.append('Resource   variables.robot')
                    new_lines.append('Resource   config_sensitive.robot')
            
            # Remover duplicatas
            new_lines = list(dict.fromkeys(new_lines))
            
            # Reconstruir a seção Settings
            new_settings = '\n'.join(new_lines)
            
            # Substituir no conteúdo original
            content = content.replace(settings_section, new_settings)
    
    # Remover a seção *** Variables *** inteira
    variables_pattern = r'\*\*\* Variables \*\*\*.*?(?=\*\*\* Test Cases \*\*\*|\*\*\* Keywords \*\*\*|$)'
    content = re.sub(variables_pattern, '', content, flags=re.DOTALL)
    
    # Substituir timeouts hardcoded por ${TIMEOUT}
    content = re.sub(r'(\d+)s', r'${TIMEOUT}', content)
    
    # Escrever o arquivo atualizado
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"✅ Atualizado: {file_path}")

def main():
    """Função principal"""
    test_dir = Path("Smoke Test - D4S")
    
    # Arquivos para atualizar (excluindo os que já foram atualizados)
    files_to_update = [
        "06-envio-cofre.robot",
        "07-envio-assinatura.robot", 
        "08-envio-grupo-assinatura.robot",
        "09-envio-template-html.robot",
        "10-envio-template-word.robot",
        "11-envio-lote.robot",
        "12-envio-powerform.robot",
        "13-assinatura-lote.robot"
    ]
    
    for filename in files_to_update:
        file_path = test_dir / filename
        if file_path.exists():
            update_robot_file(file_path)
        else:
            print(f"❌ Arquivo não encontrado: {file_path}")

if __name__ == "__main__":
    main()
