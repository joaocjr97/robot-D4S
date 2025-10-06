*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource   ../../../resources/common/variables.robot
Resource   ../../../resources/config/config_sensitive.robot
Resource   ../../../resources/config/config_environment.robot
Resource   ../../../resources/ui/ui_keywords.robot
Resource   ../../../resources/common/tag_logging.robot
Suite Setup       Test Setup
Suite Teardown    Suite Teardown

Documentation     Dado que o usuário acessa a plataforma e faz login com sucesso
...               E escolhe um cofre pela desk
...               E seleciona um documento para upload
...               Quando na tela de visualização (viewblob) o usuário busca por um grupo
...               E acrescenta o grupo de signatários
...               E envia o documento para assinatura
...               Então o sistema deve assegurar o envio com a mudança de fase do documento

*** Test Cases ***
Upload de Documento
    [Tags]    ui    signature    regression
    Log Signature Test Info    Iniciando teste de envio para grupo de assinatura
    # Enviar documento pela desk, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${botaoEnvio}
    Wait Until Element Is Visible        ${selectCofre}           ${TIMEOUT}
    Click Element                        ${selectCofre} 
    Click Element                        ${selecionarCofre} 
    Sleep                                                         2s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Element Is Visible         ${Aguardandoenvio}       ${TIMEOUT}
    Page Should Contain Element           ${Aguardandoenvio}

Envio para Grupo de Assinatura
    Click Element                         ${grupo}
    Wait Until Element Is Visible         ${filtroGrupo}          ${TIMEOUT}
    # Pesquisa pelo Grupo de Assinatura e prepara envio. 
    Input Text                            ${filtroGrupo}          Grupo
    Wait Until Element Is Visible         ${selecionarGrupo}
    Click Element                         ${selecionarGrupo}
    Reload Page
    Wait Until Element Is Enabled         ${botaoAssinatura}      ${TIMEOUT}
    Click Element                         ${botaoAssinatura}
    Wait Until Element Is Visible         ${botaoEnvio2}          ${TIMEOUT}
    Click Element                         ${botaoEnvio2}
    Wait Until Page Contains Element      ${faseEnviado}          ${TIMEOUT}