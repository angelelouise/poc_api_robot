***Settings***

Documentation   Arquivo que descreve os casos de testes

***Keywords***
##--------------------------------------- Test cases-------------------------------##

TC1: Cadastro de usuário com sucesso
    Criar massa de dados    ${TRUE}    ${TRUE}    ${TRUE}
    Enviar requisição       post    ${DATA}     ${HEADER}
    Verificar status da response    200
    Verificar payload da resposta   schemas/signup_response_schema.json     ${RESPONSE.json()}
TC2: Cadastro de usuário com e-mail vazio
    Criar massa de dados    ${FALSE}   ${TRUE}    ${TRUE}
TC3: Cadastro de usuário com nome vazio
    Criar massa de dados    ${TRUE}    ${FALSE}   ${TRUE}
TC4: Cadastro de usuário com senha vazia
    Criar massa de dados    ${TRUE}    ${TRUE}    ${FALSE}

##--------------------------------------- Keywords Auxiliares-------------------------------##
Criar massa de dados
    [Documentation]     
    ...     Os argumentos para essa keyword são booleans, se true ele gera um valor para o campo, se false ele deixa vazio
    [Arguments]     ${B_EMAIL}    ${B_NAME}     ${B_PWD}
    #utilizando da biblioteca FakerLibrary para criar a massa de dados
    #Built.in Run keyword if    Condition	    Some Action	    arg	    ELSE	Another Action
    ${FAKE_EMAIL}=      Run keyword if      '${B_EMAIL}' == '${TRUE}'
    ...    FakerLibrary.Email
    ...    ELSE
    ...    Setar null
    ${FAKE_NAME}=       Run keyword if      '${B_NAME}' == '${TRUE}'
    ...    FakerLibrary.Name
    ...    ELSE
    ...    Setar null
    ${FAKE_PWD}=        Run keyword if      '${B_PWD}' == '${TRUE}'
    ...    FakerLibrary.Password
    ...    ELSE
    ...    Setar null

    #-------------
    Build JSON    ${FAKE_EMAIL}    ${FAKE_NAME}   ${FAKE_PWD}

Build JSON
    [Arguments]     ${EMAIL}    ${NAME}     ${PWD}
    #Construindo o JSON
    ${DATA}=            create dictionary   name=${NAME}    email=${EMAIL}      password=${PWD}
    ${HEADER}=          create dictionary   Content-Type=${DEFAULT_CONTENT_TYPE}
    #Definindo como variáveis de testes em tempo de execução
    Set Test Variable   ${DATA}
    Set Test Variable   ${HEADER}

Setar null
    ${VAR}=     Set Variable    ${EMPTY}
    [Return]       ${VAR}

Enviar requisição
    [Documentation]     
    ...     Ao chamar essa keyword passar os parâmetros:
    ...     Tipo da requisição: get, put ou post
    ...     O payload em JSON
    ...     O header da requisição
    [Arguments]     ${TIPO}     ${DATA}     ${HEADER}

    #Fazendo a requisição POST e armazenando a resposta
    ${RESPONSE}=        Run keyword if      '${TIPO}' == 'post'
    ...    POST_API     ${DATA}     ${HEADER}
    
    log to console      ${RESPONSE.status_code}
    log to console      ${RESPONSE.content}
    Set Test Variable   ${RESPONSE}

POST_API    
   [Arguments]      ${DATA}     ${HEADER} 

   ${RESPONSE}=        POST On Session     mysession   ${DEFAULT_SIGNUP_ENDPOINT}  json=${DATA}    headers=${HEADER}
    # ${RESPONSE}=        Call Post Request     headers=${HEADER}   endpoint=${DEFAULT_URL}    fullstring=${DEFAULT_SIGNUP_ENDPOINT}   data=${DATA}
    # ${RESPONSE}=    POST        ${DEFAULT_SIGNUP_ENDPOINT}      ${DATA}
    # [Teardown]  Output  response body     ${OUTPUTDIR}/signup_response.json

   [Return]     ${RESPONSE}

Verificar status da response
    [Documentation]     
        ...     Ao chamar essa keyword passar o resultado experado da response:
        ...     Tipo inteiiro
    [Arguments]     ${STATUS}

    Status Should Be    ${STATUS}    ${RESPONSE}
    # Integer     response status           200

Verificar payload da resposta
    [Documentation]
    ...     Verifica se a resposta está de acordo com o schema definido pela api
    [Arguments]        ${EXPECTED_RESPONSE}     ${RESPONSE}

    #carrega o arquivo JSON
    ${EXPECTED_RESPONSE}=    OperatingSystem.Get File   ${EXECDIR}${/}${EXPECTED_RESPONSE}
    ${EXPECTED_RESPONSE}    evaluate    json.loads('''${EXPECTED_RESPONSE}''')    json
    log to console      ${EXPECTED_RESPONSE}
    log to console      ${RESPONSE}

    #valida schema
    validate    instance=${RESPONSE}    schema=${EXPECTED_RESPONSE}

    #valida keys
    ${RESPONSE_KEYS}=   Collections.Get Dictionary Keys       ${RESPONSE} 
    ${EXPECTED_RESPONSE_KEYS}=   Collections.Get Dictionary Keys       ${EXPECTED_RESPONSE}
    Should be Equal      ${RESPONSE_KEYS}     ${EXPECTED_RESPONSE_KEYS}

    #valida resposta esperada
    ${EXPECTED_RESPONSE}=   Construir resposta esperada     ${DATA}
    Dictionaries Should Be Equal        ${RESPONSE}    ${EXPECTED_RESPONSE}


    # Expect Response Body     ${EXPECTED_RESPONSE}
    # ${EXPECTED_RESPONSE}=    OperatingSystem.Get File   ${EXECDIR}${/}${JSONFILE}

    # Validate Response Contains Expected Response    ${RESPONSE.json()}      ${EXPECTED_RESPONSE}

Construir resposta esperada
    [Documentation]
    ...     Constroi o JSON da resposta esperada
    [Arguments]        ${EXPECTED_RESPONSE}

    # ${NOME}=    Get from Dictionary     ${EXPECTED_RESPONSE}     name
    # ${EMAIL}=    Get from Dictionary     ${EXPECTED_RESPONSE}     email
    # ${PWD}=    Get from Dictionary     ${EXPECTED_RESPONSE}     password
    # ${EXPECTED_RESPONSE_FILE}=      Create Dictionary   _id=${RESPONSE.json()["_id"]}   name=${NOME}    email=${EMAIL}      password=${RESPONSE.json()["password"]}     __v=${0}   
    Set to Dictionary   ${EXPECTED_RESPONSE}   _id=${RESPONSE.json()["_id"]}
    Set to Dictionary   ${EXPECTED_RESPONSE}    __v=${0}
    Set to Dictionary   ${EXPECTED_RESPONSE}    password=${RESPONSE.json()["password"]}

    [Return]    ${EXPECTED_RESPONSE}



