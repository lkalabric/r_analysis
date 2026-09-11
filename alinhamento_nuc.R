if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Biostrings")

library(Biostrings)

# 1. Configura o diretório de trabalho
setwd("C:/Users/Luciano Kalabric/Downloads")

# 1. Carregar as sequências a partir de arquivos FASTA
# Substitua 'seq1.fasta' e 'seq2.fasta' pelos caminhos dos seus arquivos
seq1 <- readDNAStringSet("sequence1.fasta")
seq2 <- readDNAStringSet("sequence2.fasta")

# 2. Definir a matriz de substituição de nucleotídeos
# A matriz 'NUCLEOTIDE_MIX' atribui pontuações para correspondências (matches) e divergências (mismatches)
matriz_subst <- nucleotideSubstitutionMatrix(match = 1, mismatch = -1, baseOnly = TRUE)

# 3. Executar o alinhamento global (Needleman-Wunsch)
alinhamento <- pairwiseAlignment(
  pattern = seq1[[1]],
  subject = seq2[[1]],
  type = "global",
  substitutionMatrix = matriz_subst,
  gapOpening = 10,
  gapExtension = 0.5
)

# 4. Exibir o resultado detalhado no console
print(alinhamento)

# 5. Calcular e exibir estatísticas do alinhamento
cat("\n--- Estatísticas do Alinhamento ---\n")
cat("Score:", score(alinhamento), "\n")
cat("Identidade (%):", pid(alinhamento), "\n")

# 6. Salvar o resultado em um arquivo de texto
writePairwiseAlignments(alinhamento, file = "alinhamento_resultado.txt")