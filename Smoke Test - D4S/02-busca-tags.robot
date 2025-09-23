*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot

*** Test Cases ***
Login
    Open Browser                    ${URL}       ${BROWSER_HEADLESS}    
    Maximize Browser Window
    Execute Javascript              ${setcookie}    
# Define o cookie para evitar o popup de escolha de idioma
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S} 


Busca de Tag Urgente
    Click Element                     ${buscaTags}
    Wait Until Element Is Visible     H:\robot-D4S\files\doc-testes.pdf       ${TIMEOUT}
    Input Text                        H:\robot-D4S\files\doc-testes.pdf       urgente
    Press Keys                        H:\robot-D4S\files\doc-testes.pdf       ENTER
    Sleep                             2s
    Click Element                     ${btnBusca}
    Wait Until Element Is Visible     ${resultadoBusca}    ${TIMEOUT}
    Click Element                     ${linkDocumento}
    Switch Window                                          NEW
    Wait Until Element Is Visible     ${viewblob}          ${TIMEOUT}
    Click Element                     ${tagViewblob}
    Wait Until Element Is Visible     ${urgenteTag}        ${TIMEOUT}