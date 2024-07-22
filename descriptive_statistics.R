# Estatística descritiva para análise de dados provenientes de um arquivo .csv

# Trabalhando com tabelas em R

# Carrega os dados de um arquivo .csv
library(readr)
#Tabela_1 <- read_csv("C:/Users/kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - SA2018.csv")
Tabela_1 <- read_csv("C:/Users/kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - All.csv")
Tabela_2 <- read.csv("C:/Users/luciano.kalabric/Downloads/EsquistossomoseUrban-RelatrioFinalCoorteT_DATA_2024-07-22_1447.csv")
# Para confirmar a classe de uam variável

class(Tabela_1)

# Frequencia de uma variável qualitativa ou categórica
study <- table(Tabela_1$study)
study
sexo <- table(Tabela_1$sexo)
sexo

# Média de uma variável quantitativa
mean(Tabela_1$idade)

# Média removendo dados faltantes ou missing data (NA)
mean(Tabela_1$perct_vida_salvador)
mean(Tabela_1$perct_vida_salvador, na.rm = TRUE)
mean(Tabela_1$smovosq_prev, na.rm = TRUE)
mean(Tabela_2$smovosq, na.rm = TRUE)

# Desvio padrão da média
sd(Tabela_1$idade, na.rm = TRUE)
sd(Tabela_1$perct_vida_salvador, na.rm = TRUE)
sd(Tabela_1$smovosq_prev, na.rm = TRUE)
sd(Tabela_2$smovosq, na.rm = TRUE)


# Média geométrica
exp(mean(log(Tabela_1$smovosq_prev), na.rm = TRUE))
exp(mean(log(Tabela_2$smovosq), na.rm = TRUE))

# Análise estratificada utilizando a função subset
# Dados SB2024
coorte<-subset(Tabela_2, id<3000)
sm_coorte<-table(coorte$sm)
sm_coorte
mean(coorte$smovosq, na.rm = TRUE)
sd(coorte$smovosq, na.rm = TRUE)
exp(mean(log(coorte$smovosq), na.rm = TRUE))
novos<-subset(Tabela_2, id>=3000)
mean(Tabela_2$smovosq, na.rm = TRUE)

# Análise estratificada

# Teste de qui-quadrado
stu_data = table(Tabela_1$sexo,Tabela_1$sm_prev)
print(stu_data)
chisq.test(stu_data)

# Análise Urban Schisto
# Dados SB2024
# Prev
sm_prev <- table(Tabela_2$sm)
sm_prev
mean(Tabela_2$smovosq, na.rm = TRUE)
sd(Tabela_2$smovosq, na.rm = TRUE)
exp(mean(log(Tabela_2$smovosq), na.rm = TRUE))
# Coorte
coorte<-subset(Tabela_2, id<3000)
sm_coorte<-table(coorte$sm)
sm_coorte
mean(coorte$smovosq, na.rm = TRUE)
sd(coorte$smovosq, na.rm = TRUE)
exp(mean(log(coorte$smovosq), na.rm = TRUE))
# Novos
novos<-subset(Tabela_2, id>=3000)
sm_novos<-table(novos$sm)
sm_novos
mean(novos$smovosq, na.rm = TRUE)
sd(novos$smovosq, na.rm = TRUE)
exp(mean(log(novos$smovosq), na.rm = TRUE))



