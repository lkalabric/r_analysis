# Mapping between genome, transcript and protein coordinates
# References: https://bioconductor.org/packages/release/bioc/vignettes/ensembldb/inst/doc/coordinate-mapping.html
# https://bioconductor.org/packages/release/bioc/html/ensembldb.html
# Authors: Luciano Kalabric & Gabriela
# Date: 03-23-2023

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ensembldb")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("EnsDb.Hsapiens.v86")

library(ensembldb)
library(EnsDb.Hsapiens.v86)

edbx <- filter(EnsDb.Hsapiens.v86, filter = ~ seq_name == "X")
