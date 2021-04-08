***Settings***

Documentation   Testes do endpoint de criar novo usuário (signup)

Resource       ../resources/setup.robot

#Suite Setup     Create Session    jsonplaceholder    https://jsonplaceholder.typicode.com

***Test Cases***

Cenário 01: Criar novo usuário
    Dado que eu iniciei a sessão
    Quando enviar uma requisição de cadastro de novo usuário
    Então o usuário deve ser cadastrado com sucesso
    E uma resposta deve ser retornada com a informação de id gerado pelo sistema 
    E com o nome cadastrado
    E com o email cadastrado
    E com a senha cadastrada criptografada