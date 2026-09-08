# Instalar pacote caso não tenha
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("Biostrings")

library(Biostrings)

# 1. Carregar sequências de proteínas e peptídeos
# 1. Caminho do seu arquivo contendo a lista de acessos
# (O arquivo deve conter um número de acesso por linha, ex: NC_001653)
setwd("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2025 Kalabric - HDV/Dados da pesquisa/Mapeamento/"
proteinas <- readAAStringSet("HDV_Brazil_196_protein_sequences.fasta")
peptideos <- readAAStringSet("peptides.fasta")

# 2. Mapeamento/Alinhamento de um peptídeo específico na referência
# Permite buscar correspondências exatas ou com até 'max.mismatch' diferenças
alinhamentos <- vmatchPattern(
  pattern = peptideos[[1]],      # Primeiro peptídeo
  subject = proteinas,            # Banco de proteínas
  max.mismatch = 1                # Tolera 1 erro (opcional)
)

# 3. Visualizar posições encontradas
alinhamentos