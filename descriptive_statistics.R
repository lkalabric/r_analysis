# Estatística descritiva para análise de dados

# Trabalhando com arquivos .csv em R

# Preparação do ambiente
list.of.packages <- c("dplyr", "readr", "ggpubr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# "dplyr" é um pacote para transformação de dados e "readr" para leitura de dados de arquivos delimitados
library(dplyr)
library(readr)
library(ggpubr)

###
### Análise Urban Schisto - Tabela 1
###

# Carregando os dados de um arquivo .csv
#data <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - SB2011.csv")
#data <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - DC2017.csv")
data <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - SA2018.csv")
#data <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - PI2019.csv")
#data <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - LP2022.csv")
#data <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - BF2023.csv")

# Para confirmar a classe de uma variável
class(data)

# Frequencia de uma variável qualitativa ou categórica - Exemplo
participants_study <- table(data$study)
participants_study
sexo <- table(data$sexo)
sexo

# Média de uma variável quantitativa - Exemplo
mean(data$idade)

# Média removendo dados faltantes ou missing data (NA) - Exemplo
mean(data$perct_vida_salvador)
mean(data$perct_vida_salvador, na.rm = TRUE)
mean(data$smovosq, na.rm = TRUE)
summary(data$smovosq, na.rm = TRUE)
mean(data$smovosq_prev, na.rm = TRUE)
summary(data$smovosq_prev, na.rm = TRUE)

# Desvio padrão da média - Exemplo
sd(data$idade, na.rm = TRUE)
sd(data$perct_vida_salvador, na.rm = TRUE)
sd(data$smovosq, na.rm = TRUE)
sd(data$smovosq_prev, na.rm = TRUE)


# Média geométrica - Exemplo
exp(mean(log(data$smovosq), na.rm = TRUE))
exp(mean(log(data$smovosq_prev), na.rm = TRUE))

# Análise estratificada utilizando a função subset - Exemplo
sm_idade_menor30<-subset(data, idade<30)
sm_idade<-table(sm_idade_menor30$sm)
sm_idade
mean(sm_idade_menor30$smovosq, na.rm = TRUE)
sd(sm_idade_menor30$smovosq, na.rm = TRUE)
exp(mean(log(sm_idade_menor30$smovosq), na.rm = TRUE))
sm_idade_maior30<-subset(data, idade>=30)
mean(sm_idade_maior30$smovosq, na.rm = TRUE)
sd(sm_idade_maior30$smovosq, na.rm = TRUE)
exp(mean(log(sm_idade_maior30$smovosq), na.rm = TRUE))

###
### Análise Urban Schisto - Tabela 2
###
# Carregando os dados de um arquivo .csv
data <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 2 - All.csv")

# Teste de qui-quadrado
# stu_data = table(data$sexo,data$smansoni) # Só em SB2015
stu_data = table(data$sexo,data$sm)         # Todos os estudos
print(stu_data)
chisq.test(stu_data)
stu_data = table(data$sexo,data$sm_prev)    # Só estudos com piloto
print(stu_data)
chisq.test(stu_data)

# Análise de médias
# Link: http://www.sthda.com/english/wiki/comparing-means-in-r

# 1) Comparing one-sample mean to a standard known mean
# 1.1) One-sample T-test (parametric)
t.test(data$idade, mu = 0, alternative = "two.sided")
ggboxplot(data$idade, na.rm = TRUE,
          ylab = "Age (years)", xlab = FALSE,
          ggtheme = theme_minimal())
shapiro.test(data$idade) # Shapiro-Wilk normality test 
# 1.2) One-sample Wilcoxon test (non-parametric)
wilcox.test(data$idade, mu = 0, alternative = "two.sided")
group_by(data, sm_prev) %>%
  summarise(
    count = n(),
    mean = mean(idade, na.rm = TRUE),
    sd = sd(idade, na.rm = TRUE)
  )

# 2) Comparing the means of two independent groups
# 2.1) Unpaired two samples t-test (parametric)
ggboxplot(data, x = "sm_prev", y = "idade", 
          color = "sm_prev", palette = c("#00AFBB", "#E7B800"),
          ylab = "Idade", xlab = "Groups")
# Shapiro-Wilk normality test for Men's weights
with(data, shapiro.test(idade[sm_prev == 1])) # p = 0.1
# Shapiro-Wilk normality test for Women's weights
with(data, shapiro.test(idade[sm_prev == 2])) # p = 0.6
var.test(idade ~ sm_prev, data = data)
t.test(idade ~ sm_prev, data = data, var.equal = TRUE)

# 3) Comparing the means of paired samples
# 4) Comparing the means of more than two groups
# 5) MANOVA test: Multivariate analysis of variance
# 6) Kruskal-Wallis test
levels(data$sm_prev)
group_by(data, sm_prev) %>%
  summarise(
    count = n(),
    mean = mean(idade, na.rm = TRUE),
    sd = sd(idade, na.rm = TRUE),
    median = median(idade, na.rm = TRUE),
    IQR = IQR(idade, na.rm = TRUE)
  )
ggboxplot(data, x = "sm_prev", y = "idade", 
          color = "sm_prev", palette = c("#00AFBB", "#E7B800"),
          ylab = "Idade", xlab = "Groups")
ggline(data, x = "sm_prev", y = "idade", 
       add = c("mean_se", "jitter"), 
       ylab = "Idade", xlab = "SM")
kruskal.test(idade ~ sm_prev, data = data)

# Análise estratificada a função group_by

###
### Análise Urban Schisto - Tabela 2
###
# Comparação de médias
levels(data$sm_prev)
group_by(data, sm_prev) %>%
  summarise(
    count = n(),
    mean = mean(perct_vida_salvador, na.rm = TRUE),
    sd = sd(perct_vida_salvador, na.rm = TRUE),
    median = median(perct_vida_salvador, na.rm = TRUE),
    IQR = IQR(perct_vida_salvador, na.rm = TRUE)
  )
ggboxplot(data, x = "sm_prev", y = "perct_vida_salvador", 
          color = "sm_prev", palette = c("#00AFBB", "#E7B800"),
          ylab = "%Life in Salvador", xlab = "Groups")
ggline(data, x = "sm_prev", y = "perct_vida_salvador", 
       add = c("mean_se", "jitter"), 
       ylab = "%Life in Salvador", xlab = "SM")
kruskal.test(perct_vida_salvador ~ sm_prev, data = data)

###
### Análise Urban Schisto - Tabela 3
###
# Carregando os dados de um arquivo .csv
# Dados SA2019
data3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - SA2019.csv")
id_corte<-4000
# Dados SA2023
data3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - SA2023.csv")
id_corte<-5000
# Dados PI2021
data3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - PI2021.csv")
id_corte<-3000
# Dados PI2023
data3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - PI2023.csv")
id_corte<-4000
# Dados SB2024
data3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - SB2024.csv")
id_corte<-3000

# Prevalência Global
sm_prev <- table(data3$sm)
sm_prev
mean(data3$smovosq, na.rm = TRUE)
sd(data3$smovosq, na.rm = TRUE)
exp(mean(log(data3$smovosq), na.rm = TRUE))
# Prevalência da Coorte (Incidência)
coorte <- subset(data3, id<id_corte)
sm_coorte <- table(coorte$sm)
sm_coorte
mean(coorte$smovosq, na.rm = TRUE)
sd(coorte$smovosq, na.rm = TRUE)
exp(mean(log(coorte$smovosq), na.rm = TRUE))
# Prevalência dos Novos
novos <- subset(data3, id>=id_corte)
sm_novos <- table(novos$sm)
sm_novos
mean(novos$smovosq, na.rm = TRUE)
sd(novos$smovosq, na.rm = TRUE)
exp(mean(log(novos$smovosq), na.rm = TRUE))


# Dados SB2015
data3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - SB2015.csv")

# Prevalência Global
sm_prev <- table(data3$smansoni)
sm_prev
mean(data3$smovosq, na.rm = TRUE)
sd(data3$smovosq, na.rm = TRUE)
exp(mean(log(data3$smovosq), na.rm = TRUE))
# Prevalência da Coorte (Incidência)
coorte <- subset(data3, part2011==1)
sm_coorte <- table(coorte$smansoni)
sm_coorte
mean(coorte$smovosqmedia, na.rm = TRUE)
sd(coorte$smovosqmedia, na.rm = TRUE)
exp(mean(log(coorte$smovosqmedia), na.rm = TRUE))
# Prevalência dos Novos
novos <- subset(data3, part2011==2)
sm_novos <- table(novos$smansoni)
sm_novos
mean(novos$smovosqmedia, na.rm = TRUE)
sd(novos$smovosqmedia, na.rm = TRUE)
exp(mean(log(novos$smovosqmedia), na.rm = TRUE))









# Figura 1
data2 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 2 - All.csv")
sm_by_studygroup <- subset(data2, study=="DC2017", select=c(idade, sexo, sm, sm_prev))
sm_by_studygroup$faixaetaria <- NA

# Recodifica idade por grupo etário
sm_by_studygroup[sm_by_studygroup$idade <= 6, "faixaetaria"] <- "2-6"
sm_by_studygroup[sm_by_studygroup$idade >= 7 & sm_by_studygroup$idade <= 12, "faixaetaria"] <- "7-12"
sm_by_studygroup[sm_by_studygroup$idade >= 13 & sm_by_studygroup$idade <= 18, "faixaetaria"] <- "13-18"
sm_by_studygroup[sm_by_studygroup$idade >= 19 & sm_by_studygroup$idade <= 29, "faixaetaria"] <- "19-29"
sm_by_studygroup[sm_by_studygroup$idade >= 30 & sm_by_studygroup$idade <= 49, "faixaetaria"] <- "30-49"
sm_by_studygroup[sm_by_studygroup$idade >= 50 & sm_by_studygroup$idade <= 64, "faixaetaria"] <- "50-64"
sm_by_studygroup[sm_by_studygroup$idade >= 65 & sm_by_studygroup$idade <= 100, "faixaetaria"] <- "+65"

participants_sm <- table(sm_by_studygroup$faixaetaria, sm_by_studygroup$sm)
participants_sm
participants_sm_prev <- table(sm_by_studygroup$faixaetaria, sm_by_studygroup$sm_prev)
participants_sm_prev
