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
...               E acessa a guia de "Novo PowerForm"
...               Quando o usuário prepara o envio de um documento a preencher
...               E define o template, o cofre e os e-mails dos destinatários
...               E envia o documento para preenchimento
...               Então o usuário deve aguardar a confirmação do envio

*** Test Cases ***
Preparação do PowerForm
    [Tags]    ui    regression
    Log UI Test Info    Iniciando teste de PowerForm
    Click Element                          ${CLM}
    Click Element                          ${PowerForm}
    Wait Until Element Is Visible          ${criarPowerForm}            ${TIMEOUT}
    Click Element                          ${criarPowerForm}
    Wait Until Page Contains Element       ${modalPowerForm}            ${TIMEOUT}
    Click Element                          ${campoCofrePF}
    Click Element                          ${selecionarCofrePF}
    Sleep                                                               5s
    # O tempo de carregamento após selecionar o cofre é maior, por isso o sleep.
    Click Element                  ${campoTemplate}     
    Click Element                  ${selecionarTemplate}
    Input Text                     ${nomeDocumento}     PowerForm - Automação
    Click Element                  ${botaoContinuar}
    Wait Until Element Is Visible  ${btntoken}          ${TIMEOUT}
    Click Element                  ${btntoken}
    Sleep                                               2s
    Input Text                     ${campoEmail}        ${USERNAME}
    Set Focus To Element           ${campoEmail}
    Press Keys                     ${campoEmail}        TAB
    Click Element                  ${btnEmail}
    Click Element                  ${btnSalvarPf}
    Sleep                                               5s
    Click Element                  ${btnsend}
    Wait Until Element Is Visible  ${btnSalvarPower}    ${TIMEOUT}
    Click Element                  ${btnSalvarPower}
    Wait Until Page Does Not Contain Element  ${btnSalvarPower}   ${TIMEOUT}