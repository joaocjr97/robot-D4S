*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot


*** Test Cases ***
Login
    Open Browser    ${URL}    ${BROWSER_HEADLESS}
    Set Window Size    1920    1080
    # Define o cookie de IA do cofre, para impedir que atrapalhe o fluxo.
    Execute Javascript              ${setcookie2}
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S} 

Acessar o cofre e listar fases
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
    Close Browser