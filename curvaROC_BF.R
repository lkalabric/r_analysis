# title: "tabelas"
# author: "Bianca Ferreira"
# date: "2025-01-14"
# output: html_document

# Instala os pacotes requeridos para o script
list.of.packages <- c("dplyr","pROC", "ggplot2")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Carregando os dados .csv obtidos do Excel diretamente para uma data.frame em R devemos usar a função read.csv2 ao invés de read.csv...
# Carregando os dados de um arquivo .csv na pasta datasets
dados <- read.csv2("C:/Users/kalab/OneDrive - FIOCRUZ/GitHub/r_analysis/datasets/dados_curvaROC.csv")

# Para confirmar a classe de uma variável
View(dados)
class(dados)

# Carregar as bibliotecas necessárias
library(dplyr)
library(pROC)

# Transformar a coluna controle em um fator, definindo os níveis como "negativo" e "positivo".
dados_recodificado <- dados %>%
  mutate(controle = recode(controle, "1" = "positivo", "2" = "negativo"))

# Filtrando os dados usando o operador %in%
dados_filtrados <- dados_recodificado[dados_recodificado$controle %in% c("positivo", "negativo"), ]

# Removendo os registros com dados faltantes NA em 'a260_media' ou 'a260_a280_media'
dados_sem_na <- dados_filtrados[complete.cases(dados_filtrados$a260_media) | (dados_filtrados$a260_a280_media), ]

# calcula a curva ROC usando os dados fornecidos.
roc_curve <- roc(dados_sem_na$controle, dados_sem_na$a260_media)

# Calcular o valor AUC
auc_value <- auc(roc_curve)
print(paste("AUC: ", auc_value))

# plotar a curva ROC calculada.
plot(roc_curve, col = "blue", main = "Curva ROC para A260.media")
legend("bottomright", legend = c("A260.media"), col = c("blue"), lwd = 2)

# Adicionar o valor da AUC ao gráfico
text(0.0, 0.75, paste("AUC =", round(auc_value, 2)), col = "blue")

# Analisando e plotando dois dados simultaneamente
# Carregar as bibliotecas necessárias
library(ggplot2)

# Calcular as curvas ROC para a260_1 e a260_2
roc_a260_media <- roc(dados_sem_na$controle, dados_sem_na$a260_media)
roc_a260_a280_media <- roc(dados_sem_na$controle, dados_sem_na$a260_a280_media)

# Calcular os valores AUC
auc_a260_media <- auc(roc_a260_media)
print(paste("AUC: ", auc_a260_media))

auc_a260_a280_media <- auc(roc_a260_a280_media)
print(paste("AUC: ", auc_a260_a280_media))

# Preparar dados para ggplot2
df_roc_a260_media <- data.frame(
  TPR = roc_a260_media$sensitivities,
  FPR = 1 - roc_a260_media$specificities,
  curva = "a260_media"
)

df_roc_a260_a280_media <- data.frame(
  TPR = roc_a260_a280_media$sensitivities,
  FPR = 1 - roc_a260_a280_media$specificities,
  curva = "a260_a280_media"
)

# Combinar os data frames
df_roc <- rbind(df_roc_a260_media, df_roc_a260_a280_media)


# Plotar as curvas ROC usando ggplot2
ggplot() +
  geom_line(data = df_roc_a260_media, aes(x = FPR, y = TPR, color = "a260_media"), linewidth = 1) +
  geom_line(data = df_roc_a260_a280_media, aes(x = FPR, y = TPR, color = "a260_a280_media"), linewidth = 1) +
  labs(title = "Curvas ROC para a260_media e a260_a280_media",
       x = "Taxa de Falsos Positivos (1 - Especificidade)",
       y = "Taxa de Verdadeiros Positivos (Sensibilidade)") +
  theme_minimal() +
  scale_color_manual(values = c("a260_media" = "blue", "a260_a280_media" = "red")) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "grey") +
  annotate("text", x = 0.75, y = 0.25, label = paste("AUC a260_media =", round(auc_a260_media, 2)), color = "blue") +
  annotate("text", x = 0.75, y = 0.20, label = paste("AUC a260_a280_media =", round(auc_a260_a280_media, 2)), color = "red")
