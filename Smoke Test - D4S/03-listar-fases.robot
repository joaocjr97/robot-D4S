*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}               https://secure.d4sign.com.br/
${USERNAME}          automacao@d4sign.com.br
${setcookie}         document.cookie = "contratoazul_language=pt"
${PASSWORD}          d4sign123
${logar}             id=logar
${Email}             id=Email
${Passwd}            id=Passwd
${logoD4S}           //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img
${cofre12}           //*[@id="liCofre_1414985"]/a
${btnFase}           //*[@id="divBtnMoveFase"]/button
${fase1}             //*[@id="divBtnMoveFase"]/ul/li[3]/a
${signatarios}       //span[contains(normalize-space(text()), 'AGUARDANDO SIGNATÁRIOS')]
${fase2}             //*[@id="divBtnMoveFase"]/ul/li[4]/a
${assinaturas}       //span[contains(normalize-space(text()), 'AGUARDANDO ASSINATURAS')]
${finalizado}        //span[contains(normalize-space(text()), 'FINALIZADO')]
${fase3}             //*[@id="divBtnMoveFase"]/ul/li[5]/a
${btnInicio}         //*[@id="page-wrapper"]/div[2]/div[1]/div[1]/a


*** Test Cases ***
Login
    Open Browser                    ${URL}       chrome
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}     10s
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   10s
    Page Should Contain Image       ${logoD4S} 

Acessar o cofre e listar fases
    Click Element                   ${cofre12}
    Wait Until Element Is Visible   ${btnFase}
    Click Element                   ${btnFase}     
    Click Element                   ${fase1}
    Page Should Contain Element     ${signatarios}
    Click Element                   ${btnFase}
    Click Element                   ${fase2}
    Page Should Contain Element     ${assinaturas}
    Click Element                   ${btnFase}
    Click Element                   ${fase3}
    Page Should Contain Element     ${finalizado}
    # Voltar para a tela inicial.
    Click Element                   ${btnInicio}