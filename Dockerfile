# Use a imagem base do R com Quarto
FROM rocker/verse:latest

# Defina o frontend do Debian como não interativo
ENV DEBIAN_FRONTEND=noninteractive

# Instale o Quarto e dependências do sistema
RUN apt-get update && \
    apt-get install -y wget curl gdebi-core \
    libatk1.0-0 libatk-bridge2.0-0 libxml2-dev libcurl4-openssl-dev libssl-dev \
    libxkbcommon0 libxcomposite1 libxdamage1 libxrandr2 libgbm1 libasound2 libpangocairo-1.0-0 libnss3 libxshmfence1 \
    libgtk-3-0 fonts-texgyre && \
    curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb && \
    gdebi -n quarto-linux-amd64.deb && \
    rm quarto-linux-amd64.deb

# # Aceite automaticamente o EULA e instale as fontes da Microsoft
# RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
#     apt-get install -y ttf-mscorefonts-installer && \
#     fc-cache -f -v

# Copie os arquivos do projeto para o contêiner
WORKDIR /workspace
COPY . .

# Instalar o renv
RUN R --silent --slave --no-save --no-restore -e "install.packages('renv')"

# Instale o languageserver do R e suas dependências
RUN R --silent --slave --no-save --no-restore -e "install.packages('languageserver', repos='https://p3m.dev/cran/__linux__/jammy/latest')"

# Instale o TinyTeX e Chromium usando Quarto
RUN quarto install tinytex
RUN quarto install chromium

# Exponha a porta 8787 para o RStudio Server
EXPOSE 8787

# Comando para iniciar o Quarto
# CMD ["quarto", "render", "manuscrito.qmd"]