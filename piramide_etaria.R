install.packages("ggplot2")
install.packages("tidyverse")

# Carregando as bibliotecas necessárias
library(tidyverse)
library(ggplot2)

# Configurando o diretório de trabalho
setwd("C:/Users/kalab/OneDrive/Documentos/GitHub/r_analysis")

library(ggplot2)
library(tidyverse)

# 1. Ler o arquivo CSV
dados <- read.csv("dados_demograficos.csv")

# 2. Estratificar os dados por "study" e criar faixas etárias de 10 em 10 anos
dados <- dados %>% 
  mutate(faixa_etaria = cut(idade, breaks = seq(0, 100, by = 10))) %>%
  group_by(study, faixa_etaria, sexo) %>%
  summarise(n = n())

# 3. Plotar as pirâmides etárias
ggplot(dados, aes(x = faixa_etaria, y = n, fill = factor(sexo))) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ study) +
  coord_flip() +
  scale_y_continuous(labels = abs) +
  labs(x = "Faixa Etária", y = "Frequência", fill = "Sexo") +
  ggtitle("Pirâmides Etárias por Estudo") +
  theme_minimal()
