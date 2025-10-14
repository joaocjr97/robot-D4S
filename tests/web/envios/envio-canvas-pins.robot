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
...               E envia o documento, abrindo a viewblob
...               Deve carregar o canvas e as duas páginas
...               E deve clicar em uma das páginas e verificar se o pin foi adicionado

*** Keywords ***
Click At Canvas Position Simple
    [Documentation]    Clique simples no canvas
    [Arguments]    ${canvas_locator}    ${x}    ${y}
    
    # Aguarda o canvas estar visível
    Wait Until Element Is Visible    ${canvas_locator}    30s
    
    # Scroll para o elemento
    Scroll Element Into View         ${canvas_locator}
    Sleep    2s
    
    # Clique nas coordenadas
    Click Element At Coordinates     ${canvas_locator}    ${x}    ${y}
    
    Log    🔍 [DEBUG] Clique executado no canvas ${canvas_locator} em (${x}, ${y})    DEBUG

Tentar Clique JavaScript No Canvas
    [Documentation]    Tenta clique com JavaScript
    Log    🔍 [DEBUG] Tentativa 2: Clique com JavaScript    DEBUG
    
    # Clique direto com JavaScript
    Execute Javascript    document.getElementById('canvas1').click();
    Sleep    2s
    
    # Tenta evento de mouse
    Execute Javascript    ${EMPTY}
    ...    var canvas = document.getElementById('canvas1');
    ...    var rect = canvas.getBoundingClientRect();
    ...    var x = rect.left + 300;
    ...    var y = rect.top + 600;
    ...    var event = new MouseEvent('click', {clientX: x, clientY: y});
    ...    canvas.dispatchEvent(event);
    
    Sleep    2s
    Log    🔍 [DEBUG] Clique JavaScript executado    DEBUG

*** Test Cases ***
Envio
    [Tags]    ui    signature    critical
    Log Signature Test Info    Iniciando teste de envio para cofre
    # Enviar documento pela cofre, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${cofre12}
    Wait Until Element Is Visible        ${novoArquivo}            ${TIMEOUT}
    Click Element                        ${novoArquivo}
    Click Element                        ${newfile}
    Sleep                                                          4s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Page Contains Element      ${verificaAssinatura}   ${TIMEOUT}
    # Verifica se o documento e suas duas páginas carregaram na viewblob
    Page Should Contain Element           //*[@id="doc-div-principal"]/div/img                       ${TIMEOUT}
    Wait Until Page Does Not Contain Element	      //*[@id="doc-div-principal"]/div/img           ${TIMEOUT}
    
    # Aguarda os canvas estarem completamente carregados
    Wait Until Element Is Visible         //*[@id="canvas1"]    30s
    Wait Until Element Is Visible         //*[@id="canvas2"]    30s
    Sleep    3s
    
    Page Should Contain Element           //*[@id="canvas1"]                                         ${TIMEOUT}
    Page Should Contain Element           //*[@id="canvas2"]                                         ${TIMEOUT}
    
    # Configura assinatura
    Wait Until Page Contains Element      //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/div[4]/div/div[2]/div[1]/span[1]/a    ${TIMEOUT}
    Click Element                         //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/div[4]/div/div[2]/div[1]/span[1]/a
    
    # Aguarda o processamento terminar
    Wait Until Element Is Not Visible     //div[contains(@class, 'progress-bar-striped')]            ${TIMEOUT}
    # DEBUG: Verificar se o canvas está realmente visível e clicável
    Log    🔍 [DEBUG] Verificando se canvas1 está visível e clicável    DEBUG
    
    # Verifica se o canvas está presente e visível
    Element Should Be Visible             //*[@id="canvas1"]
    Element Should Be Enabled             //*[@id="canvas1"]
    
    # Captura screenshot antes do clique para debug
    Capture Page Screenshot               before_canvas_click.png
    
    # Tenta diferentes abordagens de clique no canvas
    Log    🔍 [DEBUG] Tentativa 1: Clique direto no canvas    DEBUG
    Click At Canvas Position Simple       //*[@id="canvas1"]    300    600
    
    # Aguarda um pouco para ver se o pin aparece
    Sleep    3s
    
    # Verifica se o pin apareceu
    ${pin_exists}=    Run Keyword And Return Status    Element Should Be Visible    //*[@id="pin-container-for-canvas1"]/div/img    5s
    
    # Se não apareceu, tenta outras abordagens
    Run Keyword If    not ${pin_exists}    Tentar Clique JavaScript No Canvas
    
    # Aguarda o pin aparecer
    Wait Until Element Is Visible         //*[@id="pin-container-for-canvas1"]/div/img               ${TIMEOUT}
    
    # Captura screenshot após o clique para debug
    Capture Page Screenshot               after_canvas_click.png
    
    Log    ✅ [DEBUG] Pin criado com sucesso!    DEBUG
