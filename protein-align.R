# Mapping between genome, transcript and protein coordinates
# References: https://bioconductor.org/packages/release/bioc/vignettes/ensembldb/inst/doc/coordinate-mapping.html
# https://bioconductor.org/packages/release/bioc/html/ensembldb.html
# Authors: Luciano Kalabric & Gabriela
# Date: 03-23-2023

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ensembldb")
BiocManager::install("EnsDb.Hsapiens.v86")
BiocManager::install("Gviz")

library(ensembldb)
library(EnsDb.Hsapiens.v86)

edbx <- filter(EnsDb.Hsapiens.v86, filter = ~ seq_name == "X")
gnm <- GRanges("X:107716399-107716401")

library("Gviz")
## Since we're using Ensembl chromosome names we have to set:
options(ucscChromosomeNames = FALSE)

## Define a genome axis track
gat <- GenomeAxisTrack(range = gnm)

## Get all genes in that region
gnm_gns <- getGeneRegionTrackForGviz(edbx, filter = GRangesFilter(gnm))
gtx <- GeneRegionTrack(gnm_gns, name = "tx", geneSymbol = TRUE,
                       showId = TRUE)

## Generate a higlight track
ht <- HighlightTrack(trackList = list(gat, gtx), range = gnm)
## plot the region
plotTracks(list(ht))
