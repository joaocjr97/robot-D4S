*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot

*** Test Cases ***
Login
    Open Browser    ${URL}    ${BROWSER_HEADLESS}
    Set Window Size    1920    1080
    Wait Until Element Is Visible   ${Email}      ${TIMEOUT}
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    ${TIMEOUT}
    Page Should Contain Image       ${logoD4S}  

Preenchimento de Template HTML
    # Enviar o template pelo cofre, preenchendo o arquivo e verificando a viewblob.
    Click Element                        ${cofre12}
    Wait Until Element Is Visible        ${novoArquivo}       ${TIMEOUT}
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
    Wait Until Page Contains Element     ${verificaEnvio}     ${TIMEOUT}

Envio do Documento
    # Assinar o documento enviado pelo template HTML.
    Click Element                         ${incluirEmail}
    Wait Until Element Is Visible         ${botaoAssinatura}     ${TIMEOUT}
    Sleep                                                        10s
    Click Element                         ${botaoAssinatura}
    Wait Until Element Is Visible         ${botaoEnvio2}         ${TIMEOUT}
    Click Element                         ${botaoEnvio2}
    Wait Until Page Contains Element      ${faseEnviado}         ${TIMEOUT}

Assinatura do Template
    Click Element                         ${assinar}
    Wait Until Element Is Visible         ${senhaConta}          ${TIMEOUT}
    Input Text                            ${senhaConta}          ${PASSWORD}
    Click Element                         ${salvarAssinatura}
    Wait Until Element Is Visible         ${verificaAssinatura}  ${TIMEOUT}
    Page Should Contain Element           ${verificaAssinatura}
    Close Browser