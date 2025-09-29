*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Library    OperatingSystem
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot
Resource   ../resource/keywords.robot


*** Test Cases ***
1 - Upload de documento PDF
    [Documentation]    Upload de PDF para o endpoint /upload da D4Sign.
    ${response}=    Upload PDF    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    Log To Console    STATUS: ${response.status_code}
    Log To Console    BODY: ${response.text}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    
    # Asserções para Upload PDF
    Status Should Be    200    ${response}     # Verifica se a resposta é bem-sucedida
    Should Not Be Empty    ${response.text}    #  Verifica se há conteúdo na resposta
    ${json}=    Call Method    ${response}    json
    Should Not Be Empty    ${json['uuid']}
    Should Match Regexp    ${json['uuid']}    ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$  # Com padrão UUID v4 - Verifica se o UUID tem formato correto
    Should Be Equal As Strings    ${json['message']}    success  # Valida a mensagem de resposta da API
    Log Response As Formatted JSON    ${response}
    Log    UUID do documento criado: ${json['uuid']}
2 - Upload de documento binário - base64
    [Documentation]    Faz upload binário (base64) de um PDF para a D4Sign via /uploadbinary.
    ${response}=    Upload Binario    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}    ${MIME_TYPE}    ${NOME}
    Log To Console    STATUS: ${response.status_code}
    Log To Console    BODY: ${response.text}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    
    # Asserções para Upload Binário Base64
    Status Should Be    200    ${response}
    Should Not Be Empty    ${response.text}
    ${json}=    Call Method    ${response}    json
    Should Not Be Empty    ${json['uuid']}
    Should Match Regexp    ${json['uuid']}    ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$
    Should Be Equal As Strings    ${json['message']}    success
    Log Response As Formatted JSON    ${response}
    Log    UUID do documento criado: ${json['uuid']}

3 - Upload de documento HASH
    [Documentation]    Faz upload do hash SHA256/SHA512 de um PDF para o endpoint /uploadhash da D4Sign.
    ${response}=    Upload Hash    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}    ${NOME_HASH}
    Log To Console    STATUS: ${response.status_code}
    Log To Console    BODY: ${response.text}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    
    # Asserções para Upload Hash
    Status Should Be    200    ${response}
    Should Not Be Empty    ${response.text}
    ${json}=    Call Method    ${response}    json
    Should Not Be Empty    ${json['uuid']}
    Should Match Regexp    ${json['uuid']}    ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$
    Should Be Equal As Strings    ${json['message']}    success
    Log Response As Formatted JSON    ${response}
    Log    UUID do documento criado: ${json['uuid']}


4 - Upload de documento + anexo
    [Documentation]    Envia o documento para assinatura e acrescenta anexo
    # Upload do PDF e captura UUID
    ${response}=    Upload PDF    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Body upload: ${response.text}
    # Armazena o UUID do upload
    ${json}=    Call Method    ${response}    json
    ${UUID_DOCUMENT}=    Get From Dictionary    ${json}    uuid
    Should Not Be Empty    ${UUID_DOCUMENT}
    Log To Console    Documento UUID criado: ${UUID_DOCUMENT}
    # Upload do anexo
    ${resp2}=    Upload Anexo PDF    ${UUID_DOCUMENT}    ${RELATIVE_PATH}    ${TOKEN_API}    ${CRYPT_KEY}
    Log To Console    STATUS ANEXO: ${resp2.status_code}
    Log To Console    BODY ANEXO: ${resp2.text}
    ${tempo}=    Log Response Time    ${resp2}
    Log To Console    Tempo de resposta anexo: ${tempo} segundos
    Log    Tempo de resposta anexo: ${tempo} segundos
    # Asserções para Upload de Anexo
    Status Should Be    200    ${resp2}
    Should Not Be Empty    ${resp2.text}
    ${json_anexo}=    Call Method    ${resp2}    json
    Should Be Equal As Strings    ${json_anexo['message']}    File created
    Log Response As Formatted JSON    ${resp2}
    Log    Anexo adicionado com sucesso ao documento: ${UUID_DOCUMENT}

5 - Faz upload - Acrescenta signatários - Envia para assinatura
    [Documentation]    Envia o documento, cadastra signatário e envia
    # Upload do PDF e captura UUID
    ${response}=    Upload PDF    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Body upload: ${response.text}
    # Armazena o UUID do upload
    ${json}=    Call Method    ${response}    json
    ${UUID_DOCUMENT}=    Get From Dictionary    ${json}    uuid
    Should Not Be Empty    ${UUID_DOCUMENT}
    Log To Console    Documento UUID criado: ${UUID_DOCUMENT}
    # Cadastro dos signatários
    ${resp2}=    Adicionar Signatarios    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}
    Should Be Equal As Strings    ${resp2.status_code}    200
    Log    Status signatario: ${resp2.status_code}
    Log    Body signatario: ${resp2.text}
    # Envia para assinatura
    ${resp_enviar}=    Enviar Documento Para Assinatura    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}
    Log    Status envio: ${resp_enviar.status_code}
    Log    Body envio: ${resp_enviar.text}
    ${tempo}=    Log Response Time    ${resp_enviar}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Status Should Be    200    ${resp_enviar}
    Should Not Be Empty    ${resp_enviar.text}
    ${json_anexo}=    Call Method    ${resp_enviar}    json
    Should Be Equal As Strings    ${json_anexo['message']}    File sent to successfully signing
    Log Response As Formatted JSON    ${resp_enviar}

6 - Upload com Pins
    [Documentation]    Sobe o documento e acrescenta pins
    # Upload do PDF e captura UUID
    ${response}=    Upload PDF    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Body upload: ${response.text}
    # Armazena o UUID do upload
    ${json}=    Call Method    ${response}    json
    ${UUID_DOCUMENT}=    Get From Dictionary    ${json}    uuid
    Should Not Be Empty    ${UUID_DOCUMENT}
    Log To Console    Documento UUID criado: ${UUID_DOCUMENT}
    # Cadastro dos signatários
    ${resp2}=    Adicionar Signatarios    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}
    Should Be Equal As Strings    ${resp2.status_code}    200
    Log    Status signatario: ${resp2.status_code}
    Log    Body signatario: ${resp2.text}
    # Pin 1 - Assinatura (canto superior esquerdo)
    ${response3}=    Adicionar Pins
    ...    ${UUID_DOCUMENT}
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${EMAIL_TESTE}
    ...    ${PAGE_WIDTH}
    ...    ${PAGE_HEIGHT}
    ...    ${PAGE}
    ...    ${POS_X_0}
    ...    ${POS_Y_0}
    ...    ${TYPE_0}
    ${tempo}=    Log Response Time    ${response3}
    Log    Pin 1 (Assinatura) adicionado - Posição: (${POS_X_0}, ${POS_Y_0})
    
    # Pin 2 - Rubrica (centro)
    ${response4}=    Adicionar Pins
    ...    ${UUID_DOCUMENT}
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${EMAIL_TESTE}
    ...    ${PAGE_WIDTH}
    ...    ${PAGE_HEIGHT}
    ...    ${PAGE}
    ...    ${POS_X_1}
    ...    ${POS_Y_1}
    ...    ${TYPE_1}
    ${tempo}=    Log Response Time    ${response4}
    Log    Pin 2 (Rubrica) adicionado - Posição: (${POS_X_1}, ${POS_Y_1})
    
    # Pin 3 - Selo (canto inferior direito)
    ${response5}=    Adicionar Pins
    ...    ${UUID_DOCUMENT}
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${EMAIL_TESTE}
    ...    ${PAGE_WIDTH}
    ...    ${PAGE_HEIGHT}
    ...    ${PAGE}
    ...    ${POS_X_2}
    ...    ${POS_Y_2}
    ...    ${TYPE_2}
    ${tempo}=    Log Response Time    ${response5}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Status Should Be    200    ${response5}
    Should Not Be Empty    ${response5.text}
    ${json_anexo}=    Call Method    ${response5}    json
    Should Be Equal As Strings    ${json_anexo['message']}    success
    Log Response As Formatted JSON    ${response5}