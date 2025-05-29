# Script: Acessar o NCBI e baixar arquivos .gb, extrair dados do arquivo
# Autor: Luciano Kalabric

# Preparação do ambiente
list.of.packages <- c("read.gb", "rentrez")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Carregar as bibliotecas necessárias
library(rentrez)
library(read.gb) # Lê arquivos .gb

#
# Método 1 - Ler os dados de um arquivo .gb baixado diretamente do Genbank através da Web
#
# Link: https://cran.r-project.org/web/packages/rentrez/vignettes/rentrez_tutorial.html
require(rentrez) # Importa dados diretamente do Genbank
data <- rentrez::entrez_fetch(db = "Nucleotide", id = "AB037947", rettype = "gb") 
gb <- read.gb(data, DNA = TRUE, Type = "full", Source = "Char")
traducao <- extract.gb(gb, "CDS")
print(traducao)

#
# Método 2 - Ler os dados de um arquivo .gb baixado em um diretório de trabalho
#
# Configura o diretório de trabalho
setwd("C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/GitHub/r_analysis/datasets")

# read.gb Opens files with .gb extensions
gb <- read.gb("AB037947.gb", DNA = TRUE, Type = "full", Source = "File")

# extract.gb Extracts and returns a specific item from .gb records
extract.gb(gb, "CDS")


#
# Método 3 - Ler os dados de múltiplos arquivos .gb armazenados em um diretório de trabalho, processar os arquivos e gerar um multiseqeunce FASTA
#
# Define o caminho do diretório que você quer ler
# Substitua "/caminho/para/seu/diretorio" pelo caminho real do seu diretório
diretorio_alvo <- "C:/Users/luciano.kalabric/OneDrive - FIOCRUZ/GitHub/r_analysis/datasets" # Exemplo para Windows
# diretorio_alvo <- "/home/seu_usuario/documentos/meus_arquivos" # Exemplo para Linux/macOS

# Verifica se o diretório existe
if (!dir.exists(diretorio_alvo)) {
  stop("O diretório especificado não existe. Por favor, verifique o caminho.")
}

# Lista todos os arquivos no diretório
# full.names = FALSE (padrão) retorna apenas o nome do arquivo
# full.names = TRUE retornaria o caminho completo do arquivo
nomes_arquivos <- list.files(path = diretorio_alvo, pattern = "*.gb", full.names = FALSE)

# Cria um data frame com os nomes dos arquivos
df_nomes_arquivos <- data.frame(NomeDoArquivo = nomes_arquivos)

# Exibe o data frame resultante
print(df_nomes_arquivos)

# Você pode verificar a estrutura do data frame
# str(df_nomes_arquivos)

# Você também pode verificar o número de arquivos encontrados
# nrow(df_nomes_arquivos)

