## To cite bibliometrix in publications, please use:
## 
## Aria, M. & Cuccurullo, C. (2017) bibliometrix: An R-tool for comprehensive science mapping analysis, 
##                                  Journal of Informetrics, 11(4), pp 959-975, Elsevier.
##                         
## 
## https://www.bibliometrix.org
## 
##                         
## For information and bug reports:
##                         - Send an email to info@bibliometrix.org   
##                         - Write a post on https://github.com/massimoaria/bibliometrix/issues
##                         
## Help us to keep Bibliometrix free to download and use by contributing with a small donation to support our research team (https://bibliometrix.org/donate.html)
## 
##                         
## To start with the shiny web-interface, please digit:
## biblioshiny()

# Links: 
# https://rstudio-pubs-static.s3.amazonaws.com/1048400_41fe0b9bc8f2443c872918e7aafa71e6.html
# https://github.com/jalvesaq/PontuarLattes


install.packages("bibliometrix")
library(bibliometrix)   ### load bibliometrix package

install.packages("remotes")         
remotes::install_github("massimoaria/bibliometrix")

setwd("C:/Users/kalab/OneDrive - FIOCRUZ/GitHub/r_analysis/datasets")
file <- "LKS_savedrecs.bib"
#file <- "https://www.bibliometrix.org/datasets/savedrecs.bib"

M <- convert2df(file = file, dbsource = "isi", format = "bibtex")

# Caso voce tenha mais de um arquivo de bibliometria
# Carregue os arquivos
#setwd("C:/Users/kalab/OneDrive - FIOCRUZ/GitHub/r_analysis/datasets")
#file1 <- "LKS_savedrecs.bib"
# file2 <- "C:/Users/danie/OneDrive/0 - ROTINAS R/1 - Bibliometria/501_1000.txt"
# file3 <- "C:/Users/danie/OneDrive/0 - ROTINAS R/1 - Bibliometria/1001_1468.txt"
# Junte eles
#es.file <- c(file1, file2, file3)
# E converta a base:
#M <- convert2df(file = es.file, dbsource = "wos", format = "plaintext")

results <- biblioAnalysis(M, sep = ";")

options(width=100)
S <- summary(object = results, k = 10, pause = FALSE)

plot(x = results, k = 10, pause = FALSE)

# Análise das citações
CR <- citations(M, field = "article", sep = ";")
cbind(CR$Cited[1:10]) # Dez manuscritos mais citados

CR <- citations(M, field = "author", sep = ";")
cbind(CR$Cited[1:10]) # Dez autores mais citados

CR <- localCitations(M, sep = ";")
CR$Authors[1:10,] # Dez autores com mais citações localmente (auto-citações)
CR$Papers[1:10,]

# Ranking de dominância dos autores
DF <- dominance(results, k = 10)
DF

#Indice H dos autores
indices <- Hindex(M, field = "author", elements="BLANTON RE", sep = ";", years = 10)

# Bornmann's impact indices:
indices$H

# Bornmann's citations
indices$CitationList

# Calculo do indice-H dos dez autores mais produtivos
authors=gsub(","," ",names(results$Authors)[1:10])

indices <- Hindex(M, field = "author", elements=authors, sep = ";", years = 50)

indices$H

# Produtividade dos autores no tempo
topAU <- authorProdOverTime(M, k = 10, graph = TRUE)


## Table: Author's productivity per year
head(topAU$dfAU)

## Table: Auhtor's documents list
head(topAU$dfPapersAU)
