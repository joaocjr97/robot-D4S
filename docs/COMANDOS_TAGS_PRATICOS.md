# 🚀 Comandos Práticos para Tags

## 📋 Comandos Mais Usados

### **1. Executar por Tipo de Teste**

```bash
# Smoke Tests (testes básicos)
robot --include smoke .

# Testes de API
robot --include api .

# Testes de UI
robot --include ui .

# Testes críticos
robot --include critical .

# Testes de regressão
robot --include regression .
```

### **2. Executar por Funcionalidade**

```bash
# Testes de login
robot --include login .

# Testes de upload
robot --include upload .

# Testes de assinatura
robot --include signature .

# Testes de template
robot --include template .

# Testes em lote
robot --include batch .
```

### **3. Executar por Ambiente**

```bash
# Apenas testes de desenvolvimento
robot --include dev .

# Apenas testes de homologação
robot --include homol .

# Apenas testes de staging
robot --include staging .

# Apenas testes de produção
robot --include prod .
```

### **4. Combinações Úteis**

```bash
# API críticos em staging
robot -v ENVIRONMENT:staging --include api --include critical .

# Smoke tests excluindo upload
robot --include smoke --exclude upload .

# UI excluindo regressão
robot --include ui --exclude regression .

# Todos exceto produção
robot --exclude prod .
```

## 🎯 Cenários de Uso

### **Desenvolvimento Local**
```bash
# Executar apenas smoke tests durante desenvolvimento
robot --include smoke .

# Executar testes de uma funcionalidade específica
robot --include upload .

# Executar testes críticos
robot --include critical .
```

### **CI/CD Pipeline**
```bash
# Smoke tests em cada commit
robot --include smoke .

# Regressão completa antes de release
robot --include regression .

# Testes críticos em produção
robot -v ENVIRONMENT:prod --include critical .
```

### **Testes por Ambiente**
```bash
# Testes específicos de staging
robot -v ENVIRONMENT:staging --include staging .

# Testes específicos de produção
robot -v ENVIRONMENT:prod --include prod .

# Excluir testes de produção em outros ambientes
robot -v ENVIRONMENT:staging --exclude prod .
```

## 📊 Relatórios por Tags

### **Gerar Relatório Detalhado**
```bash
# Relatório com estatísticas de tags
robot --tagstatinclude * --outputdir results .

# Relatório apenas de tags específicas
robot --include api --tagstatinclude api --outputdir results/api .
```

### **Ver Tags Disponíveis**
```bash
# Listar todas as tags do projeto
robot --dryrun . | findstr "Tags:"

# Ver testes com tag específica
robot --dryrun --include api . | findstr "Test:"
```

## 🔍 Comandos de Debug

### **Ver Estrutura dos Testes**
```bash
# Dry run para ver estrutura sem executar
robot --dryrun .

# Dry run com tags específicas
robot --dryrun --include smoke .

# Listar apenas nomes dos testes
robot --dryrun . | findstr "Test:"
```

### **Verificar Tags em Arquivo Específico**
```bash
# Ver tags de um arquivo específico
robot --dryrun API/Listagens-API.robot

# Ver tags de uma pasta específica
robot --dryrun "Smoke Test - D4S/"
```

## 🎨 Exemplos Avançados

### **Execução Condicional**
```bash
# Se staging, executar smoke + api
robot -v ENVIRONMENT:staging --include smoke --include api .

# Se produção, executar apenas critical
robot -v ENVIRONMENT:prod --include critical .
```

### **Múltiplas Tags (E lógico)**
```bash
# Testes que são AO MESMO TEMPO api E critical
robot --include api --include critical .

# Testes que são AO MESMO TEMPO ui E login
robot --include ui --include login .
```

### **Exclusões Específicas**
```bash
# Todos os testes exceto os de produção
robot --exclude prod .

# Smoke tests exceto upload
robot --include smoke --exclude upload .

# API exceto regressão
robot --include api --exclude regression .
```

## 🚀 Scripts Automatizados

### **Usar o Script de Execução**
```bash
# Executar smoke tests
scripts\executar_por_tags.bat smoke staging

# Executar testes de API
scripts\executar_por_tags.bat api prod

# Executar testes críticos
scripts\executar_por_tags.bat critical staging
```

### **Usar o Script de Rastreamento**
```bash
# Analisar todas as tags do projeto
python scripts\rastrear_tags.py
```

## 💡 Dicas Práticas

### **1. Organização por Prioridade**
```bash
# Executar por ordem de prioridade
robot --include critical .    # Primeiro: críticos
robot --include smoke .       # Segundo: smoke
robot --include regression .  # Terceiro: regressão
```

### **2. Testes por Ambiente**
```bash
# Desenvolvimento: apenas smoke
robot -v ENVIRONMENT:dev --include smoke .

# Staging: smoke + api + critical
robot -v ENVIRONMENT:staging --include smoke --include api --include critical .

# Produção: apenas critical
robot -v ENVIRONMENT:prod --include critical .
```

### **3. Debugging**
```bash
# Ver o que seria executado
robot --dryrun --include api .

# Executar com logs detalhados
robot --loglevel TRACE --include critical .
```

**🎯 Use essas tags para organizar e executar seus testes de forma eficiente!**
