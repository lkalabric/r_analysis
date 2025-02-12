# Preparação do ambiente
list.of.packages <- c("tidyverse", "epiDisplay", "epitools")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Carregar as bibliotecas necessárias
library(tidyverse)
library(epiDisplay)
library(epitools)

# Ler os dados
dados <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1&2 - All.csv")

# Converter variáveis para fatores
dados$sexo <- as.factor(dados$sexo)
dados$nat1 <- as.factor(dados$nat1)
dados$sm_prev <- as.factor(dados$sm_prev)

# Análise univariada
tabela_sexo <- table(dados$sexo, dados$sm_prev)
tabela_nat1 <- table(dados$nat1, dados$sm_prev)

# Odds ratio crudo
or_sexo <- oddsratio(tabela_sexo)
or_nat1 <- oddsratio(tabela_nat1)

# Exibir resultados
cat("Análise Univariada:\n")
cat("Sexo:\n")
print(tabela_sexo)
print(or_sexo)
cat("\nNaturalidade:\n")
print(tabela_nat)
print(or_nat1)

# Razão de prevalência crua
rp_sexo <- riskratio(tabela_sexo)
rp_nat1 <- riskratio(tabela_nat1)

# Exibir resultados
cat("Análise Univariada:\n")
cat("Sexo:\n")
print(tabela_sexo)
print(rp_sexo)
cat("\nNaturalidade:\n")
print(tabela_nat1)
print(rp_nat1)

# Análise multivariada

# Converter valores de 1 e 2 para True e False
dados$sm_prev <- ifelse(dados$sm_prev == 1, TRUE, FALSE)
modelo <- glm(sm_prev ~ sexo + nat1, data = dados, family = poisson(link = "log"))

# Razão de prevalência ajustada
rp_ajustado <- exp(coef(modelo))

# Exibir resultados
cat("\nAnálise Multivariada:\n")
print(summary(modelo))
cat("\nRazão de Prevalência Ajustada:\n")
print(rp_ajustado)

# Análise multivariada
modelo <- glm(desfecho ~ sexo + nat, data = dados, family = binomial)

# Odds ratio ajustado
or_ajustado <- exp(coef(modelo))

# Exibir resultados
cat("\nAnálise Multivariada:\n")
print(summary(modelo))
cat("\nOdds Ratio Ajustado:\n")
print(or_ajustado)