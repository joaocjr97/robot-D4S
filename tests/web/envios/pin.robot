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
...               E espera o documento carregar devidamente
...               E adiciona um novo anexo
...               E valida o canvas e as páginas do documento e anexo
...               E adiciona um pin no documento e anexo
...               E valida o pin adicionado em todas as páginas do documento e anexo
...               E valida o pin removido em todas as páginas do documento e anexo
...               Então todos os elementos devem ser validados com sucesso

*** Test Cases ***
Envio - Envio de anexo - Validação de canvas e páginas
    [Tags]    ui    signature    critical
    Click Element                        ${cofre12}
    Wait Until Element Is Visible        ${novoArquivo}            ${TIMEOUT}
    Click Element                        ${novoArquivo}
    Click Element                        ${newfile}
    Sleep                                                          2s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path       ${RELATIVE_PATH}
    Choose File                                ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Element Is Visible              ${Aguardandoenvio}  ${TIMEOUT}
    Page Should Contain Element                ${Aguardandoenvio}
    # Garante que o documento esteja carregado e o canvas esteja visível
    Wait Until Page Contains Element           ${carregandoDocumento}     ${TIMEOUT}
    Wait Until Page Contains Element           ${canvas1}    ${TIMEOUT}
    Wait Until Page Contains Element           ${canvas2}    ${TIMEOUT}
    Click Element                              ${botaoAnexo}
    Choose File                                ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Page Contains Element           ${carregandoAnexo}         ${TIMEOUT}
    Wait Until Page Contains Element           ${Addanexo}     ${TIMEOUT}
    Wait Until Page Contains Element           ${docsCarregados}       ${TIMEOUT}
    Wait Until Page Contains Element           ${canvas3}    ${TIMEOUT}
    Wait Until Page Contains Element           ${canvas4}    ${TIMEOUT}
Adicionar pin
    # Clica no botão de add e-mail e valida o e-mail adicionado
    Click Element                              ${addEmail}
    # Garante que o canvas esteja visível e centralizado
    Sleep                                      2s
    Scroll Element Into View                   ${canvas1}
    Execute JavaScript                         window.scrollTo(0, 0)
    Sleep                                      1s
    Click Element At Coordinates               ${canvas1}    200    200
    # Garante que o pin foi adicionado
    Wait Until Page Contains Element           ${pin1}    ${TIMEOUT}
    # Começa a replicar o pin em todas as páginas do documento e anexo
    Sleep                                      2s
    Wait Until Page Contains Element           ${btnReplicarPin}    ${TIMEOUT}
    Click Element                              ${btnReplicarPin}
    Wait Until Page Contains Element           ${checkboxDoc}    ${TIMEOUT}
    Click Element                              ${checkboxDoc}
    Click Element                              ${checkboxAnexo}
    Click Element                              ${btnModalPins}
    # Garante que o pin foi replicado em todas as páginas do documento e anexo
    Sleep                                      2s
    Wait Until Page Contains Element           ${pin1}    ${TIMEOUT}
    Page Should Contain Element                ${pin1}    ${TIMEOUT}
    Page Should Contain Element                ${pin2}    ${TIMEOUT}
    Page Should Contain Element                ${pin3}    ${TIMEOUT}
    Page Should Contain Element                ${pin4}    ${TIMEOUT}
    # Remove o pin de todas as páginas do documento e anexo
    Click Element                              ${btnRemoverPin}
    # Aguarda o modal aparecer e clica no botão de confirmação
    Wait Until Page Contains Element           ${modalRemocaoPin}    ${TIMEOUT}
    Sleep                                      1s
    Click Element                              ${btnConfirmarRemocao}
    Sleep                                      1s
    # Garante que o pin foi removido de todas as páginas do documento e anexo
    Page Should Not Contain Element            ${pin1}    ${TIMEOUT}
    Page Should Not Contain Element            ${pin2}    ${TIMEOUT}
    Page Should Not Contain Element            ${pin3}    ${TIMEOUT}
    Page Should Not Contain Element            ${pin4}    ${TIMEOUT}