# Your code should look something like this:
#!/usr/bin/env Rscript
# library(RCurl)
# result <- postForm(
#   uri='https://redcap.chop.edu/api/',
#   token='SOME TEXT HERE',
#   content='project',
#   format='csv',
#   returnFormat='csv'
#)
#print(result)

# Install required packages, if not installed
list.of.packages <- c("RCurl")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Carregar as bilbiotecas requeridas
library(RCurl)

# Dados de acesso do projeto
api_token       <- '39169DDCCC39AED2489284B828E0A65A'
api_url         <- 'https://bdp.bahia.fiocruz.br/api/'

# Baixando dados a partir de um report de um projeto no REDCap
library(RCurl)

# Replace placeholders with your actual values
url <- "https://bdp.bahia.fiocruz.br/api/"
token <- "39169DDCCC39AED2489284B828E0A65A"
report_id <- "Tabela 1. Características dos participantes"
format <- "csv"

params <- list(
  token = token,
  content = "report",
  report_id = report_id,
  format = format
)

response <- getForm(url, .params = params)

# Write the response to a file
writeLines(response, "report_data.csv")

# Outra forma de acessar o servidor REDCap
result <- postForm(
 uri='https://bdp.bahia.fiocruz.br/api/',
 token='39169DDCCC39AED2489284B828E0A65A',
 content='project',
 format='csv',
 returnFormat='csv'
)
print(result)
