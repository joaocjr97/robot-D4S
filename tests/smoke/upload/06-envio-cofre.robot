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
...               E abre um cofre
...               Quando o usuário faz o upload de um documento dentro deste cofre
...               Então o documento deve ser exibido na tela de visualização (viewblob)

*** Test Cases ***
Envio
    [Tags]    ui    signature    critical
    Log Signature Test Info    Iniciando teste de envio para cofre
    # Enviar documento pela cofre, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${cofre12}
    # Ao acessar o cofre, o modal de IA aparece e aqui, garantimos que ele seja fechado.
    Wait Until Page Contains Element            ${IAmodal}         ${TIMEOUT}
    Click Element                               ${IAmodal}
    Wait Until Page Does Not Contain Element    ${IAmodal}         ${TIMEOUT}
    Wait Until Element Is Visible        ${novoArquivo}            ${TIMEOUT}
    Click Element                        ${novoArquivo}
    Click Element                        ${newfile}
    Sleep                                                          2s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Element Is Visible         ${Aguardandoenvio}  ${TIMEOUT}
    Page Should Contain Element           ${Aguardandoenvio}