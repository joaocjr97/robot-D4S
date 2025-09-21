*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${URL}                 https://secure.d4sign.com.br/
${USERNAME}            automacao@d4sign.com.br
${PASSWORD}            d4sign123
${logar}               id=logar
${setcookie}           document.cookie = "contratoazul_language=pt"
${Email}               id=Email
${Passwd}              id=Passwd
${logoD4S}             //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img
${botaoEnvio}          //*[@id="drop-zone"]/a/p[2]
${RELATIVE_PATH}       ${CURDIR}/../files/doc-testes.pdf
${Aguardandoenvio}     //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/span[1]
${selectCofre}         name=uuid-cofre
${selecionarCofre}     //*[@id="formUpload"]/select/option[157]
${fileupload}          id=fileupload
${incluirEmail}        //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/div[4]/div/div[2]/div[1]/span[1]/a
${botaoAssinatura}     //*[@id="enviar-para-assinatura"]
${botaoEnvio2}         //*[@id="btnSalvarDocumento"]
${faseEnviado}         //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/span[1]
${assinar}             //*[@id="adicionar-assinatura"]
${senhaConta}          id=senhaConta
${salvarAssinatura}    //*[@id="btnSalvarAssinatura"]
${verificaAssinatura}  //*[@id="viewblobdiv"]/div[2]/div[1]


*** Test Cases ***
Login
    Open Browser                    ${URL}        chrome
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}      10s
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    10s
    Page Should Contain Image       ${logoD4S}  

Envio
    # Enviar documento pela desk, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${botaoEnvio}
    Wait Until Element Is Visible        ${selectCofre}      20s
    Click Element                        ${selectCofre} 
    Click Element                        ${selecionarCofre}
    Sleep                                                    2s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Element Is Visible         ${Aguardandoenvio}  20s
    Page Should Contain Element           ${Aguardandoenvio}

Assinatura
    # Assinar o documento enviado pela desk.
    Click Element                         ${incluirEmail}
    Wait Until Element Is Enabled         ${botaoAssinatura}      20s
    Click Element                         ${botaoAssinatura}
    Wait Until Element Is Visible         ${botaoEnvio2}          20s
    Click Element                         ${botaoEnvio2}
    Wait Until Page Contains Element      ${faseEnviado}          10s
    Click Element                         ${assinar} 
    Wait Until Element Is Visible         ${senhaConta}           20s
    Input Password                        ${senhaConta}           ${PASSWORD}
    Click Element                         ${salvarAssinatura} 
    Wait Until Page Contains Element      ${verificaAssinatura}   20s