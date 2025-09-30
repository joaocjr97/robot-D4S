# 🏷️ Guia das Tags Aplicadas nos Testes

## ✅ **Status da Implementação**

### **Arquivos Atualizados:**

#### **📁 API Tests:**
- ✅ `API/Listagens-API.robot` - Tags aplicadas
- ✅ `API/Posts-API.robot` - Tags aplicadas

#### **📁 Smoke Tests:**
- ✅ `01-busca-signatario.robot` - Tags aplicadas
- ✅ `02-busca-tags.robot` - Tags aplicadas
- ✅ `03-listar-fases.robot` - Tags aplicadas
- ✅ `04-criar-cofre.robot` - Tags aplicadas
- ✅ `05-envio-desk.robot` - Tags aplicadas
- ✅ `06-envio-cofre.robot` - Tags aplicadas
- ✅ `07-envio-assinatura.robot` - Tags aplicadas
- ✅ `08-envio-grupo-assinatura.robot` - Tags aplicadas
- ✅ `09-envio-template-html.robot` - Tags aplicadas
- ✅ `10-envio-template-word.robot` - Tags aplicadas
- ✅ `11-envio-lote.robot` - Tags aplicadas
- ✅ `12-envio-powerform.robot` - Tags aplicadas
- ✅ `13-assinatura-lote.robot` - Tags aplicadas

---

## 🎯 **Tags Aplicadas por Teste**

### **📋 API Tests:**

#### **Listagens-API.robot:**
- `1 - Listar todos os documentos da conta`: `api`, `smoke`, `critical`
- `2 - Listar documento específico`: `api`, `critical`
- `3 - Listar documentos por fase`: `api`, `regression`
- `4 - Listar todos os cofres da conta`: `api`, `smoke`
- `5 - Listar documentos de um cofre específico`: `api`, `critical`
- `6 - Listar webhooks de um documento específico`: `api`, `regression`
- `7 - Listar pins do documento`: `api`, `signature`, `critical`

#### **Posts-API.robot:**
- `1 - Upload de documento PDF`: `api`, `upload`, `critical`
- `2 - Upload de documento binário - base64`: `api`, `upload`, `regression`
- `3 - Upload de documento HASH`: `api`, `upload`, `regression`
- `4 - Upload de documento + anexo`: `api`, `upload`, `critical`
- `5 - Faz upload - Acrescenta signatários via Email`: `api`, `upload`, `signature`, `critical`
- `6 - Faz upload - Acrescenta signatário via WhatsApp`: `api`, `upload`, `signature`, `regression`
- `7 - Upload com Pins`: `api`, `upload`, `signature`, `critical`
- `8 - Gerar documento via template word`: `api`, `template`, `regression`
- `9 - Envio com edição e remoção de signatário`: `api`, `signature`, `regression`
- `10 - Adcionar webhook ao documento`: `api`, `regression`
- `11 - Criar documento Template HTML`: `api`, `template`, `regression`

### **🖥️ Smoke Tests:**

#### **Testes de Login e Busca:**
- `01-busca-signatario.robot`: `ui`, `login`, `smoke`, `critical`
- `02-busca-tags.robot`: `ui`, `smoke`
- `03-listar-fases.robot`: `ui`, `smoke`

#### **Testes de Criação:**
- `04-criar-cofre.robot`: `ui`, `smoke`, `critical`

#### **Testes de Assinatura:**
- `05-envio-desk.robot`: `ui`, `signature`, `critical`
- `06-envio-cofre.robot`: `ui`, `signature`, `critical`
- `07-envio-assinatura.robot`: `ui`, `signature`, `critical`
- `08-envio-grupo-assinatura.robot`: `ui`, `signature`, `regression`
- `13-assinatura-lote.robot`: `ui`, `batch`, `signature`, `regression`

#### **Testes de Template:**
- `09-envio-template-html.robot`: `ui`, `template`, `regression`
- `10-envio-template-word.robot`: `ui`, `template`, `regression`

#### **Testes em Lote:**
- `11-envio-lote.robot`: `ui`, `batch`, `regression`

#### **Testes de Regressão:**
- `12-envio-powerform.robot`: `ui`, `regression`

---

## 🚀 **Como Executar por Tags**

### **1. Smoke Tests:**
```bash
# Apenas smoke tests
robot --include smoke .

# Smoke tests em staging
robot -v ENVIRONMENT:staging --include smoke .
```

### **2. Testes Críticos:**
```bash
# Apenas testes críticos
robot --include critical .

# Testes críticos em produção
robot -v ENVIRONMENT:prod --include critical .
```

### **3. Testes de API:**
```bash
# Apenas testes de API
robot --include api .

# API críticos
robot --include api --include critical .
```

### **4. Testes de UI:**
```bash
# Apenas testes de UI
robot --include ui .

# UI excluindo regressão
robot --include ui --exclude regression .
```

### **5. Testes de Assinatura:**
```bash
# Apenas testes de assinatura
robot --include signature .

# Assinatura críticos
robot --include signature --include critical .
```

### **6. Testes de Upload:**
```bash
# Apenas testes de upload
robot --include upload .

# Upload críticos
robot --include upload --include critical .
```

### **7. Testes de Template:**
```bash
# Apenas testes de template
robot --include template .

# Template em regressão
robot --include template --include regression .
```

### **8. Testes em Lote:**
```bash
# Apenas testes em lote
robot --include batch .

# Lote com assinatura
robot --include batch --include signature .
```

### **9. Testes de Regressão:**
```bash
# Apenas testes de regressão
robot --include regression .

# Regressão excluindo críticos
robot --include regression --exclude critical .
```

### **10. Combinações Úteis:**
```bash
# Smoke + críticos
robot --include smoke --include critical .

# API + UI críticos
robot --include api --include ui --include critical .

# Todos exceto regressão
robot --exclude regression .

# Todos exceto produção (se houver tag prod)
robot --exclude prod .
```

---

## 📊 **Logs Específicos por Tag**

### **🔥 Smoke Tests:**
- `Log Smoke Test Info` - Logs específicos para smoke tests

### **🌐 API Tests:**
- `Log API Test Info` - Logs específicos para testes de API

### **🖥️ UI Tests:**
- `Log UI Test Info` - Logs específicos para testes de UI

### **⚠️ Critical Tests:**
- `Log Critical Test Info` - Logs específicos para testes críticos

### **🔄 Regression Tests:**
- `Log Regression Test Info` - Logs específicos para testes de regressão

### **🔐 Login Tests:**
- `Log Login Test Info` - Logs específicos para testes de login

### **📤 Upload Tests:**
- `Log Upload Test Info` - Logs específicos para testes de upload

### **✍️ Signature Tests:**
- `Log Signature Test Info` - Logs específicos para testes de assinatura

### **📄 Template Tests:**
- `Log Template Test Info` - Logs específicos para testes de template

### **📦 Batch Tests:**
- `Log Batch Test Info` - Logs específicos para testes em lote

---

## 🎉 **Benefícios Alcançados**

### **✅ Organização:**
- Testes categorizados por funcionalidade
- Fácil identificação por tipo de teste
- Logs específicos para cada categoria

### **✅ Execução Seletiva:**
- Execute apenas os testes que precisa
- Combinações flexíveis de tags
- Exclusões específicas

### **✅ Rastreamento:**
- Logs detalhados por categoria
- Emojis para fácil identificação
- Informações contextuais

### **✅ Manutenção:**
- Identificação rápida de áreas problemáticas
- Execução por prioridade (críticos, smoke, regressão)
- Organização clara por funcionalidade

**🎯 Agora você pode executar seus testes de forma organizada e eficiente usando as tags aplicadas!**
