*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                https://secure.d4sign.com.br/
${USERNAME}           automacao@d4sign.com.br
${PASSWORD}           d4sign123
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
    Wait Until Element Is Visible   ${Email}      10s
    Input Text                      ${Email}      ${USERNAME}
    Input Text                      ${Passwd}     ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}    10s
    Page Should Contain Image       ${logoD4S}  

Envio
    # Enviar documento pela cofre, escolhendo o cofre e enviando o arquivo.
    Click Element                        //*[@id="liCofre_1414985"]/a
    Wait Until Element Is Visible        id=label-new-file      20s
    Click Element                        id=label-new-file
    Click Element                        //*[@id="page-wrapper"]/div[2]/div[2]/div[2]/div/div[1]/div[2]/ul/li[1]/a
    Sleep                                2s
    Choose File                          id=fileupload       ${uploadArquivo}
    Wait Until Element Is Visible        ${Aguardandoenvio}  60s
    Page Should Contain Element          ${Aguardandoenvio}