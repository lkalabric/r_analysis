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

file <- "https://www.bibliometrix.org/datasets/savedrecs.bib"

M <- convert2df(file = file, dbsource = "isi", format = "bibtex")

results <- biblioAnalysis(M, sep = ";")

options(width=100)
S <- summary(object = results, k = 10, pause = FALSE)


