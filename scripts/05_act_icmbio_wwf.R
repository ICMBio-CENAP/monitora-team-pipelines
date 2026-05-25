# clean environment
rm(list=ls())


#----- load libraries
library(here)
library(tidyverse)


# read pre-processed data
rn_data_gurupi <- readRDS(here("output","rn_data_gurupi.rds"))
rn_data_jamari <- readRDS(here("output","rn_data_jamari.rds"))
rn_data_juruena <- readRDS(here("output","rn_data_juruena.rds"))
#rn_data_maraca <- readRDS(here("output","rn_data_maraca.rds"))
rn_data_tdm <- readRDS(here("output","rn_data_tdm.rds"))

# save results
out_gurupi <- readRDS(here("output", "model_gurupi.rds"))
out_jamari <- readRDS(here("output", "model_jamari.rds"))
out_juruena <- readRDS(here("output", "model_juruena.rds"))
#out_maraca <- readRDS(here("output", "model_maraca.rds"))
out_tdm <- readRDS(here("output", "model_tdm.rds"))


florestal_fixed_taxonomy <- readRDS(here("output", "florestal_fixed_taxonomy.rds"))
projects <- florestal_fixed_taxonomy$projects
deployments <- florestal_fixed_taxonomy$deployments
rm(florestal_fixed_taxonomy)

coordinates <- deployments %>% 
  group_by(project_id) %>%
  summarise(latitude = mean(latitude),
            longitude = mean(longitude)) %>%
  left_join(projects, by = "project_id") %>%
  print()


#----- get abundances only for sampled years
# abundance for unsampled years should be NA
N_gurupi <- tibble(especie = unique(rn_data_gurupi$species),
            uc = "Reserva Biologica do Gurupi") %>%
  bind_cols(round(apply(out_gurupi$sims.list$N, c(2,4), mean),2)) %>%
  rename_with(~ as.character(c(2016:2025)), .cols = c(3:12)) %>%
  pivot_longer(cols = -c(1,2),  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano)) %>%
  left_join(tibble(ano = sort(unique(rn_data_gurupi$sampling_event)),
                   amostrado = "sim")) %>%
  mutate(n = case_when(amostrado == "sim" ~ n,
                       .default = NA)) %>%
  select(-amostrado) %>%
  mutate(lat = coordinates$latitude[1],
         lon = coordinates$longitude[1]) %>%
  print()


N_jamari <- tibble(especie = unique(rn_data_jamari$species),
                   uc = "Floresta Nacional do Jamari") %>%
  bind_cols(round(apply(out_jamari$sims.list$N, c(2,4), mean),2)) %>%
  rename_with(~ as.character(c(2016:2024)), .cols = c(3:11)) %>%
  pivot_longer(cols = -c(1,2),  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano)) %>%
  left_join(tibble(ano = sort(unique(rn_data_jamari$sampling_event)),
                   amostrado = "sim")) %>%
  mutate(n = case_when(amostrado == "sim" ~ n,
                       .default = NA)) %>%
  mutate(lat = coordinates$latitude[3],
         lon = coordinates$longitude[3]) %>%
  
  select(-amostrado) %>%
  print()


N_juruena <- tibble(especie = unique(rn_data_juruena$species),
                   uc = "Parque Nacional do Juruena") %>%
  bind_cols(round(apply(out_juruena$sims.list$N, c(2,4), mean),2)) %>%
  rename_with(~ as.character(c(2016:2024)), .cols = c(3:11)) %>%
  pivot_longer(cols = -c(1,2),  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano)) %>%
  left_join(tibble(ano = sort(unique(rn_data_juruena$sampling_event)),
                   amostrado = "sim")) %>%
  mutate(n = case_when(amostrado == "sim" ~ n,
                       .default = NA)) %>%
  select(-amostrado) %>%
  mutate(lat = coordinates$latitude[4],
         lon = coordinates$longitude[4]) %>%
  print()

N_tdm <- tibble(especie = unique(rn_data_tdm$species),
                    uc = "Estação Ecológica da Terra do Meio") %>%
  bind_cols(round(apply(out_tdm$sims.list$N, c(2,4), mean),2)) %>%
  rename_with(~ as.character(c(2016:2018)), .cols = c(3:5)) %>%
  pivot_longer(cols = -c(1,2),  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano)) %>%
  left_join(tibble(ano = sort(unique(rn_data_tdm$sampling_event)),
                   amostrado = "sim")) %>%
  mutate(n = case_when(amostrado == "sim" ~ n,
                       .default = NA)) %>%
  select(-amostrado) %>%
  mutate(lat = coordinates$latitude[2],
         lon = coordinates$longitude[2]) %>%
  print()


# join all
team_trends <- bind_rows(N_gurupi, N_jamari, N_juruena, N_tdm) %>%
  drop_na()


# plot site-level abundances
team_trends %>%
  mutate(pop = paste(especie, uc, sep = " ")) %>%
  ggplot(aes(x = ano, y = n, group = pop)) +
  geom_line() +
  facet_wrap(~ pop, scales = "free_y") +
  expand_limits(y = 0) +
  #scale_x_continuous(breaks = scales::breaks_pretty(n=5)) +
  scale_x_continuous(breaks = seq(2016, 2025, by = 2)) +
  labs(y = "Abundancia relativa", x = "")


# plot site-level abundances
team_trends %>%
  mutate(pop = paste(especie, uc, sep = " ")) %>%
  group_by(pop) %>%
  mutate(nstd = n/first(n)) %>%
  ggplot(aes(x = ano, y = nstd, group = pop)) +
  geom_smooth(span = 0.5, se = FALSE, 
              linewidth = 0.5, color = "darkgrey") +
  expand_limits(y = 0) +
  scale_x_continuous(breaks = seq(2016, 2025, by = 2)) +
  labs(y = "Abundancia relativa", x = "")

team_trends %>%
  filter(n == 0)


team_trends %>%
  mutate(pop = paste(especie, uc, sep = " ")) %>%
  group_by(pop) %>%
  mutate(nstd = n/first(n)) %>%
  ggplot(aes(x = ano, y = n, group = pop)) +
  geom_smooth(se = FALSE, linewidth = 0.5, color = "grey") +
  expand_limits(y = 0) +
  scale_x_continuous(breaks = seq(2016, 2025, by = 2)) +
  labs(y = "Abundancia relativa", x = "")


# complete years
monitora_icmbio_team_trends <- team_trends %>%
  filter(especie != "Geotrygon montana") %>%
  complete(nesting(uc, lat, lon, especie),
         ano = 1970:2025) %>%
  pivot_wider(names_from = ano,
              values_from = n) %>%
  mutate("ID" = NA,
         "Data source full citation" = "verificar com COMOB, talvez ICMBio ou CENAP ou Carvalho Jr E.A.R.  (2026) unpublished",
         "Purpose of monitoring (if known)" = "verificar com COMOB",
         "Species (Scientific name)" = especie,
         "Taxonomic authority species is based on (provide link)" = "https://github.com/ConservationInternational/Wildlife-Insights----Data-Migration/tree/master/WI_Global_Taxonomy",
         "Location of Population" = uc,
         "Latitude" = lat,
         "Longitude" = lon,
         "Is lat/long for specific location?" = "Centroid of sampling array",
         "Is it a migratory population? - Y/N/Unknown/Partially (for when a proportion of the population is migratory but another is resident)" = "N",
         "Is population in a protected area? (Yes/No/Unknown)" = "Yes",
         "Protected area name (in English if available) or in original language\n" = uc,
         "Is the population utilised?" = NA,
         "Are any conservation actions in place to protect the population?" = NA,
         "What threats, if any, are impacting the population?" = NA,
         "Notes (include here if the species is referred to with a different binomial in the paper, how the data has been transformed and where it has been taken from e.g. Figure 3, in text on page 5 etc.)" = "Relative abundances estimated using the Bernoulli-Poisson (BernP) mixture model (“Royle-Nichols model”)",
         "Units (what the population values represent)" = "Number of individuals (average)",
         "Method (how the data were collected)" = "Camera-trap (TEAM protocol)") %>%
  select(61:78, 5:60) %>%
  print()


View(monitora_icmbio_team_trends)

write.csv(monitora_icmbio_team_trends, here("output", "cenap_monitora_team_lpi_data.csv"), row.names = FALSE)


