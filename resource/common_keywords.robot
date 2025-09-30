*** Settings ***
Library    SeleniumLibrary
Resource   variables.robot
Resource   config_sensitive.robot

*** Keywords ***
Login D4Sign
    [Documentation]    Realiza login no sistema D4Sign
    [Arguments]    ${browser_type}=${BROWSER_HEADLESS}    ${set_cookie}=${EMPTY}
    
    Open Browser    ${URL}    ${browser_type}
    Set Window Size    1920    1080
    
    # Executa JavaScript se necessário (para cookies específicos)
    Run Keyword If    '${set_cookie}' != '${EMPTY}'    Execute Javascript    ${set_cookie}
    
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S}

Login D4Sign With Cookie
    [Documentation]    Realiza login com cookie específico (para testes que precisam)
    [Arguments]    ${cookie_script}
    Login D4Sign    ${BROWSER_HEADLESS}    ${cookie_script}

Close Browser And Cleanup
    [Documentation]    Fecha o browser e limpa recursos
    Close Browser
