*** Settings ***
Documentation    Keywords específicas para testes de UI
Library    SeleniumLibrary
Resource   ../common/variables.robot
Resource   ../config/config_sensitive.robot
Resource   ../config/config_environment.robot

*** Keywords ***
Test Setup
    [Documentation]    Setup comum para todos os testes
    [Arguments]    ${browser_type}=${BROWSER_HEADLESS}    ${set_cookie}=${cookie_script}    ${setcookie_language}=document.cookie = "contratoazul_language=pt"
    
    # Configurações iniciais
    Set Log Level    ${LOG_LEVEL}
    
    Set Log Level    DEBUG
    ${url}=    Set Variable If
    ...    '${ENVIRONMENT}'=='ghost'       ${URL_GHOST}
    ...    '${ENVIRONMENT}'=='homol'       ${URL_HOMOL}
    ...    '${ENVIRONMENT}'=='staging'     ${URL_STAGING}
    ...    '${ENVIRONMENT}'=='hotfix'      ${URL_HOTFIX}
    ...    '${ENVIRONMENT}'=='prod'        ${URL_PROD}
    ...     ${URL_PROD}
    Set Suite Variable    ${URL}    ${url}

    ${timeout}=    Set Variable If
    ...    '${ENVIRONMENT}'=='dev'         ${TIMEOUT_DEV}
    ...    '${ENVIRONMENT}'=='homol'       ${TIMEOUT_STAGING}
    ...    '${ENVIRONMENT}'=='staging'     ${TIMEOUT_STAGING}
    ...    '${ENVIRONMENT}'=='prod'        ${TIMEOUT_PROD}
    ...    ${TIMEOUT_STAGING}
    Set Suite Variable    ${TIMEOUT}    ${timeout}
    Set Log Level    ${LOG_LEVEL}

    # Login no sistema
    Login D4Sign    ${browser_type}    ${set_cookie}    ${setcookie_language}

Test Teardown
    [Documentation]    Teardown comum para todos os testes
    [Arguments]    ${take_screenshot}=${SCREENSHOT_ON_FAIL}
    
    # Captura screenshot em caso de falha
    Run Keyword If    ${take_screenshot}    Capture Page Screenshot

Suite Setup
    [Documentation]    Setup da suíte de testes
    Log    Iniciando execução da suíte de testes    DEBUG

Suite Teardown
    [Documentation]    Teardown da suíte de testes
    Log    Finalizando execução da suíte de testes    DEBUG
    Close Browser

Login D4Sign
    [Documentation]    Realiza login no sistema D4Sign
    [Arguments]    ${BROWSER_HEADLESS}    ${set_cookie}    ${setcookie_language}
    
    Open Browser                    ${URL}    ${BROWSER_HEADLESS}
    Set Window Size                 1920    1080
    Execute Javascript              ${set_cookie}
    Execute Javascript              ${setcookie_language}
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Click Element                   ${idioma}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S}