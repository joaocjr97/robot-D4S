*** Settings ***
Library    SeleniumLibrary
Resource   variables.robot
Resource   config_sensitive.robot
Library    OperatingSystem

*** Test Cases ***
Login
    Open Browser                    ${URL}        chrome
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}      10s
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    60s
    Page Should Contain Image       ${logoD4S}  

Envio
    # Enviar documento pela desk, escolhendo o cofre e enviando o arquivo.
    Click Element                        ${botaoEnvio}
    Wait Until Element Is Visible        ${selectCofre}           20s
    Click Element                        ${selectCofre} 
    Click Element                        ${selecionarCofre} 
    Sleep                                                         2s
    # Aqui, o uso da segunda lib do arquivo, ajuda a driblar o impeditivo do caminho absoluto do arquivo e ser usado o relativo.
    ${ABSOLUTE_PATH}=     Normalize Path  ${RELATIVE_PATH}
    Choose File                           ${fileupload}       ${ABSOLUTE_PATH}
    Wait Until Element Is Visible         ${Aguardandoenvio}       20s
    Page Should Contain Element           ${Aguardandoenvio}

Assinatura
    # Assinar o documento enviado pela desk.
    Click Element                         ${grupo}
    Wait Until Element Is Visible         ${filtroGrupo}          10s
    # Pesquisa pelo Grupo de Assinatura e envia para o mesmo.
    Input Text                            ${filtroGrupo}          Grupo
    Wait Until Element Is Visible         ${selecionarGrupo}
    Click Element                         ${selecionarGrupo}
    Reload Page
    Wait Until Element Is Enabled         ${botaoAssinatura}      30s
    Click Element                         ${botaoAssinatura}
    Wait Until Element Is Visible         ${botaoEnvio2}          20s
    Click Element                         ${botaoEnvio2}
    Wait Until Page Contains Element      ${faseEnviado}          50s
