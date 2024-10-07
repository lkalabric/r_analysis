
# Configurando o diretório de trabalho
setwd("C:/Users/kalab/OneDrive/Documentos/GitHub/r_analysis")

# Instalando e carregando bibliotecas necessários
install.packages("ggplot2")
install.packages("tidyverse")
library(tidyverse)
library(ggplot2)

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

ggplot(dados, aes(x = faixa_etaria, y = n, fill = factor(sexo))) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_bar(data = subset(dados, sexo == 1), aes(y = -..count..), stat = "count") +
  geom_bar(data = subset(dados, sexo == 2), aes(y = ..count..), stat = "count") +
  facet_wrap(~ study) +
  coord_flip() +
  scale_y_continuous(labels = abs) +
  labs(x = "Faixa Etária", y = "Frequência", fill = "Sexo") +
  ggtitle("Pirâmides Etárias por Estudo") +
  theme_minimal()

# Carregar os dados
dados <- read.csv("dados_demograficos.csv")

# Limpar os dados (opcional, ajustar de acordo com a necessidade)
dados <- dados %>%
  filter(!is.na(sexo), !is.na(idade), !is.na(study))

# Criar faixas etárias
dados <- dados %>%
  mutate(faixa_etaria = cut(idade, breaks = seq(0, 100, by = 10), right = FALSE))

# Plotar a pirâmide etária para cada estudo
ggplot(dados, aes(x = faixa_etaria, fill = factor(sexo))) +
  geom_bar(data = subset(dados, sexo == 1), aes(y = -..count..), stat = "count") +
  geom_bar(data = subset(dados, sexo == 2), aes(y = ..count..), stat = "count") +
  facet_wrap(~ study) +
  scale_fill_manual(values = c("1" = "blue", "2" = "red"),
                    labels = c("Masculino", "Feminino")) +
  coord_flip() +
  labs(x = "Faixa Etária", y = "Frequência", fill = "Sexo") +
  theme_minimal()

