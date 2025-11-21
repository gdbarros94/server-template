#!/bin/bash

set -e

echo "📱 Instalando Android SDK..."

# Diretórios
SDK_ROOT="/opt/android-sdk"
CMDLINE_TOOLS_DIR="$SDK_ROOT/cmdline-tools"

# Versão do Android SDK command-line tools
CMDLINE_TOOLS_VERSION="11.0"

# Criar diretórios necessários
mkdir -p "$SDK_ROOT"
mkdir -p "$CMDLINE_TOOLS_DIR"
mkdir -p "$SDK_ROOT/platforms"

# Baixar command-line tools
echo "Baixando Android SDK command-line tools..."
cd /tmp

# URL para download dos command-line tools
CMDLINE_URL="https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_TOOLS_VERSION}_latest.zip"

if ! wget -q --show-progress "$CMDLINE_URL" -O cmdline-tools.zip; then
    echo "Erro ao baixar command-line tools. Tentando URL alternativa..."
    CMDLINE_URL="https://dl.google.com/android/repository/commandlinetools-linux-9477620_latest.zip"
    wget -q --show-progress "$CMDLINE_URL" -O cmdline-tools.zip
fi

# Extrair
unzip -q cmdline-tools.zip
mv cmdline-tools/* "$CMDLINE_TOOLS_DIR/latest" 2>/dev/null || mv cmdline-tools "$CMDLINE_TOOLS_DIR/latest"
rm -rf cmdline-tools.zip cmdline-tools

# Configurar PATH
export PATH="$CMDLINE_TOOLS_DIR/latest/bin:$SDK_ROOT/platform-tools:$PATH"
export ANDROID_SDK_ROOT="$SDK_ROOT"
export ANDROID_HOME="$SDK_ROOT"

echo "✓ Command-line tools instalados"
echo ""

# Aceitar licenças
echo "Aceitando licenças do Android SDK..."
mkdir -p "$SDK_ROOT/licenses"
cat > "$SDK_ROOT/licenses/android-sdk-license" << 'EOF'
8403ada5be477e421f41d3a1a038a6e07e4d1070
d56f5187479451eabf01fb78af6dfcb131b33910
24333f8a63b6825ea9c5514f83c2829b004d1fee
EOF

# Instalar SDKs e ferramentas via sdkmanager
echo "Instalando plataformas e ferramentas Android..."

# Platform Tools
echo "Instalando platform-tools..."
echo "y" | sdkmanager --sdk_root="$SDK_ROOT" "platform-tools" > /dev/null 2>&1 || true

# APIs Android
echo "Instalando Android APIs..."
for api in 31 32 33 34; do
    echo "y" | sdkmanager --sdk_root="$SDK_ROOT" "platforms;android-$api" > /dev/null 2>&1 || true
done

# Build Tools
echo "Instalando build-tools..."
for version in 30.0.3 31.0.0 32.0.0 33.0.0 34.0.0; do
    echo "y" | sdkmanager --sdk_root="$SDK_ROOT" "build-tools;$version" > /dev/null 2>&1 || true
done

# Command-line tools
echo "y" | sdkmanager --sdk_root="$SDK_ROOT" "cmdline-tools;latest" > /dev/null 2>&1 || true

# Emulator (mesmo que não funcione no Codespace)
echo "y" | sdkmanager --sdk_root="$SDK_ROOT" "emulator" > /dev/null 2>&1 || true

# NDK (opcional, mas útil para Flutter)
echo "Instalando NDK..."
echo "y" | sdkmanager --sdk_root="$SDK_ROOT" "ndk;25.1.8937393" > /dev/null 2>&1 || true

echo ""
echo "✓ Android SDK instalado com sucesso em $SDK_ROOT"
