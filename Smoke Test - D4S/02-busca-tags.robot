*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}               https://secure.d4sign.com.br/
${USERNAME}          automacao@d4sign.com.br
${PASSWORD}          d4sign123
${nomecofre}         id=nomeCofre  
${setcookie}         document.cookie = "contratoazul_language=pt"
${logar}             id=logar
${Email}             id=Email
${Passwd}            id=Passwd
${logoD4S}           //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img
${buscaTags}         //*[@id="page-wrapper"]/div[2]/div[2]/div[1]/div/div/div/small/a[1]
${campoBusca}        //*[@id="form-cofre"]/div/ul/li/input
${resultadoBusca}    //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div[1]/div[2]/div/span/b
${linkDocumento}     //*[@id="contratos"]/tbody/tr[2]/td[3]/a
${btnBusca}          //*[@id="btnS"]
${viewblob}          //*[@id="btnNovoDoc"]
${tagViewblob}       //*[@id="btnshowdiv-tags-bbe2f42c-76c6-457e-b984-a5ba4f97b7dc"]/a
${urgenteTag}        //*[@id="div-tags-bbe2f42c-76c6-457e-b984-a5ba4f97b7dc"]/div/ul/li[1]/span

*** Test Cases ***
Login
    Open Browser                    ${URL}       chrome
    Execute Javascript              ${setcookie}    
# Define o cookie para evitar o popup de escolha de idioma
    Wait Until Element Is Visible   ${Email}     10s
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   10s
    Page Should Contain Image       ${logoD4S} 


Busca de e-mail de signatário
    Click Element                     ${buscaTags}
    Wait Until Element Is Visible     ${campoBusca}        10s
    Input Text                        ${campoBusca}        urgente
    Press Keys                        ${campoBusca}        ENTER
    Sleep                             2s
    Click Element                     ${btnBusca}
    Wait Until Element Is Visible     ${resultadoBusca}    10s
    Click Element                     ${linkDocumento}
    Switch Window                                          NEW
    Wait Until Element Is Visible     ${viewblob}          10s
    Click Element                     ${tagViewblob}
    Wait Until Element Is Visible     ${urgenteTag}        10s