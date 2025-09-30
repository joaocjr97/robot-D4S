*** Settings ***
Library    SeleniumLibrary
Resource   common_keywords.robot
Resource   config_environment.robot

*** Keywords ***
Test Setup
    [Documentation]    Setup comum para todos os testes
    [Arguments]    ${browser_type}=${BROWSER_HEADLESS}    ${set_cookie}=${EMPTY}
    
    # Configurações iniciais
    Set Screenshot Directory    ${CURDIR}/../reports/screenshots
    Set Log Level    ${LOG_LEVEL}
    
    # Login no sistema
    Login D4Sign    ${browser_type}    ${set_cookie}

Test Teardown
    [Documentation]    Teardown comum para todos os testes
    [Arguments]    ${take_screenshot}=${SCREENSHOT_ON_FAIL}
    
    # Captura screenshot em caso de falha
    Run Keyword If    ${take_screenshot}    Capture Page Screenshot
    
    # Fecha browser e limpa recursos
    Close Browser And Cleanup

Suite Setup
    [Documentation]    Setup da suíte de testes
    Log    Iniciando execução da suíte de testes    INFO

Suite Teardown
    [Documentation]    Teardown da suíte de testes
    Log    Finalizando execução da suíte de testes    INFO
