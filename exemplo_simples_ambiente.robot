*** Settings ***
Documentation    Exemplo simples de teste usando configurações de ambiente
Resource         resources/config/config_environment.robot

*** Test Cases ***
Teste Simples com Retry
    [Documentation]    Exemplo básico de como usar retry com diferentes ambientes
    [Tags]    exemplo
    Configurar URL do Ambiente
    Executar Ação com Retry

*** Keywords ***
Configurar URL do Ambiente
    [Documentation]    Configura a URL baseada na variável ENVIRONMENT
    
    # Se ENVIRONMENT estiver vazio, usar dev como padrão
    ${env}=    Set Variable If    '${ENVIRONMENT}' == '${EMPTY}'    dev    ${ENVIRONMENT}
    
    # Definir URL baseada no ambiente
    ${url}=    Set Variable If
    ...    '${env}' == 'dev'        ${URL_DEV}
    ...    '${env}' == 'homol'      ${URL_HOMOL}
    ...    '${env}' == 'staging'    ${URL_STAGING}
    ...    '${env}' == 'prod'       ${URL_PROD}
    ...    ${URL_DEV}  # Default
    
    Set Test Variable    ${URL_ATUAL}    ${url}
    Log    Ambiente: ${env} - URL: ${url}

Executar Ação com Retry
    [Documentation]    Executa uma ação com retry usando MAX_RETRIES e RETRY_DELAY
    
    ${tentativa}=    Set Variable    1
    
    WHILE    ${tentativa} <= ${MAX_RETRIES}
        TRY
            Log    Tentativa ${tentativa} de ${MAX_RETRIES}
            
            # Sua ação aqui (exemplo: abrir página)
            Open Browser    ${URL_ATUAL}    browser=chrome
            Wait Until Page Contains    D4Sign    timeout=10s
            Log    Página carregada com sucesso!
            Close Browser
            
            Log    ✅ Sucesso na tentativa ${tentativa}
            BREAK
            
        EXCEPT    AS    ${erro}
            Log    ❌ Falha na tentativa ${tentativa}: ${erro}
            
            # Fechar browser se estiver aberto
            Run Keyword And Ignore Error    Close Browser
            
            IF    ${tentativa} < ${MAX_RETRIES}
                Log    ⏳ Aguardando ${RETRY_DELAY} antes da próxima tentativa...
                Sleep    ${RETRY_DELAY}
                ${tentativa}=    Evaluate    ${tentativa} + 1
            ELSE
                Fail    💥 Falha após ${MAX_RETRIES} tentativas. Último erro: ${erro}
            END
        END
    END
