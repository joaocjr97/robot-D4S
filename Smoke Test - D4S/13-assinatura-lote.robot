*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot

*** Test Cases ***
Login
    Open Browser    ${URL}    ${BROWSER_HEADLESS}
    Set Window Size    1920    1080
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S} 

Assinar em Lote
    Click Element                               ${botaoLote}
    Wait Until Element Is Visible               ${paginaLote}          ${TIMEOUT}
    Reload Page                                 # Reload para driblar modal de IA
    Click Element                               ${botaoPagina5}
    Click Element                               ${botaoPagina9}
    Click Element                               ${botaoPagina13}
    Sleep                                                              2s
    Click Element                               ${checkbox}
    Click Element                               ${botaoAssinarLote}
    Wait Until Element Is Visible               ${senhaContaLote}      ${TIMEOUT}
    Input Text                                  ${senhaContaLote}      ${PASSWORD}
    Click Element                               ${salvarAssinatura}
    # Tempo grande para esperar assinar em lote
    Wait Until Page Does Not Contain Element    ${modal}               240s
    Page Should Not Contain Element             ${modal}
    Close Browser