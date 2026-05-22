# monitora-team-pipelines
Workflow para construir produtos de dados do programa Monitora, protocolo TEAM. O principal objetivo desse workflow é transformar os dados do programa Monitora em Variáveis Essenciais de Biodiversidade - EBVs. EBVs são medidas padronizadas usadas para monitorar e relatar mudanças na biodiversidade global. Eles atuam como camada intermediária entre os dados brutos obtidos em campo, e indicadores agregados de biodiversidade, de mais alto nivel (e.g., [Kissling et al., 2017](https://doi.org/10.1111/brv.12359)).

Primeiramente, os dados passam por um controle de qualidade, visando garantir sua consistência em termos de formatos de data e hora, coordenadas espaciais e taxonomia, de forma a se tornarem dados utilizáveis para EBV ("EBV-usable data sets"). Em seguida, os dados são inseridos em modelos populacionais para gerar dados compatíveis com EBV ("EBV-ready data"), isto é, dados passíveis de serem utilizados na produção de índices agregados de tendências de biodiversidade, como o Living Planet Index - LPI, e outros.


## Estrutura do diretório

``` bash
├───input
├───script
│   ├───01_aggregate_raw_data_sources
│   ├───02a_check_coordinates
    ├───02b_check_dates
│   ├───03_prep_rn_data
│   ├───04a_fit_rn_gurupi
│   ├───04b_fit_rn_tdm
│   ├───04c_fit_rn_jamari
│   ├───04d_fit_rn_juruena
│   ├───04e_fit_rn_maraca
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
