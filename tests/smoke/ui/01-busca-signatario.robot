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
...               Quando o usuário clica no botão de busca de signatários
...               E insere um e-mail válido no campo de busca
...               Então o sistema deve exibir os documentos associados àquele e-mail

*** Test Cases ***
Busca de e-mail de signatário
    [Tags]    ui    login    smoke    critical
    Log Login Test Info    Iniciando teste de login
    Wait Until Element Is Visible                 ${buscaSignatario}             ${TIMEOUT}
    Click Element                                 ${buscaSignatario}
    Wait Until Element Is Visible                 ${campoBuscaSignatario}        ${TIMEOUT}
    Input Text                                    ${campoBuscaSignatario}        ${EMAIL_TESTE}
    Press Keys                                    ${campoBuscaSignatario}        ENTER
    Wait Until Element Is Visible                 ${resultadoBusca}              ${TIMEOUT}
    Wait Until Page Contains Element              ${linkDocumento}