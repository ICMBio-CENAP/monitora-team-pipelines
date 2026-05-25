
# clean environment
rm(list=ls())


#----- load libraries
library(here)
library(tidyverse)
library(jagsUI)

# read pre-processed data
rn_data_tdm <- readRDS(here("output","rn_data_tdm.rds"))

# use only first 3 years (array 1)
rn_data_tdm <- rn_data_tdm %>%
  filter(sampling_event <= 2018)

# teste para ver se roda
# problema na funcao que cria objeto para rn:
#rn_data_tdm[1746,] # y > trials...


site <- as.numeric(dense_rank(rn_data_tdm$placename))
species <- as.numeric(dense_rank(rn_data_tdm$species))
year <- match(rn_data_tdm$sampling_event, 2016:2023)
trials <- as.numeric(rn_data_tdm$trials)
y <- as.numeric(rn_data_tdm$y)

#rm(rn_data_2002545)

min(rn_data_tdm$sampling_event)
max(rn_data_tdm$sampling_event)

# bundle data
jags_data = list(site = site,
                 nsite = length(unique(site)),
                 species = species,
                 nsp = length(unique(species)),
                 year = year,
                 nyear = max(year),
                 nobs = length(y),
                 trials = trials,
                 y = y)



##----- Specify model in JAGS language -----
# dynamic N-occupancy model adapted from Rossman et al 2016
# potential source for improving codes:
# https://github.com/zipkinlab/Farr_etal_2022_ConsBiol/blob/master/DataAnalysis/CaseStudy/Model.R

sink(here("scripts", "rn_model.txt"))
cat("
model {
  
  
  ## Priors
  
  ## community-level priors
    
    # abundance intercept
    mu.alpha0 ~ dunif(-10,10)
    sd.alpha0 ~ dunif(0,2)
    tau.alpha0 <- 1/(sd.alpha0*sd.alpha0)
    
    # time effect
    mu.alpha1 ~ dunif(-10,10)
    sd.alpha1 ~ dunif(0,2)
    tau.alpha1 <- 1/(sd.alpha1*sd.alpha1)
    
    # detection
    mu.r ~ dunif(-2,2)
    sd.r ~ dunif(0,2)
    tau.r <- 1/(sd.r*sd.r)
    

  ## species-level priors
    
    for(i in 1:nsp){
    
      # average species abundance
      alpha0.sp[i] ~ dnorm(mu.alpha0,tau.alpha0)
      
      # time effect
      alpha1.sp[i] ~ dnorm(mu.alpha1,tau.alpha0)
      
      # average species detection
      r.sp[i] ~ dnorm(mu.r,tau.r)
      logit(r[i]) <- r.sp[i]
      
      # random site effects
      for (j in 1:nsite){
        eps.site[i,j] ~ dnorm(mu.eps.site, tau.eps.site)
        }#j
      
    }#i

  # hyperparameter for random site effects
  mu.eps.site ~ dnorm(0, 0.01)
  tau.eps.site <- 1 / (sd.eps.site*sd.eps.site)
  sd.eps.site ~ dunif(0, 2)

  ## Likelihood

  for(i in 1:nsp){
   for(j in 1:nsite){
    for(k in 1:nyear){
  
    # abundance
    log(lambda[i,j,k]) <- alpha0.sp[i] + alpha1.sp[i]*year[k] + eps.site[i,j]
    N[i,j,k] ~ dpois(lambda[i,j,k])
    
      }#k
    }#j
  }#i
    
    
  ## detection model
    for(i in 1:nobs){

        p[species[i],site[i],year[i]] <- 1-pow(1-r[species[i]], N[ species[i],site[i],year[i] ])
        y[i] ~ dbin(p[species[i],site[i],year[i]], trials[i])
        
        }#i

    
    # derived parameters
    # PA-level population abundance per year
    for(i in 1:nsp){
      for (k in 1:nyear){
        Nhat[i,k] <- sum(N[i,1:nsite,k])
      }#t
    #for (k in 2:nyear){
    #  growth_rate[i,k] <- Nhat[i,k]/(Nhat[i,k-1])
    #}#k
      
    }#i


}",fill=TRUE)
sink()


##----- fit model -----#


parameters <- c("r", "p",  "N", "Nhat")


# inits
#Nst <- apply(jags_data$y, 1, max)
#inits <- function()list(#N = jags_data$y,
#  #lambda = runif(jags_data$nSites, 1,3),
#  alpha_p = 0.1,#runif(1, 0.1, 0.1),
#  beta_p = 100)#runif(1, 0.1, 50))



# fit model
out <- jags(jags_data, inits=NULL, parameters,
            here("scripts", "rn_model.txt"),
            n.chain=3, n.burnin=10000, n.iter=30000, n.thin=250)
#n.chain=3, n.burnin=1500, n.iter=5000, n.thin=15)
#n.chain=3, n.burnin=25000, n.iter=50000, n.thin=100)
#n.chain=3, n.burnin=50000, n.iter=150000, n.thin=100)


# save results
saveRDS(out, here("output", "model_tdm.rds"))


##----- check convergence -----

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
N <- tibble(especie = unique(rn_data_tdm$species)) %>%
  bind_cols(round(apply(out$sims.list$N, c(2,4), mean),2)) %>%
  rename_with(~ as.character(c(2016:2018)), .cols = c(2:4)) %>%
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
  #scale_x_continuous(breaks = seq(2016, 2018, by = 2)) +
  labs(y = "Abundancia relativa", x = "")


# get PA-level abundance data for each species and year
Nhat <- tibble(especie = unique(rn_data_tdm$species)) %>%
  bind_cols(round(apply(out$sims.list$Nhat, c(2,3), mean),2)) %>%
  rename_with(~ as.character(c(2016:2018)), .cols = c(2:4)) %>%
  print()

# plot PA-level abundances
Nhat %>%
  pivot_longer(cols = -1,  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano)) %>%
  ggplot(aes(x = ano, y = n, group = especie)) +
  geom_line() +
  facet_wrap(~especie, scales = "free_y") +
  expand_limits(y = 0) +
  #scale_x_continuous(breaks = seq(2016, 2018, by = 2)) +
  labs(y = "Abundancia relativa", x = "")


#----- get abundances only for sampled years
# abundance for unsampled years should be NA

N %>%
  pivot_longer(cols = -1,  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano))

tibble(ano = sort(unique(rn_data_tdm$sampling_event)),
       sampled = "yes")

N <- tibble(especie = unique(rn_data_tdm$species),
            uc = "Estação Ecológica da Terra do Meio") %>%
  bind_cols(round(apply(out$sims.list$N, c(2,4), mean),2)) %>%
  rename_with(~ as.character(c(2016:2018)), .cols = c(3:5)) %>%
  pivot_longer(cols = -c(1,2),  names_to = "ano", values_to = "n") %>%
  mutate(ano = as.numeric(ano)) %>%
  left_join(tibble(ano = sort(unique(rn_data_tdm$sampling_event)),
                   amostrado = "sim")) %>%
  mutate(n = case_when(amostrado == "sim" ~ n,
                       .default = NA)) %>%
  select(-amostrado) %>%
  print()
