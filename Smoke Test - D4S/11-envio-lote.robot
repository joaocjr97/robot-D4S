*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Process
Resource   variables.robot
Resource   config_sensitive.robot

*** Test Cases ***
Login
    Open Browser                    ${URL}       chrome
    Maximize Browser Window
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S} 

Envio em Lote
    Click Element                           ${lote}
    Wait Until Element Is Visible           ${btnlote}
    Click Element                           ${btnlote}
    Wait Until Element Is Visible           ${campoCofre}
    Click Element                           ${campoCofre}
    Click Element                           ${cofreEnvioLote}
    Wait Until Element Is Visible           ${nomeEnvio}
    Input Text                              ${nomeEnvio}         Envio em Lote - Robot
    Click Element                           ${tipoDoc}
    Click Element                           ${tempHTML}
    Click Element                           ${btnSalvarPf}
    Sleep                                   ${TIMEOUT}
    Click Element                           ${btnOpcao}
    Wait Until Element Is Visible           ${selecionarDoc}
    Click Element                           ${selecionarDoc}
    Sleep                                   ${TIMEOUT}
    ${ABSOLUTE_PATH}=    Normalize Path     ${RELATIVE_PATH_LOTE}
    Choose File                             ${fileupload}        ${ABSOLUTE_PATH}
    Sleep                                   ${TIMEOUT}
    Press Keys                              ${sucesso}           ESC
    Reload Page
    Click Element                           ${btnOpcao}
    Wait Until Element Is Visible           ${processamento}
    Click Element                           ${processamento}
    Sleep                                   ${TIMEOUT}
    Wait Until Element Is Visible           ${campoSenha}
    Input Text                              ${campoSenha}        ${PASSWORD}
    Click Element                           ${btnFim}
    Wait Until Page Contains Element        ${tagProcessando}
    Sleep                                                        120s
    Reload Page
    Wait Until Page Contains Element        ${tagProcessado}     10s