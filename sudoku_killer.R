# Objetivo: Calcular as possiveis solucoes para a soma dos algarismos de um numero

# Define a variavel soma
s <- 22

# Definindo a variável a que corresponde ao numero de algarismos de um numero inteiro j
a <- 4

print(paste("Soma:", s, "Numero de algaritimos: ", a))

# Possiveis algarismos
algarismos <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)

# Lista de solucoes
solucoes <- c()

j_min <- 0
# Loop para criar um numero minimo formado por "a" algarismos que nao se repetem
for (j in 1:a) {
    j_min <- j_min + algarismos[j]*10^(a-j)
}
print(j_min)

j_max<-0
# Loop para criar um numero maximo formado por "a" algarismos que nao se repetem
for (j in 1:a) {
  j_max <- j_max + algarismos[length(algarismos)+1-j]*10^(a-j)
}
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




