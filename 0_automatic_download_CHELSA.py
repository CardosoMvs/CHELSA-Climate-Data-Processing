"""
Script para download automático de rasters via links disponibilizados pelo CHELSA.
Pode ser adaptado para outros links.

O script acessa um arquivo TXT contendo os links e faz o download dos arquivos para a pasta desejada.

Grupo de Carbono no Solo, LAPIG - UFG
Contato: cardoso.mvs@gmail.com
"""

#-----
# INSTRUÇÕES PARA UTILIZAR O SCRIPT:
#
# 1. INSTALAÇÃO DAS BIBLIOTECAS NECESSÁRIAS:
#    - Abra o prompt de comando (cmd):
#      * No Windows, pressione WIN + R, digite "cmd" e pressione ENTER.
#    - Cole individualmente os comandos abaixo no prompt de comando (sem o "#") e pressione ENTER:
#
#      pip install requests
#
#    OBS: A biblioteca "os" já vem instalada por padrão no Python, não sendo necessário instalá-la.
# 2. DOWNLOAD DOS ARQUIVOS DE TEXTO:
#    - Baixe os arquivos de texto com os links dos rasters que deseja baixar:
#     * chelsa-climate: https://chelsa-climate.org/downloads/
#
# 3. CONFIGURAÇÃO DO SCRIPT:
#    - Altere os caminhos dos arquivos TXT (chelsa_tmax.txt, chelsa_tmin.txt, chelsa_prec.txt)
#      e da pasta de destino (pasta_downloads) conforme necessário.
#    - Execute o script.
#
#-----

import os
import requests

# Caminho dos arquivos de texto com os links
caminho_tmax = r"C:\Users\marco\Downloads\chelsa_tmax.txt"
caminho_tmin = r"C:\Users\marco\Downloads\chelsa_tmin.txt"
caminho_prec = r"C:\Users\marco\Downloads\chelsa_prec.txt"

# Pasta onde os arquivos serão salvos
pasta_downloads = r"D:\Projetos-Lapig\century\rasters\chelsea_climate_1km"

# Criar pastas para tmax, tmin e prec
pastas = {
    "tmax": os.path.join(pasta_downloads, "tmax"),
    "tmin": os.path.join(pasta_downloads, "tmin"),
    "prec": os.path.join(pasta_downloads, "prec"),
}

for pasta in pastas.values():
    if not os.path.exists(pasta):
        os.makedirs(pasta)

# Função para baixar arquivos de uma lista de links
def baixar_arquivos(caminho_txt, pasta_destino):
    with open(caminho_txt, "r") as arquivo:
        links = arquivo.read().splitlines()  # Ler todos os links do arquivo

    for link in links:
        link = link.strip()  # Remover espaços em branco no início e no final do link
        if link:  # Verificar se o link não está vazio
            nome_arquivo = link.split("/")[-1]  # Extrair o nome do arquivo do link
            caminho_completo = os.path.join(pasta_destino, nome_arquivo)

            print(f"Baixando {nome_arquivo}...")
            try:
                resposta = requests.get(link, stream=True)
                resposta.raise_for_status()  # Verificar se o download foi bem-sucedido

                with open(caminho_completo, "wb") as arquivo:
                    for chunk in resposta.iter_content(chunk_size=8192):
                        if chunk:
                            arquivo.write(chunk)
                print(f"{nome_arquivo} baixado com sucesso!")
            except Exception as e:
                print(f"Erro ao baixar {nome_arquivo}: {e}")

# Baixar arquivos para cada categoria
baixar_arquivos(caminho_tmax, pastas["tmax"])
baixar_arquivos(caminho_tmin, pastas["tmin"])
baixar_arquivos(caminho_prec, pastas["prec"])

print("Todos os downloads foram concluídos!")