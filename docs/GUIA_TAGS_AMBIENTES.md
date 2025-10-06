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

## 🏷️ **Tags de Ambiente Disponíveis**

### **Ambientes Suportados**
- `dev` - Desenvolvimento
- `homol` - Homologação  
- `staging` - Staging
- `prod` - Produção

### **Tags Funcionais Disponíveis**
- `ui` - Testes de interface
- `api` - Testes de API
- `smoke` - Testes básicos
- `critical` - Testes críticos
- `regression` - Testes de regressão
- `signature` - Testes de assinatura
- `batch` - Testes em lote
- `template` - Testes de template
- `upload` - Testes de upload
- `login` - Testes de login

## 🎯 **Comandos de Execução por Ambiente**

### **1. Executar por Ambiente Específico**

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

### **2. Executar por Tipo + Ambiente**

```bash
# UI em desenvolvimento
robot --include ui --include dev .

# Smoke tests em staging
robot --include smoke --include staging .

# Críticos em produção
robot --include critical --include prod .

# Regressão em homologação
robot --include regression --include homol .
```

### **3. Executar com Variável de Ambiente**

```bash
# Desenvolvimento
robot -v ENVIRONMENT:dev --include dev .

# Homologação
robot -v ENVIRONMENT:homol --include homol .

# Staging
robot -v ENVIRONMENT:staging --include staging .

# Produção
robot -v ENVIRONMENT:prod --include prod .
```

### **4. Combinações Avançadas**

```bash
# UI críticos em staging
robot -v ENVIRONMENT:staging --include ui --include critical .

# Smoke tests excluindo produção
robot --include smoke --exclude prod .

# Todos exceto desenvolvimento
robot --exclude dev .

# API em produção (se tiver testes de API)
robot --include api --include prod .
```

## 📊 **Exemplos Práticos**

### **Desenvolvimento Local**
```bash
# Testes básicos durante desenvolvimento
robot --include dev --include smoke .

# Testes de uma funcionalidade específica
robot --include dev --include signature .

# Testes críticos
robot --include dev --include critical .
```

### **Pipeline CI/CD**
```bash
# Smoke tests em cada commit (dev)
robot --include smoke --include dev .

# Regressão completa antes de release (staging)
robot --include regression --include staging .

# Testes críticos em produção
robot --include critical --include prod .
```

### **Testes Específicos**
```bash
# Envio em lote em desenvolvimento
robot --include dev --include batch tests/web/envios/envio-lote.robot

# Assinatura em staging
robot --include staging --include signature tests/web/envios/envio-assinatura.robot

# UI em homologação
robot --include homol --include ui tests/web/ui/
```

## 🔧 **Configuração de Ambiente**

### **URLs por Ambiente**
```robot
# Em resources/config/config_environment.robot
${URL_DEV}              https://ghost.d4sign.com.br/
${URL_HOMOL}            https://homol.d4sign.com.br/
${URL_STAGING}          https://stage.d4sign.com.br/
${URL_PROD}             https://secure.d4sign.com.br/
```

### **Timeouts por Ambiente**
```robot
${TIMEOUT_DEV}          240s
${TIMEOUT_STAGING}      240s
${TIMEOUT_PROD}         240s
```

## 📋 **Cenários de Uso Recomendados**

### **1. Desenvolvimento Diário**
```bash
# Executar smoke tests
robot --include dev --include smoke .

# Executar testes de funcionalidade sendo desenvolvida
robot --include dev --include signature .
```

### **2. Antes de Commit**
```bash
# Executar testes críticos
robot --include dev --include critical .
```

### **3. Deploy para Homologação**
```bash
# Executar regressão completa
robot --include homol --include regression .
```

### **4. Deploy para Produção**
```bash
# Executar apenas testes críticos
robot --include prod --include critical .
```

### **5. Testes de API**
```bash
# API em desenvolvimento
robot --include api --include dev tests/api/

# API em staging
robot --include api --include staging tests/api/
```

## 🎯 **Estratégia de Tags por Ambiente**

### **Desenvolvimento (`dev`)**
- ✅ Todos os testes
- ✅ Testes experimentais
- ✅ Debugging ativo

### **Homologação (`homol`)**
- ✅ Testes estáveis
- ✅ Validação de funcionalidades
- ❌ Testes experimentais

### **Staging (`staging`)**
- ✅ Testes de produção
- ✅ Validação final
- ✅ Testes de performance

### **Produção (`prod`)**
- ✅ Apenas testes críticos
- ✅ Testes de smoke
- ❌ Testes destrutivos

## 🔍 **Verificação de Tags**

### **Listar Testes por Tag**
```bash
# Ver quais testes têm tag dev
robot --dryrun --include dev .

# Ver quais testes têm tag critical
robot --dryrun --include critical .

# Ver quais testes têm tag prod
robot --dryrun --include prod .
```

### **Verificar Tags de um Teste**
```bash
# Ver todas as tags do teste de lote
robot --dryrun tests/web/envios/envio-lote.robot
```

## ⚠️ **Importante**

### **Tags Implementadas**
- ✅ `envio-lote.robot`: `dev`, `homol`, `staging`
- ✅ `envio-assinatura.robot`: `dev`, `homol`, `staging`, `prod`
- ✅ `busca-signatario.robot`: `dev`, `homol`, `staging`, `prod`

### **Tags Pendentes**
- ⏳ Outros testes precisam ser atualizados com tags de ambiente
- ⏳ Testes de API precisam de tags de ambiente

### **Próximos Passos**
1. Atualizar todos os testes com tags de ambiente apropriadas
2. Definir estratégia de quais testes executar em cada ambiente
3. Configurar pipelines CI/CD com as tags corretas

## 🚀 **Comandos Rápidos**

```bash
# Desenvolvimento - smoke tests
robot --include dev --include smoke .

# Staging - regressão completa
robot --include staging --include regression .

# Produção - apenas críticos
robot --include prod --include critical .

# UI em homologação
robot --include homol --include ui .

# Excluir produção
robot --exclude prod .
```

Agora seus testes têm suporte completo para execução por ambiente! 🎉

