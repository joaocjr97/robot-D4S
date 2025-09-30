*** Settings ***
Documentation    Exemplo de como testar em diferentes ambientes usando configurações do config_environment.robot
Resource         resources/config/config_environment.robot
Resource         resources/common/common_keywords.robot
Resource         resources/ui/ui_keywords.robot

*** Variables ***
# Variável para armazenar a URL atual baseada no ambiente
${CURRENT_URL}    ${EMPTY}

*** Test Cases ***
Teste Login em Ambiente DEV
    [Documentation]    Testa login no ambiente de desenvolvimento
    [Tags]    dev    login
    Configurar Ambiente    dev
    Executar Teste Login com Retry

Teste Login em Ambiente HOMOL
    [Documentation]    Testa login no ambiente de homologação
    [Tags]    homol    login
    Configurar Ambiente    homol
    Executar Teste Login com Retry

Teste Login em Ambiente STAGING
    [Documentation]    Testa login no ambiente de staging
    [Tags]    staging    login
    Configurar Ambiente    staging
    Executar Teste Login com Retry

Teste Login em Ambiente PROD
    [Documentation]    Testa login no ambiente de produção
    [Tags]    prod    login
    Configurar Ambiente    prod
    Executar Teste Login com Retry

*** Keywords ***
Configurar Ambiente
    [Arguments]    ${ambiente}
    [Documentation]    Configura o ambiente baseado no parâmetro recebido
    
    # Define a URL baseada no ambiente
    ${CURRENT_URL}=    Set Variable If
    ...    '${ambiente}' == 'dev'        ${URL_DEV}
    ...    '${ambiente}' == 'homol'      ${URL_HOMOL}
    ...    '${ambiente}' == 'staging'    ${URL_STAGING}
    ...    '${ambiente}' == 'prod'       ${URL_PROD}
    ...    ${URL_DEV}  # Default para dev se não encontrar
    
    Set Global Variable    ${CURRENT_URL}
    Set Global Variable    ${ENVIRONMENT}    ${ambiente}
    
    # Configura timeout baseado no ambiente
    ${timeout}=    Set Variable If
    ...    '${ambiente}' == 'dev'        ${TIMEOUT_DEV}
    ...    '${ambiente}' == 'staging'    ${TIMEOUT_STAGING}
    ...    '${ambiente}' == 'prod'       ${TIMEOUT_PROD}
    ...    ${TIMEOUT_DEV}  # Default
    
    Set Global Variable    ${TIMEOUT}    ${timeout}
    
    Log    Ambiente configurado: ${ambiente} - URL: ${CURRENT_URL} - Timeout: ${timeout}

Executar Teste Login com Retry
    [Documentation]    Executa teste de login com retry automático usando as configurações do config_environment.robot
    
    ${retry_count}=    Set Variable    0
    ${max_attempts}=    Evaluate    ${MAX_RETRIES} + 1
    
    WHILE    ${retry_count} < ${max_attempts}
        TRY
            Log    Tentativa ${retry_count + 1} de ${max_attempts}
            Executar Login
            Log    Login realizado com sucesso!
            BREAK
        EXCEPT    AS    ${error}
            ${retry_count}=    Evaluate    ${retry_count} + 1
            Log    Falha na tentativa ${retry_count}: ${error}
            
            IF    ${retry_count} < ${max_attempts}
                Log    Aguardando ${RETRY_DELAY} antes da próxima tentativa...
                Sleep    ${RETRY_DELAY}
            ELSE
                Log    Número máximo de tentativas (${MAX_RETRIES}) atingido. Falha no teste.
                Fail    Falha após ${MAX_RETRIES} tentativas: ${error}
            END
        END
    END

Executar Login
    [Documentation]    Simula um teste de login (substitua pela sua lógica real)
    
    # Abrir navegador
    Open Browser    ${CURRENT_URL}    browser=chrome
    Set Window Size    1920    1080
    
    # Simular login (substitua pelos seus elementos reais)
    Wait Until Page Contains    Login    timeout=${TIMEOUT}
    Input Text    id=email    teste@exemplo.com
    Input Text    id=password    senha123
    Click Button    id=login-button
    
    # Verificar se login foi bem-sucedido
    Wait Until Page Contains    Dashboard    timeout=${TIMEOUT}
    Page Should Contain    Bem-vindo
    
    # Fechar navegador
    Close Browser

Executar Teste API com Retry
    [Documentation]    Exemplo de como usar retry para testes de API
    
    ${retry_count}=    Set Variable    0
    ${max_attempts}=    Evaluate    ${MAX_RETRIES} + 1
    
    WHILE    ${retry_count} < ${max_attempts}
        TRY
            Log    Tentativa API ${retry_count + 1} de ${max_attempts}
            
            # Exemplo de chamada API
            ${response}=    Get Request    ${CURRENT_URL}/api/health
            Should Be Equal As Strings    ${response.status_code}    200
            
            Log    API respondeu com sucesso!
            BREAK
            
        EXCEPT    AS    ${error}
            ${retry_count}=    Evaluate    ${retry_count} + 1
            Log    Falha na tentativa API ${retry_count}: ${error}
            
            IF    ${retry_count} < ${max_attempts}
                Log    Aguardando ${RETRY_DELAY} antes da próxima tentativa API...
                Sleep    ${RETRY_DELAY}
            ELSE
                Log    Número máximo de tentativas API (${MAX_RETRIES}) atingido.
                Fail    Falha na API após ${MAX_RETRIES} tentativas: ${error}
            END
        END
    END
