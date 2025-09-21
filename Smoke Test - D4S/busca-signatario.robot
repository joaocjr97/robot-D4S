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
${buscaSignatario}   //*[@id="page-wrapper"]/div[2]/div[2]/div[1]/div/div/div/small/a[2]
${campoBusca}        //*[@id="q"]
${resultadoBusca}    //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div[1]/div[2]/div/span/b
${linkDocumento}     //*[@id="contratos"]/tbody/tr[7]/td[3]/a
${novaViewblob}      //*[@id="viewblobdiv"]/div[2]/div[1]
${btnViewblob}       //*[@id="btn-viewblob-completa"]
${signatario}        //*[@id="lista-assinatura"]/table/tbody/tr/td[2]/div/b


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
    Click Element                     ${buscaSignatario}
    Wait Until Element Is Visible     ${campoBusca}        10s
    Input Text                        ${campoBusca}        joao.carlos@d4sign.com.br
    Press Keys                        ${campoBusca}        ENTER
    Wait Until Element Is Visible     ${resultadoBusca}    10s
    Click Element                     ${linkDocumento}
    Switch Window                                          NEW
    Wait Until Element Is Visible     ${novaViewblob}      10s
    Click Element                     ${btnViewblob}
    Wait Until Element Is Visible     ${signatario}        10s