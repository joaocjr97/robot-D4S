*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Resource   ../../../resources/common/variables.robot
Resource   ../../../resources/config/config_sensitive.robot
Resource   ../../../resources/config/config_environment.robot
Resource   ../../../resources/ui/ui_keywords.robot
Resource   ../../../resources/common/tag_logging.robot
Suite Setup       Test Setup
Suite Teardown    Suite Teardown

Documentation     Dado que o usuário acessa a plataforma e faz login com sucesso
...               Quando o usuário clica no botão de "Criar Cofre"
...               E preenche o nome do cofre com um nome empresarial aleatório
...               Então o novo cofre deve ser criado e validado com sucesso na plataforma

*** Test Cases ***
Criar Cofre
    [Tags]    ui    smoke    critical
    Log UI Test Info    Iniciando teste de criação de cofre
    Wait Until Element Is Visible            ${CreateNewVault}  ${TIMEOUT}
    Click Element                            ${CreateNewVault}
    Wait Until Element Is Visible            ${nomecofre}       ${TIMEOUT}

    #Gerar nome aleatório para o cofre
    ${palavragerada}=    FakerLibrary.Company

    Input Text                              ${nomecofre}        ${palavragerada} 
    Click Button                            ${btnSalvarCofre}