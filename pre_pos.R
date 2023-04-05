# Projeto: Schisto Urbano
# Coordenador: Mitermayer G. Reis
# Autor: Vinícius Raimundo & Luciano Kalabric
# Data: 16/03/2023

# Tipo de análise: Análise tipo pré e pós
# Aplicação: Intervenção educativa e aplicação de um inquérito CAP

#Pacotes e datasets ----
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("ggpubr")
library(tidyverse)
library(ggplot2)
library(dplyr)
library(ggpubr)

#Defini??o de diret?rio de trabalho----
getwd()

#setwd("G:\\Meu Drive\\Inicia??o Cient?fica Mitermayer\\KAP\\Bancos de dados")
#setwd("C:\\Users\\kalabric\\Downloads")
#setwd("C:\\Users\\kalabric\\OneDrive - FIOCRUZ\\Projetos\\2019 Kalabric & Camila - Schisto Pirajá\\Produção\\2023 Educação")
#setwd("C:\\Users\\kalabric\\Documents\\GitHub\\r_analysis\\datasets")
setwd("C:/Users/kalabric/Documents/GitHub/r_analysis/datasets")

#An?lise explorat?ria dos dados----
df.cap <- read.csv(file="pre_pos.csv")
View(df.cap)

#Avaliando a estrutura do dataset
str(df.cap)

#Transformando algumas vari?veis categ?ricas em fatores
cols <- c("sexo", "nat1", "esc")

df.cap[cols] <- lapply(df.cap[cols], as.factor)

str(df.cap)

# Modificando os nomes de alguns fatores
levels(df.cap$sexo) <- c("Homem", "Mulher")
levels(df.cap$nat1) <- c("Salvador", "Outro")
levels(df.cap$esc) <- c("Analfabeto/Fund1_incompleto", "Fund1_completo", "Fund2_completo", "Med_completo", "Sup_completo")

# Transformando a categoria da vari?vel "NA DNO" em NA

# An?lise descritiva----

summary(df.cap)
sd(sub.df.cap$Idade)

# Estat?stica descritiva----

#30observa?oes

#14 homens e 16 mulheres

#Idade m?dia 44 anos

#19 naturais de Salvador; 11 naturais de outros locais

#M?dia do pr? teste 9 (sd=2.95)

#M?dia do p?s teste 9.6 (sd=3.5)

#N?mero de individuos por escolaridade

#Analfabeto / Fundamental 1 Incompleto:7; M?dio Completo/Superior Incompleto :6; 
# NSA/DN:2; Superior completo: 1

# An?lises gr?ficas----

## Exibir a tabela
## Link: https://www.statology.org/str-function-in-r/
str(df.cap)

## Grafico pareado sem estratifica??o
ggpaired(df.cap,cond1= "pre_total", cond2= "pos_total",ylab= "Resultado no question?rio CAP", xlab= "Momento de aplica??o", title= "Desempenho no question?rio CAP",fill= "condition",
         line.color = "red",line.size= 0.4,palette="jco")

## Gr?fico pareados por sexo
ggpaired(df.cap,cond1= "pre_total", cond2= "pos_total",ylab= "Resultado no question?rio CAP", xlab= "Momento de aplica??o", title= "Desempenho no question?rio CAP",fill= "condition",
         line.color = "red",line.size= 0.4,palette="jco") + facet_wrap(~ sexo)

## Gr?fico pareados por esc
ggpaired(df.cap,cond1= "pre_total", cond2= "pos_total",ylab= "Resultado no question?rio CAP", xlab= "Momento de aplica??o", title= "Desempenho no question?rio CAP",fill= "condition",
         line.color = "red",line.size= 0.4,palette="jco") + facet_wrap(~ esc)

