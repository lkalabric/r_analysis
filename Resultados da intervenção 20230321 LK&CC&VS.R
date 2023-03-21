# Identifica??o ----
#T?tulo: An?lise interina estudo CAP - Grupo Schisto
#Autor: Vin?cius Raimundo
#Data: 16/03/2023

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
setwd("C:\\Users\\kalabric\\Downloads")

#An?lise explorat?ria dos dados----
df.cap <- read.csv(file="InquritoCAPEsquistos-ResultadosDoInqurito_DATA_2023-03-21_1549.csv")
View(df.cap)

#Avaliando a estrutura do dataset
str(df.cap)

#Transformando algumas vari?veis categ?ricas em fatores
cols <- c("sexo", "nat1", "esc")

df.cap[cols] <- lapply(df.cap[cols], as.factor)

str(df.cap)

#Modificando os nomes de alguns fatores
levels(df.cap$sexo) <- c("Homem", "Mulher")
levels(df.cap$nat1) <- c("Salvador", "Outro")

#Transformando a categoria da vari?vel "NA DNO" em NA

#An?lise descritiva----

summary(df.cap)
sd(sub.df.cap$Idade)

#Estat?stica descritiva----

#30observa?oes

#14 homens e 16 mulheres

#Idade m?dia 44 anos

#19 naturais de Salvador; 11 naturais de outros locais

#M?dia do pr? teste 9 (sd=2.95)

#M?dia do p?s teste 9.6 (sd=3.5)

#N?mero de individuos por escolaridade

#Analfabeto / Fundamental 1 Incompleto:7; M?dio Completo/Superior Incompleto :6; 
# NSA/DN:2; Superior completo: 1

#An?lises gr?ficas----


##Grafico pareado sem estratifica??o
ggpaired(df.cap,cond1= "pre_total", cond2= "pos_total",ylab= "Resultado no question?rio CAP", xlab= "Momento de aplica??o", title= "Desempenho no question?rio CAP",fill= "condition",
         line.color = "red",line.size= 0.4,palette="jco")

##Gr?fico pareados por sexo
str(df.cap)
ggpaired(df.cap,cond1= "pre_total", cond2= "pos_total",ylab= "Resultado no question?rio CAP", xlab= "Momento de aplica??o", title= "Desempenho no question?rio CAP",fill= "condition",
         line.color = "red",line.size= 0.4,palette="jco") + facet_wrap(~ sexo)

