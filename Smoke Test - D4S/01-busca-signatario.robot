*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot

*** Test Cases ***
Login
    Open Browser    ${URL}    ${BROWSER_HEADLESS}
    Set Window Size    1920    1080
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S} 


Busca de e-mail de signatário
    Wait Until Element Is Visible                 ${buscaSignatario}             ${TIMEOUT}
    Click Element                                 ${buscaSignatario}
    Wait Until Element Is Visible                 ${campoBuscaSignatario}        ${TIMEOUT}
    Input Text                                    ${campoBuscaSignatario}        ${EMAIL_TESTE}
    Press Keys                                    ${campoBuscaSignatario}        ENTER
    Wait Until Element Is Visible                 ${resultadoBusca}              ${TIMEOUT}
    Wait Until Page Contains Element              ${linkDocumento}
    Close Browser