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
...               E abre um cofre específico
...               Quando o usuário aplica o filtro de documentos por fase
...               Então o sistema deve validar que os documentos exibidos correspondem a cada fase selecionada (laranja, azul e verde)

*** Test Cases ***
Acessar o cofre e listar fases
    [Tags]    ui    smoke
    Log UI Test Info    Iniciando teste de listagem de fases
    Click Element                               ${cofre12}
    # Ao acessar o cofre, o modal de IA aparece e aqui, garantimos que ele seja fechado.
    Wait Until Page Contains Element            ${IAmodal}         ${TIMEOUT}
    Click Element                               ${IAmodal}
    Wait Until Page Does Not Contain Element    ${IAmodal}         ${TIMEOUT}
    Wait Until Element Is Visible               ${btnFase}         ${TIMEOUT240s}
    Click Element                               ${btnFase}
    Click Element                               ${fase1}     
    Page Should Contain Element                 ${signatarios}     ${TIMEOUT240s}
    Click Element                               ${btnFase}
    Click Element                               ${fase2}
    Page Should Contain Element                 ${assinaturas}     ${TIMEOUT240s}
    Click Element                               ${btnFase}
    Click Element                               ${fase3}
    Page Should Contain Element                 ${finalizado}      ${TIMEOUT240s}
    # Voltar para a tela inicial.
    Click Element                               ${btnInicio}