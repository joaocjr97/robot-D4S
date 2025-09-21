*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    Screenshot

*** Variables ***
${URL}                   https://secure.d4sign.com.br/
${USERNAME}              automacao@d4sign.com.br
${PASSWORD}              d4sign123
${nomecofre}             id=nomeCofre  
${btnSalvarCofre}        id=btnSalvarCofre
${logar}                 //*[@id="logar"]
${setcookie}             document.cookie = "contratoazul_language=pt"
${Email}                 id=Email
${Passwd}                id=Passwd
${CreateNewVault}        xpath=//a[contains(., 'Create a new vault')]
${logoD4S}               //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img
${CLM}                   //*[@id="page-wrapper"]/div[2]/div[1]/div[3]/div/a
${PowerForm}             //*[@id="page-wrapper"]/div[2]/div[1]/div[3]/div/ul/li[5]/a
${criarPowerForm}        //*[@id="btnSaveTemplate"]
${campoCofre}            //*[@id="uuid_cofre"]
${selecionarCofre}       //*[@id="uuid_cofre"]/option[2]
${campoTemplate}         //*[@id="uuid-template"]
${selecionarTemplate}    //*[@id="meus-templates"]/option[338]
${nomeDocumento}         //*[@id="nome_documento"]
${botaoContinuar}        //*[@id="docButton"]
${btntoken}              //*[@id="tokenCount"]/button
${campoEmail}            //*[@id="email_be7b9c59-e046-4f7f-999f-19f91b57c346"]
${btnEmail}              //*[@id="fillerButton"]
${btnsalvar}             //*[@id="btnSavePf"]
${btnsend}               //*[@id="pfv2-result"]/button
${btnSalvarPower}        //*[@id="btnSalvarPower"]



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
    Wait Until Element Is Visible  ${campoCofre}        20s
    Click Element                  ${campoCofre}
    Click Element                  ${selecionarCofre}
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
    Click Element                  ${btnsalvar}
    Sleep                                               5s
    Click Element                  ${btnsend}
    Wait Until Element Is Visible  ${btnSalvarPower}    20s
    Click Element                  ${btnSalvarPower}
    Wait Until Page Does Not Contain Element  ${btnSalvarPower}   20s