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
...               Quando o usuário escolhe um cofre pela desk
...               E seleciona um documento para upload
...               E acrescenta os signatários necessários
...               E envia o documento para assinatura
...               E o signatário assina o documento
...               Então a assinatura no documento deve ser verificada com sucesso

*** Test Cases ***
Envio
    [Tags]    ui    signature    critical
    Log Signature Test Info    Iniciando teste de envio para assinatura
    # Enviar documento pela desk, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${botaoEnvio}
    Wait Until Element Is Visible        ${selectCofre}      ${TIMEOUT}
    Click Element                        ${selectCofre} 
    Click Element                        ${selecionarCofre}
    Sleep                                                    2s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Element Is Visible         ${Aguardandoenvio}  ${TIMEOUT}
    Page Should Contain Element           ${Aguardandoenvio}

Assinatura
    # Assinar o documento enviado pela desk.
    Click Element                         ${incluirEmail}
    Wait Until Element Is Enabled         ${botaoAssinatura}      ${TIMEOUT}
    Click Element                         ${botaoAssinatura}
    Wait Until Element Is Visible         ${botaoEnvio2}          ${TIMEOUT}
    Click Element                         ${botaoEnvio2}
    Wait Until Page Contains Element      ${faseEnviado}          ${TIMEOUT}
    Click Element                         ${assinar} 
    Wait Until Element Is Visible         ${senhaConta}           ${TIMEOUT}
    Input Password                        ${senhaConta}           ${PASSWORD}
    Click Element                         ${salvarAssinatura} 
    Wait Until Page Contains Element      ${verificaAssinatura}   ${TIMEOUT}