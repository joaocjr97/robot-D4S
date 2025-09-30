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
- [Contribuição](#-contribuição)

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

```bash
# Copie o arquivo de exemplo
copy "Smoke Test - D4S\config_sensitive.example.robot" "Smoke Test - D4S\config_sensitive.robot"

# Edite o arquivo com suas credenciais reais
notepad "Smoke Test - D4S\config_sensitive.robot"
```

### 5. Configure as credenciais da API

Edite o arquivo `resource/config_sensitive.robot` com suas credenciais da API D4Sign:

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

### 6. Configure o ChromeDriver

1. Baixe o ChromeDriver compatível com sua versão do Chrome em [chromedriver.chromium.org](https://chromedriver.chromium.org/downloads)
2. Adicione o executável ao seu PATH ou coloque na pasta do projeto

## ▶️ Executando os Testes

### Executar todos os testes (Smoke + API)

```bash
# Executar todos os testes do projeto
robot --outputdir results "Smoke Test - D4S" API/
```

### Executar todos os testes Smoke

```bash
cd "Smoke Test - D4S"
robot --outputdir results .
```

### Executar teste específico

```bash
robot --outputdir results 01-busca-signatario.robot
```

### Executar com tags específicas

```bash
robot --include smoke --outputdir results .
```

## 🔌 Testes de API

O projeto inclui testes automatizados para a API da D4Sign, validando endpoints de upload, listagem e gerenciamento de documentos.

### Executar todos os testes de API

```bash
cd API
robot --outputdir ../results .
```

### Executar testes de API específicos

```bash
# Testes de POST (Upload e operações)
robot --outputdir ../results Posts-API.robot

# Testes de GET (Listagens)
robot --outputdir ../results Listagens-API.robot
```

### Testes de API Disponíveis

#### **Posts-API.robot** - Operações de Criação e Modificação
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

#### **Listagens-API.robot** - Operações de Consulta
- Listar todos os documentos da conta
- Listar documento específico
- Listar documentos por fase
- Listar todos os cofres da conta
- Listar documentos de um cofre específico
- Listar webhooks de um documento específico
- Listar pins do documento

### Recursos Compartilhados

O projeto utiliza recursos compartilhados na pasta `resource/`:

- **`variables.robot`** - Contém todas as variáveis do projeto (URLs, elementos de interface, dados de teste)
- **`keywords.robot`** - Keywords customizadas para automação web e API
- **`config_sensitive.robot`** - Configurações sensíveis (credenciais, tokens de API)

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

#### 🛡️ **Tratamento de Erros**
- Validação de arquivos antes do upload
- Verificação de existência de documentos
- Tratamento de respostas de erro da API

## 📁 Estrutura do Projeto

```
robot-D4S/
│
├── API/                        # Testes de API
│   ├── Posts-API.robot         # Testes de POST (Upload, criação, modificação)
│   └── Listagens-API.robot     # Testes de GET (Listagens e consultas)
│
├── Smoke Test - D4S/           # Testes de smoke test
│   ├── 01-busca-signatario.robot
│   ├── 02-busca-tags.robot
│   ├── 03-listar-fases.robot
│   ├── 04-criar-cofre.robot
│   ├── 05-envio-desk.robot
│   ├── 06-envio-cofre.robot
│   ├── 07-envio-assinatura.robot
│   ├── 08-envio-grupo-assinatura.robot
│   ├── 09-envio-template-html.robot
│   ├── 10-envio-template-word.robot
│   ├── 11-envio-lote.robot
│   ├── 12-envio-powerform.robot
│   ├── 13-assinatura-lote.robot
│ 
│   
│ 
│ 
│
├── resource/                   # Recursos compartilhados
│   ├── variables.robot         # Variáveis do projeto
│   ├── keywords.robot          # Keywords customizadas
│   └── config_sensitive.robot  # Configurações sensíveis
│
├── files/                      # Arquivos de teste
│   ├── doc-testes.pdf
│   └── planilha.xlsx
│
├── results/                    # Relatórios gerais
│   ├── log.html
│   ├── output.xml
│   └── report.html
│
├── README.md                   # Este arquivo
├── anotacoes.md               # Anotações do projeto
└── requirements.txt           # Dependências Python
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

Após a execução dos testes, os seguintes arquivos são gerados na pasta `results/`:

- **`report.html`** - Relatório principal com resumo dos testes
- **`log.html`** - Log detalhado da execução
- **`output.xml`** - Arquivo XML com dados estruturados dos testes

Para visualizar os relatórios, abra o arquivo `report.html` em seu navegador.

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

---

**Desenvolvido com ❤️ usando Robot Framework por João Carlos Jr.**