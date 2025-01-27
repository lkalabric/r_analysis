Carregando os dados .csv obtidos do Excel diretamente para uma data.frame em R devemos usar a função read.csv2 ao invés de read.csv...

# Carregando os dados de um arquivo .csv na Fiocruz
dados <- read.csv("C:/Users/bianc/Desktop/IC FIOCRUZ\Análise validação dos métodos moleculares 20250113 BF.csv", sep=",")

# Carregando os dados de um arquivo .csv no laptop ASUS
dados <- read.csv2("C:/Users/bianc/Desktop/IC FIOCRUZ/Análise validação dos métodos moleculares 20250113 BF.csv")

# Para confirmar a classe de uma variável
View(dados)
class(dados)

# Carregar as bibliotecas necessárias
library(pROC)

# transformar a coluna controle em um fator, definindo os níveis como "negativo" e "positivo".
dados$controle <- factor(dados$controle, levels = c("negativo", "positivo"))

# calcula a curva ROC usando os dados fornecidos.
roc_curve <- roc(dados$controle, dados$A260.media)

# Calcular o valor AUC
auc_value <- auc(roc_curve)
print(paste("AUC: ", auc_value))

# plotar a curva ROC calculada.
plot(roc_curve, col = "blue", main = "Curva ROC para A260.media")
legend("bottomright", legend = c("A260.media"), col = c("blue"), lwd = 2)

# Adicionar o valor da AUC ao gráfico
text(0.0, 0.75, paste("AUC =", round(auc_value, 2)), col = "blue")

# Analisando dois dados simultaneamente....Esse script calculará e plotará as curvas ROC para as colunas a260_1 e a260_2
#com base na mesma classe controle. 

# Carregar as bibliotecas necessárias
library(ggplot2)

# Criar um data frame com os dados fornecidos
dados <- data.frame(
  controle = c("positivo", "negativo", "positivo", "negativo", 
               "positivo", "negativo", "positivo", "negativo", 
               "positivo", "negativo", "positivo", "negativo", 
               "positivo", "negativo", "positivo", "negativo", 
               "positivo", "negativo", "positivo", "negativo", 
               "positivo", "negativo", "positivo", "negativo", 
               "positivo"),
  a260_1 = c(333.4, 106.9, 246, 34.7, 385.3, 61.4, 52.6, 247.6, 202.4, 195.4, 605, 6.6, 51.7, 18.4, 54, 14.1, 4.2, 3.3, 9.6, 127.2, 14.8, 772.8, 98.2, 30.5, 1.9),
  a260_2 = c(298.6, 198.4, 243.1, 34, 412.9, 61.1, 52.9, 249.6, 209.6, 198.1, 624.4, 6.8, 57.7, NA, 60.4, 14.2, 4.6, 3.5, 9.6, 131.5, 15, 773.7, 105.5, 31.2, 1.9)
)

# Remover valores NA para evitar problemas na análise
dados <- na.omit(dados)

# Transformar a coluna 'controle' em fator
dados$controle <- factor(dados$controle, levels = c("negativo", "positivo"))


# Calcular as curvas ROC para a260_1 e a260_2
roc_a260_1 <- roc(dados$controle, dados$a260_1, direction = "<")
roc_a260_2 <- roc(dados$controle, dados$a260_2, direction = "<")

# Calcular os valores AUC
auc_a260_1 <- auc(roc_a260_1)
auc_a260_2 <- auc(roc_a260_2)

# Preparar dados para ggplot2
df_roc_a260_1 <- data.frame(
  TPR = roc_a260_1$sensitivities,
  FPR = 1 - roc_a260_1$specificities,
  curva = "a260_1"
)

df_roc_a260_2 <- data.frame(
  TPR = roc_a260_2$sensitivities,
  FPR = 1 - roc_a260_2$specificities,
  curva = "a260_2"
)

# Combinar os data frames
df_roc <- rbind(df_roc_a260_1, df_roc_a260_2)


# Plotar as curvas ROC usando ggplot2
ggplot() +
  geom_line(data = df_roc_a260_1, aes(x = FPR, y = TPR, color = "a260_1"), linewidth = 1) +
  geom_line(data = df_roc_a260_2, aes(x = FPR, y = TPR, color = "a260_2"), linewidth = 1) +
  labs(title = "Curvas ROC para a260_1 e a260_2",
       x = "Taxa de Falsos Positivos (1 - Especificidade)",
       y = "Taxa de Verdadeiros Positivos (Sensibilidade)") +
  theme_minimal() +
  scale_color_manual(values = c("a260_1" = "blue", "a260_2" = "red")) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "grey") +
  annotate("text", x = 0.75, y = 0.25, label = paste("AUC a260_1 =", round(auc_a260_1, 2)), color = "blue") +
  annotate("text", x = 0.75, y = 0.20, label = paste("AUC a260_2 =", round(auc_a260_2, 2)), color = "red")
