FROM ubuntu:24.04

# Evitar prompts interativos durante instalação
ENV DEBIAN_FRONTEND=noninteractive

# Atualizar repositórios e instalar pacotes base
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Web Stack
    apache2 \
    mysql-server \
    mysql-client \
    php \
    php-cli \
    php-common \
    php-mysql \
    php-sqlite3 \
    php-xml \
    php-curl \
    php-mbstring \
    php-zip \
    php-gd \
    php-intl \
    php-json \
    php-bcmath \
    php-opcache \
    # SQLite
    sqlite3 \
    libsqlite3-dev \
    # Python Stack
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    # Node.js Stack
    nodejs \
    npm \
    # Utilitários de Download
    curl \
    wget \
    git \
    # Build Tools
    build-essential \
    g++ \
    gcc \
    make \
    cmake \
    clang \
    ninja-build \
    # Dependências de Compilação
    pkg-config \
    libstdc++-12-dev \
    libssl-dev \
    zlib1g-dev \
    # Java
    openjdk-17-jdk \
    openjdk-17-jre \
    # Android / Mobile tools
    gradle \
    android-tools-adb \
    # Utilitários Diversos
    zip \
    unzip \
    htop \
    nano \
    vim \
    software-properties-common \
    lsb-release \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configurar variáveis de ambiente para Android SDK
ENV ANDROID_SDK_ROOT=/opt/android-sdk \
    ANDROID_HOME=/opt/android-sdk \
    PATH=/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/platform-tools:/opt/flutter/bin:${PATH}

# Criar diretório para Flutter e Android SDK
RUN mkdir -p /opt/flutter /opt/android-sdk /opt/scripts

# Copiar scripts locais para dentro do container (garantir que estejam no contexto .devcontainer)
COPY ./scripts/ /opt/scripts/

RUN chmod +x /opt/scripts/*.sh

# Instalar Flutter (script fornecido em .devcontainer/scripts)
RUN bash /opt/scripts/install_flutter.sh || true

# Instalar Android SDK (script fornecido em .devcontainer/scripts)
RUN bash /opt/scripts/install_android_sdk.sh || true

# Aceitar licenças do Android (script fornecido em .devcontainer/scripts)
RUN bash /opt/scripts/accept_licenses.sh || true

# Instalar Ansible e Terraform (Terraform via repositório HashiCorp)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg \
    curl \
    ca-certificates \
    software-properties-common \
    && \
    # Adicionar chave e repositório HashiCorp para terraform
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    DISTRO=$( . /etc/os-release && echo "$VERSION_CODENAME" ) && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com ${DISTRO} main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y --no-install-recommends ansible terraform && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar phpMyAdmin de forma não-interativa (pré-configurar debconf)
RUN apt-get update && apt-get install -y --no-install-recommends debconf-utils \
    && echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections \
    && echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections \
    && echo 'phpmyadmin phpmyadmin/mysql/admin-pass password ' | debconf-set-selections \
    && echo 'phpmyadmin phpmyadmin/mysql/app-pass password ' | debconf-set-selections \
    && echo 'phpmyadmin phpmyadmin/app-password-confirm password ' | debconf-set-selections \
    && apt-get update && apt-get install -y --no-install-recommends phpmyadmin \
    && apt-get clean && rm -rf /var/lib/apt/lists/* || true

# Configurar PHP com Apache
RUN a2enmod rewrite \
    && a2enmod ssl \
    && a2enmod proxy \
    && a2enmod proxy_http || true

# Criar diretório de logs
RUN mkdir -p /var/log/app

# Definir diretório de trabalho
WORKDIR /workspace

# Comando padrão
CMD ["/bin/bash"]
