#!/bin/bash

set -e

echo "✅ Aceitando licenças do Android SDK..."

SDK_ROOT="/opt/android-sdk"

# Criar diretório de licenças
mkdir -p "$SDK_ROOT/licenses"

# Aceitar todas as licenças
cat > "$SDK_ROOT/licenses/android-sdk-license" << 'EOF'
8403ada5be477e421f41d3a1a038a6e07e4d1070
d56f5187479451eabf01fb78af6dfcb131b33910
24333f8a63b6825ea9c5514f83c2829b004d1fee
EOF

cat > "$SDK_ROOT/licenses/android-sdk-preview-license" << 'EOF'
84831b9409646a918e30573bab4c9c91346d8abd
EOF

cat > "$SDK_ROOT/licenses/google-android-sdk-license" << 'EOF'
0e340632a9f83e17f0a9dcd1ffdf3ebef2c5a6f7
EOF

cat > "$SDK_ROOT/licenses/intel-android-sysimage-license" << 'EOF'
d975f751176a0ee99d7d5d08ad3fa089da7da16b
EOF

# Tentar executar sdkmanager para aceitar mais licenças via stdin
if command -v sdkmanager &> /dev/null; then
    export ANDROID_SDK_ROOT="$SDK_ROOT"
    export ANDROID_HOME="$SDK_ROOT"
    
    # Isso ajuda a aceitar qualquer licença pendente
    yes | sdkmanager --licenses > /dev/null 2>&1 || true
fi

echo "✓ Licenças do Android SDK aceitas"
