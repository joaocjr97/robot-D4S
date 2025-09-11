*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                 https://secure.d4sign.com.br/
${USERNAME}            automacao@d4sign.com.br
${PASSWORD}            d4sign123
${logar}               id=logar
${Email}               id=Email
${Passwd}              id=Passwd
${logoD4S}             //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img
${botaoEnvio}          //*[@id="drop-zone"]/a/p[2]
${uploadArquivo}       C:/Users/joao.carlos_d4sign/Desktop/Robot/files/doc-testes.pdf
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
${cofre}               //*[@id="liCofre_1414985"]/a
${novoArquivo}         id=label-new-file
${templateHTML}        //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div/div[1]/div[2]/ul/li[5]/a
${campoMarca}          //*[@id="keyt_marca"]
${campoLaranja}        //*[@id="keyt_laranja"]
${campoCor}            //*[@id="keyt_cor"]
${campoTrueFALSE}      //*[@id="keyt_trueFALSE"]
${campoRua}            //*[@id="keyt_rua"]
${campoLugares}        //*[@id="keyt_lugares"]
${campoRestaurant}     //*[@id="keyt_restaurant"]
${salvarTemplate}      //*[@id="btnSaveTemplate"]
${verificaEnvio}       //*[@id="email-assinatura"]

*** Test Cases ***
Login
    Open Browser                    ${URL}        chrome
    Wait Until Element Is Visible   ${Email}      10s
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    10s
    Page Should Contain Image       ${logoD4S}  

Preenchimento de Template HTML
    # Enviar o template pelo cofre, preenchendo o arquivo e verificando a viewblob.
    Click Element                        ${cofre}
    Wait Until Element Is Visible        ${novoArquivo}       20s
    Click Element                        ${novoArquivo}
    Click Element                        ${templateHTML}
    Input Text                           ${campoMarca}        Apple
    Input Text                           ${campoLaranja}      Fruta
    Input Text                           ${campoCor}          Preto
    Input Text                           ${campoTrueFALSE}    TRUE
    Input Text                           ${campoRua}          Av. Brasil
    Input Text                           ${campoLugares}      Paris
    Input Text                           ${campoRestaurant}   Taverna Medieval
    Click Element                        ${salvarTemplate}
    Wait Until Page Contains Element     ${verificaEnvio}     60s

Envio do Documento
    # Assinar o documento enviado pelo template HTML.
    Click Element                         ${incluirEmail}
    Wait Until Element Is Visible         ${botaoAssinatura}     10s
    Sleep                                                        10s
    Click Element                         ${botaoAssinatura}
    Wait Until Element Is Visible         ${botaoEnvio2}         20s
    Click Element                         ${botaoEnvio2}
    Wait Until Page Contains Element      ${faseEnviado}         50s

Assinatura do Template
    Click Element                         ${assinar}
    Wait Until Element Is Visible         ${senhaConta}          10s
    Input Text                            ${senhaConta}          ${PASSWORD}
    Click Element                         ${salvarAssinatura}
    Wait Until Element Is Visible         ${verificaAssinatura}  20s
    Page Should Contain Element           ${verificaAssinatura}    