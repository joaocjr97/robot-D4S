# 🤖 Robot-D4S

[![Python](https://img.shields.io/badge/Python-3.7+-blue.svg)](https://www.python.org/downloads/)
[![Robot Framework](https://img.shields.io/badge/Robot%20Framework-Latest-green.svg)](https://robotframework.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Este projeto contém scripts de automação de testes utilizando o [Robot Framework](https://robotframework.org/) para validação de funcionalidades do sistema D4S.

## 📋 Índice

- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Executando os Testes](#-executando-os-testes)
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
```

### 4. Configure o ChromeDriver

1. Baixe o ChromeDriver compatível com sua versão do Chrome em [chromedriver.chromium.org](https://chromedriver.chromium.org/downloads)
2. Adicione o executável ao seu PATH ou coloque na pasta do projeto

## ▶️ Executando os Testes

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

## 📁 Estrutura do Projeto

```
robot-D4S/
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
│   └── results/                # Relatórios de execução
│       ├── log.html
│       ├── output.xml
│       └── report.html
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
| **SeleniumLibrary** | Automação de browser e interface web |
| **OperatingSystem** | Comandos do sistema operacional (arquivos, diretórios, etc.) |
| **FakerLibrary** | Geração de dados aleatórios para preenchimento em testes |

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

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

**Desenvolvido com ❤️ usando Robot Framework por João Carlos Jr.**