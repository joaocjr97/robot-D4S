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
...               Quando o usuário clica no botão de busca de tags
...               E insere uma tag existente no campo de busca
...               Então o sistema deve exibir os documentos que possuem a tag informada

*** Test Cases ***
Busca de Tag Urgente
    [Tags]    ui    smoke
    Log UI Test Info    Iniciando teste de busca por tags
    Click Element                     ${buscaTags}
    Wait Until Element Is Visible     ${campoBusca}        ${TIMEOUT}
    Input Text                        ${campoBusca}        urgente
    Press Keys                        ${campoBusca}        ENTER
    Sleep                                                  2s
    Click Element                     ${btnBusca}
    Wait Until Element Is Visible     ${resultadoBusca}    ${TIMEOUT}
    Click Element                     ${linkDocumento}
    Switch Window                                          NEW
    Wait Until Element Is Visible     ${viewblob}          ${TIMEOUT}
    Click Element                     ${tagViewblob}
    Wait Until Element Is Visible     ${urgenteTag}        ${TIMEOUT}