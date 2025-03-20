# Script para conversão de unidades da precipitação CHELSA e recorte de rasters por bioma.
#
# O script carrega rasters de precipitação de uma pasta de entrada, converte suas unidades (dividindo por 100 e arredondando),
# recorta os rasters para o bioma especificado e salva os rasters processados em uma pasta de saída.
#
# Grupo de Carbono no Solo, LAPIG - UFG
# Contato: cardoso.mvs@gmail.com

#-----
# INSTRUÇÕES PARA UTILIZAR O SCRIPT:
#
# 1. INSTALAÇÃO DAS BIBLIOTECAS NECESSÁRIAS:
#    - Abra o R ou RStudio.
#    - Instale as bibliotecas necessárias executando os comandos abaixo no console do R:
#
#      install.packages("raster")
#      install.packages("sf")
#
#    OBS: A biblioteca "raster" é usada para manipulação de rasters, e "sf" para trabalhar com shapefiles.
#
# 2. PREPARAÇÃO DOS ARQUIVOS:
#    - Certifique-se de que os rasters que deseja processar estão na pasta de entrada especificada.
#    - Baixe o shapefile do bioma de interesse e defina o caminho correto no script.
#
# 3. CONFIGURAÇÃO DO SCRIPT:
#    - Altere os caminhos das pastas de entrada (input_dir) e saída (output_dir) conforme necessário.
#    - Defina o caminho do shapefile do bioma (shapefile_path).
#    - Execute o script.
#
#-----

# Carregar pacotes necessários
library(raster)
library(sf)
# library(rgdal)

# Definir diretórios
input_dir <- "D:/Projetos-Lapig/century/rasters/chelsea_climate_1km/prec/"
output_dir <- "D:/Projetos-Lapig/century/rasters/chelsea_climate_1km/prec-mataatlantica/"
# shapefile_path <- "C:/Users/marco/Downloads/BR_Pais_2023/BR_Pais_2023.shp"
shapefile_path <- "D:/Projetos-Lapig/century/rasters/0_shp_bioma/Biomas_250mil/Mataatlantica.shp"

# Ler o shapefile
brasil <- st_read(shapefile_path)

# Listar todos os arquivos raster na pasta de entrada
raster_files <- list.files(input_dir, pattern = ".tif$", full.names = TRUE)

# Função para processar cada raster
process_raster <- function(raster_path) {
  # Ler o raster
  r <- raster(raster_path)
  
  # Recortar o raster para o Brasil
  r_cropped <- crop(r, brasil)
  r_masked <- mask(r_cropped, brasil)
  
  # Converter as unidades do raster
  r_converted <- round(r_masked / 100)
  
  # Definir o nome do arquivo de saída
  output_file <- file.path(output_dir, basename(raster_path))
  
  # Salvar o raster processado
  writeRaster(r_converted, filename = output_file, format = "GTiff", overwrite = TRUE)
  
  print(paste("Arquivo salvo:", output_file))
}

# Aplicar a função a todos os rasters
lapply(raster_files, process_raster)

print("Processamento concluído!")