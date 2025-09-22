*** Settings ***
Library    SeleniumLibrary
Resource   variables.robot
Resource   config_sensitive.robot

*** Test Cases ***
Login
    Open Browser                    ${URL}       ${BROWSER}
    Execute Javascript              ${setcookie} 
    Wait Until Element Is Visible   ${Email}     10s
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   10s
    Page Should Contain Image       ${logoD4S} 

Assinar em Lote
    Click Element                               ${botaoLote}
    Wait Until Element Is Visible               ${paginaLote}          10s
    Reload Page                                 # Reload para driblar modal de IA
    Click Element                               ${botaoPagina5}
    Click Element                               ${botaoPagina9}
    Click Element                               ${botaoPagina13}
    Sleep                                       2s
    Click Element                               ${checkbox}
    Click Element                               ${botaoAssinarLote}
    Wait Until Element Is Visible               ${senhaContaLote}      10s
    Input Text                                  ${senhaContaLote}      ${PASSWORD}
    Click Element                               ${salvarAssinatura}
    # Tempo grande para esperar assinar em lote
    Wait Until Page Does Not Contain Element    ${modal}               240s
    Page Should Not Contain Element             ${modal}