*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Process

*** Variables ***
${URL}               https://secure.d4sign.com.br/
${USERNAME}          automacao@d4sign.com.br
${setcookie}         document.cookie = "contratoazul_language=pt"
${PASSWORD}          d4sign123
${logar}             id=logar
${Email}             id=Email
${Passwd}            id=Passwd
${logoD4S}           //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img
${RELATIVE_PATH}     ${CURDIR}/../files/planilha.xlsx
${fileupload}        //*[@id="fileupload"]
${lote}              //*[@id="page-wrapper"]/div[2]/div[1]/div[5]/a
${btnlote}           //*[@id="btnSaveTemplate"]
${campoCofre}        //*[@id="uuid-cofre"]
${cofre}             //*[@id="uuid-cofre"]/option[2]
${nomeEnvio}         //*[@id="div_up"]/input
${tipoDoc}           //*[@id="div_up"]/select[4]
${tempHTML}          //*[@id="div_up"]/select[4]/option[2]
${btnSalvar}         //*[@id="btnSavePf"] 
${btnOpcao}          //*[@id="label-opcao-cofre"]
${selecionarDoc}     //*[@id="contratos"]/tbody/tr[1]/td[6]/div/ul/li[4]/a
${sucesso}           //*[@id="sucesso"]/h4
${processamento}     //*[@id="contratos"]/tbody/tr[1]/td[6]/div/ul/li[8]/a
${campoSenha}        //*[@id="senhaConta"]
${btnFim}            //*[@id="btnSalvarDocumento"]
${tagProcessando}    //small[contains(text(), 'ENVIADO PARA PROCESSAMENTO')]



*** Test Cases ***
Login
    Open Browser                    ${URL}       chrome
    Maximize Browser Window
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}     10s
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   10s
    Page Should Contain Image       ${logoD4S} 

Envio em Lote 
    Click Element                     ${lote}
    Wait Until Element Is Visible     ${btnlote} 
    Click Element                     ${btnlote} 
    Wait Until Element Is Visible     ${campoCofre}
    Click Element                     ${campoCofre}
    Click Element                     ${cofre}
    Wait Until Element Is Visible     ${nomeEnvio}
    Input Text                        ${nomeEnvio}         Envio em Lote - Robot
    Click Element                     ${tipoDoc}
    Click Element                     ${tempHTML}
    Click Element                     ${btnSalvar}
    Sleep                                                  2s
    Click Element                     ${btnOpcao}
    Wait Until Element Is Visible     ${selecionarDoc}
    Click Element                     ${selecionarDoc}
    Sleep                                                  2s
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Sleep                                                  3s
    Press Keys                        ${sucesso}           ESC
    Reload Page
    Click Element                     ${btnOpcao}
    Wait Until Element Is Visible     ${processamento}
    Click Element                     ${processamento}
    Sleep                                                  2s
    Wait Until Element Is Visible     ${campoSenha}
    Input Text                        ${campoSenha}          ${PASSWORD}
    Click Element                     ${btnFim}  
    Wait Until Page Contains Element  ${tagProcessando}
    Sleep                                                  60s
    Reload Page
    Wait Until Page Does Not Contain Element  ${tagProcessando}    60s
