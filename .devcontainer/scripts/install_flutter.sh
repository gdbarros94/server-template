#!/bin/bash

set -e

echo "📦 Instalando Flutter SDK..."

# Diretório de instalação
FLUTTER_DIR="/opt/flutter"

# Clonar repositório do Flutter
if [ ! -d "$FLUTTER_DIR/.git" ]; then
    git clone https://github.com/flutter/flutter.git -b stable "$FLUTTER_DIR"
else
    echo "Flutter já está instalado, atualizando..."
    cd "$FLUTTER_DIR"
    git fetch origin
    git checkout stable
    git pull origin stable
fi

# Adicionar ao PATH
export PATH="$FLUTTER_DIR/bin:$PATH"

# Desabilitar telemetria do Flutter
flutter config --no-analytics || true

# Aceitar a licença do Android SDK
flutter config --android-sdk=/opt/android-sdk || true

echo "✓ Flutter SDK instalado com sucesso em $FLUTTER_DIR"
