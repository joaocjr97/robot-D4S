# Como Executar Testes em Diferentes Ambientes

## Exemplos de Comandos para Executar

### 1. Teste em Ambiente de Desenvolvimento
```bash
robot -v ENVIRONMENT:dev exemplo_teste_ambientes.robot
```

### 2. Teste em Ambiente de Homologação
```bash
robot -v ENVIRONMENT:homol exemplo_teste_ambientes.robot
```

### 3. Teste em Ambiente de Staging
```bash
robot -v ENVIRONMENT:staging exemplo_teste_ambientes.robot
```

### 4. Teste em Ambiente de Produção
```bash
robot -v ENVIRONMENT:prod exemplo_teste_ambientes.robot
```

### 5. Executar com Configurações Personalizadas
```bash
# Alterar número de retries e delay
robot -v ENVIRONMENT:staging -v MAX_RETRIES:5 -v RETRY_DELAY:3s exemplo_teste_ambientes.robot

# Executar em modo GUI (não headless)
robot -v ENVIRONMENT:dev -v BROWSER_MODE:gui exemplo_teste_ambientes.robot

# Executar com timeout personalizado
robot -v ENVIRONMENT:prod -v TIMEOUT_PROD:300s exemplo_teste_ambientes.robot
```

### 6. Executar Testes Específicos por Tags
```bash
# Apenas testes de login
robot -v ENVIRONMENT:staging --include login exemplo_teste_ambientes.robot

# Apenas ambiente de produção
robot -v ENVIRONMENT:prod --include prod exemplo_teste_ambientes.robot

# Excluir testes de produção
robot -v ENVIRONMENT:staging --exclude prod exemplo_teste_ambientes.robot
```

## Configurações Disponíveis

### Ambientes Suportados:
- `dev` - Desenvolvimento
- `homol` - Homologação  
- `staging` - Staging
- `prod` - Produção

### Parâmetros de Retry:
- `MAX_RETRIES` - Número máximo de tentativas (padrão: 3)
- `RETRY_DELAY` - Tempo de espera entre tentativas (padrão: 2s)

### Outros Parâmetros:
- `BROWSER_MODE` - headless ou gui
- `SCREENSHOT_ON_FAIL` - true ou false
- `LOG_LEVEL` - DEBUG, INFO, WARN, ERROR

## Exemplo de Execução com Múltiplas Configurações

```bash
robot \
  -v ENVIRONMENT:staging \
  -v MAX_RETRIES:5 \
  -v RETRY_DELAY:3s \
  -v BROWSER_MODE:headless \
  -v LOG_LEVEL:DEBUG \
  --include login \
  exemplo_teste_ambientes.robot
```

## Logs e Resultados

Os logs e screenshots serão salvos na pasta `results/` com informações sobre:
- Qual ambiente foi testado
- Quantas tentativas foram feitas
- Tempo de execução
- Screenshots em caso de falha
