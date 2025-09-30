*** Settings ***
Library    RequestsLibrary
Library    String
Library    JSONLibrary
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot
Resource   ../resource/keywords.robot

*** Test Cases ***
1 - Listar todos os documentos da conta
    [Documentation]    Listar todos os documentos da conta
    ${response}=    Listar Todos Documentos Conta
    Log Response Time    ${response}
    Log Response As Formatted JSON    ${response}
    Status Should Be    200    ${response}

2 - Listar documento específico
    [Documentation]    Listar documento específico
    ${response}=    Listar Documento Especifico    ${LIST_ESPECIFIC_DOCUMENT}
    Log Response Time    ${response}
    Log Response As Formatted JSON    ${response}
    Status Should Be    200    ${response}

3 - Listar documentos por fase
    [Documentation]    Listar documentos por fase
    ${response}=    Listar Documentos Por Fase
    Log Response Time    ${response}
    Log Response As Formatted JSON    ${response}
    Status Should Be    200    ${response}

4 - Listar todos os cofres da conta
    [Documentation]    Listar todos os cofres da conta
    ${response}=    Listar Todos Cofres Conta
    Log Response Time    ${response}
    Log Response As Formatted JSON    ${response}
    Status Should Be    200    ${response}

5 - Listar documentos de um cofre específico
    [Documentation]    Listar documentos de um cofre específico
    ${response}=    Listar Documentos De Safe    ${UUID_SAFE}
    Log Response Time    ${response}
    Log Response As Formatted JSON    ${response}
    Status Should Be    200    ${response}

6 - Listar webhooks de um documento específico
    [Documentation]    Listar webhooks de um documento específico
    ${response}=    Listar Webhooks De Documento Especifico    ${UUID_WEBHOOK}
    Log Response Time    ${response}
    Log Response As Formatted JSON    ${response}
    Status Should Be    200    ${response}

7 - Listar pins do documento
    [Documentation]    Lista as assinaturas posicionadas e suas posições em um documento da D4Sign.
    ${response}=    Listar Pins    ${UUID_PINS}    ${TOKEN_API}    ${CRYPT_KEY}
    Should Be Equal As Strings    ${response.status_code}    200
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Status Should Be    200    ${response}
    Should Not Be Empty    ${response.text}
    ${json_anexo}=    Call Method    ${response}    json
    # Valida a resposta da API, com as posições de um dos pins
    ${primeiro_pin}=    Get From List    ${json_anexo['pins']}    0
    Should Be Equal    ${primeiro_pin['email']}    joao.carlos@d4sign.com.br
    Should Be Equal    ${primeiro_pin['position_x']}    600
    Should Be Equal    ${primeiro_pin['page_height']}    1123.00
    Log Response As Formatted JSON    ${response}