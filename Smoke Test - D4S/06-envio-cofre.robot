*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot
Library    OperatingSystem
    
*** Test Cases ***
Login
    Open Browser    ${URL}    ${BROWSER_HEADLESS}
    Set Window Size    1920    1080
    Execute Javascript              ${setcookie2}
    Wait Until Element Is Visible   ${Email}      ${TIMEOUT}
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    ${TIMEOUT}
    Page Should Contain Image       ${logoD4S}  

Envio
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
    Close Browser