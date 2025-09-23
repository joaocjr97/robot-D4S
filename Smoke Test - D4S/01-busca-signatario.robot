*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot

*** Test Cases ***
Login
    Open Browser      ${URL}   headlesschrome    arguments=--window-size=1920,1080
    Set Window Size   1920    1080
    Execute Javascript              ${setcookie}    
# Define o cookie para evitar o popup de escolha de idioma
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S} 


Busca de e-mail de signatário
    Click Element                     ${buscaSignatario}
    Wait Until Element Is Visible     ${campoBuscaSignatario}        ${TIMEOUT}
    Input Text                        ${campoBuscaSignatario}        ${EMAIL_TESTE}
    Press Keys                        ${campoBuscaSignatario}        ENTER
    Wait Until Element Is Visible     ${resultadoBusca}              ${TIMEOUT}
    Click Element                     ${linkDocumento}
    Switch Window                                                    NEW
    Wait Until Element Is Visible     ${novaViewblob}                ${TIMEOUT}
    Click Element                     ${btnViewblob}
    Wait Until Element Is Visible     ${signatario}                  ${TIMEOUT}