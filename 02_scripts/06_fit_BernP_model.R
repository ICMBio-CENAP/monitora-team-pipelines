
# clean environment
rm(list=ls())


#----- setup
source("02_scripts/00_setup.R")


# read pre-processed data
gurupi <- readRDS("01_entrada/dados_processados/BernP_data_gurupi.rds")
jamari <- readRDS("01_entrada/dados_processados/BernP_data_jamari.rds")
juruena <- readRDS("01_entrada/dados_processados/BernP_data_juruena.rds")
maraca <- readRDS("01_entrada/dados_processados/BernP_data_maraca.rds")
tdm <- readRDS("01_entrada/dados_processados/BernP_data_tdm.rds")


# fit BernP model
out_gurupi <- fit_BernP(gurupi, 2016, 2025)
out_jamari <- fit_BernP(jamari, 2016, 2024)
out_juruena <- fit_BernP(juruena, 2016, 2024)
out_maraca <- fit_BernP(maraca, 2018, 2021)
out_tdm <- fit_BernP(tdm, 2016, 2023)



# save results
saveRDS(out_gurupi, "03_saida/model_gurupi.rds")
saveRDS(out_jamari, "03_saida/model_jamari.rds")
saveRDS(out_juruena, "03_saida/model_juruena.rds")
saveRDS(out_maraca, "03_saida/model_maraca.rds")
saveRDS(out_tdm, "03_saida/model_tdm")



##----- check convergence -----

out <- out_gurupi

out$summary
hist(out$summary[,"Rhat"], main = "", xlab = "Rhat")
abline(v = 1.1, lty = "dashed", lwd = 2, col = "red")
# which parameters did not converged?
length(out$summary[which(out$summary[,"Rhat"] > 1.1),])
round(length(out$summary[which(out$summary[,"Rhat"] > 1.1),])/length(out$summary),2)

#traceplot(out, parameters = c("N"))
#traceplot(out, parameters = c("r"))


##----- check results -----

# check detection
str(out$sims.list$r)
hist(apply(out$sims.list$r, 2, mean),
     main = "Per-individual/species detectability",
     xlab = "Detection probability")

str(out$sims.list$p)
hist(apply(out$sims.list$p, 2, mean, na.rm=TRUE),
     main = "Species detectability",
     xlab = "Detection probability")

# check abundances
str(out$sims.list$N)

# check average species abundance
# just to see if there are crazy local abundances
hist(apply(out$sims.list$N, 2, mean),
     main = "",
     xlab = "Average relative abundance")

# get site-level abundance data for each species and year
N <- tibble(especie = unique(gurupi$species)) %>%
  bind_cols(round(apply(out$sims.list$N, c(2,4), mean),2)) %>%
  rename_with(~ as.character(c(2016:2025)), .cols = c(2:11)) %>%
  print()

# plot site-level abundances
N %>%
  pivot_longer(cols = -1,  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano)) %>%
  ggplot(aes(x = ano, y = n, group = especie)) +
  geom_line() +
  facet_wrap(~especie, scales = "free_y") +
  expand_limits(y = 0) +
  #scale_x_continuous(breaks = scales::breaks_pretty(n=5)) +
  scale_x_continuous(breaks = seq(2016, 2025, by = 2)) +
  labs(y = "Abundancia relativa", x = "")


# get PA-level abundance data for each species and year
Nhat <- tibble(especie = unique(gurupi$species)) %>%
  bind_cols(round(apply(out$sims.list$Nhat, c(2,3), mean),2)) %>%
  rename_with(~ as.character(c(2016:2025)), .cols = c(2:11)) %>%
  print()

# plot PA-level abundances
Nhat %>%
  pivot_longer(cols = -1,  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano)) %>%
  ggplot(aes(x = ano, y = n, group = especie)) +
  geom_line() +
  facet_wrap(~especie, scales = "free_y") +
  expand_limits(y = 0) +
  #scale_x_continuous(breaks = scales::breaks_pretty(n=5)) +
  scale_x_continuous(breaks = seq(2016, 2025, by = 2)) +
  labs(y = "Abundancia relativa", x = "")



#----- get abundances only for sampled years
# abundance for unsampled years should be NA
N %>%
  pivot_longer(cols = -1,  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano))

tibble(ano = sort(unique(gurupi$sampling_event)),
       sampled = "yes")

N <- tibble(especie = unique(gurupi$species),
            uc = "Reserva Biologica do Gurupi") %>%
  bind_cols(round(apply(out$sims.list$N, c(2,4), mean),2)) %>%
  rename_with(~ as.character(c(2016:2025)), .cols = c(3:12)) %>%
  pivot_longer(cols = -c(1,2),  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano)) %>%
  left_join(tibble(ano = sort(unique(gurupi$sampling_event)),
                   amostrado = "sim")) %>%
  mutate(n = case_when(amostrado == "sim" ~ n,
                       .default = NA)) %>%
  select(-amostrado) %>%
  print()
