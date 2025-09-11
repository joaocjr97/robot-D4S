*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary

*** Variables ***
${URL}               https://secure.d4sign.com.br/
${USERNAME}          automacao@d4sign.com.br
${PASSWORD}          d4sign123
${nomecofre}         id=nomeCofre  
${btnSalvarCofre}    id=btnSalvarCofre
${logar}             id=logar
${Email}             id=Email
${Passwd}            id=Passwd
${CreateNewVault}    xpath=//a[contains(., 'Create a new vault')]
${logoD4S}           //*[@id="page-wrapper"]/div[1]/nav/div/div/div[1]/a/img

*** Test Cases ***
Login
    Open Browser                    ${URL}       chrome
    Wait Until Element Is Visible   ${Email}     10s
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   10s
    Page Should Contain Image       ${logoD4S} 

Criar Cofre
    Wait Until Element Is Visible            ${CreateNewVault}  10s
    Click Element                            ${CreateNewVault}
    Wait Until Element Is Visible            ${nomecofre}       20s

    #Gerar nome aleatório para o cofre
    ${palavragerada}=    FakerLibrary.Company

    Input Text                              ${nomecofre}     ${palavragerada} 
    Click Button                            ${btnSalvarCofre}