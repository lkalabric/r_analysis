# Se não tiver instalado:
BiocManager::install("Biostrings")
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")

library(Biostrings)
library(tidyverse)
#library(dplyr)

# 1. Configura o diretório de trabalho
setwd("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2025 Kalabric - HDV/Dados da pesquisa/Refseq/Genbank")

# 2. Lê o arquivo FASTA (substitua "meu_arquivo.fasta" pelo nome do seu arquivo)
fasta_data <- readAAStringSet("HDV_4272_sequences_protein.fasta")  # Use readDNAStringSet se for DNA/RNA

# Carrega um arquivo FASTA de proteínas
# pep <- readAAStringSet("suas_proteinas.fasta")

# Limpa lacunas antigas ou caracteres desconhecidos
# pep_clean <- AAStringSet(gsub("[^ACDEFGHIKLMNPQRSTVWY]", "", as.character(pep)))

# 3. Converte para data.frame
tabela_seqs <- data.frame(
  label = names(fasta_data),
  sequencia = as.character(fasta_data),
  stringsAsFactors = FALSE
)

# 4. Garante remoção de eventuais espaços/quebras extras e remove o '>' se houver
tabela_seqs <- tabela_seqs %>%
  mutate(
    label = gsub("^>", "", label),
    sequencia = gsub("\\s+", "", sequencia)
  )

# 5. Exibe o resultado
head(tabela_seqs)

# 6. Salvar o resultado final em uma tabela CSV
# write_csv(tabela_seqs, "HDV_4272_sequences_protein_table.csv")
 write_tsv(tabela_seqs, "HDV_4272_sequences_protein_table.tsv")
cat("\nProcesso concluído! Arquivo salvo como 'HDV_4272_sequences_protein_table.csv'.\n")

