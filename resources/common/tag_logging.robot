*** Settings ***
Documentation    Sistema de logs específicos por tag

*** Variables ***
# Tags para categorização de testes
${SMOKE_TAG}              smoke
${API_TAG}                api
${UI_TAG}                 ui
${CRITICAL_TAG}           critical
${REGRESSION_TAG}         regression
${LOGIN_TAG}              login
${UPLOAD_TAG}             upload
${SIGNATURE_TAG}          signature
${TEMPLATE_TAG}           template
${BATCH_TAG}              batch

*** Keywords ***
Log Tag Info
    [Documentation]    Log informações específicas baseadas na tag do teste
    [Arguments]    ${tag}    ${message}    ${level}=INFO
    
    ${emoji}=    Set Variable If
    ...    '${tag}' == '${SMOKE_TAG}'           🔥
    ...    '${tag}' == '${API_TAG}'             🌐
    ...    '${tag}' == '${UI_TAG}'              🖥️
    ...    '${tag}' == '${CRITICAL_TAG}'        ⚠️
    ...    '${tag}' == '${REGRESSION_TAG}'      🔄
    ...    '${tag}' == '${LOGIN_TAG}'           🔐
    ...    '${tag}' == '${UPLOAD_TAG}'          📤
    ...    '${tag}' == '${SIGNATURE_TAG}'       ✍️
    ...    '${tag}' == '${TEMPLATE_TAG}'        📄
    ...    '${tag}' == '${BATCH_TAG}'           📦
    ...    🏷️
    
    Log    ${emoji} [${tag}] ${message}    ${level}

Log Smoke Test Info
    [Documentation]    Log específico para smoke tests
    [Arguments]    ${message}
    Log Tag Info    ${SMOKE_TAG}    ${message}

Log API Test Info
    [Documentation]    Log específico para testes de API
    [Arguments]    ${message}
    Log Tag Info    ${API_TAG}    ${message}

Log UI Test Info
    [Documentation]    Log específico para testes de UI
    [Arguments]    ${message}
    Log Tag Info    ${UI_TAG}    ${message}

Log Critical Test Info
    [Documentation]    Log específico para testes críticos
    [Arguments]    ${message}
    Log Tag Info    ${CRITICAL_TAG}    ${message}

Log Regression Test Info
    [Documentation]    Log específico para testes de regressão
    [Arguments]    ${message}
    Log Tag Info    ${REGRESSION_TAG}    ${message}

Log Login Test Info
    [Documentation]    Log específico para testes de login
    [Arguments]    ${message}
    Log Tag Info    ${LOGIN_TAG}    ${message}

Log Upload Test Info
    [Documentation]    Log específico para testes de upload
    [Arguments]    ${message}
    Log Tag Info    ${UPLOAD_TAG}    ${message}

Log Signature Test Info
    [Documentation]    Log específico para testes de assinatura
    [Arguments]    ${message}
    Log Tag Info    ${SIGNATURE_TAG}    ${message}

Log Template Test Info
    [Documentation]    Log específico para testes de template
    [Arguments]    ${message}
    Log Tag Info    ${TEMPLATE_TAG}    ${message}

Log Batch Test Info
    [Documentation]    Log específico para testes em lote
    [Arguments]    ${message}
    Log Tag Info    ${BATCH_TAG}    ${message}

Log Test Start
    [Documentation]    Log início do teste com informações das tags
    [Arguments]    @{tags}
    
    ${tag_list}=    Evaluate    ', '.join($tags)
    Log Tag Info    Test Start    Iniciando teste com tags: ${tag_list}

Log Test End
    [Documentation]    Log fim do teste
    [Arguments]    @{tags}
    
    ${tag_list}=    Evaluate    ', '.join($tags)
    Log Tag Info    Test End    Teste finalizado com tags: ${tag_list}

Log Test Result
    [Documentation]    Log resultado do teste
    [Arguments]    ${result}    @{tags}
    
    ${emoji}=    Set Variable If
    ...    '${result}' == 'PASS'    ✅
    ...    '${result}' == 'FAIL'    ❌
    ...    '${result}' == 'SKIP'    ⏭️
    ...    ℹ️
    
    ${tag_list}=    Evaluate    ', '.join($tags)
    Log Tag Info    Test Result    ${emoji} Resultado: ${result} - Tags: ${tag_list}