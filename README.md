# monitora-team-pipelines
Workflow para construir produtos de dados do programa Monitora, protocolo TEAM. O principal objetivo desse workflow é transformar os dados do programa Monitora em Variáveis Essenciais de Biodiversidade - EBVs. EBVs são medidas padronizadas usadas para monitorar e relatar mudanças na biodiversidade global. Eles atuam como camada intermediária entre os dados brutos obtidos em campo, e indicadores agregados de biodiversidade [Kissling et al. 2017]([https://github.com/elildojr/Wildlife-Insights---Analytics](https://onlinelibrary.wiley.com/doi/full/10.1111/brv.12359)).

Primeiramente, os dados passam por um controle de qualidade rudimentar, visando garantir sua consistência em termos de formatos de tempo, coordenadas espaciais e taxonomia, de forma a transforma-los em dados utilizáveis para EBV ("EBV-usable data sets"). Em seguida, os dados são modelados para gerar dados compatíveis com EBV ("EBV-ready data"), passíveis de uso na produção de índices agregados de tendências de biodiversidade.


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
