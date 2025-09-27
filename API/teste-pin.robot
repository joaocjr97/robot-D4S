*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Resource   ../resource/variables.robot
Library    String

*** Variables ***
${BROWSER}               headlessfirefox
${TIMEOUT}               50s
${URL_BASE}              https://homol.d4sign.com.br
${API_BASE_URL}          https://homol.d4sign.com.br
${LOGIN_PATH}            /login
${USERNAME}              automacao@d4sign.com.br
${PASSWORD}              d4sign123
${ENDPOINT}              /desk/getAssinaturasPin/41d360a8-9e1d-479f-8bee-96436e29f37d
${Email}                 id=Email
${Passwd}                id=Passwd
${logar}                 id=logar

*** Test Cases ***
Login Web E Consumir API Protegida
    [Documentation]    Login via browser, pegar o cookie, usar na request autenticada da API
    Realizar Login Via Navegador E Salvar Cookie Sessao
    Consumir Endpoint API Usando Cookie De Sessao

*** Keywords ***
Realizar Login Via Navegador E Salvar Cookie Sessao
    Open Browser    ${URL_BASE}${LOGIN_PATH}    ${BROWSER}
    Set Window Size    1920    1080
    Execute Javascript    document.cookie = "contratoazul_language=pt"
    Input Text              ${Email}     ${USERNAME}
    Input Text              ${Passwd}    ${PASSWORD}
    Click Button            ${logar}
    Wait Until Element Is Visible   ${logoD4S}   ${TIMEOUT}
    Page Should Contain Image       ${logoD4S}
    ${all_cookies}=    Get Cookies
    Log To Console    Raw cookies: ${all_cookies}

    &{cookie_dict}=    Create Dictionary
    FOR    ${cookiepair}    IN    @{all_cookies.split(";")}
        ${cookiepair}=    Strip String    ${cookiepair}
        ${parts}=    Split String    ${cookiepair}    =
        Run Keyword If    len(${parts}) < 2    Continue For Loop
        ${name}=    Strip String    ${parts[0]}
        ${value}=   Strip String    ${parts[1]}
        Set To Dictionary    ${cookie_dict}    ${name}    ${value}
    END
    Log To Console    Cookies dicionário: ${cookie_dict}
    Set Suite Variable    ${COOKIE_DICT}    ${cookie_dict}
    Close Browser

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

Consumir Endpoint API Usando Cookie De Sessao
    &{headers}=    Create Dictionary    Content-Type=application/json
    Create Session    d4sign    ${API_BASE_URL}    headers=${headers}    cookies=${COOKIE_DICT}
    ${response}=    GET On Session    d4sign    ${ENDPOINT}
    Log    Status: ${response.status_code}
    Log    Body: ${response.text}
    ${tempo}=    Log Response Time    ${response}
    Log To Console    Tempo de resposta: ${tempo} segundos
    Log    Tempo de resposta: ${tempo} segundos
    Should Be Equal As Strings    ${response.status_code}    200
    Log Response As Formatted JSON    ${response}