*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot


*** Test Cases ***
Login
    Open Browser                    ${URL}       ${BROWSER_HEADLESS}
    Set Window Size   1920    1080
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S} 

Acessar o cofre e listar fases
    Click Element                   ${cofre12}
    Wait Until Element Is Visible   ${btnFase}
    Click Element                   ${btnFase}
    Click Element                   ${fase1}
    Page Should Contain Element     ${signatarios}
    Click Element                   ${btnFase}
    Click Element                   ${fase2}
    Page Should Contain Element     ${assinaturas}
    Click Element                   ${btnFase}
    Click Element                   ${fase3}
    Page Should Contain Element     ${finalizado}
    # Voltar para a tela inicial.
    Click Element                   ${btnInicio}