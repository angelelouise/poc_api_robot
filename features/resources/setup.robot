***Settings***
Documentation   Arquivo que implementa a estrutura inicial do projeto de teste

Library         RequestsLibrary
Library         Collections
Library         BuiltIn
Library         FakerLibrary
Library         OperatingSystem
Library         JsonValidator
#Library         REST    http://18.189.43.194:3333 
Library         jsonschema  

#Fixtures
Resource        fixtures/api_variaveis.robot
Resource       fixtures/api_mensagens.robot

#BDD definição de passos
Resource        ../steps_definitions/signup_bdd_steps.robot
Resource        ../steps_definitions/signup_bdd_steps_definitions.robot

#Teste
Resource        ../bdd_testcase/signup_bdd_testcase.robot
Resource        ../bdd_testcase/signup_testcase.robot


***Keywords***
#Configuração do gherkin para pt-br

Dado ${keyword}
    Run keyword     ${keyword}
Quando ${keyword}
    Run keyword     ${keyword}
Então ${keyword}
    Run keyword     ${keyword}
E ${keyword}
    Run keyword     ${keyword}

# configuração teste

Cenario ${identificador}
    Run keyword     ${identificador}