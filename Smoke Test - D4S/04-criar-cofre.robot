*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Resource   variables.robot
Resource   config_sensitive.robot

*** Test Cases ***
Login
    Open Browser                    ${URL}       ${BROWSER_HEADLESS}
    Execute Javascript              ${setcookie}
    Wait Until Element Is Visible   ${Email}     ${TIMEOUT}
    Input Text                      ${Email}     ${USERNAME}
    Input Text                      ${Passwd}    ${PASSWORD}
    Click Button                    ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S} 

Criar Cofre
    Wait Until Element Is Visible            ${CreateNewVault}  ${TIMEOUT}
    Click Element                            ${CreateNewVault}
    Wait Until Element Is Visible            ${nomecofre}       20s

    #Gerar nome aleatório para o cofre
    ${palavragerada}=    FakerLibrary.Company

    Input Text                              ${nomecofre}        ${palavragerada} 
    Click Button                            ${btnSalvarCofre}