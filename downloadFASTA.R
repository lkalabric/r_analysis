# downloadFASTA.R
# Autores: Luciano Kalabric & Aline Fernandes com ajuda do Gemini

# Preparação do ambiente, instalação do pacote rentrez do repositório BiocManager
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("rentrez")

# Carregar o pacote
library(rentrez)

# Diretório ou pasta de trabalho
setwd("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2025 Kalabric & Aline/Dados da pesquisa/Genbank")

# 1. Definir o diretório onde os arquivos serão salvos
# ATENÇÃO: Substitua "/caminho/para/salvar/arquivos_genbank" pelo seu diretório desejado
output_dir <- "./genbank_sequences" # Exemplo: Salva em uma pasta chamada 'genbank_sequences' no diretório de trabalho atual

# 2. Criar o diretório de saída se ele não existir
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  message(paste("Diretório de saída criado:", output_dir))
} else {
  message(paste("Diretório de saída já existe:", output_dir))
}

# 3. Lista de identificadores GenBank (IDs de acesso)
# Exemplo: IDs para algumas sequências de nucleotídeos
genbank_ids <- c(
  "AB000263", # Sequence of Arabidopsis thaliana genomic DNA for AGAMOUS gene
  "AF002223", # Homo sapiens tumor necrosis factor-alpha (TNF-alpha) mRNA
  "AY509204", # Severe acute respiratory syndrome coronavirus Urbani isolate, complete genome
  "DQ377038", # Rattus norvegicus strain BN/MolCrl (BN), complete genome
  "JN000001"  # Exemplo de ID que pode não existir ou ser um placeholder
)

# 4. Iterar sobre a lista de IDs e baixar cada sequência
message("\nIniciando o download das sequências...")

for (id in genbank_ids) {
  # Definir o nome do arquivo de saída (ex: AB000263.fasta)
  file_name <- file.path(output_dir, paste0(id, ".fasta"))
  
  message(paste("Tentando baixar:", id))
  
  # Tentar baixar a sequência
  # db = "nucleotide" para sequências de DNA/RNA
  # rettype = "fasta" para obter no formato FASTA
  # retmode = "text" para obter como texto simples
  tryCatch({
    sequence_data <- entrez_fetch(db = "nucleotide", id = id, rettype = "fasta", retmode = "text")
    
    # Verificar se algum dado foi retornado
    if (nchar(sequence_data) > 0) {
      # Salvar a sequência no arquivo
      writeLines(sequence_data, file_name)
      message(paste("  - Baixado com sucesso:", id, "->", file_name))
    } else {
      warning(paste("  - Nenhum dado retornado para o ID:", id, ". O arquivo pode não ter sido criado ou está vazio."))
    }
    
    # Pequena pausa para evitar sobrecarregar o servidor do NCBI (boa prática)
    Sys.sleep(0.5) # Pausa de 0.5 segundos
    
  }, error = function(e) {
    # Capturar e reportar erros de download
    warning(paste("  - Erro ao baixar o ID:", id, "-", e$message))
  })
}

message("\nProcesso de download concluído.")
message(paste("Verifique os arquivos baixados na pasta:", output_dir))

# Opcional: listar os arquivos baixados para verificar
print(list.files(output_dir))
