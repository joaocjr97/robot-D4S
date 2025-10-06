*** Settings ***
Documentation    Keywords específicas para testes de API
Library    RequestsLibrary
Library    String
Library    Collections
Library    OperatingSystem
Resource         ../config/config_environment.robot
Resource         ../config/config_sensitive.robot
Resource         ../common/variables.robot

*** Keywords ***
Headers D4S
    ${headers}=    Create Dictionary    Content-Type=application/json    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}
    RETURN    ${headers}
    
Upload PDF
    [Arguments]    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    Log    Tentando acessar arquivo: ${RELATIVE_PATH}
    Log    EXECDIR atual: ${EXECDIR}
    File Should Exist    ${RELATIVE_PATH}
    ${dir}    ${filename}=    Split Path    ${RELATIVE_PATH}
    ${file_obj}=    Evaluate    open(r'''${RELATIVE_PATH}''', 'rb')
    @{file_tuple}=    Create List    ${filename}    ${file_obj}    application/pdf
    &{headers}=    Create Dictionary    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}
    &{files}=      Create Dictionary    file=${file_tuple}
    Delete All Sessions
    Create Session    d4sign_upload    ${BASE_URL}    headers=${headers}
    ${response}=    Post On Session    d4sign_upload    /documents/${UUID_SAFE1}/upload    files=${files}
    Call Method    ${file_obj}    close
    RETURN    ${response}

Upload Anexo PDF
    [Arguments]    ${UUID_DOCUMENT}    ${RELATIVE_PATH}    ${TOKEN_API}    ${CRYPT_KEY}
    File Should Exist    ${RELATIVE_PATH}
    ${dir}    ${filename}=    Split Path    ${RELATIVE_PATH}
    ${file_obj}=    Evaluate    open(r'''${RELATIVE_PATH}''', 'rb')
    @{file_tuple}=    Create List    ${filename}    ${file_obj}    application/pdf
    &{headers}=    Create Dictionary    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}
    &{files}=      Create Dictionary    file=${file_tuple}
    Delete All Sessions
    Create Session    d4s_slave    ${BASE_URL}    headers=${headers}
    ${response}=    Post On Session    d4s_slave    /documents/${UUID_DOCUMENT}/uploadslave    files=${files}
    Call Method    ${file_obj}    close
    RETURN    ${response}

Gerar Documento Via Template Word
    [Documentation]    Cria um documento a partir de um template word.
    # Lista completa de argumentos necessários para a requisição
    [Arguments]
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${UUID_SAFE1}
    ...    ${template_id}
    ...    ${nome_template_word}
    # Argumentos que preenchem as variáveis do template
    ...    ${nome_razao_social}    ${PF_PF}                  ${CNPJ_CPF}
    ...    ${rua_numero}           ${bairro}                 ${cidade}
    ...    ${Estado_UF}            ${cep}                    ${qtdveic1}
    ...    ${veiculo1}             ${Valor_Veic1}            ${qtdveic2}
    ...    ${veiculo2}             ${Valor_Veic2}            ${qtdveic3}
    ...    ${veiculo3}             ${Valor_Veic3}            ${tipopjoupf}
    ...    ${datainicialcontrato}  ${RAZAOSOCIAL_NOME}       
    ...    ${nomerepresentante}    ${cpfrepresentante}
    # Cria o dicionário de Headers
    &{headers}=    Create Dictionary
    ...    tokenAPI=${TOKEN_API}
    ...    cryptKey=${CRYPT_KEY}
    ...    Content-Type=application/json
    ...    Accept=application/json
    # Cria o dicionário interno com as variáveis do template
    &{dados_template}=    Create Dictionary
    ...    nome_razao_social=${nome_razao_social}
    ...    PF_PF=${PF_PF}
    ...    CNPJ_CPF=${CNPJ_CPF}
    ...    rua_numero=${rua_numero}
    ...    bairro=${bairro}
    ...    cidade=${cidade}
    ...    Estado_UF=${Estado_UF}
    ...    cep=${cep}
    ...    veiculo1=${veiculo1}
    ...    Valor_Veic1=${Valor_Veic1}
    ...    qtdveic1=${qtdveic1}
    ...    veiculo2=${veiculo2}
    ...    Valor_Veic2=${Valor_Veic2}
    ...    qtdveic2=${qtdveic2}
    ...    veiculo3=${veiculo3}
    ...    Valor_Veic3=${Valor_Veic3}
    ...    qtdveic3=${qtdveic3}
    ...    datainicialcontrato=${datainicialcontrato}
    ...    RAZAOSOCIAL_NOME=${RAZAOSOCIAL_NOME}
    ...    tipopjoupf=${tipopjoupf}
    ...    nomerepresentante=${nomerepresentante}
    ...    cpfrepresentante=${cpfrepresentante}
    # Cria o objeto 'templates' que envolve os dados, usando o template_id como chave
    &{templates_obj}=    Create Dictionary    ${template_id}=&{dados_template}
    &{body}=    Create Dictionary
    ...    name_document=${nome_template_word}
    ...    templates=&{templates_obj}
    Delete All Sessions
    Create Session    gerar_template_word    ${BASE_URL}    headers=&{headers}
    ${response}=    Post On Session
    ...    gerar_template_word
    ...    /documents/${UUID_SAFE1}/makedocumentbytemplateword
    ...    json=&{body}
    RETURN    ${response}

Gerar Documento Via Template HTML
    [Documentation]    Cria um documento a partir de um template HTML.
    [Arguments]
    ...    ${TOKEN_API}
    ...    ${CRYPT_KEY}
    ...    ${UUID_SAFE1}
    ...    ${template_id_html}
    ...    ${nome_documento_html}
    ...    ${marca}
    ...    ${laranja}
    ...    ${cor}
    ...    ${trueFALSE}
    ...    ${rua}
    ...    ${lugares}
    ...    ${restaurant}
    &{headers}=    Create Dictionary
    ...    tokenAPI=${TOKEN_API}
    ...    cryptKey=${CRYPT_KEY}
    ...    Content-Type=application/json
    ...    Accept=application/json
    &{dados_template}=    Create Dictionary
    ...    marca=${marca}
    ...    laranja=${laranja}
    ...    cor=${cor}
    ...    trueFALSE=${trueFALSE}
    ...    rua=${rua}
    ...    lugares=${lugares}
    ...    restaurant=${restaurant}
    &{templates_obj}=    Create Dictionary    ${template_id_html}=&{dados_template}
    &{body}=    Create Dictionary
    ...    name_document=${nome_documento_html}
    ...    templates=&{templates_obj}
    Delete All Sessions
    Create Session    gerar_template_html    ${BASE_URL}    headers=&{headers}
    ${response}=    Post On Session
    ...    gerar_template_html
    ...    /documents/${UUID_SAFE1}/makedocumentbytemplate
    ...    json=&{body}
    RETURN    ${response}

Adicionar Pins
    [Arguments]    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}    ${EMAIL_TESTE}    ${PAGE_WIDTH}    ${PAGE_HEIGHT}    ${PAGE}    ${POS_X}    ${POS_Y}    ${TYPE}
    &{headers}=    Create Dictionary    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}    Content-Type=application/json    Accept=application/json
    &{pin}=    Create Dictionary
    ...    document=${UUID_DOCUMENT}
    ...    email=${EMAIL_TESTE}
    ...    page_width=${PAGE_WIDTH}
    ...    page_height=${PAGE_HEIGHT}
    ...    page=${PAGE}
    ...    position_x=${POS_X}
    ...    position_y=${POS_Y}
    ...    type=${TYPE}
    @{pins}=    Create List    ${pin}
    &{body}=    Create Dictionary    pins=${pins}
    Delete All Sessions
    Create Session    add_pin    ${BASE_URL}    headers=${headers}
    ${response}=    Post On Session    add_pin    /documents/${UUID_DOCUMENT}/addpins    json=${body}
    RETURN    ${response}

Replicar Pin Em Todas As Paginas
    [Documentation]    Envia uma requisição para replicar uma posição de assinatura em todas as páginas de um documento.
    [Arguments]    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}    ${EMAIL_TESTE}    ${PAGE_WIDTH}    ${PAGE_HEIGHT}    ${POS_X}    ${POS_Y}    ${TYPE}
    &{headers}=    Create Dictionary
    ...    tokenAPI=${TOKEN_API}
    ...    cryptKey=${CRYPT_KEY}
    ...    Content-Type=application/json
    ...    Accept=application/json
    &{pin_details}=    Create Dictionary
    ...    email=${EMAIL_TESTE}
    ...    page_height=${PAGE_HEIGHT}
    ...    page_width=${PAGE_WIDTH}
    ...    position_x=${POS_X}
    ...    position_y=${POS_Y}
    ...    type=${TYPE}
    &{body}=    Create Dictionary    pins=&{pin_details}
    Delete All Sessions
    Create Session    replicate_pins    ${BASE_URL}    headers=&{headers}
    ${response}=    Post On Session
    ...    replicate_pins
    ...    /documents/${UUID_DOCUMENT}/addpinswithreplics
    ...    json=&{body}
    RETURN    ${response}

Listar Pins
    [Arguments]    ${UUID_PINS}    ${TOKEN_API}    ${CRYPT_KEY}
    &{headers}=    Create Dictionary    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}    Accept=application/json
    Create Session    list_pins    ${BASE_URL}    headers=${headers}
    ${response}=    Get On Session    list_pins    /documents/${UUID_PINS}/listpins
    RETURN    ${response}

Upload Binario
    [Arguments]    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}    ${MIME_TYPE}    ${NOME}
    File Should Exist    ${RELATIVE_PATH}
    ${base64pdf}=     Convert File To Base64    ${RELATIVE_PATH}
    &{headers}=    Create Dictionary    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}    Content-Type=application/json    Accept=application/json
    &{body}=    Create Dictionary
    ...    base64_binary_file=${base64pdf}
    ...    mime_type=${MIME_TYPE}
    Run Keyword If    '${NOME}' != ''              Set To Dictionary    ${body}    name    ${NOME}
    Delete All Sessions
    Create Session    d4sign_binary    ${BASE_URL}    headers=${headers}
    ${response}=    Post On Session    d4sign_binary    /documents/${UUID_SAFE1}/uploadbinary    json=${body}
    RETURN    ${response}

Convert File To Base64
    [Arguments]    ${file_path}
    ${base64_string}=    Evaluate    __import__('base64').b64encode(open(r'''${file_path}''', 'rb').read()).decode('utf-8')
    RETURN    ${base64_string}

Upload Hash
    [Arguments]    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}    ${NOME_HASH}=''
    File Should Exist    ${RELATIVE_PATH}
    ${sha256}=    Calculate SHA256 Hash    ${RELATIVE_PATH}
    ${sha512}=    Calculate SHA512 Hash    ${RELATIVE_PATH}
    &{headers}=    Create Dictionary    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}    Content-Type=application/json    Accept=application/json
    &{body}=       Create Dictionary    sha256=${sha256}    sha512=${sha512}
    Run Keyword If    '${NOME_HASH}' != ''        Set To Dictionary    ${body}    name    ${NOME_HASH}
    Delete All Sessions
    Create Session    d4sign_hash    ${BASE_URL}    headers=${headers}
    ${response}=    Post On Session    d4sign_hash    /documents/${UUID_SAFE1}/uploadhash    json=${body}
    RETURN    ${response}

Calculate SHA256 Hash
    [Arguments]    ${file_path}
    ${sha256_hash}=    Evaluate    __import__('hashlib').sha256(open(r'''${file_path}''', 'rb').read()).hexdigest()
    RETURN    ${sha256_hash}

Calculate SHA512 Hash
    [Arguments]    ${file_path}
    ${sha512_hash}=    Evaluate    __import__('hashlib').sha512(open(r'''${file_path}''', 'rb').read()).hexdigest()
    RETURN    ${sha512_hash}

Adicionar Signatarios
    [Arguments]    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}    @{lista_de_signatarios}
    &{headers}=    Create Dictionary    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}    Content-Type=application/json    Accept=application/json
    &{body}=    Create Dictionary    signers=${lista_de_signatarios}
    Delete All Sessions
    Create Session    d4sign_signers    ${BASE_URL}    headers=${headers}
    ${response}=    Post On Session    d4sign_signers    /documents/${UUID_DOCUMENT}/createlist    json=${body}
    RETURN    ${response}

Alterar Email Do Signatario
    [Documentation]    Atualiza o e-mail de um signatário existente em um documento.
    [Arguments]    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}    ${KEY_SIGNER}    ${EMAIL_TESTE}    ${EMAIL_NOVO}
    &{headers}=    Create Dictionary
    ...    tokenAPI=${TOKEN_API}
    ...    cryptKey=${CRYPT_KEY}
    ...    Content-Type=application/json
    ...    Accept=application/json
    &{body}=    Create Dictionary
    ...    email-before=${EMAIL_TESTE}
    ...    email-after=${EMAIL_NOVO}
    ...    key-signer=${KEY_SIGNER}
    Delete All Sessions
    Create Session    change_email    ${BASE_URL}    headers=&{headers}
    ${response}=    Post On Session    change_email    /documents/${UUID_DOCUMENT}/changeemail    json=&{body}
    RETURN    ${response}

Remover Signatario Do Documento
    [Documentation]    Remove um signatário de um documento usando o e-mail e a key-signer.
    [Arguments]    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}    ${KEY_SIGNER}    ${EMAIL_ALTERADO}
    &{headers}=    Create Dictionary
    ...    tokenAPI=${TOKEN_API}
    ...    cryptKey=${CRYPT_KEY}
    ...    Content-Type=application/json
    ...    Accept=application/json
    &{body}=    Create Dictionary
    ...    email-signer=${EMAIL_ALTERADO}
    ...    key-signer=${KEY_SIGNER}
    Delete All Sessions
    Create Session    remove_signer    ${BASE_URL}    headers=&{headers}
    ${response}=    Post On Session    remove_signer    /documents/${UUID_DOCUMENT}/removeemaillist    json=&{body}
    RETURN    ${response}

Enviar Documento Para Assinatura
    [Arguments]    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}    ${message}=    ${skip_email}=1    ${workflow}=0
    &{headers}=    Create Dictionary    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}    Content-Type=application/json    Accept=application/json
    &{body}=       Create Dictionary    skip_email=${skip_email}    workflow=${workflow}
    Delete All Sessions
    Create Session    d4sign_send    ${BASE_URL}    headers=${headers}
    ${response}=   Post On Session    d4sign_send    /documents/${UUID_DOCUMENT}/sendtosigner    json=${body}
    RETURN    ${response}

Adicionar Webhook Ao Documento
    [Documentation]    Envia uma requisição para cadastrar uma URL de webhook em um documento.
    [Arguments]    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}    ${WEBHOOK_URL}
    &{headers}=    Create Dictionary
    ...    tokenAPI=${TOKEN_API}
    ...    cryptKey=${CRYPT_KEY}
    ...    Content-Type=application/json
    ...    Accept=application/json
    &{body}=    Create Dictionary
    ...    url=${WEBHOOK_URL}
    Delete All Sessions
    Create Session    add_webhook    ${BASE_URL}    headers=&{headers}
    ${response}=    Post On Session
    ...    add_webhook
    ...    /documents/${UUID_DOCUMENT}/webhooks
    ...    json=&{body}
    RETURN    ${response}

Log Response As Formatted JSON
    [Arguments]    ${response}
    # Transforma o texto da resposta da API (JSON em string) em um dicionário/lista Python
    # Usa json.loads para "desempacotar" o texto e permitir formatar depois
    ${json}=      Evaluate    json.loads(r'''${response.text}''')    json
    # Transforma o dicionário/lista Python de volta para texto,
    # mas agora adicionando quebras de linha e identação para facilitar a leitura
    ${pretty}=    Evaluate    json.dumps(${json}, indent=2, ensure_ascii=False)    json
    # Salva o JSON formatado no arquivo de log (log.html)
    Log    ${pretty}
    # Mostra o JSON formatado imediatamente no terminal/console enquanto o teste roda
    Log To Console    ${pretty}

Log Response Time
    [Arguments]    ${response}
    # Converte o tempo de resposta (que é um timedelta) para string, exemplo: '0:00:01.410198'
    ${tempo_str}=    Convert To String    ${response.elapsed}
    # Divide a string onde houver dois pontos, resultado: ['0', '00', '01.410198']
    ${partes}=    Split String    ${tempo_str}    :
    # Pega a terceira parte (os segundos, ex: '01.410198') e converte de texto para número
    ${segundos}=    Convert To Number    ${partes}[2]
    # Arredonda o valor dos segundos para 3 casas decimais, ficando mais fácil de ler
    ${tempo_arredondado}=    Evaluate    round(${segundos}, 3)
    # Retorna o valor final dos segundos (já arredondado) para ser usado onde precisar
    RETURN    ${tempo_arredondado}

Listar Todos Documentos Conta
    ${headers}=    Headers D4S
    Create Session    d4s_list_docs    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4s_list_docs    /${DOCUMENTS}
    RETURN    ${response}

Listar Documento Especifico
    [Arguments]    ${document_id}
    ${headers}=    Headers D4S
    Create Session    d4s_list_one_doc    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4s_list_one_doc    /${DOCUMENTS}/${document_id}
    RETURN    ${response}

Listar Documentos Por Fase
    ${headers}=    Headers D4S
    Create Session    d4s_list_phase    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4s_list_phase    /${DOCUMENTS}/${LIST_DOCUMENTS_PHASE}
    RETURN    ${response}

Listar Todos Cofres Conta
    ${headers}=    Headers D4S
    Create Session    d4s_list_safes    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4s_list_safes    /${LIST_SAFE}
    RETURN    ${response}

Listar Documentos De Safe
    [Arguments]    ${uuid_safe}
    ${headers}=    Headers D4S
    Create Session    d4s_list_docs_safe    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4s_list_docs_safe    /${DOCUMENTS}/${uuid_safe}
    RETURN    ${response}

Listar Webhooks De Documento Especifico
    [Arguments]    ${uuid_webhook}
    ${headers}=    Headers D4S
    Create Session    d4s_list_webhooks    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4s_list_webhooks    /${DOCUMENTS}/${uuid_webhook}
    RETURN    ${response}