# 🤖 Robot-D4S

[![Python](https://img.shields.io/badge/Python-3.7+-blue.svg)](https://www.python.org/downloads/)
[![Robot Framework](https://img.shields.io/badge/Robot%20Framework-Latest-green.svg)](https://robotframework.org/)

Este projeto contém scripts de automação de testes utilizando o [Robot Framework](https://robotframework.org/) para validação de funcionalidades do sistema D4S.

## 📋 Índice

- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Executando os Testes](#-executando-os-testes)
- [Testes de API](#-testes-de-api)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Bibliotecas Utilizadas](#-bibliotecas-utilizadas)
- [Relatórios](#-relatórios)
- [Estrutura Organizada do Projeto](#-estrutura-organizada-do-projeto)

## 🔧 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [Python (>=3.7)](https://www.python.org/downloads/)
- [pip](https://pip.pypa.io/en/stable/installation/)
- [Git](https://git-scm.com/downloads)
- **Chrome/Chromium** e o [ChromeDriver](https://chromedriver.chromium.org/downloads) compatível com sua versão (para testes web)

## 🚀 Instalação

### 1. Clone este repositório

```bash
git clone https://github.com/joaocrj97/robot-D4S.git
cd robot-D4S
```

### 2. Crie um ambiente virtual (recomendado)

```bash
# Criar ambiente virtual
python -m venv venv

# Ativar ambiente virtual
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate
```

### 3. Instale as dependências

```bash
pip install -r requirements.txt
```

**Ou instale manualmente:**

```bash
pip install robotframework
pip install robotframework-seleniumlibrary
pip install robotframework-faker
pip install robotframework-operatingsystem
pip install robotframework-requests
pip install robotframework-jsonlibrary
```

### 4. Configure os dados sensíveis

**IMPORTANTE**: O arquivo `config_sensitive.robot` contém dados sensíveis e não está no repositório por segurança.


2. **Edite o arquivo com suas credenciais reais:**
```robot
*** Variables ***
# Credenciais de login
${USERNAME}          seu_email@exemplo.com
${PASSWORD}          sua_senha

# Chaves de API
${TOKEN_API}         sua_token_api_aqui
${CRYPT_KEY}         sua_crypt_key_aqui

# Dados de teste específicos
${EMAIL_TESTE}       email_para_testes@exemplo.com
```

### 5. Configure o ChromeDriver

1. Baixe o ChromeDriver compatível com sua versão do Chrome em [chromedriver.chromium.org](https://chromedriver.chromium.org/downloads)
2. Adicione o executável ao seu PATH ou coloque na pasta do projeto

## ▶️ Executando os Testes

### Executar todos os testes (Web + API)

```bash
# Executar todos os testes do projeto
robot --outputdir results tests/
```

### Executar todos os testes Web

```bash
# Executar todos os testes web
robot --outputdir results tests/web/
```

### Executar todos os testes de API

```bash
# Executar todos os testes de API
robot --outputdir results tests/api/
```

### Executar teste específico

```bash
# Executar teste específico de UI
robot --outputdir results tests/web/ui/busca-signatario.robot

# Executar teste específico de envio
robot --outputdir results tests/web/envios/envio-assinatura.robot

# Executar teste específico de pin
robot --outputdir results tests/web/envios/pin.robot

# Executar teste específico de API
robot --outputdir results tests/api/posts/Posts-API.robot
```

### Executar com tags específicas

```bash
# Executar apenas testes com tag 'web'
robot --include web --outputdir results tests/

# Executar apenas testes com tag 'api'
robot --include api --outputdir results tests/

# Executar apenas testes críticos
robot --include critical --outputdir results tests/

# Executar testes por categoria
robot --include ui --outputdir results tests/web/
robot --include envio --outputdir results tests/web/
```

## 🔌 Testes de API

O projeto inclui testes automatizados para a API da D4Sign, validando endpoints de upload, listagem e gerenciamento de documentos.

### Executar testes de API específicos

```bash
# Testes de POST (Upload e operações)
robot --outputdir results tests/api/posts/Posts-API.robot

# Testes de GET (Listagens)
robot --outputdir results tests/api/gets/Listagens-API.robot
```

### Testes de API Disponíveis

#### **tests/api/posts/Posts-API.robot** - Operações de Criação e Modificação
- Upload de documento PDF
- Upload de documento binário (base64)
- Upload de documento HASH
- Upload de documento + anexo
- Cadastro de signatários via Email/WhatsApp
- Envio para assinatura
- Adição de pins (assinatura, rubrica, selo)
- Geração de documentos via template Word/HTML
- Edição e remoção de signatários
- Adição de webhooks

#### **tests/api/gets/Listagens-API.robot** - Operações de Consulta
- Listar todos os documentos da conta
- Listar documento específico
- Listar documentos por fase
- Listar todos os cofres da conta
- Listar documentos de um cofre específico
- Listar webhooks de um documento específico
- Listar pins do documento

## 📌 Teste de Pin

O projeto inclui um teste específico para validação de funcionalidades de pin no sistema D4Sign.

### **tests/web/envios/pin.robot** - Validação de Pin e Canvas

Este teste valida o funcionamento completo do sistema de pins no documento:

#### **Funcionalidades Testadas:**
- ✅ Upload de documento principal
- ✅ Adição de anexo ao documento
- ✅ Validação de carregamento de canvas (páginas 1, 2, 3, 4)
- ✅ Adição de pin no documento
- ✅ Replicação de pin em todas as páginas do documento e anexo
- ✅ Validação de pin adicionado em todas as páginas
- ✅ Remoção de pin de todas as páginas
- ✅ Validação de pin removido de todas as páginas

#### **Cenários de Teste:**
1. **Carregamento de Documentos**: Verifica se o documento principal e anexo são carregados corretamente
2. **Validação de Canvas**: Confirma que todos os canvas (páginas) estão disponíveis
3. **Adição de Pin**: Testa a funcionalidade de adicionar pin no documento
4. **Replicação de Pin**: Valida a replicação automática do pin em todas as páginas
5. **Remoção de Pin**: Testa a remoção do pin de todas as páginas com confirmação

#### **Executar o Teste de Pin:**
```bash
# Executar teste específico de pin
robot --outputdir results tests/web/envios/pin.robot

# Executar com logs detalhados
robot --outputdir results --loglevel DEBUG tests/web/envios/pin.robot
```

### Recursos Compartilhados

O projeto utiliza recursos compartilhados organizados na pasta `resources/`:

#### **resources/common/**
- **`variables.robot`** - Variáveis globais e elementos de UI
- **`tag_logging.robot`** - Sistema de logs específicos por tag com emojis

#### **resources/config/**
- **`config_environment.robot`** - Configurações de ambiente (URLs, timeouts, retry)
- **`config_sensitive.robot`** - Configurações sensíveis (credenciais, tokens de API)

#### **resources/ui/**
- **`ui_keywords.robot`** - Keywords específicas para UI (setup/teardown, login)

#### **resources/api/**
- **`api_keywords.robot`** - Keywords específicas para testes de API (upload, signatários, templates, webhooks)

### Funcionalidades dos Testes de API

#### 🔄 **Validações Automáticas**
- Status codes HTTP (200, 400, 401, etc.)
- Estrutura e conteúdo de respostas JSON
- Tempo de resposta das requisições
- Validação de UUIDs e formatos de dados

#### 📊 **Logs Detalhados**
- Respostas formatadas em JSON para fácil leitura
- Tempo de execução de cada requisição
- Logs estruturados para debugging
- Sistema de logs por tag com emojis identificadores

#### 🛡️ **Tratamento de Erros**
- Validação de arquivos antes do upload
- Verificação de existência de documentos
- Tratamento de respostas de erro da API
- Caminhos de arquivos corrigidos com `${EXECDIR}`

#### 🚀 **Keywords Avançadas**
- **Upload PDF**: Upload direto de arquivos PDF
- **Upload Binário**: Upload em base64
- **Upload Hash**: Upload via SHA256/SHA512
- **Adicionar Signatários**: Cadastro via email/WhatsApp
- **Gerenciar Pins**: Adição de campos de assinatura
- **Templates**: Geração via Word/HTML
- **Webhooks**: Configuração de notificações

## 📁 Estrutura do Projeto

```
robot-D4S/
│
├── tests/                      # Testes organizados por categoria
│   ├── api/                    # Testes de API
│   │   ├── gets/               # Testes de GET (Listagens)
│   │   │   └── Listagens-API.robot
│   │   └── posts/              # Testes de POST (Upload, criação)
│   │       └── Posts-API.robot
│   │
│   └── web/                    # Testes web organizados por funcionalidade
│       ├── ui/                 # Testes de interface do usuário
│       │   ├── busca-signatario.robot
│       │   ├── busca-tags.robot
│       │   ├── criar-cofre.robot
│       │   └── listar-fases.robot
│       │
│       └── envios/             # Testes de envios e assinaturas
│           ├── envio-assinatura.robot
│           ├── envio-cofre.robot
│           ├── envio-desk.robot
│           ├── envio-grupo-assinatura.robot
│           ├── envio-lote.robot
│           ├── envio-powerform.robot
│           ├── envio-template-html.robot
│           └── pin.robot
|               
│
├── resources/                  # Recursos organizados por contexto
│   ├── api/                    # Recursos específicos para API
│   │   └── api_keywords.robot
│   │
│   ├── common/                 # Recursos compartilhados
│   │   ├── variables.robot
│   │   ├── tag_logging.robot
│   │   └── retry_utils.robot
│   │
│   ├── config/                 # Configurações
│   │   ├── config_environment.robot
│   │   └── config_sensitive.robot
│   │
│   └── ui/                     # Recursos específicos para UI
│       └── ui_keywords.robot
│
├── data/                       # Dados e arquivos de teste
│   └── files/                  # Arquivos de teste
│       ├── doc-testes.pdf
│       └── planilha.xlsx
│
├── results/                    # Relatórios de execução
│   ├── log.html
│   ├── output.xml
│   └── report.html
│
├── docs/                       # Documentação do projeto
│   └── GUIA_TAGS_AMBIENTES.md  # Guia de tags e ambientes
│
├── README.md                   # Este arquivo
├── requirements.txt            # Dependências do projeto
└── .gitignore                  # Configurações do Git
```

## 📚 Bibliotecas Utilizadas

| Biblioteca | Descrição |
|------------|-----------|
| **SeleniumLibrary**    | Automação de browser e interface web |
| **OperatingSystem**    | Comandos do sistema operacional (arquivos, diretórios, etc.) |
| **FakerLibrary**       | Geração de dados aleatórios para preenchimento em testes |
| **RequestsLibrary**    | Automação de testes de API REST |
| **JSONLibrary**        | Manipulação e validação de dados JSON |
| **String**             | Operações com strings e manipulação de texto |
| **Collections**        | Operações com listas, dicionários e estruturas de dados |

## 📊 Relatórios

Após a execução dos testes, os relatórios são gerados na pasta `results/`:

### **Estrutura de Relatórios:**

#### **results/** - Relatórios de Execução
- **`report.html`** - Relatório principal com resumo dos testes executados
- **`log.html`** - Log detalhado da execução completa
- **`output.xml`** - Arquivo XML com dados estruturados dos testes

### **Visualização dos Relatórios:**

```bash
# Abrir relatório principal
start results/report.html

# Abrir log detalhado
start results/log.html
```

### **Tags nos Relatórios:**

Os relatórios incluem sistema de tags para facilitar a análise:

- **🌐 web** - Testes web (interface e funcionalidades)
- **🔌 api** - Testes de API
- **🖥️ ui** - Testes de interface do usuário
- **📤 envio** - Testes de envios e assinaturas
- **⚠️ critical** - Testes críticos
- **📄 template** - Testes de templates
- **📦 lote** - Testes de processamento em lote

## 🚀 Estrutura Organizada do Projeto

### **✅ Benefícios da Organização:**

#### **📁 Separação por Contexto:**
- **Web Tests**: Organizados por funcionalidade (ui, envios)
- **API Tests**: Separados por operação (gets, posts)
- **Resources**: Organizados por contexto (common, config, ui, api)

#### **🏷️ Sistema de Tags:**
- Categorização automática dos testes
- Logs específicos por tag com emojis
- Execução seletiva por categoria
- Relatórios organizados por tag

#### **📊 Relatórios Centralizados:**
- Relatórios unificados na pasta `results/`
- Logs detalhados por categoria
- Visualização simplificada dos resultados

#### **🔧 Configuração Modular:**
- Configurações de ambiente centralizadas
- Recursos específicos por contexto
- Dependências claras entre arquivos

### **🎯 Como Usar a Estrutura:**

#### **Executar por Categoria:**
```bash
# Apenas testes de UI
robot --include ui tests/web/

# Apenas testes de envios
robot --include envio tests/web/

# Apenas testes de pin
robot --include pin tests/web/

# Apenas testes de API
robot --include api tests/api/

# Testes críticos de todas as categorias
robot --include critical tests/
```

#### **Executar por Ambiente:**
```bash
# Executar em ambiente de desenvolvimento
robot --variable ENVIRONMENT:dev tests/

# Executar em ambiente de staging
robot --variable ENVIRONMENT:staging tests/

# Executar em ambiente de produção
robot --variable ENVIRONMENT:prod tests/
```

#### **Executar com Logs Detalhados:**
```bash
# Com logs de debug ativados
robot --variable DEBUG_MODE:true tests/

# Com logs específicos de API
robot --variable DEBUG_API_CALLS:true tests/api/
```



---

**Desenvolvido com ❤️ usando Robot Framework por João Carlos Jr.**