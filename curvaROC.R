# Estatística descritiva para análise de dados
# Trabalhando pROC-package {pROC}
# Autor: Luciano K. Silva

# Installing and using
list.of.packages <- c("pROC", "dplyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(pROC)

library(dplyr)
# Experimental: pipelines
View(aSAH)
aSAH %>% 
  filter(gender == "Female") %>%
  roc(outcome, s100b)

gender <- table(aSAH$gender)
gender
