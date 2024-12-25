#!/usr/bin/env Rscript

# Script Get API data 
# Link: https://www.dataquest.io/blog/r-api-tutorial/

# Instala as biblioteca básicas para conexão API no R
list.of.packages <- c("httr", "jsonlite")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Testa as bibliotecas
library(httr)
library(jsonlite)


setwd("C:/Users/kalab/OneDrive - FIOCRUZ/GitHub/r_analysis/redcap_analysis")
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
