***Settings***
Documentation   Arquivo que implementa a estrutura inicial do projeto de teste

Library         RequestsLibrary
Library         Collections
Library         BuiltIn
Library         FakerLibrary

#Fixtures
Resource       fixtures/api_variaveis.robot

#BDD definição de passos
Resource        ../steps_definitions/signup_bdd_steps.robot
Resource        ../steps_definitions/signup_bdd_steps_definitions.robot

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

