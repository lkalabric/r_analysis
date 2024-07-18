# Estatística descritiva de dados provenientes de um arquivo .csv

# Trabalhando com tabelas em R

# Carrega os dados de um arquivo .csv
library(readr)
#Tabela_1 <- read_csv("C:/Users/kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - SA2018.csv")
Tabela_1 <- read_csv("C:/Users/kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - All.csv")
View(Tabela_1)

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

# Desvio padrão da média
sd(Tabela_1$idade, na.rm = TRUE)
sd(Tabela_1$perct_vida_salvador, na.rm = TRUE)
sd(Tabela_1$smovosq_prev, na.rm = TRUE)

# Média geométrica
exp(mean(log(Tabela_1$smovosq_prev), na.rm = TRUE))

# Análise estratificada

# Teste de qui-quadrado
stu_data = table(Tabela_1$sexo,Tabela_1$sm_prev)
print(stu_data)
chisq.test(stu_data)
