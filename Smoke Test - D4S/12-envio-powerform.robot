*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot
Library    FakerLibrary
Library    Screenshot

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

Preparação do PowerForm
    Click Element                          ${CLM}
    Click Element                          ${PowerForm}
    Wait Until Element Is Visible          ${criarPowerForm}            ${TIMEOUT}
    Click Element                          ${criarPowerForm}
    Wait Until Page Contains Element       ${modalPowerForm}            ${TIMEOUT}
    Click Element                          ${campoCofrePF}
    Click Element                          ${selecionarCofrePF}
    Sleep                                                               5s
    # O tempo de carregamento após selecionar o cofre é maior, por isso o sleep.
    Click Element                  ${campoTemplate}     
    Click Element                  ${selecionarTemplate}
    Input Text                     ${nomeDocumento}     PowerForm - Automação
    Click Element                  ${botaoContinuar}
    Wait Until Element Is Visible  ${btntoken}          ${TIMEOUT}
    Click Element                  ${btntoken}
    Sleep                                               2s
    Input Text                     ${campoEmail}        ${USERNAME}
    Set Focus To Element           ${campoEmail}
    Press Keys                     ${campoEmail}        TAB
    Click Element                  ${btnEmail}
    Click Element                  ${btnSalvarPf}
    Sleep                                               5s
    Click Element                  ${btnsend}
    Wait Until Element Is Visible  ${btnSalvarPower}    ${TIMEOUT}
    Click Element                  ${btnSalvarPower}
    Wait Until Page Does Not Contain Element  ${btnSalvarPower}   ${TIMEOUT}
    Close Browser