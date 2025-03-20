# Script para combinar rasters de diferentes biomas em um único raster para o Brasil.
#
# O script carrega rasters de precipitação de diferentes biomas (Amazônia, Pampa, Pantanal, Cerrado, Caatinga e Mata Atlântica),
# combina-os usando a função `mosaic` do pacote `terra` e salva o raster combinado em uma pasta de saída.

# Grupo de Carbono no Solo, LAPIG - UFG
# Contato: cardoso.mvs@gmail.com

#-----
# INSTRUÇÕES PARA UTILIZAR O SCRIPT:
#
# 1. INSTALAÇÃO DAS BIBLIOTECAS NECESSÁRIAS:
#    - Abra o R ou RStudio.
#    - Instale a biblioteca `terra` executando o comando abaixo no console do R:
#
#      install.packages("terra")
#
#    OBS: A biblioteca `terra` é usada para manipulação de rasters.
#
# 2. PREPARAÇÃO DOS ARQUIVOS:
#    - Certifique-se de que os rasters para cada bioma estão organizados em pastas separadas,
#      seguindo o padrão de nomenclatura "prec-<bioma>" ou "temp-<bioma>".
#    - Defina o caminho base onde as pastas dos biomas estão localizadas.
#
# 3. CONFIGURAÇÃO DO SCRIPT:
#    - Altere o caminho base (caminho_base) e o caminho de saída (caminho_saida) conforme necessário.
#    - Execute o script.
#
#-----


library(terra)

# Defina os caminhos das pastas
caminho_base <- "D:/Projetos-Lapig/century/rasters/chelsea_climate_1km"
biomas <- c("amazonia", "pampa", "pantanal", "cerrado", "caatinga", "mataatlantica")
caminho_saida <- "D:/Projetos-Lapig/century/rasters/chelsea_climate_1km/prec-brasil"

# Crie a pasta de saída se não existir
if (!dir.exists(caminho_saida)) {
  dir.create(caminho_saida, recursive = TRUE)
}

# Liste os arquivos TIF de um dos biomas (assumindo que todos têm os mesmos nomes)
arquivos <- list.files(path = file.path(caminho_base, "prec-amazonia"), 
                       pattern = "\\.tif$", 
                       full.names = TRUE)

# Processe cada arquivo
for (arquivo in arquivos) {
  # Leia os rasters de cada bioma
  rasters <- lapply(biomas, function(bioma) {
    rast(file.path(caminho_base, paste0("prec-", bioma), basename(arquivo))) ##adaptado para precipitação, utilize tmax ou tmin, para temperatura.
  })
  
  # Combine os rasters usando a função `mosaic`
  raster_brasil <- do.call(mosaic, c(rasters, fun = "mean"))
  
  # Salve o raster combinado
  nome_saida <- file.path(caminho_saida, basename(arquivo))
  writeRaster(raster_brasil, filename = nome_saida)
}