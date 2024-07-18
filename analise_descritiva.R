# Estatística descritiva de dados provenientes de um arquivo .csv

library(readr)
Tabela_1_All <- read_csv("C:/Users/kalabric/OneDrive - FIOCRUZ/Projetos/2014- Mitermayer Esquistossomose urbana/Produção/Publicações/2023 Artigo Urban Schisto/Tabela 1 - All.csv")

# Frequencia de uma variável
sextable <- table(Tabela_1_All$sexo)
sextable

# Média de uma variável
mean(Tabela_1_All$idade)