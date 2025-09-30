# 🏷️ Guia Completo de Tags - Robot Framework

## 📋 O que são Tags?

As **Tags** são etiquetas que você pode adicionar aos testes para categorizá-los, facilitando:
- ✅ **Execução seletiva** de testes específicos
- ✅ **Organização** e classificação
- ✅ **Rastreamento** de resultados por categoria
- ✅ **Relatórios** mais detalhados

---

## 🎯 Tags Disponíveis no Projeto

### **Categorias Principais:**
```robot
${SMOKE_TAG}              smoke        # Testes de smoke test
${API_TAG}                api          # Testes de API
${UI_TAG}                 ui           # Testes de interface
${CRITICAL_TAG}           critical     # Testes críticos
${REGRESSION_TAG}         regression   # Testes de regressão
```

### **Funcionalidades Específicas:**
```robot
${LOGIN_TAG}              login        # Testes de login
${UPLOAD_TAG}             upload       # Testes de upload
${SIGNATURE_TAG}          signature    # Testes de assinatura
${TEMPLATE_TAG}           template     # Testes de template
${BATCH_TAG}              batch        # Testes em lote
```

---

## 🔧 Como Implementar Tags nos Testes

### **1. Tags Simples:**
```robot
*** Test Cases ***
Teste de Login
    [Tags]    ${LOGIN_TAG}    ${CRITICAL_TAG}
    # Seu teste aqui
```

### **2. Tags Múltiplas:**
```robot
*** Test Cases ***
Upload de Documento
    [Tags]    ${UPLOAD_TAG}    ${API_TAG}    ${SMOKE_TAG}
    # Seu teste aqui
```

### **3. Tags com Ambiente:**
```robot
*** Test Cases ***
Teste em Staging
    [Tags]    ${API_TAG}    staging    ${REGRESSION_TAG}
    # Seu teste aqui
```

---

## 🚀 Como Executar Testes por Tags

### **1. Incluir Testes (--include):**
```bash
# Apenas testes de API
robot --include ${API_TAG} .

# Apenas smoke tests
robot --include ${SMOKE_TAG} .

# Apenas testes críticos
robot --include ${CRITICAL_TAG} .

# Múltiplas tags (E lógico)
robot --include ${API_TAG} --include ${CRITICAL_TAG} .

# Tags específicas
robot --include login --include critical .
```

### **2. Excluir Testes (--exclude):**
```bash
# Excluir testes de UI
robot --exclude ${UI_TAG} .

# Excluir testes de upload
robot --exclude ${UPLOAD_TAG} .

# Múltiplas exclusões
robot --exclude ${UI_TAG} --exclude ${TEMPLATE_TAG} .
```

### **3. Combinações Avançadas:**
```bash
# Apenas API críticos, excluindo upload
robot --include ${API_TAG} --include ${CRITICAL_TAG} --exclude ${UPLOAD_TAG} .

# Smoke tests em staging
robot --include ${SMOKE_TAG} --include staging .

# Todos exceto regressão
robot --exclude ${REGRESSION_TAG} .
```

---

## 📊 Rastreamento e Relatórios

### **1. Relatório por Tags:**
```bash
# Gerar relatório com estatísticas de tags
robot --tagstatinclude * --outputdir results .
```

### **2. Logs Detalhados:**
```bash
# Log level TRACE para ver todas as tags
robot --loglevel TRACE .
```

### **3. Saída Personalizada:**
```bash
# Salvar resultados com nome baseado em tags
robot --include ${API_TAG} --outputdir results/api_tests .
robot --include ${SMOKE_TAG} --outputdir results/smoke_tests .
```

---

## 🎯 Exemplos Práticos

### **Executar por Ambiente:**
```bash
# Apenas testes de produção
robot --include prod .

# Apenas testes de desenvolvimento
robot --include dev .

# Excluir testes de produção
robot --exclude prod .
```

### **Executar por Criticidade:**
```bash
# Apenas testes críticos
robot --include ${CRITICAL_TAG} .

# Testes de regressão
robot --include ${REGRESSION_TAG} .

# Excluir testes não críticos
robot --exclude ${CRITICAL_TAG} .
```

### **Executar por Funcionalidade:**
```bash
# Apenas testes de upload
robot --include ${UPLOAD_TAG} .

# Apenas testes de assinatura
robot --include ${SIGNATURE_TAG} .

# Testes de login
robot --include ${LOGIN_TAG} .
```

---

## 📈 Estratégias de Organização

### **1. Por Prioridade:**
```robot
# Testes críticos que devem sempre passar
[Tags]    ${CRITICAL_TAG}    ${SMOKE_TAG}

# Testes importantes mas não críticos
[Tags]    ${REGRESSION_TAG}

# Testes de funcionalidades novas
[Tags]    new_feature
```

### **2. Por Ambiente:**
```robot
# Testes específicos de produção
[Tags]    ${API_TAG}    prod

# Testes de desenvolvimento
[Tags]    ${UI_TAG}    dev

# Testes de staging
[Tags]    ${SMOKE_TAG}    staging
```

### **3. Por Funcionalidade:**
```robot
# Fluxo completo de assinatura
[Tags]    ${SIGNATURE_TAG}    ${CRITICAL_TAG}

# Upload de documentos
[Tags]    ${UPLOAD_TAG}    ${API_TAG}

# Testes de template
[Tags]    ${TEMPLATE_TAG}    ${UI_TAG}
```

---

## 🔍 Comandos Úteis para Rastreamento

### **1. Ver Todas as Tags Disponíveis:**
```bash
robot --dryrun . | findstr "Tags:"
```

### **2. Contar Testes por Tag:**
```bash
robot --dryrun . | findstr -c "Tags:"
```

### **3. Listar Testes com Tag Específica:**
```bash
robot --dryrun --include ${API_TAG} . | findstr "Test:"
```

### **4. Verificar Tags em Arquivo Específico:**
```bash
robot --dryrun API/Listagens-API.robot
```

---

## 🎉 Benefícios das Tags

### **✅ Para Desenvolvimento:**
- Executar apenas testes relevantes durante desenvolvimento
- Identificar rapidamente testes quebrados por categoria
- Organizar testes por funcionalidade

### **✅ Para CI/CD:**
- Executar smoke tests em cada commit
- Executar regressão completa antes de releases
- Executar testes críticos em produção

### **✅ Para Relatórios:**
- Estatísticas por categoria de teste
- Identificar áreas com mais falhas
- Métricas de cobertura por funcionalidade

---

## 🚀 Próximos Passos

1. **Implementar tags** nos testes existentes
2. **Criar scripts** de execução por categoria
3. **Configurar CI/CD** com execução por tags
4. **Gerar relatórios** específicos por tag

**As tags são uma ferramenta poderosa para organizar e executar seus testes de forma eficiente!** 🎯
