*** Settings ***
Library    RequestsLibrary
Library    String
Resource   ../resource/variables.robot
Resource   ../resource/config_sensitive.robot

*** Keywords ***
Header Json
    ${headers}=    Create Dictionary    Content-Type=application/json    tokenAPI=${TOKEN_API}    cryptKey=${CRYPT_KEY}
    RETURN    ${headers}

Fazer Upload PDF D4sign
    [Arguments]    ${file_path}    ${uuid_safe}    ${token}
    &{headers}=    Create Dictionary    tokenAPI=${token}
    &{files}=      Create Dictionary    File=${file_path}
    Create Session    d4sign    ${BASE_URL}    headers=${headers}
    ${response}=   Post On Session    d4sign    /documents/${uuid_safe}/upload    files=${files}
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
1 - Listar todos os documentos da conta
    [Documentation]    Listar todos os documentos da conta
    ${headers}=    Header Json
    Create Session    d4sign    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4sign    /${DOCUMENTS}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Status Should Be    200    ${response}
    Log Response As Formatted JSON    ${response}

2- Listar documento específico
    [Documentation]    Listar documento específico
    ${headers}=    Header Json
    Create Session    d4sign    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4sign    /${DOCUMENTS}/${LIST_ESPECIFIC_DOCUMENT}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Status Should Be    200    ${response}
    Log Response As Formatted JSON    ${response}

3 - Listar documentos por fase
    # Listagem de documentos pela fase 3 (aguardando assinaturas).
    [Documentation]    Listar documentos por fase
    ${headers}=    Header Json
    Create Session    d4sign    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4sign    /${DOCUMENTS}/${LIST_DOCUMENTS_PHASE}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Status Should Be    200    ${response}
    Log Response As Formatted JSON    ${response}

4 - Listar todos os cofres da conta
    [Documentation]    Listar todos os cofres da conta
    ${headers}=    Header Json
    Create Session    d4sign    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4sign    /${LIST_SAFE}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Status Should Be    200    ${response}
    Log Response As Formatted JSON    ${response}

5 - Listar documentos de um cofre específico
    [Documentation]    Listar documentos de um cofre específico
    ${headers}=    Header Json
    # Em Create Session, usar "cofres" no lugar de "d4sign" para diferenciar a sessão, ou seja, quem está fazendo a requisição.
    Create Session    cofres    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    cofres    /${DOCUMENTS}/${UUID_SAFE}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Status Should Be    200    ${response}
    Log Response As Formatted JSON    ${response}

6 - Listar webhooks de um documento específico
    # Listar webhooks de um documento de um cofre compartilhado, para aumentar a complexidade do teste.
    [Documentation]    Listar webhooks de um documento específico
    ${headers}=    Header Json
    Create Session    d4sign    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    d4sign    /${DOCUMENTS}/${UUID_WEBHOOK}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Status Should Be    200    ${response}
    Log Response As Formatted JSON    ${response}

# =============================================================================

# Post - Upload de documentos

Upload Documento Principal
    [Documentation]    Faz upload de um PDF para o endpoint da D4Sign.
    ${headers}=    Create Dictionary    tokenAPI=${TOKEN_API}
    &{files}=      Create Dictionary    File=${RELATIVE_PATH}
    # Se quiser enviar uuid_folder e workflow:
    &{data}=       Create Dictionary    uuid_folder=    workflow=
    Create Session    d4sign    ${BASE_URL}    headers=${headers}
    ${response}=   Post On Session    d4sign    /documents/${UUID_SAFE1}/upload    files=${files}    data=${data}
    Log    Status: ${response.status_code}
    Log    Body: ${response.text}
    Status Should Be    200    ${response}
    # Se esperar JSON e quiser bonitinho:
    Log Response As Formatted JSON    ${response}