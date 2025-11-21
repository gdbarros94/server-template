#!/bin/bash

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  Inicializando Ambiente de Desenvolvimento                     ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Configurar variáveis de ambiente
export ANDROID_SDK_ROOT=/opt/android-sdk
export ANDROID_HOME=/opt/android-sdk
export PATH=/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/platform-tools:/opt/flutter/bin:${PATH}

# Adicionar permanentemente ao bashrc
cat >> /root/.bashrc << 'EOF'
# Development Environment Variables
export ANDROID_SDK_ROOT=/opt/android-sdk
export ANDROID_HOME=/opt/android-sdk
export PATH=/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/platform-tools:/opt/flutter/bin:${PATH}
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
EOF

echo "✓ Variáveis de ambiente configuradas"
echo ""

# Executar flutter doctor
echo "┌────────────────────────────────────────────────────────────────┐"
echo "│  Executando Flutter Doctor                                     │"
echo "└────────────────────────────────────────────────────────────────┘"
echo ""

flutter doctor || true

echo ""
echo "✓ Flutter Doctor executado"
echo ""

# Aceitar licenças do Android SDK
echo "┌────────────────────────────────────────────────────────────────┐"
echo "│  Aceitando Licenças do Android SDK                             │"
echo "└────────────────────────────────────────────────────────────────┘"
echo ""

/opt/scripts/accept_licenses.sh || true

echo ""
echo "✓ Licenças aceitas"
echo ""

# Verificar versões instaladas
echo "┌────────────────────────────────────────────────────────────────┐"
echo "│  Versões Instaladas                                            │"
echo "└────────────────────────────────────────────────────────────────┘"
echo ""

echo "Java:"
java -version 2>&1 | head -n 3

echo ""
echo "Node.js:"
node --version

echo ""
echo "Python:"
python3 --version

echo ""
echo "PHP:"
php --version | head -n 1

echo ""
echo "MySQL Server:"
mysql --version

echo ""
echo "Git:"
git --version

echo ""
echo "Flutter:"
flutter --version

echo ""

# Informações finais
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  Ambiente Inicializado com Sucesso!                            ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📋 Próximos Passos:"
echo ""
echo "  → Para aplicar configurações extras com Ansible, execute:"
echo "    • make ansible-full      (playbook completo)"
echo "    • make ansible-extra     (role de extras)"
echo "    • make ansible-fix       (playbook de reparo)"
echo ""
echo "🔧 Stack Disponível:"
echo ""
echo "  • Apache2 (porta 80)"
echo "  • MySQL Server (porta 3306)"
echo "  • PHP 8.3 com módulos"
echo "  • Python 3 com pip"
echo "  • Node.js com npm"
echo "  • C/C++ com g++, gcc, clang"
echo "  • Java 17 (OpenJDK)"
echo "  • Flutter SDK"
echo "  • Android SDK com command-line tools"
echo ""
echo "📂 Estrutura do Projeto:"
echo "  • .devcontainer/      → Configuração do DevContainer"
echo "  • scripts/            → Scripts utilitários"
echo "  • ansible/            → Configurações Ansible"
echo "  • Makefile            → Targets de automação"
echo ""
