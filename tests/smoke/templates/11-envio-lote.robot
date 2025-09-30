*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Process
Resource   ../../../resources/common/variables.robot
Resource   ../../../resources/config/config_sensitive.robot
Resource   ../../../resources/config/config_environment.robot
Resource   ../../../resources/ui/ui_keywords.robot
Resource   ../../../resources/common/tag_logging.robot
Suite Setup       Test Setup
Suite Teardown    Suite Teardown

Documentation     Dado que o usuário acessa a plataforma e faz login com sucesso
...               E acessa a guia de envio em lote
...               Quando o usuário prepara um novo envio em lote
...               E define o template e o cofre de destino
...               E faz o upload de uma planilha preenchida
...               E envia o lote para processamento
...               Então o usuário deve aguardar até que a fase do lote mude para "processado"

*** Test Cases ***
Envio em Lote
    [Tags]    ui    batch    regression
    Log Batch Test Info    Iniciando teste de envio em lote
    Click Element                           ${lote}
    Wait Until Element Is Visible           ${btnlote}
    Click Element                           ${btnlote}
    Wait Until Element Is Visible           ${campoCofre}
    Click Element                           ${campoCofre}
    Click Element                           ${cofreEnvioLote}
    Wait Until Element Is Visible           ${nomeEnvio}
    Input Text                              ${nomeEnvio}         Envio em Lote - Robot
    Click Element                           ${tipoDoc}
    Click Element                           ${tempHTML}
    Click Element                           ${btnSalvarPf}
    Sleep                                   2s
    Click Element                           ${btnOpcao}
    Wait Until Element Is Visible           ${selecionarDoc}
    Click Element                           ${selecionarDoc}
    Sleep                                   2s
    ${ABSOLUTE_PATH}=    Normalize Path     ${RELATIVE_PATH_LOTE}
    Choose File                             ${fileupload}        ${ABSOLUTE_PATH}
    Sleep                                   5s
    Press Keys                              ${sucesso}           ESC
    Reload Page
    Click Element                           ${btnOpcao}
    Wait Until Element Is Visible           ${processamento}
    Click Element                           ${processamento}
    Sleep                                   2s
    Wait Until Element Is Visible           ${campoSenha}
    Input Text                              ${campoSenha}        ${PASSWORD}
    Click Element                           ${btnFim}
    Wait Until Page Contains Element        ${tagProcessando}
    Sleep                                                        120s
    Reload Page
    Wait Until Page Contains Element        ${tagProcessado}     ${TIMEOUT}