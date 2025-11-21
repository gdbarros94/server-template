#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════════
# SCRIPT DE VERIFICAÇÃO PÓS-REORGANIZAÇÃO
# ═══════════════════════════════════════════════════════════════════════════════

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Contadores
PASS=0
FAIL=0

# Função para exibir resultado
check() {
    local condition=$1
    local message=$2
    
    if eval "$condition"; then
        echo -e "${GREEN}✓${NC} $message"
        ((PASS++))
    else
        echo -e "${RED}✗${NC} $message"
        ((FAIL++))
    fi
}

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Verificação de Reorganização .containerBuild/            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# 1. VERIFICAR ESTRUTURA DE DIRETÓRIOS
# ═══════════════════════════════════════════════════════════════════════════════

echo -e "${YELLOW}[1] Verificando Estrutura de Diretórios${NC}"
echo ""

check "[ -d '.containerBuild' ]" ".containerBuild/ existe"
check "[ -d '.containerBuild/scripts' ]" ".containerBuild/scripts/ existe"
check "[ -d '.containerBuild/ansible' ]" ".containerBuild/ansible/ existe"
check "[ -d '.containerBuild/ansible/roles/extra/tasks' ]" ".containerBuild/ansible/roles/extra/tasks/ existe"
check "[ ! -d 'scripts' ]" "scripts/ no raiz foi removido"
check "[ ! -d 'ansible' ]" "ansible/ no raiz foi removido"
check "[ ! -f 'Makefile' ]" "Makefile no raiz foi removido"

echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# 2. VERIFICAR ARQUIVOS CRÍTICOS
# ═══════════════════════════════════════════════════════════════════════════════

echo -e "${YELLOW}[2] Verificando Arquivos Críticos${NC}"
echo ""

check "[ -f '.containerBuild/Makefile' ]" ".containerBuild/Makefile existe"
check "[ -f '.containerBuild/scripts/install_flutter.sh' ]" "install_flutter.sh existe"
check "[ -f '.containerBuild/scripts/install_android_sdk.sh' ]" "install_android_sdk.sh existe"
check "[ -f '.containerBuild/scripts/accept_licenses.sh' ]" "accept_licenses.sh existe"
check "[ -f '.containerBuild/ansible/playbook.yml' ]" "playbook.yml existe"
check "[ -f '.containerBuild/ansible/repair.yml' ]" "repair.yml existe"
check "[ -f '.containerBuild/ansible/roles/extra/tasks/main.yml' ]" "roles/extra/tasks/main.yml existe"

echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# 3. VERIFICAR CAMINHOS NO DOCKERFILE
# ═══════════════════════════════════════════════════════════════════════════════

echo -e "${YELLOW}[3] Verificando Caminhos no Dockerfile${NC}"
echo ""

check "grep -q 'COPY .containerBuild/scripts/ /opt/scripts/' .devcontainer/Dockerfile" "Dockerfile: COPY .containerBuild/scripts/ atualizado"
check "grep -q 'bash /opt/scripts/install_flutter.sh' .devcontainer/Dockerfile" "Dockerfile: Comando Flutter correto"
check "grep -q 'bash /opt/scripts/install_android_sdk.sh' .devcontainer/Dockerfile" "Dockerfile: Comando Android SDK correto"
check "grep -q 'bash /opt/scripts/accept_licenses.sh' .devcontainer/Dockerfile" "Dockerfile: Comando licenses correto"

echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# 4. VERIFICAR CAMINHOS NO MAKEFILE
# ═══════════════════════════════════════════════════════════════════════════════

echo -e "${YELLOW}[4] Verificando Caminhos no Makefile${NC}"
echo ""

check "grep -q '.containerBuild/ansible/playbook.yml' .containerBuild/Makefile" "Makefile: .containerBuild/ansible/playbook.yml referenciado"
check "grep -q '.containerBuild/ansible/repair.yml' .containerBuild/Makefile" "Makefile: .containerBuild/ansible/repair.yml referenciado"
check "grep -q 'ansible-full' .containerBuild/Makefile" "Makefile: Target ansible-full existe"
check "grep -q 'build-container' .containerBuild/Makefile" "Makefile: Target build-container existe"

echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# 5. VERIFICAR CAMINHOS NO README
# ═══════════════════════════════════════════════════════════════════════════════

echo -e "${YELLOW}[5] Verificando Caminhos no README.md${NC}"
echo ""

check "grep -q '.containerBuild/' README.md" "README.md: .containerBuild/ mencionado"
check "grep -q 'make -f .containerBuild/Makefile' README.md" "README.md: Comando make -f atualizado"
check "grep -q '.containerBuild/ansible/' README.md" "README.md: .containerBuild/ansible/ referenciado"

echo ""

# ═══════════════════════════════════════════════════════════════════════════════
# 6. RESUMO
# ═══════════════════════════════════════════════════════════════════════════════

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Resumo de Verificação                                    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "Verificações passadas: ${GREEN}${PASS}${NC}"
echo -e "Verificações falhadas: ${RED}${FAIL}${NC}"

echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✓ TODAS AS VERIFICAÇÕES PASSARAM!${NC}"
    echo ""
    echo "A reorganização foi concluída com sucesso!"
    echo "Você pode agora usar:"
    echo ""
    echo "  • make -f .containerBuild/Makefile help"
    echo "  • docker build -f .devcontainer/Dockerfile -t server-template:latest ."
    echo "  • Abrir em VS Code com Dev Containers"
    echo ""
    exit 0
else
    echo -e "${RED}✗ ALGUMAS VERIFICAÇÕES FALHARAM${NC}"
    echo ""
    echo "Verifique os erros acima e corrija os problemas."
    echo ""
    exit 1
fi
