*** Settings ***
Library    SeleniumLibrary
Resource   ../../../resources/common/variables.robot
Resource   ../../../resources/config/config_sensitive.robot
Resource   ../../../resources/config/config_environment.robot
Resource   ../../../resources/ui/ui_keywords.robot
Resource   ../../../resources/common/tag_logging.robot
Suite Setup       Test Setup
Suite Teardown    Suite Teardown

Documentation     Dado que o usuário acessa a plataforma e faz login com sucesso
...               E acessa um cofre
...               Quando o usuário seleciona um template HTML
...               E preenche os campos do documento
...               E prepara o envio acrescentando um signatário
...               E envia o documento para assinatura
...               E o signatário realiza a assinatura
...               Então o sistema deve verificar que o documento foi assinado com sucesso



*** Test Cases ***
Preenchimento de Template HTML
    # Enviar o template pelo cofre, preenchendo o arquivo e verificando a viewblob.
    [Tags]    ui    template    regression
    Log Template Test Info    Iniciando teste de template HTML
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