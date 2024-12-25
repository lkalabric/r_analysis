#!/usr/bin/env Rscript

# Script Get API data 
# Link: https://www.dataquest.io/blog/r-api-tutorial/

# Instala as biblioteca básicas para conexão API no R
install.packages(c("httr", "jsonlite"))inst

# Testa as bibliotecas
library(httr)
library(jsonlite)

# API Playground REDCap
#!/usr/bin/env Rscript
token <- "39169DDCCC39AED2489284B828E0A65A"
url <- "https://bdp.bahia.fiocruz.br/api/"
formData <- list("token"=token,
    content='project',
    format='json',
    returnFormat='json'
)
response <- httr::POST(url, body = formData, encode = "form")
result <- httr::content(response)
print(result)


# Export records to R
install.packages("RCurl")

source('config.R')
library(RCurl)
result <- postForm(
    api_url,
    token=api_token,
    content='record',
    format='json',
    type='flat'
)
print(result)
