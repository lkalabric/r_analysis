# 1. Instalar e carregar os pacotes necessários
if (!requireNamespace("countrycode", quietly = TRUE)) install.packages("countrycode")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("purrr", quietly = TRUE)) install.packages("purrr")
# if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
if (!requireNamespace("rentrez", quietly = TRUE)) install.packages("rentrez")
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")

library(countrycode)
library(dplyr)
library(purrr)
# library(readr)
library(rentrez)
library(rlang)
library(tidyverse)

# --- FUNÇÃO DE BUSCA NO NCBI ---
get_metadata <- function(acc_number) {
  # Mensagem de progresso no console
  cat("Buscando dados para o acesso:", acc_number, "...\n")
  
  tryCatch({
    # Busca o registro no banco 'protein' (proteínas) em formato GenBank
    gb_text <- entrez_fetch(
      db = "protein", # db = "nuccore" para nucleotide 
      id = acc_number, 
      rettype = "gb", 
      retmode = "text"
    )
    
    # Busca o registro no banco 'protein' (proteínas) em formato FASTA
    # fasta_data <- entrez_fetch(db = "protein", id = acc_number, rettype = "fasta")
    
    # Função auxiliar para garantir que SEMPRE retorne 1 elemento (texto ou NA)
    extract_one <- function(text, pattern) {
      res <- str_extract(text, pattern)
      if (is.na(res) || length(res) == 0) return(NA_character_)
      return(res)
    }
    
    # Extrai as protein_IDs presentes nas regiões CDS
    # protein_id_ext <- extract_one(gb_text, '(?<=/protein_id=")[^"]+')
    
    # Extrai o isolado das sequencias
    isolate_ext <- extract_one(gb_text, '(?<=/isolate=")[^"]+')
    isolate_ext <- if(is.na(isolate_ext)) extract_one(gb_text, '(?<=/strain=")[^"]+') else isolate_ext
    
    # Extrai o país de origem das sequencias
    origin_ext <- extract_one(gb_text, '(?<=/geo_loc_name=")[^"]+')
    
    # Converte o nome do país em inglês para o código de 3 letras (ISO3)
    country_iso3 <- countrycode(origin_ext, origin = "country.name", destination = "iso3c")
    
    # Extrai a data da coleta
    collection_date_ext <- extract_one(gb_text, '(?<=/collection_date=")[^"]+')
    
    # Extrai o genótipo das sequencias
    genotype_ext <- extract_one(gb_text, '(?<="genotype: )[^"]+')
    
    # Extrai as sequências de aminoácidos (translation)
    # translations_raw <- extract_one(gb_text, '(?<=/translation=")[^"]+')
    
    # Remove quebras de linha e espaços da sequência de aminoácidos
    # translations <- map_chr(translations_raw, ~ str_replace_all(.x, "[\\s\\n\\r]+", ""))
    
    # Remove quebras de linha e espaços da sequência de aminoácidos
    # fasta_ext <- map_chr(fasta_data, ~ str_replace_all(.x, "[\\s\\n\\r]+", ""))
    
    # Caso o acesso não possua CDS/protein_id cadastrada
    if (length(protein_id_ext) == 0) {
      return(tibble(
        accession = acc_number, 
        # protein_id = NA_character_, 
        isolate = isolate_ext,
        origin = origin_ext,
        country = country_iso3,
        collection_date = collection_date_ext,
        genotype = genotype_ext,
        # translation = NA_character_,
        # fasta = fasta_ext
      ))
    }
    
    # Retorna uma tabela estruturada
    tibble(
      accession = acc_number,
      # protein_id = protein_id_ext,
      isolate = isolate_ext,
      origin = origin_ext,
      country = country_iso3,
      collection_date = collection_date_ext,
      genotype = genotype_ext,
      # translation = translations,
      # fasta = fasta_ext
    )
    
  }, error = function(e) {
    warning(paste("Erro ao processar o acesso:", acc_number, "-", e$message))
    return(tibble(
      accession = acc_number, 
      # protein_id = NA_character_, 
      isolate = isolate_ext,
      origin = origin_ext,
      country = country_iso3,
      collection_date = collection_date_ext,
      genotype = genotype_ext,
      # translation = NA_character_,
      # fasta = fasta_ext
    ))
  })
}

# --- PROCESSAMENTO DO ARQUIVO DE ENTRADA ---

# 1. Configura o diretório de trabalho
setwd("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/Projetos/2025 Kalabric - HDV/Dados da pesquisa/Refseq/Genbank")

# 2. Caminho do seu arquivo contendo a lista de acessos
# (O arquivo deve conter um número de acesso por linha, ex: NC_001653)
arquivo_entrada <- "HDV_4272_sequences_protein.list"

# 3. Ler a lista de acessos
# 'read_lines' remove espaços em branco e linhas vazias automaticamente
acessos <- read_lines(arquivo_entrada) %>% 
  str_trim() %>% 
  .[. != ""]

cat("Total de acessos encontrados no arquivo:", length(acessos), "\n\n")

# 4. Executar a busca para todos os acessos do arquivo
# (Utiliza map_df do purrr/tidyverse para unir os resultados)
df_resultados <- map_df(acessos, get_metadata)

# 5. Exibir o resultado no console
print(df_resultados)

# 6. Salvar o resultado final em uma tabela CSV
write_csv(df_resultados, "HDV_4272_sequences_protein_metadados.csv")
cat("\nProcesso concluído! Arquivo salvo como 'HDV_4272_sequences_protein_metadados.csv'.\n")

