# 📁 Estrutura Sugerida para Melhor Organização

```
robot-D4S/
│
├── tests/                           # Todos os testes organizados
│   ├── smoke/                       # Testes de smoke test
│   │   ├── ui/                      # Testes de interface
│   │   │   ├── 01-busca-signatario.robot
│   │   │   ├── 02-busca-tags.robot
│   │   │   └── 03-listar-fases.robot
│   │   ├── upload/                  # Testes de upload
│   │   │   ├── 04-criar-cofre.robot
│   │   │   ├── 05-envio-desk.robot
│   │   │   └── 06-envio-cofre.robot
│   │   ├── signature/               # Testes de assinatura
│   │   │   ├── 07-envio-assinatura.robot
│   │   │   ├── 08-envio-grupo-assinatura.robot
│   │   │   └── 13-assinatura-lote.robot
│   │   └── templates/               # Testes de templates
│   │       ├── 09-envio-template-html.robot
│   │       ├── 10-envio-template-word.robot
│   │       ├── 11-envio-lote.robot
│   │       └── 12-envio-powerform.robot
│   └── api/                         # Testes de API
│       ├── posts/                   # Operações POST
│       │   └── Posts-API.robot
│       └── gets/                    # Operações GET
│           └── Listagens-API.robot
│
├── resources/                       # Recursos compartilhados
│   ├── common/                      # Keywords comuns
│   │   ├── common_keywords.robot    # Keywords de login, etc.
│   │   └── test_tags.robot          # Tags padronizadas
│   ├── api/                         # Recursos específicos de API
│   │   ├── api_keywords.robot       # Keywords de API
│   │   └── api_variables.robot      # Variáveis de API
│   ├── ui/                          # Recursos específicos de UI
│   │   ├── ui_keywords.robot        # Keywords de UI
│   │   └── ui_variables.robot       # Variáveis de UI
│   └── config/                      # Configurações
│       ├── config_sensitive.robot   # Dados sensíveis
│       └── config_environment.robot # Configurações de ambiente
│
├── data/                           # Dados de teste
│   ├── files/                      # Arquivos de teste
│   │   ├── doc-testes.pdf
│   │   └── planilha.xlsx
│   └── test_data/                  # Dados estruturados
│       ├── users.json
│       └── test_scenarios.json
│
├── reports/                        # Relatórios de execução
│   ├── smoke/
│   ├── api/
│   └── combined/
│
├── scripts/                        # Scripts auxiliares
│   ├── setup_environment.py
│   └── generate_reports.py
│
├── docs/                          # Documentação
│   ├── README.md
│   ├── API_DOCUMENTATION.md
│   └── TEST_STRATEGY.md
│
└── requirements.txt
```

## 🎯 Benefícios da Nova Estrutura:

1. **Organização por funcionalidade** - Fácil localização de testes
2. **Separação clara de responsabilidades** - UI, API, dados separados
3. **Escalabilidade** - Fácil adicionar novos tipos de teste
4. **Manutenibilidade** - Recursos organizados por contexto
5. **Reutilização** - Keywords comuns centralizadas
