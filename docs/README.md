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
- [Novidades da Nova Estrutura](#-novidades-da-nova-estrutura)
- [Arquivos de Exemplo](#-arquivos-de-exemplo)

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

Edite o arquivo `resources/config/config_sensitive.robot` com suas credenciais da API D4Sign:

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

### Executar todos os testes (Smoke + API)

```bash
# Executar todos os testes do projeto
robot --outputdir reports/combined tests/
```

### Executar todos os testes Smoke

```bash
# Executar todos os testes de smoke
robot --outputdir reports/smoke tests/smoke/
```

### Executar todos os testes de API

```bash
# Executar todos os testes de API
robot --outputdir reports/api tests/api/
```

### Executar teste específico

```bash
# Executar teste específico de UI
robot --outputdir reports/smoke tests/smoke/ui/01-busca-signatario.robot

# Executar teste específico de API
robot --outputdir reports/api tests/api/posts/Posts-API.robot
```

### Executar com tags específicas

```bash
# Executar apenas testes com tag 'smoke'
robot --include smoke --outputdir reports/combined tests/

# Executar apenas testes com tag 'api'
robot --include api --outputdir reports/combined tests/

# Executar apenas testes críticos
robot --include critical --outputdir reports/combined tests/

# Executar testes por categoria
robot --include upload --outputdir reports/smoke tests/smoke/
robot --include signature --outputdir reports/smoke tests/smoke/
```

## 🔌 Testes de API

O projeto inclui testes automatizados para a API da D4Sign, validando endpoints de upload, listagem e gerenciamento de documentos.

### Executar testes de API específicos

```bash
# Testes de POST (Upload e operações)
robot --outputdir reports/api tests/api/posts/Posts-API.robot

# Testes de GET (Listagens)
robot --outputdir reports/api tests/api/gets/Listagens-API.robot
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
│   └── smoke/                  # Testes de smoke organizados por funcionalidade
│       ├── ui/                 # Testes de interface do usuário
│       │   ├── 01-busca-signatario.robot
│       │   ├── 02-busca-tags.robot
│       │   └── 03-listar-fases.robot
│       │
│       ├── upload/             # Testes de upload
│       │   ├── 04-criar-cofre.robot
│       │   ├── 05-envio-desk.robot
│       │   └── 06-envio-cofre.robot
│       │
│       ├── signature/          # Testes de assinatura
│       │   ├── 07-envio-assinatura.robot
│       │   ├── 08-envio-grupo-assinatura.robot
│       │   └── 13-assinatura-lote.robot
│       │
│       └── templates/          # Testes de templates
│           ├── 09-envio-template-html.robot
│           ├── 10-envio-template-word.robot
│           ├── 11-envio-lote.robot
│           └── 12-envio-powerform.robot
│
├── resources/                  # Recursos organizados por contexto
│   ├── api/                    # Recursos específicos para API
│   │   └── api_keywords.robot
│   │
│   ├── common/                 # Recursos compartilhados
│   │   ├── variables.robot
│   │   └── tag_logging.robot
│   │
│   ├── config/                 # Configurações
│   │   ├── config_environment.robot
│   │   └── config_sensitive.robot
│   │
│   └── ui/                     # Recursos específicos para UI
│       └── ui_keywords.robot
│
├── data/                       # Dados e arquivos de teste
│   ├── files/                  # Arquivos de teste
│   │   ├── doc-testes.pdf
│   │   └── planilha.xlsx
│   └── test_data/              # Dados de teste estruturados
│
├── reports/                    # Relatórios organizados por categoria
│   ├── api/                    # Relatórios de testes de API
│   ├── smoke/                  # Relatórios de smoke tests
│   └── combined/               # Relatórios combinados
│       ├── log.html
│       ├── output.xml
│       └── report.html
│
├── docs/                       # Documentação do projeto
│   ├── README.md               # Este arquivo
│   ├── NOVA_ESTRUTURA.md       # Documentação da nova estrutura
│   ├── ESTRUTURA_RESOURCES.md  # Documentação dos recursos
│   └── GUIA_TAGS.md            # Guia de uso de tags
│
├── .gitignore                  # Configurações do Git
└── to do API.txt              # Lista de tarefas
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

Após a execução dos testes, os relatórios são gerados organizados por categoria:

### **Estrutura de Relatórios:**

#### **reports/combined/** - Relatórios Combinados
- **`report.html`** - Relatório principal com resumo de todos os testes
- **`log.html`** - Log detalhado da execução completa
- **`output.xml`** - Arquivo XML com dados estruturados dos testes

#### **reports/api/** - Relatórios de API
- Relatórios específicos dos testes de API
- Logs detalhados das requisições HTTP

#### **reports/smoke/** - Relatórios de Smoke Tests
- Relatórios específicos dos smoke tests
- Logs detalhados das interações com a UI

### **Visualização dos Relatórios:**

```bash
# Abrir relatório combinado
start reports/combined/report.html

# Abrir relatório de API
start reports/api/report.html

# Abrir relatório de smoke tests
start reports/smoke/report.html
```

### **Tags nos Relatórios:**

Os relatórios incluem sistema de tags para facilitar a análise:

- **🔥 smoke** - Testes de smoke
- **🌐 api** - Testes de API
- **🖥️ ui** - Testes de interface
- **⚠️ critical** - Testes críticos
- **📤 upload** - Testes de upload
- **✍️ signature** - Testes de assinatura
- **📄 template** - Testes de template
- **📦 batch** - Testes de lote

## 🚀 Novidades da Nova Estrutura

### **✅ Benefícios da Organização:**

#### **📁 Separação por Contexto:**
- **UI Tests**: Organizados por funcionalidade (ui, upload, signature, templates)
- **API Tests**: Separados por operação (gets, posts)
- **Resources**: Organizados por contexto (common, config, ui, api)

#### **🏷️ Sistema de Tags:**
- Categorização automática dos testes
- Logs específicos por tag com emojis
- Execução seletiva por categoria
- Relatórios organizados por tag

#### **📊 Relatórios Organizados:**
- Relatórios separados por tipo de teste
- Relatórios combinados para visão geral
- Logs detalhados por categoria

#### **🔧 Configuração Modular:**
- Configurações de ambiente centralizadas
- Recursos específicos por contexto
- Dependências claras entre arquivos

### **🎯 Como Usar a Nova Estrutura:**

#### **Executar por Categoria:**
```bash
# Apenas testes de UI
robot --include ui tests/smoke/

# Apenas testes de upload
robot --include upload tests/smoke/

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

## 📝 Arquivos de Exemplo

O projeto inclui arquivos de exemplo na raiz para demonstrar funcionalidades:

### **exemplo_simples_ambiente.robot**
- Demonstra configuração básica de ambiente
- Exemplo de uso das variáveis de configuração

### **exemplo_teste_ambientes.robot**
- Exemplo completo de teste com múltiplos ambientes
- Demonstra uso de retry e configurações avançadas

### **exemplo_tags_implementadas.robot**
- Exemplo de implementação do sistema de tags
- Demonstra logs específicos por categoria

### **Como Executar os Exemplos:**

```bash
# Executar exemplo simples
robot exemplo_simples_ambiente.robot

# Executar exemplo de ambientes
robot exemplo_teste_ambientes.robot

# Executar exemplo de tags
robot exemplo_tags_implementadas.robot
```


---

**Desenvolvido com ❤️ usando Robot Framework por João Carlos Jr.**