#!/usr/bin/env bash
set -e

# Verifica se o Python já está instalado
instalar_python() {
    echo "[INFO] Verificando se o Python 3.12 está instalado..."

    if ! command -v python3.12 &> /dev/null; then
        echo "===> [INFO] Instalando o Pyton 3.12..."
        sudo dnf install python3.12 -y
        echo "===> [SUCESSO] Python 3.12 Instalado"
    else
        echo "===> [INFO] Python 3.12 já instalado"
    fi    
}

# Função responsável por verificar se o docker está instalado
instalar_docker() {
    echo ""
    echo "[INFO] Verificando se o Docker 3.12 está instalado..."

    if ! command -v docker &> /dev/null; then
        echo "===> [INFO] Instalando o Docker..."
        sudo dnf install dnf-plugins-core -y
        sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
        sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo usermod -aG docker "$USER"
        echo "===> [SUCESSO] Docker Instalado"
    else
        echo "===> [INFO] Docker já instalado"
    fi
}

# Instala as libs via requirements.txt do Python via pip
instalar_libs_python() {1
    pip install --upgrade pip -q
    pip install -r requirements.txt -q
}

# Configura ambiente virutal do python
configurar_ambiente_virtual_python() {
    echo ""
    echo "[INFO] Criando ambiente virtual Python..."

    if [[ ! -d ".venv" ]]; then
        python3.12 -m venv .venv
    fi

    source .venv/bin/activate
    instalar_libs_python
    echo "===> [SUCESSO] Docker Instalado"
}

# Executa o docker compose para instalação do PostgreSQL
executar_docker_compose() {
    echo ""
    echo "[INFO] Executando Docker Compose..."

    cd infra/

    if [[ $(docker compose ps -q postgres 2>/dev/null) ]]; then
        echo "===> [INFO] PostgreSQL já instalado..."
    else
        docker compose up -d
        echo "===> [SUCESSO] Docker Instalado"
    fi

    until docker exec postgres-dbt pg_isready -U "${POSTGRES_USER}" &> /dev/null; do
        sleep 2
    done
}

# Função principal
main() {
    instalar_python
    instalar_docker
    configurar_ambiente_virtual_python
    executar_docker_compose
}

main