#!/usr/bin/env Rscript

# Script Get API data 
# Link: https://www.dataquest.io/blog/r-api-tutorial/

# Instala as biblioteca básicas para conexão API no R
list.of.packages <- c("httr", "jsonlite", "ggplot2", "dplyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Testa as bibliotecas
library(httr)
library(jsonlite)

# Caminho da minha casa
#setwd("C:/Users/kalab/OneDrive - FIOCRUZ/GitHub/r_analysis/redcap_analysis")
#source("config.R")   # Lê api_token e api_url do projeto

# Caminho Fiocruz
setwd("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/GitHub/r_analysis")
source("config.R")   # Lê api_token e api_url do projeto


## API Playground REDCap

# Export Project Information
formData <- list("token"=api_token,
    content='project',
    format='json',
    returnFormat='json'
)
response <- httr::POST(api_url, body = formData, encode = "form")
project <- httr::content(response)
print(project)

# Export Records
formData <- list("token"=api_token,
                 content='record',
                 format='csv',
                 type='flat'
)
response <- httr::POST(api_url, body = formData, encode = "form")
result_df <- httr::content(response)

# Estatísticas descritivas dos nossos dados
table(result_df$sexo)
summary(result_df$idade)


# Apresentando os dados num gráfico de pizza
library(ggplot2)

# Criando um novo dataframe com os rótulos
result_df$sexo <- factor(result_df$sexo, levels = c(1, 2), labels = c("Masculino", "Feminino"))

library(dplyr)
# Filtrando os dados para remover os NA
result_filtrado <- result_df %>% 
  filter(!is.na(sexo))


# Criar o gráfico de pizza
ggplot(result_filtrado, aes(x = "", fill = sexo)) +
  geom_bar(width = 1) +
  coord_polar("y", start=0) +
  labs(title = "Distribuição por Sexo", fill = "Sexo")

# Criar tabelas em R
# Link: https://www.youtube.com/watch?v=xI8f0kUnmF0


# Export records to R
# A biblioteca RCurl está dando erro no R, mas funcionou no Google Colab!!!
install.packages("RCurl")

setwd("C:/Users/kalab/OneDrive - FIOCRUZ/GitHub/r_analysis")
source("config.R")
library(RCurl)
result <- postForm(
    api_url,
    token=api_token,
    content='record',
    format='json',
    type='flat'
)
print(result)
