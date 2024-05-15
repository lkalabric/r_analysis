#GEOBR APRENDIZADO /// GILMAR RIBEIRO-JR

#CARREGAR PACOTES

install.packages("geobr", dependencies = T)

library(geobr)
library(sf)
library(magrittr)
library(dplyr)
library(ggplot2)

#GERAR E REMOVER OS VETORES
#remove(BA_GEO,DB_GEO,DBGEO,ERICO,GEOREF,municipios)

GEOBR_DATA = list_geobr()
BA_GEO = read_municipality(code_muni = 29, year = 2020)
BA = read_state(code_state = 29)
BIOMA = read_biomes(year = 2019)
MESO_BA = read_meso_region(code_meso = 29, year = 2020)
BRASIL = read_country(year = 2020)
SALVADOR = read_municipality(code_muni = 2927408, year = 2020)
SINES = read_municipality(code_muni = 2927903, year = 2020)
Saude = read_health_facilities(code_muni = 29)

#GERAR OS MAPAS
#Opção 1 - Gerar e sobrepor mapas.
# Brasil e Bahia
ggplot() + 
  geom_sf(data = BRASIL, fill="#2D3E50", color="#FEBF57", size=0.15, show.legend = T) + 
  geom_sf(data = BA_GEO, fill="#2D3E50", color="#FEBF57", size=0.15, show.legend = T)

# Bahia e Santa Inês
ggplot() + 
  geom_sf(data = BRASIL, fill="#2D3E50", color="#FEBF57", size=0.15, show.legend = T) +
  geom_sf(data = BA, fill="white", color="#FEBF57", size=0.15, show.legend = T) + 
  geom_sf(data = SINES, fill="black", color="black", size=0.15, show.legend = T) +
  geom_sf(data = SINES, aes(fill = name_muni))


ggplot() + 
  geom_sf(data = SINES, fill="#2D3E50", color="#FEBF57", size=0.15, show.legend = T)

#opção 2 - Plot, simples e fácil.               
plot(BRASIL)
plot(BIOMA)
plot(BA)

#opção 3 - Listar o nome das feições.
ggplot() +
  geom_sf(data = MESO_BA, aes(fill = name_meso)) #+ scale_fill_distiller(palette = "Reds")
