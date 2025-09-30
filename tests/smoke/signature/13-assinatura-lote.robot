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
...               E acessa a seção "Documentos para Assinar"
...               Quando o usuário avança algumas páginas na lista de documentos
...               E seleciona todos os documentos visíveis
...               E realiza a assinatura em lote
...               Então a assinatura em todos os documentos selecionados deve ser validada com sucesso

*** Test Cases ***
Assinar em Lote
    [Tags]    ui    batch    signature    regression
    Log Batch Test Info    Iniciando teste de assinatura em lote
    Click Element                               ${botaoLote}
    Wait Until Element Is Visible               ${paginaLote}          ${TIMEOUT}
    Reload Page                                 # Reload para driblar modal de IA
    Click Element                               ${botaoPagina5}
    Click Element                               ${botaoPagina9}
    Click Element                               ${botaoPagina13}
    Sleep                                                              2s
    Click Element                               ${checkbox}
    Click Element                               ${botaoAssinarLote}
    Wait Until Element Is Visible               ${senhaContaLote}      ${TIMEOUT}
    Input Text                                  ${senhaContaLote}      ${PASSWORD}
    Click Element                               ${salvarAssinatura}
    # Tempo grande para esperar assinar em lote
    Wait Until Page Does Not Contain Element    ${modal}               240s
    Page Should Not Contain Element             ${modal}