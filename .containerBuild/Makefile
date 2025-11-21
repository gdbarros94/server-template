.PHONY: help ansible-full ansible-extra ansible-fix build-container shell logs clean

# Cores para output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

help:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Full Development Environment - Makefile Targets            ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(GREEN)Targets Ansible:$(NC)"
	@echo "  $(YELLOW)make ansible-full$(NC)        - Executa playbook completo com todas as features"
	@echo "  $(YELLOW)make ansible-extra$(NC)       - Executa apenas o role de extras"
	@echo "  $(YELLOW)make ansible-fix$(NC)         - Verifica e repara ambiente de desenvolvimento"
	@echo ""
	@echo "$(GREEN)Targets DevContainer:$(NC)"
	@echo "  $(YELLOW)make build-container$(NC)     - Constrói a imagem Docker do DevContainer"
	@echo "  $(YELLOW)make shell$(NC)               - Entra no shell do container em execução"
	@echo "  $(YELLOW)make logs$(NC)                - Mostra logs do container"
	@echo ""
	@echo "$(GREEN)Targets Utilitários:$(NC)"
	@echo "  $(YELLOW)make clean$(NC)               - Remove build artifacts e cache"
	@echo "  $(YELLOW)make help$(NC)                - Mostra esta mensagem"
	@echo ""
	@echo "$(GREEN)Verificação do Ambiente:$(NC)"
	@echo "  Verifique o devcontainer.json para features instaladas:"
	@echo "  • Ansible"
	@echo "  • Terraform"
	@echo ""
	@echo "$(GREEN)Diretórios Principais:$(NC)"
	@echo "  • $(BLUE).devcontainer/$(NC)       - Configuração do DevContainer"
	@echo "  • $(BLUE).containerBuild/$(NC)     - Scripts, Ansible e Makefile"
	@echo "  • $(BLUE).containerBuild/scripts/$(NC) - Scripts de instalação"
	@echo "  • $(BLUE).containerBuild/ansible/$(NC) - Configurações Ansible"
	@echo ""

# ============================================================================
# TARGETS ANSIBLE
# ============================================================================

ansible-full:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Executando Playbook Ansible Completo                      ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@ansible-playbook .containerBuild/ansible/playbook.yml --connection=local -v
	@echo ""
	@echo "$(GREEN)✓ Playbook completo executado com sucesso!$(NC)"
	@echo ""

ansible-extra:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Executando Role Extras                                    ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@ansible-playbook .containerBuild/ansible/playbook.yml --connection=local -v --tags extra
	@echo ""
	@echo "$(GREEN)✓ Role extras executado com sucesso!$(NC)"
	@echo ""

ansible-fix:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Executando Playbook de Reparo                             ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@ansible-playbook .containerBuild/ansible/repair.yml --connection=local -v
	@echo ""
	@echo "$(GREEN)✓ Playbook de reparo executado com sucesso!$(NC)"
	@echo ""

# ============================================================================
# TARGETS DEVCONTAINER
# ============================================================================

build-container:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Construindo Imagem DevContainer                           ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@docker build -f .devcontainer/Dockerfile -t server-template:latest .
	@echo ""
	@echo "$(GREEN)✓ Imagem construída com sucesso!$(NC)"
	@echo ""

shell:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Acessando Shell do Container                              ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@docker exec -it $$(docker ps -q -f ancestor=server-template:latest) /bin/bash || echo "$(RED)Erro: Container não está em execução$(NC)"

logs:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Exibindo Logs do Container                                ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@docker logs -f $$(docker ps -q -f ancestor=server-template:latest) || echo "$(RED)Erro: Container não está em execução$(NC)"

# ============================================================================
# TARGETS UTILITÁRIOS
# ============================================================================

clean:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Limpando Build Artifacts                                  ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@find . -type f -name ".DS_Store" -delete 2>/dev/null || true
	@find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name ".venv" -exec rm -rf {} + 2>/dev/null || true
	@echo "$(GREEN)✓ Cleanup concluído!$(NC)"
	@echo ""

# ============================================================================
# INFORMAÇÕES E DOCUMENTAÇÃO
# ============================================================================

info:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Informações do Ambiente                                   ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(GREEN)Sistema Operacional:$(NC)"
	@uname -a
	@echo ""
	@echo "$(GREEN)Versões Instaladas:$(NC)"
	@echo "  Java:     $$(java -version 2>&1 | head -n1)"
	@echo "  Python:   $$(python3 --version)"
	@echo "  Node.js:  $$(node --version)"
	@echo "  NPM:      $$(npm --version)"
	@echo "  Git:      $$(git --version)"
	@echo "  Docker:   $$(docker --version || echo 'Não instalado')"
	@echo ""

# ============================================================================
# PHONY TARGETS
# ============================================================================

.PHONY: help ansible-full ansible-extra ansible-fix build-container shell logs clean info
