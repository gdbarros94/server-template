# 📚 Guia Rápido de Referência

## 🔧 Arquivos Principais

### DevContainer Configuration
- **`.devcontainer/devcontainer.json`** - Configuração principal do DevContainer com features Ansible/Terraform
- **`.devcontainer/Dockerfile`** - Build da imagem com todos os pacotes
- **`.devcontainer/post-create.sh`** - Script de inicialização pós-criação

### Scripts Auxiliares
- **`scripts/install_flutter.sh`** - Instala e configura Flutter SDK
- **`scripts/install_android_sdk.sh`** - Instala Android SDK com command-line tools
- **`scripts/accept_licenses.sh`** - Aceita licenças do Android automaticamente

### Automação
- **`Makefile`** - Targets para Ansible, Docker, limpeza e informações

### Ansible
- **`ansible/playbook.yml`** - Playbook principal com todas as features
- **`ansible/repair.yml`** - Playbook para verificar e reparar ambiente
- **`ansible/roles/extra/tasks/main.yml`** - Tasks de instalação de extras

### Documentação
- **`README.md`** - Documentação completa
- **`QUICK_REFERENCE.md`** - Este arquivo

---

## ⚡ Comandos Rápidos

### Primeiro Setup
```bash
# No GitHub Codespaces - automático
# No VS Code Local:
# 1. Ctrl+Shift+P → "Dev Containers: Reopen in Container"
# 2. Aguarde a build inicial
```

### Após Inicialização
```bash
# Verificar ambiente
flutter doctor
java -version
python3 --version

# Instalar extras (opcional)
make ansible-full

# Ver ajuda
make help
```

### Desenvolvimento
```bash
# Criar projeto Flutter
flutter create meu_app

# Iniciar serviços
service apache2 start
service mysql start

# Acessar MySQL
mysql -u root

# Usar Python/Jupyter
jupyter notebook
```

### Troubleshooting
```bash
# Reparar ambiente
make ansible-fix

# Limpar cache
make clean

# Ver informações
make info
```

---

## 📦 Stack Disponível

| Componente | Versão | Comando de Verificação |
|-----------|--------|----------------------|
| Java | 17 (OpenJDK) | `java -version` |
| Python | 3.x | `python3 --version` |
| Node.js | LTS | `node --version` |
| PHP | 8.3 | `php --version` |
| MySQL | Latest | `mysql --version` |
| Flutter | Stable | `flutter --version` |
| Android SDK | Latest | `sdkmanager --list` |
| Git | Latest | `git --version` |
| Ansible | Latest | `ansible --version` |
| Terraform | Latest | `terraform --version` |

---

## 🔧 Configuração Avançada

### Adicionar Nova Porta
Edite `.devcontainer/devcontainer.json`:
```json
"forwardPorts": [80, 3306, 8080, 3000]
```

### Instalar Novos Pacotes APT
Edite `.devcontainer/Dockerfile`, adicione em RUN apt-get install:
```dockerfile
RUN apt-get update && apt-get install -y \
    seu-pacote-aqui \
    outro-pacote
```

### Adicionar Variável de Ambiente
Edite `.devcontainer/post-create.sh`:
```bash
export MINHA_VAR="valor"
```

### Criar Novo Playbook Ansible
```bash
touch ansible/meu-playbook.yml
# Editar arquivo
# Executar com:
ansible-playbook ansible/meu-playbook.yml --connection=local -v
```

---

## 📊 Estrutura de Diretórios Final

```
/workspace/
├── .devcontainer/          # Configuração DevContainer
│   ├── Dockerfile
│   ├── devcontainer.json
│   └── post-create.sh
├── scripts/                # Scripts de instalação
│   ├── install_flutter.sh
│   ├── install_android_sdk.sh
│   └── accept_licenses.sh
├── ansible/                # Automação
│   ├── playbook.yml
│   ├── repair.yml
│   └── roles/
│       └── extra/tasks/main.yml
├── Makefile                # Automação make
├── README.md               # Documentação completa
├── QUICK_REFERENCE.md      # Este arquivo
└── LICENSE                 # Licença

/opt/                       # Instalações do sistema
├── flutter/                # Flutter SDK
├── android-sdk/            # Android SDK
│   ├── platforms/
│   ├── build-tools/
│   ├── platform-tools/
│   ├── ndk/
│   └── cmdline-tools/
├── development/            # Seus projetos
│   └── projects/
└── scripts/                # Scripts auxiliares
```

---

## 🐛 Problemas Comuns

| Problema | Solução |
|----------|---------|
| Flutter não encontrado | `bash /opt/scripts/install_flutter.sh` |
| Android SDK erro | `bash /opt/scripts/install_android_sdk.sh` |
| MySQL não inicia | `service mysql start` |
| PHP módulo faltando | `phpenmod nome-modulo` |
| Espaço insuficiente | `make clean` e `apt-get autoclean` |
| Dependências quebradas | `make ansible-fix` |

---

## 🚀 Próximas Ações Recomendadas

1. ✅ Ambiente criado e inicializado
2. 🔍 Executar `make help` para ver todos os targets
3. 📱 Criar primeiro projeto Flutter: `flutter create app_test`
4. ☕ Testar Java: `javac -version && java -version`
5. 🐍 Testar Python: `python3 -c "print('Hello')"`
6. 📦 Instalar npm packages: `npm install -g seu-pacote`
7. 🗄️ Iniciar MySQL: `service mysql start`
8. 🔧 Executar Ansible extras: `make ansible-full`

---

## 📞 Suporte

- Documentação: Ver `README.md`
- Ansible: Ver `ansible/playbook.yml` e `ansible/repair.yml`
- Makefile: Executar `make help`
- DevContainer: https://containers.dev/

---

**Última atualização:** Novembro 2025
**Versão:** 1.0
