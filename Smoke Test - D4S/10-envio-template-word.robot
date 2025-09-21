*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                  https://secure.d4sign.com.br/
${USERNAME}             automacao@d4sign.com.br
${PASSWORD}             d4sign123
${logar}                id=logar
${Email}                id=Email
${setcookie}            document.cookie = "contratoazul_language=pt"
${Passwd}               id=Passwd
${logoD4S}              //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img
${botaoEnvio}           //*[@id="drop-zone"]/a/p[2]
${uploadArquivo}        H:\robot-D4S\files\doc-testes.pdf
${Aguardandoenvio}      //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/span[1]
${selectCofre}          name=uuid-cofre
${selecionarCofre}      //*[@id="formUpload"]/select/option[157]
${fileupload}           id=fileupload
${incluirEmail}         //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/div[4]/div/div[2]/div[1]/span[1]/a
${botaoAssinatura}      //*[@id="enviar-para-assinatura"]
${botaoEnvio2}          //*[@id="btnSalvarDocumento"]
${faseEnviado}          //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/span[1]
${assinar}              //*[@id="adicionar-assinatura"]
${senhaConta}           id=senhaConta
${salvarAssinatura}     //*[@id="btnSalvarAssinatura"]
${verificaAssinatura}   //*[@id="viewblobdiv"]/div[2]/div[1]
${cofre}                //*[@id="liCofre_1414985"]/a
${novoArquivo}          id=label-new-file
${templateWORD}         //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div/div[1]/div[2]/ul/li[144]/a
${campoCodigo}          //*[@id="form_clientecodigo"]
${campoData}            //*[@id="form_data"]
${campoNomeFantasia}    //*[@id="form_clientenomefantasia"]
${campoCidade}          //*[@id="form_clientecidade"]
${campoEndereco}        //*[@id="form_clienteendereco"]
${campoBairro}          //*[@id="form_clientebairro"]
${campoCep}             //*[@id="form_clientecep"]
${salvarTemplate}       //*[@id="btnSaveTemplate"]
${verificaEnvio}        //*[@id="btnNovoDoc"]

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

Preenchimento de Template HTML
    # Enviar o template pelo cofre, preenchendo o arquivo e verificando a viewblob.
    Click Element                        ${cofre}
    Wait Until Element Is Visible        ${novoArquivo}       20s
    Click Element                        ${novoArquivo}
    Click Element                        ${templateWORD}
    Input Text                           ${campoCodigo}        000001
    Input Text                           ${campoData}          17/09/2025
    Input Text                           ${campoNomeFantasia}  Marisa Modas
    Input Text                           ${campoCidade}        Sáo Paulo
    Input Text                           ${campoEndereco}      Av. Brasil
    Input Text                           ${campoBairro}        Paris
    Input Text                           ${campoCep}           08531147
    Click Element                        ${salvarTemplate}
    Wait Until Page Contains Element     ${verificaEnvio}      240s

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