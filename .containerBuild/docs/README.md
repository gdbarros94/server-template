# 🚀 Full Development Environment - DevContainer

Um **DevContainer completo, modular e bem estruturado** para um ambiente de desenvolvimento capaz de rodar:

## ✨ Stack Incluído

### 🌐 Web Stack Completa
- **Apache2** - Servidor web HTTP/HTTPS
- **MySQL Server** - Banco de dados relacional
- **PHP 8.3** com módulos essenciais
- **SQLite3** - Banco de dados embarcado

### 🐍 Python & Ferramentas
- **Python 3** com pip e venv
- Pacotes essenciais para ciência de dados (numpy, pandas, jupyter)
- Ferramentas de linting (pylint, flake8, black)

### 📦 Node.js & NPM
- **Node.js** com npm
- Ferramentas globais (TypeScript, Angular CLI, Vue CLI, React)

### 🔧 C/C++ & Build Tools
- **GCC, G++, Clang**
- **CMake, Ninja, Make**
- Build essentials completo

### ☕ Java
- **OpenJDK 17** (JDK + JRE)

### 📱 Flutter & Android
- **Flutter SDK** (stable branch)
- **Android SDK** com:
  - Command-line tools
  - Platform tools
  - Build tools (30.0.3 até 34.0.0)
  - Android APIs (31 até 34)
  - NDK (para desenvolvimento nativo)
  - Emulator

### 🛠️ Ferramentas Adicionais
- Git, curl, wget
- Nano, vim, htop
- Zip, unzip, tar
- Ansible & Terraform (via DevContainer features)

---

## 📁 Estrutura do Projeto

\`\`\`
server-template/
├── .devcontainer/
│   ├── devcontainer.json      # Configuração do DevContainer
│   ├── Dockerfile             # Build image com todas as dependências
│   └── post-create.sh         # Script executado após criar container
├── .containerBuild/
│   ├── scripts/
│   │   ├── install_flutter.sh     # Instala Flutter SDK
│   │   ├── install_android_sdk.sh # Instala Android SDK
│   │   └── accept_licenses.sh     # Aceita licenças automaticamente
│   ├── ansible/
│   │   ├── playbook.yml           # Playbook principal
│   │   ├── repair.yml             # Playbook de reparo
│   │   └── roles/
│   │       └── extra/
│   │           └── tasks/
│   │               └── main.yml   # Tasks de extras
│   └── Makefile                   # Automação com make
├── README.md                  # Este arquivo
└── LICENSE                    # Licença do projeto
\`\`\`

**Nota:** Todos os arquivos de configuração do container (scripts, playbooks Ansible e Makefile) estão em `.containerBuild/` para manter o diretório raiz limpo e focado no desenvolvimento da aplicação principal.

---

## 🚀 Como Usar

### 1️⃣ GitHub Codespaces (Recomendado)

1. **Abra o repositório no GitHub**
2. **Clique em "Code" → "Codespaces" → "Create codespace on main"**
3. VS Code abrirá automaticamente com o DevContainer configurado
4. **Aguarde a inicialização** (pode levar alguns minutos na primeira vez)
5. Quando pronto, verá a mensagem: \`"Ambiente Inicializado com Sucesso!"\`

### 2️⃣ VS Code Local

**Pré-requisitos:**
- Docker Desktop instalado
- VS Code com extensão "Dev Containers"

**Passos:**
1. Clone o repositório: \`git clone <url>\`
2. Abra em VS Code: \`code .\`
3. Pressione \`Ctrl+Shift+P\` (ou \`Cmd+Shift+P\` no Mac)
4. Digite: \`Dev Containers: Reopen in Container\`
5. Aguarde a build (primeira vez pode levar 10-15 minutos)

### 3️⃣ Linha de Comando (Docker direto)

\`\`\`bash
# Build da imagem
docker build -f .devcontainer/Dockerfile -t server-template:latest .

# Executar container
docker run -it --rm -v $(pwd):/workspace server-template:latest

# Ou usando make
make build-container
\`\`\`

---

## 📋 Comandos Principais

### Makefile Targets

O Makefile está localizado em \`.containerBuild/Makefile\`.

**Ajuda:**
\`\`\`bash
make -f .containerBuild/Makefile help
\`\`\`

**Ansible - Configuração Extra:**
\`\`\`bash
# Playbook completo (instala todas as ferramentas extras)
make -f .containerBuild/Makefile ansible-full

# Apenas o role de extras
make -f .containerBuild/Makefile ansible-extra

# Verifica e repara ambiente
make -f .containerBuild/Makefile ansible-fix
\`\`\`

**DevContainer:**
\`\`\`bash
# Build da imagem Docker
make -f .containerBuild/Makefile build-container

# Acessar shell do container em execução
make -f .containerBuild/Makefile shell

# Ver logs do container
make -f .containerBuild/Makefile logs
\`\`\`

**Limpeza:**
\`\`\`bash
# Remove artifacts e cache
make -f .containerBuild/Makefile clean

# Mostra informações do ambiente
make -f .containerBuild/Makefile info
\`\`\``

---

## 🔍 Verificação Pós-Instalação

### Flutter
\`\`\`bash
flutter doctor
flutter --version
\`\`\`

### Android SDK
\`\`\`bash
sdkmanager --list
adb version
emulator -version
\`\`\`

### Java
\`\`\`bash
java -version
javac -version
\`\`\`

### Python
\`\`\`bash
python3 --version
pip3 --version
\`\`\`

### Node.js
\`\`\`bash
node --version
npm --version
\`\`\`

### PHP
\`\`\`bash
php --version
php -m  # Lista módulos
\`\`\`

### MySQL
\`\`\`bash
mysql --version
mysql -u root  # Conectar (sem senha por padrão)
\`\`\`

---

## 🛠️ Ansible - Configuração Avançada

### O que é Ansible?

Ansible é uma ferramenta de automação que permite configurar o ambiente de forma declarativa e reproduzível.

### Playbooks Disponíveis

#### 1. \`playbook.yml\` - Playbook Completo
Instala:
- Ferramentas Git avançadas (git-flow)
- Processadores JSON/YAML (jq, yq)
- Ferramentas de busca (ripgrep, fd-find)
- Ferramentas de produtividade (direnv, tldr)
- Pacotes Python (black, pytest, jupyter)
- Pacotes Node.js (eslint, prettier, TypeScript)

**Executar:**
\`\`\`bash
make -f .containerBuild/Makefile ansible-full
# ou
ansible-playbook .containerBuild/ansible/playbook.yml --connection=local -v
\`\`\`

#### 2. \`roles/extra/tasks/main.yml\` - Role de Extras
Instala pacotes e ferramentas adicionais sem dependências críticas.

**Executar:**
\`\`\`bash
make -f .containerBuild/Makefile ansible-extra
\`\`\`

#### 3. \`repair.yml\` - Playbook de Reparo
Verifica e repara:
- Dependências quebradas
- Instalação do Flutter
- Instalação do Android SDK
- Módulos PHP
- Cache e pacotes órfãos

**Executar:**
\`\`\`bash
make -f .containerBuild/Makefile ansible-fix
\`\`\`

### Executar Playbook Customizado

\`\`\`bash
# Com verbose
ansible-playbook .containerBuild/ansible/playbook.yml --connection=local -v

# Com debug
ansible-playbook .containerBuild/ansible/playbook.yml --connection=local -vvv

# Modo dry-run (simula sem fazer mudanças)
ansible-playbook .containerBuild/ansible/playbook.yml --connection=local --check
\`\`\`

---

## 🌍 Variáveis de Ambiente

O ambiente configura automaticamente:

\`\`\`bash
# Android SDK
export ANDROID_SDK_ROOT=/opt/android-sdk
export ANDROID_HOME=/opt/android-sdk

# Flutter
export PATH=/opt/flutter/bin:$PATH

# Java
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
\`\`\`

Para adicionar suas próprias variáveis, edite \`.devcontainer/post-create.sh\`.

---

## 🐳 DevContainer Features

O \`devcontainer.json\` instala automaticamente:

- **Ansible** - Automação e provisionamento
- **Terraform** - Infraestrutura como código
- **VS Code Extensions** - Python, C++, Ansible, Terraform

Para adicionar mais features, consulte: https://containers.dev/features

---

## 📚 Estrutura de Diretórios de Desenvolvimento

Após executar Ansible, você terá:

\`\`\`
/opt/
├── flutter/              # Flutter SDK
├── android-sdk/          # Android SDK
│   ├── platforms/
│   ├── build-tools/
│   ├── platform-tools/
│   ├── cmdline-tools/
│   └── ndk/
├── development/          # Seus projetos
│   └── projects/
└── scripts/              # Scripts auxiliares
\`\`\`

---

## 🐛 Troubleshooting

### Flutter não encontrado
\`\`\`bash
# Verificar
flutter doctor

# Reinstalar
bash /opt/scripts/install_flutter.sh
\`\`\`

### Android SDK com problemas
\`\`\`bash
# Listar SDKs instalados
sdkmanager --list

# Aceitar licenças novamente
bash /opt/scripts/accept_licenses.sh

# Reinstalar
bash /opt/scripts/install_android_sdk.sh
\`\`\`

### MySQL não iniciando
\`\`\`bash
# Iniciar serviço
service mysql start

# Verificar status
service mysql status
\`\`\`

### PHP com módulos faltando
\`\`\`bash
# Ver módulos disponíveis
php -m

# Habilitar módulo específico
phpenmod pdo_mysql

# Desabilitar módulo
phpdismod pdo_mysql
\`\`\`

### Espaço em disco limitado
\`\`\`bash
# Limpar cache APT
apt-get clean
apt-get autoclean

# Usar make clean (use -f para especificar o Makefile)
make -f .containerBuild/Makefile clean
\`\`\`

---

## 🔐 Segurança

**Importante para produção:**

- MySQL: Mude a senha padrão após setup
- PHP: Configure segurança adequadamente
- Apache: Configure certificados SSL/TLS
- Credenciais: Use variáveis de ambiente, nunca hardcode

---

## 📞 Portas Abertas

O DevContainer expõe automaticamente:

- **80** - Apache HTTP
- **3306** - MySQL
- **8080** - Aplicação customizada

Configure em \`devcontainer.json\` se precisar adicionar mais portas.

---

## �� Próximos Passos

1. **Criar seu primeiro projeto:**
   \`\`\`bash
   flutter create meu_app
   cd meu_app
   flutter doctor
   \`\`\`

2. **Iniciar serviços:**
   \`\`\`bash
   service apache2 start
   service mysql start
   \`\`\`

3. **Instalar dependências Ansible extras:**
   \`\`\`bash
   make ansible-full
   \`\`\`

4. **Criar aplicação Node.js:**
   \`\`\`bash
   npm init
   npm install express
   \`\`\`

5. **Usar Python/Jupyter:**
   \`\`\`bash
   jupyter notebook
   \`\`\`

---

## �� Documentação Adicional

- [Flutter Docs](https://flutter.dev/docs)
- [Android SDK Guide](https://developer.android.com/studio/command-line)
- [Ansible Documentation](https://docs.ansible.com/)
- [DevContainers Spec](https://containers.dev/)
- [Docker Documentation](https://docs.docker.com/)

---

## 💡 Dicas Úteis

1. **Para desenvolvimento local rápido:** Use o Makefile em `.containerBuild/` para automatizar tasks
2. **Para testes reproduzíveis:** Sempre use \`make -f .containerBuild/Makefile clean\` antes de começar novamente
3. **Para debug:** Ative verbose com \`-v\` ou \`-vv\` em Ansible
4. **Para desenvolvimento iOS:** Necesita macOS, não funciona no container Linux
5. **Para Windows:** Use WSL2 com Docker Desktop para melhor performance

---

## 🤝 Contribuindo

Para melhorias ou correções:

1. Faça um fork
2. Crie uma branch (\`git checkout -b feature/improvement\`)
3. Commit suas mudanças (\`git commit -am 'Add improvement'\`)
4. Push para a branch (\`git push origin feature/improvement\`)
5. Abra um Pull Request

---

## �� Licença

Este projeto está sob a licença definida em \`LICENSE\`.

---

## ✅ Checklist Pós-Setup

- [ ] DevContainer criado e inicializado
- [ ] Todos os pacotes instalados com sucesso
- [ ] Flutter doctor executado sem erros críticos
- [ ] Android SDK funcional
- [ ] MySQL iniciado e conectável
- [ ] PHP com módulos essenciais
- [ ] Java 17 funcionando
- [ ] Node.js/NPM prontos
- [ ] Ansible executado (opcional)
- [ ] Variáveis de ambiente setadas

---

**Pronto para desenvolver! 🎉**

Se encontrar problemas, execute:
\`\`\`bash
make -f .containerBuild/Makefile ansible-fix
\`\`\`

Para recriar o ambiente do zero:
\`\`\`bash
make -f .containerBuild/Makefile clean
make -f .containerBuild/Makefile build-container
\`\`\`
