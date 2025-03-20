# CHELSA-Climate-Data-Processing
This repository contains a collection of scripts designed to process climate data from CHELSA (chelsa-climate.org). The scripts facilitate the download, unit conversion, cropping by biome, and merging of raster data for precipitation, min temperature, and max temperature. The processed data can be used for various environmental and climate studies.

Files:
# 0_automatic_download_CHELSA.py

Description: This Python script automates the download of CHELSA rasters using links provided in text files. It downloads the rasters for precipitation, minimum temperature, and maximum temperature and saves them to specified directories.

Usage: Ensure the text files containing the download links are correctly set. Run the script to download the rasters.

# 1_convert_units_crop_biome_prec.R

Description: This script processes precipitation rasters from CHELSA. It converts the units (dividing by 100 and rounding), crops the rasters to a specified biome, and saves the processed rasters to an output directory.

Usage: Ensure the input rasters are in the specified input directory and the biome shapefile is correctly set. Run the script to process the rasters.

# 1_convert_units_crop_biome_tmin_tmax.R

Description: This script processes temperature rasters (minimum and maximum) from CHELSA. It converts the units (dividing by 10 and subtracting 273.15), crops the rasters to a specified biome, and saves the processed rasters to an output directory.

Usage: Ensure the input rasters are in the specified input directory and the biome shapefile is correctly set. Run the script to process the rasters.

# 2_merge_rasters_BR.R

Description: This script combines rasters from different biomes (Amazon, Pampa, Pantanal, Cerrado, Caatinga, and Atlantic Forest) into a single raster for Brazil. It uses the mosaic function from the terra package to merge the rasters.

Usage: Ensure the rasters for each biome are organized in separate folders. Run the script to combine the rasters.

Instructions:
Install Required Libraries:

For R scripts, install the necessary libraries using the following commands in R or RStudio:

R
Copy
install.packages("raster")
install.packages("sf")
install.packages("terra")

For the Python script, install the required library using the following command in the command prompt:
Copy
pip install requests
Prepare the Files:

Ensure the input rasters and shapefiles are correctly placed in the specified directories.

For the Python script, ensure the text files containing the download links are correctly set.

Configure the Scripts:

Adjust the input and output directories in the scripts as needed.

Set the correct paths for the shapefiles and text files.

Run the Scripts:

Execute the scripts in the appropriate environment (R for R scripts, Python for the Python script).

Contact:
For any questions or issues, please contact: cardoso.mvs@gmail.com
