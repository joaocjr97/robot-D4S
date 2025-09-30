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
...               Quando o usuário procura por um cofre
...               E realiza o upload de um documento diretamente pela desk para esse cofre
...               Então o documento deve ser exibido na tela de visualização (viewblob)

*** Test Cases ***
Envio
    [Tags]    ui    signature    critical
    Log Signature Test Info    Iniciando teste de envio via desk
    # Enviar documento pela desk, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${botaoEnvio}
    Wait Until Element Is Visible        ${selectCofre}      ${TIMEOUT}
    Click Element                        ${selectCofre} 
    Click Element                        ${selecionarCofre} 
    Sleep                                                    2s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Element Is Visible         ${Aguardandoenvio}  120s
    Page Should Contain Element           ${Aguardandoenvio}