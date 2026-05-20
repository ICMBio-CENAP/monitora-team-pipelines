# monitora-team-pipelines
Workflow para construir produtos de dados do programa Monitora, protocolo TEAM


## Estrutura do diretório

``` bash
├───input
├───script
│   ├───01_aggregate_raw_data_sources
│   ├───02a_check_coordinates
    ├───02b_check_dates
│   ├───02c_check_taxonomy
├───R
└───output
```

## Nota aos colaboradores

Para todas as funções, nomes de objetos, etc, usar o [Tidyverse style guide](https://style.tidyverse.org/)
Criar novos branches para modificações

## Workflow

Agregação dos dados brutos, baixados diretamente da plataforma [Wildlife Insights](https://app.wildlifeinsights.org)

Controle de qualidade dos dados (coordenadas, data e hora, correção de erros, identificações incorretas, duplicações)

Harmonização taxonômica


## Nota sobre os dados:
Arquivos .csv e .rds não foram incluídos neste repositório para evitar lentidão no Git e respeitar os limites de armazenamento do GitHub.
Assim, este repositório contém apenas o código necessário para processar os dados, assumindo que os arquivos de entrada estejam disponíveis localmente no diretório principal do repositório.


# Contato

[elildojr\@gmail.com](mailto:elildojr@gmail.com)
