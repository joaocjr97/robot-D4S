*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot

*** Test Cases ***
Login
    Open Browser                    ${URL}        ${BROWSER}
    Execute Javascript              ${setcookie} 
    Wait Until Element Is Visible   ${Email}      10s
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    10s
    Page Should Contain Image       ${logoD4S}  

Preenchimento de Template HTML
    # Enviar o template pelo cofre, preenchendo o arquivo e verificando a viewblob.
    Click Element                        ${cofre12}
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