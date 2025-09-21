*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                 https://secure.d4sign.com.br/
${USERNAME}            automacao@d4sign.com.br
${PASSWORD}            d4sign123
${setcookie}           document.cookie = "contratoazul_language=pt"
${logar}               //*[@id="logar"]
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
${grupo}               //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/div[4]/div/div[2]/div[1]/span[3]/a
${filtroGrupo}         //*[@id="filtro-grupos"]
${selecionarGrupo}     //*[@id="tabela-grupos"]/tbody/tr[29]/td[2]/a

*** Test Cases ***
Login
    Open Browser                    ${URL}        chrome
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}      10s
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    60s
    Page Should Contain Image       ${logoD4S}  

Envio
    # Enviar documento pela desk, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${botaoEnvio}
    Wait Until Element Is Visible        ${selectCofre}           20s
    Click Element                        ${selectCofre} 
    Click Element                        ${selecionarCofre} 
    Sleep                                                         2s
    Choose File                          ${fileupload}            ${uploadArquivo}
    Wait Until Element Is Visible        ${Aguardandoenvio}       20s
    Page Should Contain Element          ${Aguardandoenvio}

Assinatura
    # Assinar o documento enviado pela desk.
    Click Element                         ${grupo}
    Wait Until Element Is Visible         ${filtroGrupo}          10s
    # Pesquisa pelo Grupo de Assinatura e envia para o mesmo.
    Input Text                            ${filtroGrupo}          Grupo
    Wait Until Element Is Visible         ${selecionarGrupo}
    Click Element                         ${selecionarGrupo}
    Reload Page
    Wait Until Element Is Enabled         ${botaoAssinatura}      30s
    Click Element                         ${botaoAssinatura}
    Wait Until Element Is Visible         ${botaoEnvio2}          20s
    Click Element                         ${botaoEnvio2}
    Wait Until Page Contains Element      ${faseEnviado}          50s