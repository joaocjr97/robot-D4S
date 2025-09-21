*** Settings ***
Library    SeleniumLibrary
Resource   variables.robot
Resource   config_sensitive.robot
Library    FakerLibrary
Library    Screenshot

*** Test Cases ***
Login
    Open Browser                    ${URL}       chrome
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}     10s
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   60s
    Page Should Contain Image       ${logoD4S} 

Preparação do PowerForm
    Click Element                  ${CLM}
    Click Element                  ${PowerForm}
    Wait Until Element Is Visible  ${criarPowerForm}    20s
    Click Element                  ${criarPowerForm}
    Wait Until Page Contains Element  //*[@id="formPowerForm"]       20s
    Click Element                      //*[@id="uuid_cofre"]
    Click Element                      ${selecionarCofre}
    Sleep                                               5s
    # O tempo de carregamento após selecionar o cofre é maior, por isso o sleep.
    Click Element                  ${campoTemplate}
    Click Element                  ${campoTemplate}     
    Click Element                  ${selecionarTemplate}
    Input Text                     ${nomeDocumento}     PowerForm - Automação
    Click Element                  ${botaoContinuar}
    Wait Until Element Is Visible  ${btntoken}          20s
    Click Element                  ${btntoken}
    Sleep                                               2s
    Input Text                     ${campoEmail}        ${USERNAME}
    Set Focus To Element           ${campoEmail}
    Press Keys                     ${campoEmail}        TAB
    Click Element                  ${btnEmail}
    Click Element                  ${btnSalvarPf}
    Sleep                                               5s
    Click Element                  ${btnsend}
    Wait Until Element Is Visible  ${btnSalvarPower}    20s
    Click Element                  ${btnSalvarPower}
    Wait Until Page Does Not Contain Element  ${btnSalvarPower}   20s