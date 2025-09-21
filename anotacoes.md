# 📋 Guia de Execução dos Testes - Suíte D4S

Este guia fornece instruções detalhadas para executar os testes automatizados da suíte D4S utilizando Robot Framework.

## 🚀 Execução Básica dos Testes

### Pré-requisitos
- Robot Framework instalado
- Ambiente Python configurado
- ChromeDriver configurado (para testes web)
- Navegador Chrome/Chromium instalado

### Passo a Passo

#### 1. **Navegar até o diretório dos testes**
```powershell
cd "H:\robot-D4S\Smoke Test - D4S"
```

#### 2. **Executar todos os testes da suíte**
```powershell
robot --outputdir results .
```

**Exemplo completo de execução:**
```powershell
PS H:\robot-D4S\Smoke Test - D4S> robot --outputdir results .
```

## 📊 Interpretando os Resultados

Após a execução, os seguintes arquivos serão gerados na pasta `results/`:

- **`report.html`** - Relatório principal com estatísticas dos testes
- **`log.html`** - Log detalhado de cada teste executado
- **`output.xml`** - Arquivo XML com dados estruturados (para integração com CI/CD)

## 🎯 Execuções Específicas

### Executar um teste individual
```powershell
robot --outputdir results 01-busca-signatario.robot
```

### Executar testes com tags específicas
```powershell
robot --include smoke --outputdir results .
robot --exclude slow --outputdir results .
```

### Executar com nível de log detalhado
```powershell
robot --loglevel DEBUG --outputdir results .
```

### Executar com timeout personalizado
```powershell
robot --timeout 30s --outputdir results .
```

## 🔧 Opções Avançadas

### Executar em paralelo (se suportado)
```powershell
robot --processes 4 --outputdir results .
```

### Executar com variáveis personalizadas
```powershell
robot --variable BROWSER:chrome --variable TIMEOUT:30 --outputdir results .
```

### Executar com arquivo de configuração
```powershell
robot --variablefile config.py --outputdir results .
```

## 📁 Estrutura dos Testes

A suíte contém os seguintes testes numerados:

1. **01-busca-signatario.robot** - Teste de busca de signatários
2. **02-busca-tags.robot** - Teste de busca por tags
3. **03-listar-fases.robot** - Teste de listagem de fases
4. **04-criar-cofre.robot** - Teste de criação de cofre
5. **05-envio-desk.robot** - Teste de envio para desktop
6. **06-envio-cofre.robot** - Teste de envio para cofre
7. **07-envio-assinatura.robot** - Teste de envio para assinatura
8. **08-envio-grupo-assinatura.robot** - Teste de envio para grupo de assinatura
9. **09-envio-template-html.robot** - Teste de envio com template HTML
10. **10-envio-template-word.robot** - Teste de envio com template Word
11. **11-envio-lote.robot** - Teste de envio em lote
12. **12-envio-powerform.robot** - Teste de envio com PowerForm
13. **13-assinatura-lote.robot** - Teste de assinatura em lote

## ⚠️ Troubleshooting

### Problemas Comuns

**Erro: ChromeDriver não encontrado**
```powershell
# Verificar se o ChromeDriver está no PATH
where chromedriver
# Ou especificar o caminho completo
robot --variable CHROMEDRIVER_PATH:"C:\path\to\chromedriver.exe" --outputdir results .
```

**Erro: Navegador não abre**
- Verificar se o Chrome está instalado
- Verificar compatibilidade entre ChromeDriver e versão do Chrome
- Executar com modo headless: `robot --variable HEADLESS:True --outputdir results .`

**Testes falhando por timeout**
```powershell
# Aumentar timeout global
robot --timeout 60s --outputdir results .
```

## 📈 Monitoramento e Relatórios

### Visualizar relatórios
1. Abra o arquivo `results/report.html` no navegador
2. Analise o `log.html` para detalhes de falhas
3. Use o `output.xml` para integração com ferramentas de CI/CD

### Métricas importantes
- **Taxa de sucesso** - Percentual de testes que passaram
- **Tempo de execução** - Duração total da suíte
- **Testes críticos** - Identificar quais testes são mais importantes

---

**💡 Dica:** Para desenvolvimento contínuo, execute testes individuais durante o desenvolvimento e a suíte completa antes de commits importantes.
