#!/usr/bin/env python3
"""
Script para verificar variáveis duplicadas ou com valores duplicados
no arquivo variables.robot
"""

import re
from collections import defaultdict

def analyze_variables(file_path):
    """Analisa o arquivo de variáveis em busca de duplicatas"""
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Padrão para encontrar variáveis
    variable_pattern = r'\$\{([^}]+)\}\s+(.+)'
    
    variables = {}
    variable_names = []
    variable_values = defaultdict(list)
    
    # Encontrar todas as variáveis
    for match in re.finditer(variable_pattern, content):
        var_name = match.group(1).strip()
        var_value = match.group(2).strip()
        
        # Armazenar informações
        if var_name in variables:
            print(f"⚠️  VARIÁVEL DUPLICADA: ${var_name}")
            print(f"   Primeira ocorrência: {variables[var_name]}")
            print(f"   Segunda ocorrência: {var_value}")
            print()
        else:
            variables[var_name] = var_value
        
        variable_names.append(var_name)
        variable_values[var_value].append(var_name)
    
    # Verificar valores duplicados
    print("🔍 ANÁLISE DE VALORES DUPLICADOS:")
    print("=" * 50)
    
    duplicates_found = False
    for value, names in variable_values.items():
        if len(names) > 1:
            duplicates_found = True
            print(f"📋 VALOR DUPLICADO: '{value}'")
            print(f"   Usado por: {', '.join([f'${name}' for name in names])}")
            print()
    
    if not duplicates_found:
        print("✅ Nenhum valor duplicado encontrado!")
    
    # Verificar variáveis com nomes similares
    print("\n🔍 ANÁLISE DE NOMES SIMILARES:")
    print("=" * 50)
    
    similar_found = False
    for i, name1 in enumerate(variable_names):
        for j, name2 in enumerate(variable_names[i+1:], i+1):
            # Verificar se são muito similares (diferença de 1-2 caracteres)
            if abs(len(name1) - len(name2)) <= 2:
                # Verificar similaridade
                diff_count = sum(c1 != c2 for c1, c2 in zip(name1, name2))
                if diff_count <= 2 and name1 != name2:
                    similar_found = True
                    print(f"🔤 NOMES SIMILARES:")
                    print(f"   ${name1} = {variables[name1]}")
                    print(f"   ${name2} = {variables[name2]}")
                    print()
    
    if not similar_found:
        print("✅ Nenhum nome similar encontrado!")
    
    # Estatísticas gerais
    print(f"\n📊 ESTATÍSTICAS:")
    print(f"   Total de variáveis: {len(variables)}")
    print(f"   Valores únicos: {len(variable_values)}")
    
    return variables, variable_values

def main():
    """Função principal"""
    file_path = "Smoke Test - D4S/variables.robot"
    
    print("🔍 ANÁLISE DE VARIÁVEIS DUPLICADAS")
    print("=" * 50)
    
    try:
        variables, values = analyze_variables(file_path)
        
        print(f"\n✅ Análise concluída!")
        
    except FileNotFoundError:
        print(f"❌ Arquivo não encontrado: {file_path}")
    except Exception as e:
        print(f"❌ Erro na análise: {e}")

if __name__ == "__main__":
    main()
