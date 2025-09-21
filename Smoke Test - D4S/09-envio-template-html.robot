*** Settings ***
Library    SeleniumLibrary
Resource   variables.robot
Resource   config_sensitive.robot

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
    Click Element                        ${cofre12}
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

