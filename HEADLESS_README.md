# Execução de Testes em Modo HEADLESS

Este projeto contém scripts para executar os testes Robot Framework em modo **HEADLESS** (sem interface gráfica do navegador).

## 🎯 O que é Modo HEADLESS?

O modo headless executa os testes **sem abrir o navegador visualmente**. Isso significa:
- ✅ **Mais rápido**: Sem renderização gráfica
- ✅ **Menos recursos**: Menor uso de CPU e memória
- ✅ **Ideal para CI/CD**: Perfeito para automação
- ✅ **Estável**: Menos problemas de interface

## 🚀 Scripts Disponíveis

### 1. Script HEADLESS Dedicado
```bash
# Executar todos os testes em modo headless
python run_headless.py

# Executar teste específico em modo headless
python run_headless.py --test 12-envio-powerform.robot

# Listar testes disponíveis
python run_headless.py --list
```

### 1.1. Script HEADLESS Otimizado (Recomendado)
```bash
# Executar todos os testes em modo headless otimizado
python run_headless_optimized.py

# Executar teste específico em modo headless otimizado
python run_headless_optimized.py --test 12-envio-powerform.robot

# Listar testes disponíveis
python run_headless_optimized.py --list
```

### 2. Script Avançado (Normal + Headless)
```bash
# Modo HEADLESS (sem navegador)
python run_tests_advanced.py --headless

# Modo NORMAL (com navegador)
python run_tests_advanced.py --normal

# Executar teste específico em modo headless
python run_tests_advanced.py --test 01-busca-signatario.robot --headless
```

### 3. Scripts Batch (Windows)
```cmd
# Executar em modo headless
run_headless.bat

# Executar teste específico
run_headless.bat --test 12-envio-powerform.robot
```

## 📁 Estrutura de Resultados

```
robot-D4S/
├── results/
│   ├── headless_run_20241201_143022/    # Execução headless
│   │   ├── report.html
│   │   ├── log.html
│   │   ├── output.xml
│   │   └── selenium-screenshot-*.png
│   ├── normal_run_20241201_150145/       # Execução normal
│   └── headless_run_20241201_160200/     # Próxima execução headless
└── Smoke Test - D4S/                     # Código dos testes
```

## 🔧 Configuração Automática

Os scripts automaticamente configuram:
- **Chrome Headless**: `headlesschrome`
- **Tamanho da janela**: `1920x1080` (resolução completa)
- **Variáveis**: `HEADLESS_MODE:true`
- **Diretório de saída**: Com prefixo `headless_run_`
- **Otimizações**: `--disable-gpu`, `--no-sandbox`, `--disable-extensions`

## 📊 Comparação de Performance

| Modo | Velocidade | Recursos | Interface | Uso |
|------|------------|----------|-----------|-----|
| **Normal** | Padrão | Alto | Visível | Debug/Desenvolvimento |
| **Headless** | ⚡ 30-50% mais rápido | Baixo | Invisível | CI/CD/Produção |

## 🎯 Quando Usar Cada Modo

### Use HEADLESS quando:
- ✅ Executando em servidor/CI/CD
- ✅ Testes automatizados
- ✅ Performance é importante
- ✅ Não precisa ver o navegador

### Use NORMAL quando:
- ✅ Debugging de testes
- ✅ Desenvolvimento
- ✅ Precisa ver o que está acontecendo
- ✅ Testes manuais

## 🔍 Exemplo Prático

```bash
# 1. Listar testes disponíveis
python run_headless.py --list

# 2. Executar todos os testes em modo headless
python run_headless.py

# 3. Executar apenas o teste de PowerForm em modo headless
python run_headless.py --test 12-envio-powerform.robot

# 4. Verificar resultados
# Os arquivos estarão em: results/headless_run_YYYYMMDD_HHMMSS/
```

## 🆘 Solução de Problemas

### Erro: "Chrome headless não encontrado"
```bash
# Instalar Chrome/Chromium
# No Windows: Baixar do site oficial
# No Linux: sudo apt-get install chromium-browser
```

### Erro: "Screenshots não funcionam em headless"
- Screenshots ainda funcionam em modo headless
- São salvos normalmente na pasta de resultados

### Erro: "Teste falha em headless mas funciona em normal"
- Verifique se há elementos que dependem de JavaScript específico
- Alguns sites podem detectar modo headless e bloquear

## 🚀 Integração com CI/CD

```yaml
# Exemplo para GitHub Actions
- name: Run Robot Framework Tests (Headless)
  run: |
    python run_headless.py
    # Os resultados estarão em results/headless_run_*/
```

## 📈 Vantagens do Modo HEADLESS

✅ **Performance**: Execução mais rápida  
✅ **Recursos**: Menor uso de CPU/RAM  
✅ **Estabilidade**: Menos problemas de interface  
✅ **Automação**: Ideal para pipelines  
✅ **Escalabilidade**: Múltiplas execuções simultâneas  
✅ **Servidor**: Funciona em ambientes sem interface gráfica
