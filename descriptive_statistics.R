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

# Carregando os dados de um arquivo .csv
#Tabela_1 <- read_csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - SA2018.csv")
Tabela_1 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - All.csv")

# Para confirmar a classe de uam variável
class(Tabela_1)

### Exemplo de comandos básicos
# Frequencia de uma variável qualitativa ou categórica
participants_study <- table(Tabela_1$study)
participants_study
sexo <- table(Tabela_1$sexo)
sexo

# Média de uma variável quantitativa
mean(Tabela_1$idade)

# Média removendo dados faltantes ou missing data (NA)
mean(Tabela_1$perct_vida_salvador)
mean(Tabela_1$perct_vida_salvador, na.rm = TRUE)
mean(Tabela_1$smovosq_prev, na.rm = TRUE)
summary(Tabela_1$smovosq_prev, na.rm = TRUE)

# Desvio padrão da média
sd(Tabela_1$idade, na.rm = TRUE)
sd(Tabela_1$perct_vida_salvador, na.rm = TRUE)
sd(Tabela_1$smovosq_prev, na.rm = TRUE)
sd(Tabela_2$smovosq, na.rm = TRUE)

# Média geométrica
exp(mean(log(Tabela_1$smovosq_prev), na.rm = TRUE))

# Análise estratificada utilizando a função subset
# Dados SB2024
sm_idade_menor30<-subset(Tabela_1, idade<30)
sm_idade<-table(sm_idade_menor30$sm)
sm_idade
mean(sm_idade_menor30$smovosq, na.rm = TRUE)
sd(sm_idade_menor30$smovosq, na.rm = TRUE)
exp(mean(log(sm_idade_menor30$smovosq), na.rm = TRUE))
sm_idade_maior30<-subset(Tabela_1, idade>=30)
mean(sm_idade_maior30$smovosq, na.rm = TRUE)
sd(sm_idade_maior30$smovosq, na.rm = TRUE)
exp(mean(log(sm_idade_maior30$smovosq), na.rm = TRUE))

# Análise estratificada

# Teste de qui-quadrado
stu_data = table(Tabela_1$sexo,Tabela_1$sm_prev)
print(stu_data)
chisq.test(stu_data)

# Análise de médias
# Link: http://www.sthda.com/english/wiki/comparing-means-in-r

# 1) Comparing one-sample mean to a standard known mean
# 1.1) One-sample T-test (parametric)
t.test(Tabela_1$idade, mu = 0, alternative = "two.sided")
ggboxplot(Tabela_1$idade, na.rm = TRUE,
          ylab = "Age (years)", xlab = FALSE,
          ggtheme = theme_minimal())
shapiro.test(Tabela_1$idade) # Shapiro-Wilk normality test 
# 1.2) One-sample Wilcoxon test (non-parametric)
wilcox.test(Tabela_1$idade, mu = 0, alternative = "two.sided")
group_by(Tabela_1, sm_prev) %>%
  summarise(
    count = n(),
    mean = mean(idade, na.rm = TRUE),
    sd = sd(idade, na.rm = TRUE)
  )

# 2) Comparing the means of two independent groups
# 2.1) Unpaired two samples t-test (parametric)
ggboxplot(Tabela_1, x = "sm_prev", y = "idade", 
          color = "sm_prev", palette = c("#00AFBB", "#E7B800"),
          ylab = "Idade", xlab = "Groups")
# Shapiro-Wilk normality test for Men's weights
with(Tabela_1, shapiro.test(idade[sm_prev == 1])) # p = 0.1
# Shapiro-Wilk normality test for Women's weights
with(Tabela_1, shapiro.test(idade[sm_prev == 2])) # p = 0.6
var.test(idade ~ sm_prev, data = Tabela_1)
t.test(idade ~ sm_prev, data = Tabela_1, var.equal = TRUE)

# 3) Comparing the means of paired samples
# 4) Comparing the means of more than two groups
# 5) MANOVA test: Multivariate analysis of variance
# 6) Kruskal-Wallis test
levels(Tabela_1$sm_prev)
group_by(Tabela_1, sm_prev) %>%
  summarise(
    count = n(),
    mean = mean(idade, na.rm = TRUE),
    sd = sd(idade, na.rm = TRUE),
    median = median(idade, na.rm = TRUE),
    IQR = IQR(idade, na.rm = TRUE)
  )
ggboxplot(Tabela_1, x = "sm_prev", y = "idade", 
          color = "sm_prev", palette = c("#00AFBB", "#E7B800"),
          ylab = "Idade", xlab = "Groups")
ggline(Tabela_1, x = "sm_prev", y = "idade", 
       add = c("mean_se", "jitter"), 
       ylab = "Idade", xlab = "SM")
kruskal.test(idade ~ sm_prev, data = Tabela_1)

###
### Análise Urban Schisto
###

# Tabela 2
# Dados SA2019
Tabela_2 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Dados da pesquisa/2019 SA Relatório final coorte Tulane-IRB & CEP-IGM.csv")
id_corte<-4000
# Dados SA2023
Tabela_2 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Dados da pesquisa/2023 SA Relatório final coorte Tulane-IRB & CEP-IGM.csv")
id_corte<-5000
# Dados PI2021
Tabela_2 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Dados da pesquisa/2021 PI Relatório final coorte Tulane-IRB & CEP-IGM.csv")
id_corte<-3000
# Dados PI2023
Tabela_2 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Dados da pesquisa/2023 PI Relatório final coorte Tulane-IRB & CEP-IGM.csv")
id_corte<-4000
# Dados SB2024
Tabela_2 <- read.csv("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Dados da pesquisa/2024 SB Relatório final coorte Tulane-IRB & CEP-IGM.csv")
id_corte<-3000
sm_prev <- table(Tabela_2$sm)
sm_prev
mean(Tabela_2$smovosq, na.rm = TRUE)
sd(Tabela_2$smovosq, na.rm = TRUE)
exp(mean(log(Tabela_2$smovosq), na.rm = TRUE))
# Coorte
coorte <- subset(Tabela_2, id<id_corte)
sm_coorte <- table(coorte$sm)
sm_coorte
mean(coorte$smovosq, na.rm = TRUE)
sd(coorte$smovosq, na.rm = TRUE)
exp(mean(log(coorte$smovosq), na.rm = TRUE))
# Novos
novos <- subset(Tabela_2, id>=id_corte)
sm_novos <- table(novos$sm)
sm_novos
mean(novos$smovosq, na.rm = TRUE)
sd(novos$smovosq, na.rm = TRUE)
exp(mean(log(novos$smovosq), na.rm = TRUE))

# Figura 1
sm_by_studygroup <- subset(Tabela_1, study=="DC2017", select=c(idade, sexo, sm, sm_prev))
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

# Tabela 3 - Kruskal-Wallis test
levels(Tabela_1$sm_prev)
group_by(Tabela_1, sm_prev) %>%
  summarise(
    count = n(),
    mean = mean(perct_vida_salvador, na.rm = TRUE),
    sd = sd(perct_vida_salvador, na.rm = TRUE),
    median = median(perct_vida_salvador, na.rm = TRUE),
    IQR = IQR(perct_vida_salvador, na.rm = TRUE)
  )
ggboxplot(Tabela_1, x = "sm_prev", y = "perct_vida_salvador", 
          color = "sm_prev", palette = c("#00AFBB", "#E7B800"),
          ylab = "%Life in Salvador", xlab = "Groups")
ggline(Tabela_1, x = "sm_prev", y = "perct_vida_salvador", 
       add = c("mean_se", "jitter"), 
       ylab = "%Life in Salvador", xlab = "SM")
kruskal.test(perct_vida_salvador ~ sm_prev, data = Tabela_1)
