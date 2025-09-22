*** Settings ***
Library    SeleniumLibrary
Resource   variables.robot
Resource   config_sensitive.robot
Library    OperatingSystem
    
*** Test Cases ***
Login
    Open Browser                    ${URL}        ${BROWSER}
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}      10s
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    60s
    Page Should Contain Image       ${logoD4S}  

Envio
    # Enviar documento pela cofre, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${cofre12}
    Wait Until Element Is Visible        ${novoArquivo}      20s
    Click Element                        ${novoArquivo}
    Click Element                        ${newfile}
    Sleep                                                    2s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Element Is Visible         ${Aguardandoenvio}  60s
    Page Should Contain Element           ${Aguardandoenvio}