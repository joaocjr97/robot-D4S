*** Settings ***
Library    SeleniumLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot
Library    OperatingSystem

*** Test Cases ***
Login
    Open Browser    ${URL}    ${BROWSER_HEADLESS}
    Set Window Size    1920    1080
    Wait Until Element Is Visible   ${Email}      ${TIMEOUT}
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    ${TIMEOUT}
    Page Should Contain Image       ${logoD4S}  

Envio
    # Enviar documento pela desk, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${botaoEnvio}
    Wait Until Element Is Visible        ${selectCofre}           ${TIMEOUT}
    Click Element                        ${selectCofre} 
    Click Element                        ${selecionarCofre} 
    Sleep                                                         2s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Element Is Visible         ${Aguardandoenvio}       ${TIMEOUT}
    Page Should Contain Element           ${Aguardandoenvio}

Assinatura
    # Assinar o documento enviado pela desk.
    Click Element                         ${grupo}
    Wait Until Element Is Visible         ${filtroGrupo}          ${TIMEOUT}
    # Pesquisa pelo Grupo de Assinatura e envia para o mesmo.
    Input Text                            ${filtroGrupo}          Grupo
    Wait Until Element Is Visible         ${selecionarGrupo}
    Click Element                         ${selecionarGrupo}
    Reload Page
    Wait Until Element Is Enabled         ${botaoAssinatura}      ${TIMEOUT}
    Click Element                         ${botaoAssinatura}
    Wait Until Element Is Visible         ${botaoEnvio2}          ${TIMEOUT}
    Click Element                         ${botaoEnvio2}
    Wait Until Page Contains Element      ${faseEnviado}          ${TIMEOUT}
    Close Browser