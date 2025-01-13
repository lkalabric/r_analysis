# Objetivo: Identificar todos os números com (a) algarismos que produzem uma soma (s) conhecida

# Define a variável soma
s <- 10

# Definindo a variável a que corresponde ao numero de algarismos de um numero inteiro j
a <- 2

print(paste("Soma:", s, "Numero de algarismos: ", a))

# Possiveis algarismos
algarismos <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)

# Lista de solucoes
solucoes <- c()

# Definição do universo amostral
j_min <- algarismos[1:a]              # Seleciona os "a" primeiros elementos do vetor algarismos
j_min <- paste(j_min, collapse = "")  # Colapsando as strings em uma única string
j_min <- as.numeric(j_min)            # Convertendo a string de volta para um número
print(j_min)

j_max <- rev(algarismos[(length(algarismos)-(a-1)):length(algarismos)]) # Seleciona os "a" últimos elementos do vetor algarismos
j_max <- paste(j_max, collapse = "")  # Colapsando as strings em uma única string
j_max <- as.numeric(j_max)            # Convertendo a string de volta para um número
print(j_max)

n_solucoes <- 0
# Loop para testar se a soma dos algarismos de um numero j correspondem a s
for (i in j_min:j_max) {
  # Convertendo o número para uma string e depois para uma lista de caracteres
  j_str <- as.character(i)
  j_list_char <- strsplit(j_str, "")[[1]]
  
  # Convertendo a lista de caracteres para uma lista de números inteiros
  j_list_num <- as.integer(j_list_char)
  
  # Verificando se "0" está presente na lista
  tem_zero <- any(j_list_num == 0)
  
  # Imprimindo o resultado dos numeros validos
  if (tem_zero) {
    next
  } else {
    # Removendo elementos duplicados e comparando os comprimentos
    algarismos_repetidos <- length(j_list_char) != length(unique(j_list_char))
  
    if (algarismos_repetidos) {
      next
    } else {
      # Calculando a soma dos elementos
      soma_total <- sum(j_list_num)
      
      if (s == soma_total) {
        solucao_ordenada <- sort(j_list_num)
        
        # Convertendo a lista em uma string, separando cada elemento por ""
        string_numeros <- paste(solucao_ordenada, collapse = "")
        
        # Convertendo a string em um número inteiro
        numero_final <- as.numeric(string_numeros)
        
        solucoes <- c(solucoes, numero_final)
        
        # Removendo elementos duplicados e comparando os comprimentos
        solucao_repetida <- length(solucoes) != length(unique(solucoes))
        
        if (solucao_repetida) {
          solucoes <- unique(solucoes)
          next
        } else {
          n_solucoes <- n_solucoes + 1
        
            # Imprimindo a lista final
          print(paste("Solucao: ", n_solucoes))
          
          # Imprimindo a lista final
          print ("Algarismos do numero: ")
          print(j_list_num)
        }
      }
    }
  }
}




