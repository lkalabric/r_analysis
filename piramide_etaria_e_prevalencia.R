# Estatística descritiva para análise de dados
# Trabalhando com arquivos .csv em R
# Autor: Luciano K. Silva
# Objetivo: Plotar um gráfico de pirâmide etária

# Configurando o diretório de trabalho
setwd("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/GitHub/r_analysis/datasets")

# Instalando bibliotecas necessários
list.of.packages <- c("ggplot2", "tidyverse", "dplyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Carregando bibliotecas necessários
library(tidyverse)
library(ggplot2)
library(dplyr)

# 1. Ler o arquivo CSV
dados <- read.csv("Figura 2 - All.csv")

# 2. Recodifica "idade" por faixas etárias de 10 em 10 anos e estratifica o dado por "study"
dados <- dados %>% 
  mutate(
    faixa_etaria = case_when(
      idade <= 10 ~ " 2-10",
      idade <= 20 ~ "11-20",
      idade <= 30 ~ "21-30",
      idade <= 40 ~ "31-40",
      idade <= 50 ~ "41-50",
      idade <= 60 ~ "51-60",
      idade <= 70 ~ "61-70",
      TRUE ~ "70+"
    )
  )

# 3. Plotar a pirâmide etária geral
ggplot(dados, aes(x = faixa_etaria, fill = factor(sexo))) +
  coord_flip() +
  geom_bar(data = subset(dados, sexo == 1), aes(y = ..count..), stat = "count") +
  geom_bar(data = subset(dados, sexo == 2), aes(y = -..count..), stat = "count") +
  #facet_wrap(~ study) +
  scale_fill_manual(values = c("1" = "blue", "2" = "red"),
                    labels = c("Male", "Female")) +
  labs(x = "Age group", y = "Frequency", fill = "Sex") +
  theme_minimal()

# 3.1 Plotar a pirâmide etária para cada estudo
ggplot(dados, aes(x = faixa_etaria, fill = factor(sexo))) +
  coord_flip() +
  geom_bar(data = subset(dados, sexo == 1), aes(y = ..count..), stat = "count") +
  geom_bar(data = subset(dados, sexo == 2), aes(y = -..count..), stat = "count") +
  scale_fill_manual(values = c("1" = "blue", "2" = "red"),
                    labels = c("Male", "Female")) +
  labs(x = "Age group", y = "Frequency", fill = "Sex") +
  facet_wrap(~ study) +
  theme_minimal()

# 4. Calcula a prevalência por faixa etária
prevalencia_por_idade <- dados %>% 
  group_by(faixa_etaria) %>%
  summarise(
    total = n(),
    sm = sum(sm_prev == 1),
    proporcao = round((sm * 100 / total), digits = 1)
  )

# 4.1 Plotar a pirâmide etária para cada estudo
ggplot(prevalencia_por_idade, aes(x = faixa_etaria, y = proporcao)) +
  coord_flip() +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(y = proporcao, label = proporcao), vjust = 0.5, hjust = 1.3) +
  labs(x = "Age group", y = "SM Prevalence (%)") +
  theme_minimal()

# 5. Calcula a prevalência por sexo e faixa etária
prevalencia_por_sexo_idade <- dados %>% 
  group_by(sexo, faixa_etaria) %>%
  summarise(
    total = n(),
    sm = sum(sm_prev == 1),
    proporcao = round((sm * 100 / total), digits = 1)
  )

# 5.1 Plotar a prevalência por sexo e faixa etária
ggplot(prevalencia_por_sexo_idade, aes(x = faixa_etaria, y = proporcao, fill = factor(sexo))) +
  coord_flip() +
  geom_bar(data = subset(prevalencia_por_sexo_idade, sexo == 1), aes(y = proporcao), stat = "identity", position = "dodge") +
  geom_text(data = subset(prevalencia_por_sexo_idade, sexo == 1), aes(y = proporcao, label = proporcao), vjust = 0.5, hjust = -0.1) +
  geom_bar(data = subset(prevalencia_por_sexo_idade, sexo == 2), aes(y = -proporcao), stat = "identity", position = "dodge") +
  geom_text(data = subset(prevalencia_por_sexo_idade, sexo == 2), aes(y = -proporcao, label = proporcao), vjust = 0.5, hjust = 1.2) +
  scale_fill_manual(values = c("1" = "blue", "2" = "red"),
                    labels = c("Male", "Female")) +
    labs(x = "Age group", y = "SM prevalence (%)", fill = "Sex") +
  #facet_wrap(~ study) +
  theme_minimal()

# 6. Calcula a prevalência por estudo
prevalencia_por_estudo <- dados %>% 
  group_by(study, faixa_etaria) %>%
  summarise(
    total = n(),
    sm = sum(sm_prev == 1),
    proporcao = round((sm * 100 / total), digits = 1)
  )

# 6.1 Plotar a prevalência por estudo
ggplot(prevalencia_por_estudo, aes(x = faixa_etaria, y = proporcao)) +
  coord_flip() +
    geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Age group", y = "SM prevalence (%)") +
  facet_wrap(~ study) +
  theme_minimal()

# 7. Calcula a prevalência por sexo, faixa etária e por estudo
prevalencia_por_agrupamento <- dados %>% 
  group_by(study, sexo, faixa_etaria) %>%
  summarise(
    total = n(),
    sm = sum(sm_prev == 1),
    proporcao = round((sm * 100 / total), digits = 1)
  )

# 7.1 Plotar a prevalência por sexo, faixa etária e por estudo
ggplot(prevalencia_por_agrupamento, aes(x = faixa_etaria, y = proporcao, fill = factor(sexo))) +
  coord_flip() +
    geom_bar(data = subset(prevalencia_por_agrupamento, sexo == 1), aes(y = proporcao), stat = "identity", position = "dodge") +
  geom_bar(data = subset(prevalencia_por_agrupamento, sexo == 2), aes(y = -proporcao), stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("1" = "blue", "2" = "red"),
                    labels = c("Male", "Female")) +
  labs(x = "Age group", y = "SM prevalence (%)", fill = "Sex") +
  facet_wrap(~ study) +
  theme_minimal()

