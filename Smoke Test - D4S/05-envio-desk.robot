*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource   variables.robot
Resource   config_sensitive.robot

*** Test Cases ***
Login
    Open Browser                    ${URL}        chrome
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   60s
    Page Should Contain Image       ${logoD4S}  

Envio
    # Enviar documento pela desk, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${botaoEnvio}
    Wait Until Element Is Visible        ${selectCofre}      60s
    Click Element                        ${selectCofre} 
    Click Element                        ${selecionarCofre} 
    Sleep                                                    2s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Element Is Visible         ${Aguardandoenvio}  120s
    Page Should Contain Element           ${Aguardandoenvio}