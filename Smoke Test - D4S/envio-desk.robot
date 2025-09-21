*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                https://secure.d4sign.com.br/
${USERNAME}           automacao@d4sign.com.br
${PASSWORD}           d4sign123
${setcookie}          document.cookie = "contratoazul_language=pt"
${logar}              id=logar
${Email}              id=Email
${Passwd}             id=Passwd
${logoD4S}            //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img
${botaoEnvio}         //*[@id="drop-zone"]/a/p[2]
${uploadArquivo}      C:/Users/joao.carlos_d4sign/Desktop/Robot/files/doc-testes.pdf
${Aguardandoenvio}    //*[@id="page-wrapper"]/div[2]/div/div[1]/div/div/div/span[1]
${selectCofre}        name=uuid-cofre
${selecionarCofre}    //*[@id="formUpload"]/select/option[157]
${fileupload}         id=fileupload

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
    Wait Until Element Is Visible        ${selectCofre}      60s
    Click Element                        ${selectCofre} 
    Click Element                        ${selecionarCofre} 
    Sleep                                                    2s
    Choose File                          ${fileupload}       ${uploadArquivo}
    Wait Until Element Is Visible        ${Aguardandoenvio}  120s
    Page Should Contain Element          ${Aguardandoenvio}