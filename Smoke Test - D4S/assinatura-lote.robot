*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                   https://secure.d4sign.com.br/
${USERNAME}              automacao@d4sign.com.br
${PASSWORD}              d4sign123
${nomecofre}             id=nomeCofre  
${btnSalvarCofre}        id=btnSalvarCofre
${logar}                 id=logar
${Email}                 id=Email
${Passwd}                id=Passwd
${CreateNewVault}        xpath=//a[contains(., 'Create a new vault')]
${logoD4S}               //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img
${botaoLote}             //*[@id="div-menu-desk"]/ul[1]/li[2]/a
${paginaLote}            //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div/div[3]
${botaoPagina5}          //*[@id="editable_paginate"]/ul/li[6]/a
${checkbox}              //*[@id="select_all"]
${botaoAssinarLote}      (//*[@id="divBtnMove"]/a)[3]
${senhaConta}            //*[@id="senhaConta"]
${assinar}               //*[@id="btnSalvarAssinatura"]
${modal}                 //*[@id="form-assinaturaend"]


*** Test Cases ***
Login
    Open Browser                    ${URL}       chrome
    Wait Until Element Is Visible   ${Email}     10s
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   10s
    Page Should Contain Image       ${logoD4S} 

Assinar em Lote
    Click Element                               ${botaoLote}
    Wait Until Element Is Visible               ${paginaLote}   10s
    Reload Page                                 # Reload para driblar modal de IA
    Click Element                               ${botaoPagina5}
    Click Element                               ${checkbox}
    Click Element                               ${botaoAssinarLote}
    Wait Until Element Is Visible               ${senhaConta}  10s
    Input Text                                  ${senhaConta}  ${PASSWORD}
    Click Element                               ${assinar}
    Wait Until Page Does Not Contain Element    ${modal}       240s        # Tempo grande para esperar assinar em lote
    Page Should Not Contain Element             ${modal}