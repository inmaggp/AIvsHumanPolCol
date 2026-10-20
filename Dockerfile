FROM rocker/r-ver:4.5.3

RUN apt update && \
    apt install -y curl make git pandoc cmake libgit2-dev libharfbuzz-dev libfribidi-dev libtiff-dev libjpeg-dev libcairo2-dev default-jdk libfontconfig1-dev

WORKDIR /root/tbv

## Pin all packages to 2026-07-23

RUN Rscript -e "options(repos = 'https://packagemanager.posit.co/cran/__linux__/noble/2026-07-23'); install.packages('pak', lib=.Library); pak::pak(c('openxlsx', 'readr', 'readxl', 'sentencepiece', 'text', 'caret', 'dplyr', 'ggplot2', 'here', 'irr', 'RColorBrewer', 'scales', 'stringi', 'stringr', 'tibble', 'tidyr', 'viridis', 'writexl', 'rmarkdown', 'bookdown', 'corrplot', 'Hmisc'))"

## initialize to install also nltk's punkt
RUN Rscript -e "library('text'); textrpp_install(prompt = FALSE); textrpp_initialize()"

CMD ["R"]
