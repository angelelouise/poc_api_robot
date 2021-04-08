***Keywords***

Que eu iniciei a sessão
    Criar sessão    mysession

Enviar uma requisição de cadastro de novo usuário
    Criar massa de dados do usuário
    Enviar requisição de cadastro de usuário        ${DATA}     ${HEADER}

O usuário deve ser cadastrado com sucesso
    Verificar status da resposta        200

Uma resposta deve ser retornada com a informação de id gerado pelo sistema  
    Verificar o id da resposta  

Com o nome cadastrado 
    Verificar o nome da resposta         ${DATA}

Com o email cadastrado     
    Verificar o email da resposta        ${DATA}

Com a senha cadastrada criptografada
    Verificar a senha da resposta   