*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Library    OperatingSystem
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot

*** Keywords ***
Fazer Upload PDF D4sign
    [Arguments]    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    File Should Exist    ${RELATIVE_PATH}
    ${dir}    ${filename}=    Split Path    ${RELATIVE_PATH}
    ${file_bytes}=    Get Binary File    ${RELATIVE_PATH}
    &{headers}=    Create Dictionary    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}    Accept=application/json
    @{file_part}=    Create List    ${filename}    ${file_bytes}    application/pdf
    &{files}=      Create Dictionary    file=${file_part}
    Create Session    d4sign    ${BASE_URL}    headers=${headers}
    ${response}=   Post On Session    d4sign    /documents/${UUID_SAFE1}/upload    files=${files}
    RETURN    ${response}

Adicionar Signatarios
    [Arguments]    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}
    &{headers}=    Create Dictionary    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}    Content-Type=application/json    Accept=application/json
    &{signer}=    Create Dictionary
    ...    email=${EMAIL_TESTE}
    ...    act=1
    ...    foreign=0
    ...    certificadoicpbr=0
    ...    assinatura_presencial=0
    ...    docauth=0
    ...    docauthandselfie=0
    ...    embed_methodauth=
    ...    embed_smsnumber=
    ...    upload_allow=
    ...    upload_obs=
    ...    whatsapp_number=
    @{signers}=    Create List    ${signer}
    &{body}=    Create Dictionary    signers=${signers}
    Create Session    d4sign    ${BASE_URL}    headers=${headers}
    ${response}=    Post On Session    d4sign    /documents/${UUID_DOCUMENT}/createlist    json=${body}
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

*** Test Cases ***
1 - Upload Documento Principal
    [Documentation]    Faz upload de um PDF para o endpoint da D4Sign.
    ${response}=    Fazer Upload PDF D4sign    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    Log    Status: ${response.status_code}
    Log    Body: ${response.text}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Should Be Equal As Strings    ${response.status_code}    200
    Log Response As Formatted JSON    ${response}

2- Upload_E_Adicionar_Signatario
    # Primeiro, faz upload do PDF e captura resposta
    ${response}=    Fazer Upload PDF D4sign    ${RELATIVE_PATH}    ${UUID_SAFE1}    ${TOKEN_API}    ${CRYPT_KEY}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Body upload: ${response.text}
    # Extrai o UUID do documento gerado
    ${json}=    Call Method    ${response}    json
    ${UUID_DOCUMENT}=    Get From Dictionary    ${json}    uuid
    Log To Console    Documento UUID criado: ${UUID_DOCUMENT}
    Should Not Be Empty    ${UUID_DOCUMENT}
    # Usa o novo uuid do documento para criar a lista de signatários
    ${resp2}=    Adicionar Signatarios    ${UUID_DOCUMENT}    ${TOKEN_API}    ${CRYPT_KEY}
    Log    Status signatario: ${resp2.status_code}
    Log    Body signatario: ${resp2.text}
    Should Be Equal As Strings    ${resp2.status_code}    200