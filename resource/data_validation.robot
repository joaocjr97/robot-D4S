*** Settings ***
Library    Collections
Library    String

*** Keywords ***
Validate Test Data
    [Documentation]    Valida se os dados de teste estão corretos
    [Arguments]    ${email}    ${password}    ${token_api}    ${crypt_key}
    
    # Validação de email
    Should Match Regexp    ${email}    ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
    
    # Validação de senha
    Should Not Be Empty    ${password}
    Length Should Be At Least    ${password}    6
    
    # Validação de token API
    Should Not Be Empty    ${token_api}
    Should Start With    ${token_api}    live_
    
    # Validação de crypt key
    Should Not Be Empty    ${crypt_key}
    Should Start With    ${crypt_key}    live_crypt_

Validate File Exists
    [Documentation]    Valida se arquivo de teste existe
    [Arguments]    ${file_path}
    File Should Exist    ${file_path}
    ${file_size}=    Get File Size    ${file_path}
    Should Be True    ${file_size} > 0    Arquivo está vazio

Validate API Response
    [Documentation]    Valida resposta da API
    [Arguments]    ${response}    ${expected_status}=200
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Not Be Empty    ${response.text}
