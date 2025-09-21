#!/usr/bin/env python3
"""
Script para atualizar todos os arquivos de teste para usar modo headless
"""

import os
import re
from pathlib import Path

def update_file_for_headless(file_path):
    """Atualiza um arquivo .robot para usar modo headless"""
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Padrão para encontrar Open Browser
    open_browser_pattern = r'(Open Browser\s+\$\{URL\}\s+)(chrome)(\s+.*)'
    
    # Substituir chrome por chrome com options
    new_content = re.sub(
        open_browser_pattern,
        r'\1chrome    options=${HEADLESS}\3',
        content
    )
    
    # Se não encontrou o padrão, tentar outro formato
    if new_content == content:
        # Padrão alternativo
        alt_pattern = r'(Open Browser\s+\$\{URL\}\s+)(chrome)'
        new_content = re.sub(
            alt_pattern,
            r'\1chrome    options=${HEADLESS}',
            content
        )
    
    # Escrever arquivo atualizado
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print(f"✅ Atualizado para headless: {file_path}")

def main():
    """Função principal"""
    test_dir = Path("Smoke Test - D4S")
    
    # Arquivos para atualizar
    files_to_update = [
        "01-busca-signatario.robot",
        "03-listar-fases.robot",
        "04-criar-cofre.robot",
        "05-envio-desk.robot",
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
            update_file_for_headless(file_path)
        else:
            print(f"❌ Arquivo não encontrado: {file_path}")

if __name__ == "__main__":
    main()
