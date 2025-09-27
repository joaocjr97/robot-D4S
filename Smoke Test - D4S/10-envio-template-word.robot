
# Este teste não está funcionando, pois existe um tempo muito grande para processar o envio do template word.

*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot

*** Test Cases ***
Login
    Open Browser    ${URL}    ${BROWSER_HEADLESS}
    Set Window Size    1920    1080
    Execute Javascript              ${setcookie2}
    Wait Until Element Is Visible   ${Email}      ${TIMEOUT}
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    ${TIMEOUT}
    Page Should Contain Image       ${logoD4S}  

Preenchimento de Template HTML
    # Enviar o template pelo cofre, preenchendo o arquivo e verificando a viewblob.
    Click Element                        ${cofre12}
    # Ao acessar o cofre, o modal de IA aparece e aqui, garantimos que ele seja fechado.
    Wait Until Page Contains Element            ${IAmodal}           ${TIMEOUT}
    Click Element                               ${IAmodal}
    Wait Until Page Does Not Contain Element    ${IAmodal}           ${TIMEOUT}
    Wait Until Element Is Visible               ${novoArquivo}       ${TIMEOUT}
    Click Element                               ${novoArquivo}
    Click Element                               ${templateWORD}
    Input Text                                  ${campoCodigo}        000001
    Input Text                                  ${campoData}          17/09/2025
    Input Text                                  ${campoNomeFantasia}  Marisa Modas
    Input Text                                  ${campoCidade}        Sáo Paulo
    Input Text                                  ${campoEndereco}      Av. Brasil
    Input Text                                  ${campoBairro}        Paris
    Input Text                                  ${campoCep}           08531147
    Click Element                               ${salvarTemplate}
    Wait Until Page Contains Element            ${verificaEnvio}      240s

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