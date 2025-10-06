*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    Collections

*** Keywords ***
Retry Keyword
    [Documentation]    Executa uma keyword com retry automático usando as configurações do config_environment.robot
    [Arguments]    ${keyword}    @{args}
    
    ${attempt}=    Set Variable    1
    ${errors}=    Create List
    
    WHILE    ${attempt} <= ${MAX_RETRIES}
        TRY
            Log    🔄 Tentativa ${attempt} de ${MAX_RETRIES} - Executando: ${keyword}
            
            # Executa a keyword
            Run Keyword    ${keyword}    @{args}
            
            Log    ✅ Sucesso na tentativa ${attempt}
            BREAK
            
        EXCEPT    AS    ${error}
            Log    ❌ Falha na tentativa ${attempt}: ${error}
            Append To List    ${errors}    Tentativa ${attempt}: ${error}
            
            IF    ${attempt} < ${MAX_RETRIES}
                Log    ⏳ Aguardando ${RETRY_DELAY} antes da próxima tentativa...
                Sleep    ${RETRY_DELAY}
                ${attempt}=    Evaluate    ${attempt} + 1
            ELSE
                Log    💥 Falha após ${MAX_RETRIES} tentativas
                ${all_errors}=    Evaluate    '\\n'.join(${errors})
                Fail    Keyword falhou após ${MAX_RETRIES} tentativas:\n${all_errors}
            END
        END
    END

Retry Click Element
    [Documentation]    Clica em elemento com retry automático (resolve problemas de modal/overlay)
    [Arguments]    ${locator}
    
    ${attempt}=    Set Variable    1
    
    WHILE    ${attempt} <= ${MAX_RETRIES}
        TRY
            Log    🖱️ Tentativa ${attempt} - Clicando em: ${locator}
            
            # Aguarda elemento estar visível
            Wait Until Element Is Visible    ${locator}    timeout=10s
            Click Element    ${locator}
            
            Log    ✅ Elemento clicado com sucesso
            BREAK
            
        EXCEPT    AS    ${error}
            Log    ❌ Falha ao clicar na tentativa ${attempt}: ${error}
            
            # Verifica se é erro de elemento interceptado (modal, overlay, etc.)
            IF    'ElementClickInterceptedException' in '${error}' or 'is not clickable' in '${error}'
                Log    🔍 Detectado problema de elemento interceptado, tentando resolver...
                
                # Tenta fechar modais ou overlays
                Run Keyword And Ignore Error    Press Keys    NONE    ESC
                Run Keyword And Ignore Error    Execute JavaScript    window.scrollTo(0, 0)
                Sleep    1s
            END
            
            IF    ${attempt} < ${MAX_RETRIES}
                Log    ⏳ Aguardando ${RETRY_DELAY} antes da próxima tentativa...
                Sleep    ${RETRY_DELAY}
                ${attempt}=    Evaluate    ${attempt} + 1
            ELSE
                Log    💥 Falha ao clicar após ${MAX_RETRIES} tentativas
                Fail    Falha ao clicar em ${locator} após ${MAX_RETRIES} tentativas: ${error}
            END
        END
    END

Retry Wait Element
    [Documentation]    Aguarda elemento aparecer com retry
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT_DEV}
    
    ${attempt}=    Set Variable    1
    
    WHILE    ${attempt} <= ${MAX_RETRIES}
        TRY
            Log    👀 Tentativa ${attempt} - Aguardando elemento: ${locator}
            
            Wait Until Element Is Visible    ${locator}    timeout=${timeout}
            
            Log    ✅ Elemento encontrado com sucesso
            BREAK
            
        EXCEPT    AS    ${error}
            Log    ❌ Elemento não encontrado na tentativa ${attempt}: ${error}
            
            IF    ${attempt} < ${MAX_RETRIES}
                Log    ⏳ Aguardando ${RETRY_DELAY} antes de tentar novamente...
                Sleep    ${RETRY_DELAY}
                ${attempt}=    Evaluate    ${attempt} + 1
            ELSE
                Log    💥 Elemento não encontrado após ${MAX_RETRIES} tentativas
                Fail    Elemento ${locator} não encontrado após ${MAX_RETRIES} tentativas: ${error}
            END
        END
    END
