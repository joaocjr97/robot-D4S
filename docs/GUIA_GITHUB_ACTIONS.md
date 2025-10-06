# 🚀 Guia de Configuração do GitHub Actions

## 📋 Visão Geral

Este guia explica como configurar e usar o pipeline de CI/CD do GitHub Actions para o projeto Robot Framework D4S.

## 🔧 Configuração Inicial

### 1. Secrets do GitHub

Configure os seguintes secrets no seu repositório GitHub:

```bash
# Acesse: Settings > Secrets and variables > Actions
```

#### Secrets Necessários:

| Secret | Descrição | Exemplo |
|--------|-----------|---------|
| `USERNAME` | Usuário para login no D4Sign | `automacao@d4sign.com.br` |
| `PASSWORD` | Senha para login no D4Sign | `sua_senha` |
| `TOKEN_API` | Token da API D4Sign | `live_edbbbe82a765d29e08d33066fca8187d4d33af4ae5069f63f2532a33e157a3cc` |
| `CRYPT_KEY` | Chave de criptografia da API | `live_crypt_986BQliUIFNKCO2ZlDCubKHZkIapJpTA` |
| `EMAIL_TESTE` | Email para testes | `joao.carlos@d4sign.com.br` |

### 2. Estrutura do Workflow

O arquivo `.github/workflows/robot-tests.yml` contém:

- **Code Quality Check**: Validação de qualidade do código
- **API Tests**: Execução dos testes de API
- **Web Tests**: Execução dos testes web
- **Combined Tests**: Execução de todos os testes
- **Generate Reports**: Geração de relatórios
- **Notifications**: Notificações de resultado

## 🎯 Triggers do Workflow

### Execução Automática:
- **Push** para branches `main` ou `develop`
- **Pull Request** para branches `main` ou `develop`
- **Agendamento**: Todos os dias às 2h UTC (23h BRT)

### Execução Manual:
- **workflow_dispatch**: Permite executar manualmente
- **Parâmetros disponíveis**:
  - `environment`: dev, staging, prod
  - `test_suite`: all, api, web, smoke

## 🏗️ Jobs do Pipeline

### 1. Code Quality Check
```yaml
- Verifica sintaxe dos arquivos Robot Framework
- Executa rflint para validação de qualidade
- Pré-requisito para todos os outros jobs
```

### 2. API Tests
```yaml
- Executa testes de API em paralelo (dev, staging)
- Usa secrets para autenticação
- Gera relatórios específicos por ambiente
```

### 3. Web Tests
```yaml
- Executa testes web com Chrome headless
- Configura ChromeDriver automaticamente
- Screenshots em caso de falha
```

### 4. Combined Tests
```yaml
- Executa todos os testes (API + Web)
- Gera relatório consolidado
- Executa apenas se API e Web passaram
```

### 5. Generate Reports
```yaml
- Consolida todos os relatórios
- Gera summary com links para relatórios
- Disponibiliza artifacts para download
```

### 6. Notifications
```yaml
- Comenta em Pull Requests
- Envia notificações de resultado
- Links para relatórios detalhados
```

## 📊 Relatórios e Artifacts

### Artifacts Gerados:
- `api-test-results-{environment}`: Relatórios de API
- `web-test-results-{environment}`: Relatórios Web
- `combined-test-results-{environment}`: Relatórios combinados
- `test-summary-report`: Relatório resumo

### Estrutura de Relatórios:
```
results/
├── api/
│   ├── dev/
│   │   ├── report.html
│   │   ├── log.html
│   │   └── output.xml
│   └── staging/
│       ├── report.html
│       ├── log.html
│       └── output.xml
├── web/
│   ├── dev/
│   └── staging/
└── combined/
    ├── dev/
    └── staging/
```

## 🚀 Como Executar

### 1. Execução Automática
- Faça push para `main` ou `develop`
- Crie um Pull Request
- O pipeline será executado automaticamente

### 2. Execução Manual
1. Acesse a aba **Actions** no GitHub
2. Selecione **Robot Framework Tests**
3. Clique em **Run workflow**
4. Escolha os parâmetros:
   - **Environment**: dev, staging, prod
   - **Test Suite**: all, api, web, smoke
5. Clique em **Run workflow**

### 3. Execução por Tags
```bash
# No GitHub Actions, os testes são executados por tags:
robot --include api tests/api/     # Apenas testes de API
robot --include web tests/web/     # Apenas testes web
robot --include smoke tests/       # Apenas smoke tests
```

## 🔍 Monitoramento

### 1. Status dos Jobs
- ✅ **Success**: Todos os testes passaram
- ❌ **Failure**: Algum teste falhou
- ⏭️ **Skipped**: Job foi pulado (condição não atendida)
- ⏳ **In Progress**: Job está executando

### 2. Logs Detalhados
- Clique no job específico para ver logs
- Logs incluem:
  - Configuração do ambiente
  - Execução dos testes
  - Screenshots de falhas
  - Relatórios de erro

### 3. Notificações
- **Pull Requests**: Comentário automático com resultado
- **Email**: Notificações configuráveis no GitHub
- **Slack/Teams**: Integração possível via webhooks

## 🛠️ Configurações Avançadas

### 1. Execução Paralela
```yaml
strategy:
  fail-fast: false
  matrix:
    environment: [dev, staging, prod]
```

### 2. Condições de Execução
```yaml
if: github.event.inputs.test_suite == 'all' || github.event.inputs.test_suite == 'api'
```

### 3. Variáveis de Ambiente
```yaml
env:
  PYTHON_VERSION: '3.9'
  CHROME_VERSION: 'latest'
  ROBOT_FRAMEWORK_VERSION: '6.0.2'
```

## 🔧 Troubleshooting

### Problemas Comuns:

#### 1. Secrets não configurados
```
Error: Secret 'USERNAME' not found
```
**Solução**: Configure todos os secrets necessários

#### 2. ChromeDriver não encontrado
```
Error: ChromeDriver not found
```
**Solução**: O workflow instala automaticamente, verifique a versão do Chrome

#### 3. Testes falhando
```
Error: Test failed
```
**Solução**: Verifique logs detalhados e screenshots

#### 4. Timeout nos testes
```
Error: Test timeout
```
**Solução**: Aumente timeout nas configurações ou otimize testes

### Logs Úteis:
- **Setup logs**: Instalação de dependências
- **Test logs**: Execução dos testes
- **Error logs**: Falhas e exceções
- **Artifact logs**: Upload de relatórios

## 📈 Métricas e Melhorias

### Métricas Coletadas:
- Tempo de execução por job
- Taxa de sucesso por ambiente
- Número de testes executados
- Cobertura de testes

### Melhorias Futuras:
- Execução em múltiplos browsers
- Testes de performance
- Integração com Slack/Teams
- Dashboard de métricas

## 🎯 Próximos Passos

1. **Configure os secrets** no GitHub
2. **Teste o pipeline** com execução manual
3. **Monitore os resultados** nas primeiras execuções
4. **Ajuste configurações** conforme necessário
5. **Configure notificações** para sua equipe

---

**Desenvolvido com ❤️ para automação de testes D4S**
