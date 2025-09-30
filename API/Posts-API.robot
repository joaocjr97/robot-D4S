*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Library    OperatingSystem
Library    JSONLibrary
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

5 - Faz upload - Acrescenta signatários via Email - Envia para assinatura
    [Documentation]    Envia o documento, cadastra signatário via e-mail e envia.
    # ETAPA 1: Upload do PDF e captura UUID
    ${response_upload}=    Upload PDF    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    Status Should Be    200    ${response_upload}
    ${json_upload}=    Call Method    ${response_upload}    json
    ${UUID_DOCUMENT}=    Get From Dictionary    ${json_upload}    uuid
    Log To Console    \n--- ETAPA 1: UPLOAD OK ---
    Log To Console    Documento UUID criado: ${UUID_DOCUMENT}
    # ETAPA 2: Preparar os dados do signatário
    &{signer_por_email}=    Create Dictionary
    ...    email=${EMAIL_TESTE}
    ...    act=1
    ...    foreign=0
    ...    certificadoicpbr=0
    ...    assinatura_presencial=0
    ...    docauth=0
    ...    docauthandselfie=0
    ...    embed_methodauth=${EMPTY}
    ...    embed_smsnumber=${EMPTY}
    ...    upload_allow=0
    ...    upload_obs=${EMPTY}
    ...    whatsapp_number=${EMPTY}
    @{signers_para_envio}=    Create List    ${signer_por_email}
    # ETAPA 3: Adicionar os signatários
    ${response_add}=    Adicionar Signatarios
    ...    ${UUID_DOCUMENT}
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    @{signers_para_envio}
    Status Should Be    200    ${response_add}
    # Verificação de cadastro do email
    ${json_add}=    Call Method    ${response_add}    json
    ${lista_wpp}=    Get Value From Json    ${json_add}    $.message[0].email
    Should Be Equal As Strings    ${lista_wpp}[0]    ${EMAIL_TESTE}
    Log    ✅ EMAIL validado com sucesso: ${lista_wpp}[0]
    Log    Body signatario: ${response_add.text}
    # ETAPA 4: Enviar para assinatura
    ${response_send}=    Enviar Documento Para Assinatura    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}
    Status Should Be    200    ${response_send}
    Log To Console    \n--- ETAPA 4: ENVIO PARA ASSINATURA OK ---
    Log    Body envio: ${response_send.text}
    ${json_send}=    Call Method    ${response_send}    json
    Should Be Equal As Strings    ${json_send['message']}    File sent to successfully signing

6 - Faz upload - Acrescenta signatário via WhatsApp - Envia
    [Documentation]    Envia o documento, cadastra signatário via WhatsApp e envia para assinatura.
    # ETAPA 1: Upload do PDF 
    ${response_upload}=    Upload PDF    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    Status Should Be    200    ${response_upload}
    ${json_upload}=    Call Method    ${response_upload}    json
    ${UUID_DOCUMENT}=    Get From Dictionary    ${json_upload}    uuid
    Log To Console    \n--- ETAPA 1 (WhatsApp): UPLOAD OK ---
    Log To Console    Documento UUID criado: ${UUID_DOCUMENT}
    # ETAPA 2: Preparar os dados do signatário para WhatsApp
    &{signer_por_whatsapp}=    Create Dictionary
    ...    email=${EMPTY}
    ...    act=1
    ...    whatsapp_number=${WHATSAPP_TESTE}
    ...    foreign=0
    ...    certificadoicpbr=0
    ...    assinatura_presencial=0
    ...    docauth=0
    ...    docauthandselfie=0
    ...    embed_methodauth=${EMPTY}
    ...    embed_smsnumber=${EMPTY}
    ...    upload_allow=0
    ...    upload_obs=${EMPTY}
    @{signers_para_envio}=    Create List    ${signer_por_whatsapp}
    # ETAPA 3: Adicionar os signatários
    ${response_add}=    Adicionar Signatarios
    ...    ${UUID_DOCUMENT}
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    @{signers_para_envio}
    Status Should Be    200    ${response_add}
    # Verificação de cadastro do WhatsApp
    ${json_add}=    Call Method    ${response_add}    json
    ${lista_wpp}=    Get Value From Json    ${json_add}    $.message[0].email
    Should Be Equal As Strings    ${lista_wpp}[0]    ${WHATSAPP_TESTE}
    Log    ✅ WhatsApp validado com sucesso: ${lista_wpp}[0]
    Log    Body signatario: ${response_add.text}
    # ETAPA 4: Enviar para assinatura
    ${response_send}=    Enviar Documento Para Assinatura    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}
    Status Should Be    200    ${response_send}
    Log To Console    \n--- ETAPA 4 (WhatsApp): ENVIO PARA ASSINATURA OK ---
    Log    Body envio: ${response_send.text}
    ${json_send}=    Call Method    ${response_send}    json
    Should Be Equal As Strings    ${json_send['message']}    File sent to successfully signing

7 - Upload com Pins
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

8 - Gerar documento via template word
    [Documentation]    Gera um documento via template word
    ${response}=    Gerar Documento Via Template Word
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${UUID_SAFE1}
    ...    ${template_id}
    ...    ${nome_template_word}
    ...    ${nome_razao_social}
    ...    ${PF_PF}
    ...    ${CNPJ_CPF}
    ...    ${rua_numero}
    ...    ${bairro}
    ...    ${cidade}
    ...    ${Estado_UF}
    ...    ${cep}
    ...    ${RAZAOSOCIAL_NOME}
    ...    ${tipopjoupf}
    ...    ${nomerepresentante}
    ...    ${cpfrepresentante}
    ...    ${veiculo1}
    ...    ${qtdveic1}
    ...    ${Valor_Veic1}
    ...    ${veiculo2}
    ...    ${qtdveic2}
    ...    ${Valor_Veic2}
    ...    ${veiculo3}
    ...    ${qtdveic3}
    ...    ${Valor_Veic3}
    ...    ${datainicialcontrato}      
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
    # Replicar os pins
    ${response}=    Replicar Pin Em Todas As Paginas
    ...    ${UUID_DOCUMENT}
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${EMAIL_TESTE}
    ...    ${PAGE_WIDTH}
    ...    ${PAGE_HEIGHT}
    ...    ${POS_X_0}
    ...    ${POS_Y_0}
    ...    ${TYPE_0}

9 - Envio com edição e remoção de signatário
    [Documentation]    Envia o documento, cadastra signatário, muda e depois remove.
     # Upload do PDF e captura UUID
    ${response}=    Upload PDF    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Body upload: ${response.text}
    # Armazena o UUID do upload
    ${json}=    Call Method    ${response}    json
    ${UUID_DOCUMENT}=    Get From Dictionary    ${json}    uuid
    Should Not Be Empty    ${UUID_DOCUMENT}
    Log To Console    Documento UUID criado: ${UUID_DOCUMENT}
    # Adicionar o signatário inicial e CAPTURAR O KEY-SIGNER -> createlist
    ${response_add}=    Adicionar Signatarios    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}
    Status Should Be    200    ${response_add}
    ${json_add}=    Call Method    ${response_add}    json
    ${signer_dictionary}=    Set Variable    ${json_add['message'][0]}
    ${key_signer}=    Get From Dictionary    ${signer_dictionary}    key_signer
    Should Not Be Empty    ${key_signer}
    Log To Console    Key-Signer capturada: ${key_signer}
    # Alterar e-mail do signatário -> changeemail
    ${response_change}=    Alterar Email Do Signatario
    ...    ${UUID_DOCUMENT}
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${key_signer}
    ...    ${EMAIL_TESTE}
    ...    ${EMAIL_ALTERADO}
    Status Should Be    200    ${response_change}
    Log    E-mail alterado de '${EMAIL_TESTE}' para '${EMAIL_ALTERADO}' com sucesso.
    Log    Resposta da alteração: ${response_change.text}
    ${json_anexo}=    Call Method    ${response_change}    json
    Should Be Equal As Strings    ${json_anexo['message']}    E-mail changed
    Log Response As Formatted JSON    ${response_change}
    # Remover signatário -> removeemaillist
    ${response_remove}=    Remover Signatario Do Documento
    ...    ${UUID_DOCUMENT}
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${key_signer}
    ...    ${EMAIL_ALTERADO}
    Status Should Be    200    ${response_remove}
    Log To Console    Signatário com e-mail '${EMAIL_ALTERADO}' removido com sucesso.
    Log    Resposta da remoção: ${response_remove.text}
    ${json_anexo}=    Call Method    ${response_remove}    json
    Should Be Equal As Strings    ${json_anexo['message']}    E-mail has removed
    Log Response As Formatted JSON    ${response_remove}

10 - Adcionar webhook ao documento
    [Documentation]    Adição de link de webhook ao documento e verificação de sucesso
    ${response}=    Adicionar Webhook Ao Documento
    ...    ${UUID_DOC_WEBHOOK}
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${URL_WEBHOOK}
    Log To Console      Response Body: ${response.text}
    Status Should Be    200    ${response}   
    ${json_anexo}=    Call Method    ${response}    json
    Should Be Equal As Strings    ${json_anexo['message']}    Webhook successfully registered
    Log Response As Formatted JSON    ${response}

11 - Criar documento Template HTML
    [Documentation]    Valida a criação de um documento usando um template HTML e variáveis específicas.
    ${response}=    Gerar Documento Via Template HTML
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${UUID_SAFE1}
    ...    ${TEMPLATE_ID_HTML}
    ...    ${NOME_DOC_HTML}
    ...    ${MARCA_VAR}
    ...    ${LARANJA_VAR}
    ...    ${COR_VAR}
    ...    ${TRUEFALSE_VAR}
    ...    ${RUA_VAR}
    ...    ${LUGARES_VAR}
    ...    ${RESTAURANT_VAR}
    Status Should Be    200    ${response}
    Log Response Time    ${response}
    ${json_anexo}=    Call Method    ${response}    json
    Should Be Equal As Strings    ${json_anexo['message']}    success
    Log Response As Formatted JSON    ${response}
    Log Response As Formatted JSON    ${response}