# monitora-team-pipelines
Workflow para construir produtos de dados do programa Monitora, protocolo TEAM


## ESTRUTURA DO DIRETÓRIO

``` bash
├───input
├───script
│   ├───01_aggregate_raw_data_sources
│   ├───02_check_data_consistency
│   ├───03_check_taxonomy
│   └───funcoes
├───R
└───output
```

## NOTA AOS COLABORADORES

Para todas as funções, nomes de objetos, etc, usar o [Tidyverse style guide](https://style.tidyverse.org/)
Criar novos branches para modificações

## WORKFLOW

Agregação dos dados brutos, baixados diretamente da plataforma [Wildlife Insights](https://app.wildlifeinsights.org)

Controle de qualidade dos dados (coordenadas, data e hora, correção de erros, identificações incorretas, duplicações)

Harmonização taxonômica


# Contato

[elildojr\@gmail.com](mailto:elildojr@gmail.com)
