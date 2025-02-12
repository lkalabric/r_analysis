# Estatística descritiva para análise de dados
# Trabalhando com arquivos .csv em R
# Autor: Luciano K. Silva

# Preparação do ambiente
list.of.packages <- c("dplyr", "readr", "ggpubr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(dplyr)  # "dplyr" é um pacote para transformação de dados
library(readr)  # "readr" para leitura de dados de arquivos delimitados
library(ggpubr) # plota gráficos diversos

###
### Análise Urban Schisto - Tabela 1
###

# Carregando os dados de um arquivo .csv
#tabela1 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - SB2011.csv")
#tabela1 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - DC2017.csv")
#tabela1 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - SA2018.csv")
#tabela1 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - PI2019.csv")
#tabela1 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - LP2022.csv")
#tabela1 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - BF2023.csv")
tabela1 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1&2 - All.csv")

# Para confirmar a classe de uma variável
class(tabela1)

# Frequencia de uma variável qualitativa ou categórica - Exemplo
sexo <- table(tabela1$sexo)
sexo
sm <- table(tabela1$smansoni) # Só em SB2011 & SB2015
sm
sm <- table(tabela1$sm)
sm
sm <- table(tabela1$sm_prev) # Inclui os resultados do piloto
sm


# Média de uma variável quantitativa - Exemplo
mean(tabela1$idade)

# Média removendo dados faltantes ou missing data (NA) - Exemplo
mean(tabela1$perct_vida_salvador)
mean(tabela1$perct_vida_salvador, na.rm = TRUE)
mean(tabela1$smovosq, na.rm = TRUE)
summary(tabela1$smovosq, na.rm = TRUE)
mean(tabela1$smovosq_prev, na.rm = TRUE) # Inclui os resultados do piloto
summary(tabela1$smovosq_prev, na.rm = TRUE)

# Desvio padrão da média - Exemplo
sd(tabela1$idade, na.rm = TRUE)
sd(tabela1$perct_vida_salvador, na.rm = TRUE)
sd(tabela1$smovosq, na.rm = TRUE)
sd(tabela1$smovosq_prev, na.rm = TRUE) # Inclui os resultados do piloto


# Média geométrica - Exemplo
exp(mean(log(tabela1$smovosq), na.rm = TRUE))
exp(mean(log(tabela1$smovosq_prev), na.rm = TRUE))  # Inclui os resultados do piloto

# Análise estratificada utilizando a função subset - Exemplo
sm_idade_menor21<-subset(tabela1, idade<21)
sm_idade<-table(sm_idade_menor21$sm_prev)
sm_idade
mean(sm_idade_menor21$smovosq, na.rm = TRUE)
sd(sm_idade_menor21$smovosq, na.rm = TRUE)
exp(mean(log(sm_idade_menor21$smovosq), na.rm = TRUE))
sm_idade_maior21<-subset(tabela1, idade>=21)
sm_idade<-table(sm_idade_maior21$sm_prev)
sm_idade
mean(sm_idade_maior21$smovosq, na.rm = TRUE)
sd(sm_idade_maior21$smovosq, na.rm = TRUE)
exp(mean(log(sm_idade_maior21$smovosq), na.rm = TRUE))

###
### Análise Urban Schisto - Tabela 2
###
# Carregando os dados de um arquivo .csv
tabela2 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1&2 - All.csv")

# Frequencia de uma variável qualitativa ou categórica - Exemplo
participants_study <- table(tabela2$study)
participants_study
sm <- table(tabela2$sm_prev) # Inclui os resultados do piloto
sm
stu_data <- table(tabela2$study,tabela2$sm_prev)
print(stu_data)

# Teste de qui-quadrado
# stu_data = table(tabela2$sexo,tabela2$smansoni) # Só em SB2011 & SB2015
stu_data = table(tabela2$sexo,tabela2$sm_prev)    # Inclui os resultados dos pilotos
print(stu_data)
chisq.test(stu_data)
stu_data = table(tabela2$nat1,tabela2$sm_prev)    # Inclui os resultados dos pilotos
print(stu_data)
chisq.test(stu_data)
stu_data = table(tabela2$resdoutr1,tabela2$sm_prev)     # Inclui os resultados dos pilotos
print(stu_data)
chisq.test(stu_data)
stu_data = table(tabela2$viaj1,tabela2$sm_prev)         # Inclui os resultados dos pilotos
print(stu_data)
# Calcular o chi-quadrado no EpiInfo
stu_data = table(tabela2$agua_ind,tabela2$sm_prev)      # Inclui os resultados dos pilotos
print(stu_data)
# Calcular o chi-quadrado no EpiInfo
stu_data = table(tabela2$banheiro_ind,tabela2$sm_prev)  # Inclui os resultados dos pilotos
print(stu_data)
# Calcular o chi-quadrado no EpiInfo
stu_data = table(tabela2$esgoto_ind,tabela2$sm_prev)    # Inclui os resultados dos pilotos
print(stu_data)
# Calcular o chi-quadrado no EpiInfo






# Análise de médias
# Link: http://www.sthda.com/english/wiki/comparing-means-in-r

# 1) Comparing one-sample mean to a standard known mean
# 1.1) One-sample T-test (parametric)
t.test(tabela2$idade, mu = 0, alternative = "two.sided")
ggboxplot(tabela2$idade, na.rm = TRUE,
          ylab = "Age (years)", xlab = FALSE,
          ggtheme = theme_minimal())
shapiro.test(tabela2$idade) # Shapiro-Wilk normality test 
# 1.2) One-sample Wilcoxon test (non-parametric)
wilcox.test(tabela2$idade, mu = 0, alternative = "two.sided")
group_by(tabela2, sm_prev) %>%
  summarise(
    count = n(),
    mean = mean(idade, na.rm = TRUE),
    sd = sd(idade, na.rm = TRUE)
  )

# 2) Comparing the means of two independent groups
# 2.1) Unpaired two samples t-test (parametric)
ggboxplot(tabela2, x = "sm_prev", y = "idade", 
          color = "sm_prev", palette = c("#00AFBB", "#E7B800"),
          ylab = "Idade", xlab = "Groups")
# Shapiro-Wilk normality test for Men's weights
with(tabela2, shapiro.test(idade[sm_prev == 1])) # p = 0.1
# Shapiro-Wilk normality test for Women's weights
with(tabela2, shapiro.test(idade[sm_prev == 2])) # p = 0.6
var.test(idade ~ sm_prev, data = tabela2)
t.test(idade ~ sm_prev, data = tabela2, var.equal = TRUE)

# 3) Comparing the means of paired samples
# 4) Comparing the means of more than two groups
# 5) MANOVA test: Multivariate analysis of variance
# 6) Kruskal-Wallis test
levels(tabela2$sm_prev)
group_by(tabela2, sm_prev) %>%
  summarise(
    count = n(),
    mean = mean(idade, na.rm = TRUE),
    sd = sd(idade, na.rm = TRUE),
    median = median(idade, na.rm = TRUE),
    IQR = IQR(idade, na.rm = TRUE)
  )
ggboxplot(tabela2, x = "sm_prev", y = "idade", 
          color = "sm_prev", palette = c("#00AFBB", "#E7B800"),
          ylab = "Idade", xlab = "Groups")
ggline(tabela2, x = "sm_prev", y = "idade", 
       add = c("mean_se", "jitter"), 
       ylab = "Idade", xlab = "SM")
kruskal.test(idade ~ sm_prev, data = tabela2)

# Análise estratificada a função group_by

###
### Análise Urban Schisto - Tabela 2
###
# Comparação de médias
levels(tabela2$sm_prev)
group_by(tabela2, sm_prev) %>%
  summarise(
    count = n(),
    mean = mean(perct_vida_salvador, na.rm = TRUE),
    sd = sd(perct_vida_salvador, na.rm = TRUE),
    median = median(perct_vida_salvador, na.rm = TRUE),
    IQR = IQR(perct_vida_salvador, na.rm = TRUE)
  )
ggboxplot(tabela2, x = "sm_prev", y = "perct_vida_salvador", 
          color = "sm_prev", palette = c("#00AFBB", "#E7B800"),
          ylab = "%Life in Salvador", xlab = "Groups")
ggline(tabela2, x = "sm_prev", y = "perct_vida_salvador", 
       add = c("mean_se", "jitter"), 
       ylab = "%Life in Salvador", xlab = "SM")
kruskal.test(perct_vida_salvador ~ sm_prev, data = tabela2)

###
### Análise Urban Schisto - Tabela 3
###
# Carregando os dados de um arquivo .csv
# Dados SA2019
tabela3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - SA2019.csv")
id_corte<-4000
# Dados SA2023
tabela3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - SA2023.csv")
id_corte<-5000
# Dados PI2021
tabela3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - PI2021.csv")
id_corte<-3000
# Dados PI2023
tabela3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - PI2023.csv")
id_corte<-4000
# Dados SB2024
tabela3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - SB2024.csv")
id_corte<-3000

# Prevalência Global
sm_prev <- table(tabela3$sm)
sm_prev
mean(tabela3$smovosq, na.rm = TRUE)
sd(tabela3$smovosq, na.rm = TRUE)
exp(mean(log(tabela3$smovosq), na.rm = TRUE))
# Prevalência da Coorte (Incidência)
coorte <- subset(tabela3, id<id_corte)
sm_coorte <- table(coorte$sm)
sm_coorte
mean(coorte$smovosq, na.rm = TRUE)
sd(coorte$smovosq, na.rm = TRUE)
exp(mean(log(coorte$smovosq), na.rm = TRUE))
# Prevalência dos Novos
novos <- subset(tabela3, id>=id_corte)
sm_novos <- table(novos$sm)
sm_novos
mean(novos$smovosq, na.rm = TRUE)
sd(novos$smovosq, na.rm = TRUE)
exp(mean(log(novos$smovosq), na.rm = TRUE))


# Dados SB2015
tabela3 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 3 - SB2015.csv")

# Prevalência Global
sm_prev <- table(tabela3$smansoni)
sm_prev
mean(tabela3$smovosq, na.rm = TRUE)
sd(tabela3$smovosq, na.rm = TRUE)
exp(mean(log(tabela3$smovosq), na.rm = TRUE))
# Prevalência da Coorte (Incidência)
coorte <- subset(tabela3, part2011==1)
sm_coorte <- table(coorte$smansoni)
sm_coorte
mean(coorte$smovosqmedia, na.rm = TRUE)
sd(coorte$smovosqmedia, na.rm = TRUE)
exp(mean(log(coorte$smovosqmedia), na.rm = TRUE))
# Prevalência dos Novos
novos <- subset(tabela3, part2011==2)
sm_novos <- table(novos$smansoni)
sm_novos
mean(novos$smovosqmedia, na.rm = TRUE)
sd(novos$smovosqmedia, na.rm = TRUE)
exp(mean(log(novos$smovosqmedia), na.rm = TRUE))

# Figura 1
figura1 <- read.csv2("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - All.csv")
sm_by_studygroup <- subset(figura1, study=="BF2023", select=c(idade, sexo, sm, sm_prev))
sm_by_studygroup$faixaetaria <- NA

# Recodifica idade por grupo etário por desenvolvimento humano
sm_by_studygroup[sm_by_studygroup$idade <= 6, "faixaetaria"] <- "2-6"
sm_by_studygroup[sm_by_studygroup$idade >= 7 & sm_by_studygroup$idade <= 12, "faixaetaria"] <- "7-12"
sm_by_studygroup[sm_by_studygroup$idade >= 13 & sm_by_studygroup$idade <= 18, "faixaetaria"] <- "13-18"
sm_by_studygroup[sm_by_studygroup$idade >= 19 & sm_by_studygroup$idade <= 29, "faixaetaria"] <- "19-29"
sm_by_studygroup[sm_by_studygroup$idade >= 30 & sm_by_studygroup$idade <= 49, "faixaetaria"] <- "30-49"
sm_by_studygroup[sm_by_studygroup$idade >= 50 & sm_by_studygroup$idade <= 64, "faixaetaria"] <- "50-64"
sm_by_studygroup[sm_by_studygroup$idade >= 65 & sm_by_studygroup$idade <= 100, "faixaetaria"] <- "+65"

# Recodifica idade por grupo etário de 5 em 5 anos
sm_by_studygroup[sm_by_studygroup$idade <= 5, "faixaetaria"] <- "2-5"
sm_by_studygroup[sm_by_studygroup$idade >= 6 & sm_by_studygroup$idade <= 10, "faixaetaria"] <- "6-10"
sm_by_studygroup[sm_by_studygroup$idade >= 11 & sm_by_studygroup$idade <= 15, "faixaetaria"] <- "11-15"
sm_by_studygroup[sm_by_studygroup$idade >= 16 & sm_by_studygroup$idade <= 20, "faixaetaria"] <- "16-20"
sm_by_studygroup[sm_by_studygroup$idade >= 21 & sm_by_studygroup$idade <= 25, "faixaetaria"] <- "21-25"
sm_by_studygroup[sm_by_studygroup$idade >= 26 & sm_by_studygroup$idade <= 30, "faixaetaria"] <- "26-30"
sm_by_studygroup[sm_by_studygroup$idade >= 31 & sm_by_studygroup$idade <= 35, "faixaetaria"] <- "31-35"
sm_by_studygroup[sm_by_studygroup$idade >= 36 & sm_by_studygroup$idade <= 40, "faixaetaria"] <- "36-40"
sm_by_studygroup[sm_by_studygroup$idade >= 41 & sm_by_studygroup$idade <= 45, "faixaetaria"] <- "41-45"
sm_by_studygroup[sm_by_studygroup$idade >= 46 & sm_by_studygroup$idade <= 50, "faixaetaria"] <- "46-50"
sm_by_studygroup[sm_by_studygroup$idade >= 51 & sm_by_studygroup$idade <= 55, "faixaetaria"] <- "51-55"
sm_by_studygroup[sm_by_studygroup$idade >= 56 & sm_by_studygroup$idade <= 60, "faixaetaria"] <- "56-60"
sm_by_studygroup[sm_by_studygroup$idade >= 61 & sm_by_studygroup$idade <= 65, "faixaetaria"] <- "61-65"
sm_by_studygroup[sm_by_studygroup$idade >= 66 & sm_by_studygroup$idade <= 70, "faixaetaria"] <- "66-70"
sm_by_studygroup[sm_by_studygroup$idade >= 71 & sm_by_studygroup$idade <= 100, "faixaetaria"] <- "+71"

participants_sm <- table(sm_by_studygroup$faixaetaria, sm_by_studygroup$sm)
participants_sm
participants_sm_prev <- table(sm_by_studygroup$faixaetaria, sm_by_studygroup$sm_prev)
participants_sm_prev


