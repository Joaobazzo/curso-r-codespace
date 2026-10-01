# ------------------------------------------------------------------
# preparar.R
# Roda automaticamente uma vez, quando o Codespace é criado.
# 1. instala os pacotes do Módulo 1 que não vêm na imagem
# 2. baixa e descompacta os dados do Módulo 1 (Release do GitHub)
# 3. configura o RStudio (sessão limpa, abre na pasta do curso)
# ------------------------------------------------------------------

# 1. pacotes ----
# A imagem geospatial já traz tidyverse, sf e terra. Os pacotes abaixo vêm como
# binários do Posit Package Manager, então a instalação leva segundos, não minutos.
pacotes <- c(
  "readr", "readxl", "writexl", "data.table", "duckplyr",
  "dplyr", "tidyr", "stringr", "lubridate", "forcats", "janitor",
  "ggplot2", "scales", "patchwork", "classInt", "ggrepel",
  "knitr", "rmarkdown", "renv", "reprex"
)
faltando <- setdiff(pacotes, rownames(installed.packages()))
if (length(faltando) > 0) install.packages(faltando)

ainda <- setdiff(pacotes, rownames(installed.packages()))
if (length(ainda) > 0) stop("Falhou a instalação de: ", paste(ainda, collapse = ", "))

# 2. dados ----
url_dados <- paste0(
  "https://github.com/Joaobazzo/curso-r-transportes/releases/download/",
  "dados-modulo1/dados_modulo1.zip"
)
if (!file.exists("dados/cabotagem_tku_2025.xlsx")) {
  zip <- tempfile(fileext = ".zip")
  options(timeout = 600)
  download.file(url_dados, zip, mode = "wb")
  unzip(zip, exdir = ".")   # o zip já contém a pasta dados/
  unlink(zip)
}
stopifnot(file.exists("dados/cabotagem_tku_2025.xlsx"))

# 3. preferências do RStudio ----
# Mesmas recomendações do capítulo de ambiente: nunca salvar nem restaurar o
# .RData, e abrir já dentro da pasta do curso. knit_working_dir = "project" faz os
# blocos dos .qmd em modulo1/ rodarem a partir da raiz, onde está dados/.
dir_prefs <- path.expand("~/.config/rstudio")
dir.create(dir_prefs, recursive = TRUE, showWarnings = FALSE)
writeLines(
  jsonlite::toJSON(
    list(
      initial_working_directory = getwd(),
      save_workspace = "never",
      load_workspace = FALSE,
      always_save_history = FALSE,
      knit_working_dir = "project",
      rmd_chunk_output_inline = TRUE
    ),
    auto_unbox = TRUE, pretty = TRUE
  ),
  file.path(dir_prefs, "rstudio-prefs.json")
)

message("\nAmbiente pronto: ", R.version.string, ", ", length(pacotes), " pacotes, dados do Módulo 1.")
