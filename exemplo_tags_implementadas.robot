*** Settings ***
Documentation    Exemplo de como implementar tags nos testes existentes
Resource         resources/common/tag_logging.robot
Resource         resources/config/config_environment.robot

*** Test Cases ***
# EXEMPLO: Como adicionar tags aos testes existentes

Teste API - Listar Documentos (COM TAGS)
    [Documentation]    Exemplo de como seria um teste API com tags
    [Tags]    ${API_TAG}    ${SMOKE_TAG}    ${CRITICAL_TAG}
    Log    Este teste lista documentos via API
    Log    Tags aplicadas: API, SMOKE, CRITICAL

Teste UI - Busca de Signatário (COM TAGS)
    [Documentation]    Exemplo de como seria um teste UI com tags
    [Tags]    ${UI_TAG}    ${LOGIN_TAG}    ${SMOKE_TAG}
    Log    Este teste busca signatários na interface
    Log    Tags aplicadas: UI, LOGIN, SMOKE

Teste Upload - Documento PDF (COM TAGS)
    [Documentation]    Exemplo de como seria um teste de upload com tags
    [Tags]    ${UPLOAD_TAG}    ${API_TAG}    ${CRITICAL_TAG}
    Log    Este teste faz upload de PDF
    Log    Tags aplicadas: UPLOAD, API, CRITICAL

Teste Assinatura - Envio para Assinatura (COM TAGS)
    [Documentation]    Exemplo de como seria um teste de assinatura com tags
    [Tags]    ${SIGNATURE_TAG}    ${UI_TAG}    ${REGRESSION_TAG}
    Log    Este teste envia documento para assinatura
    Log    Tags aplicadas: SIGNATURE, UI, REGRESSION

Teste Template - Geração de Documento (COM TAGS)
    [Documentation]    Exemplo de como seria um teste de template com tags
    [Tags]    ${TEMPLATE_TAG}    ${API_TAG}
    Log    Este teste gera documento via template
    Log    Tags aplicadas: TEMPLATE, API

Teste Lote - Processamento em Lote (COM TAGS)
    [Documentation]    Exemplo de como seria um teste de lote com tags
    [Tags]    ${BATCH_TAG}    ${API_TAG}    ${REGRESSION_TAG}
    Log    Este teste processa documentos em lote
    Log    Tags aplicadas: BATCH, API, REGRESSION

# EXEMPLO: Tags por ambiente
Teste Staging - API Crítica (COM TAGS)
    [Documentation]    Exemplo de teste específico para staging
    [Tags]    ${API_TAG}    ${CRITICAL_TAG}    staging
    Log    Este teste roda apenas em staging
    Log    Tags aplicadas: API, CRITICAL, staging

Teste Produção - Smoke Test (COM TAGS)
    [Documentation]    Exemplo de teste específico para produção
    [Tags]    ${SMOKE_TAG}    ${CRITICAL_TAG}    prod
    Log    Este teste roda apenas em produção
    Log    Tags aplicadas: SMOKE, CRITICAL, prod
