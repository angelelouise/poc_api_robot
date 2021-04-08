***Keywords***

Criar sessão
    [Arguments]     ${NAME_SESSION}

    Create Session      ${NAME_SESSION}     ${DEFAULT_URL}

Criar massa de dados do usuário
    #utilizando da biblioteca FakerLibrary para criar a massa de dados
    ${FAKE_NAME}=       FakerLibrary.Name
    ${FAKE_EMAIL}=      FakerLibrary.Email
    ${FAKE_PWD}=        FakerLibrary.Password
    #-------------
    #Construindo o JSON
    ${DATA}=            create dictionary   name=${FAKE_NAME}    email=${FAKE_EMAIL}      password=${FAKE_PWD}
    ${HEADER}=          create dictionary   Content-Type=${DEFAULT_CONTENT_TYPE}
    #Definindo como variáveis de testes em tempo de execução
    Set Test Variable   ${DATA}
    Set Test Variable   ${HEADER}

Enviar requisição de cadastro de usuário
    [Arguments]     ${JSON}     ${HEADER}

    #Fazendo a requisição POST e armazenando a resposta
    ${RESPONSE}=        POST On Session     mysession   ${DEFAULT_SIGNUP_ENDPOINT}  json=${JSON}    headers=${HEADER}

    log to console      ${RESPONSE.status_code}
    log to console      ${RESPONSE.content}
    Set Test Variable   ${RESPONSE}

Verificar status da resposta
    [Arguments]     ${STATUS}

    Status Should Be    ${STATUS}    ${RESPONSE}

Verificar o id da resposta
    Dictionary Should Contain Key        ${RESPONSE.json()}     _id

Verificar o nome da resposta
    [Arguments]        ${NOME}

    ${NOME}=    Get from Dictionary     ${NOME}     name
    Dictionary Should Contain Item       ${RESPONSE.json()}     name      ${NOME}   

Verificar o email da resposta 
    [Arguments]        ${EMAIL}

    ${EMAIL}=    Get from Dictionary     ${EMAIL}     email
    Dictionary Should Contain Item       ${RESPONSE.json()}     email      ${EMAIL}

Verificar a senha da resposta
    Dictionary Should Contain Key        ${RESPONSE.json()}     password