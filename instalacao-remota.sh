#!/bin/bash

# Script de Instalação Remota do Jellyfin para Samsung TV
# Para ser executado NA MÁQUINA REMOTA (máquina da sua amiga)

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # Sem cor

clear

echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Instalação Remota - Jellyfin para Samsung TV         ║${NC}"
echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo ""
echo -e "${CYAN}Este script vai te guiar pela instalação remota.${NC}"
echo -e "${CYAN}Você precisará comunicar com sua amiga durante o processo.${NC}"
echo ""
read -p "Pressione ENTER para começar..."

clear

# ============================================================
# PASSO 1: Verificar ambiente
# ============================================================

echo -e "${YELLOW}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║  PASSO 1: Verificando ambiente                        ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

# Descobrir IP local
echo -e "${CYAN}→ Descobrindo IP local desta máquina...${NC}"

if command -v hostname &> /dev/null; then
    LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}')
fi

if [ -z "$LOCAL_IP" ]; then
    LOCAL_IP=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1 | head -n1)
fi

if [ -z "$LOCAL_IP" ]; then
    echo -e "${RED}Não foi possível detectar o IP automaticamente.${NC}"
    read -p "Por favor, digite o IP local desta máquina: " LOCAL_IP
fi

echo -e "${GREEN}✓ IP Local: $LOCAL_IP${NC}"
echo ""

# Verificar Docker
echo -e "${CYAN}→ Verificando se Docker está instalado...${NC}"

if command -v docker &> /dev/null; then
    echo -e "${GREEN}✓ Docker encontrado!${NC}"
    USE_DOCKER=true
else
    echo -e "${YELLOW}⚠ Docker não encontrado.${NC}"
    echo -e "${YELLOW}  Você pode:${NC}"
    echo -e "${YELLOW}  1) Instalar Docker agora (recomendado)${NC}"
    echo -e "${YELLOW}  2) Continuar sem Docker (requer Node.js e Tizen CLI)${NC}"
    echo ""
    read -p "Deseja instalar Docker? (s/n): " INSTALL_DOCKER

    if [[ "$INSTALL_DOCKER" =~ ^[Ss]$ ]]; then
        echo -e "${CYAN}→ Instalando Docker...${NC}"
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        echo -e "${GREEN}✓ Docker instalado!${NC}"
        USE_DOCKER=true
    else
        USE_DOCKER=false

        # Verificar Node.js
        if ! command -v npm &> /dev/null; then
            echo -e "${RED}Node.js/npm não encontrado!${NC}"
            echo -e "${RED}Instale Node.js antes de continuar: https://nodejs.org/${NC}"
            exit 1
        fi
        echo -e "${GREEN}✓ Node.js encontrado${NC}"
    fi
fi

echo ""
read -p "Pressione ENTER para continuar..."

# ============================================================
# PASSO 2: Instruções para a amiga
# ============================================================

clear
echo -e "${YELLOW}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║  PASSO 2: Preparar a TV Samsung                       ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}Agora você precisa pedir para sua amiga fazer o seguinte:${NC}"
echo ""
echo -e "${GREEN}┌────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│ COPIE E ENVIE ESTA MENSAGEM PARA SUA AMIGA:           │${NC}"
echo -e "${GREEN}├────────────────────────────────────────────────────────┤${NC}"
echo -e "${WHITE}│                                                        │${NC}"
echo -e "${WHITE}│ Oi! Vou instalar o Jellyfin na sua TV.                │${NC}"
echo -e "${WHITE}│                                                        │${NC}"
echo -e "${WHITE}│ Por favor, siga estes passos:                         │${NC}"
echo -e "${WHITE}│ 1. Pegue o controle remoto da TV                      │${NC}"
echo -e "${WHITE}│ 2. Pressione o botão \"Home\" (casinha)                 │${NC}"
echo -e "${WHITE}│ 3. Vá em \"Apps\" (Aplicativos)                         │${NC}"
echo -e "${WHITE}│ 4. Digite: 1 2 3 4 5                                  │${NC}"
echo -e "${WHITE}│ 5. Ative \"Developer mode\" (modo desenvolvedor)        │${NC}"
echo -e "${WHITE}│ 6. Quando pedir o IP, digite: ${YELLOW}$LOCAL_IP${WHITE}      │${NC}"
echo -e "${WHITE}│ 7. Pressione OK                                       │${NC}"
echo -e "${WHITE}│ 8. REINICIE a TV                                      │${NC}"
echo -e "${WHITE}│ 9. Me avise quando a TV ligar novamente              │${NC}"
echo -e "${WHITE}│                                                        │${NC}"
echo -e "${GREEN}└────────────────────────────────────────────────────────┘${NC}"
echo ""
echo -e "${CYAN}Aguardando sua amiga completar estes passos...${NC}"
echo ""
read -p "Sua amiga completou e a TV reiniciou? (s/n): " TV_READY

if [[ ! "$TV_READY" =~ ^[Ss]$ ]]; then
    echo -e "${YELLOW}Ok, execute este script novamente quando estiver pronto.${NC}"
    exit 0
fi

# ============================================================
# PASSO 3: Obter IP da TV
# ============================================================

clear
echo -e "${YELLOW}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║  PASSO 3: Conectar na TV                              ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}Agora você precisa do IP da TV.${NC}"
echo ""
echo -e "${GREEN}┌────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│ ENVIE ESTA MENSAGEM PARA SUA AMIGA:                   │${NC}"
echo -e "${GREEN}├────────────────────────────────────────────────────────┤${NC}"
echo -e "${WHITE}│                                                        │${NC}"
echo -e "${WHITE}│ Ótimo! Agora preciso do IP da sua TV.                 │${NC}"
echo -e "${WHITE}│                                                        │${NC}"
echo -e "${WHITE}│ Na TV, vá em:                                         │${NC}"
echo -e "${WHITE}│ Configurações > Geral > Rede > Status da Rede >      │${NC}"
echo -e "${WHITE}│ Configurações IP                                      │${NC}"
echo -e "${WHITE}│                                                        │${NC}"
echo -e "${WHITE}│ Me envie o número que aparece em \"Endereço IP\".      │${NC}"
echo -e "${WHITE}│ Deve ser algo como: 192.168.1.150                    │${NC}"
echo -e "${WHITE}│                                                        │${NC}"
echo -e "${GREEN}└────────────────────────────────────────────────────────┘${NC}"
echo ""

read -p "Digite o IP da TV: " TV_IP

if [ -z "$TV_IP" ]; then
    echo -e "${RED}Erro: IP da TV é obrigatório!${NC}"
    exit 1
fi

echo -e "${GREEN}✓ IP da TV: $TV_IP${NC}"
echo ""

# Testar conexão
echo -e "${CYAN}→ Testando conexão com a TV...${NC}"
if ping -c 2 -W 2 "$TV_IP" &> /dev/null; then
    echo -e "${GREEN}✓ TV está acessível na rede!${NC}"
else
    echo -e "${YELLOW}⚠ Não foi possível fazer ping na TV, mas vamos tentar continuar...${NC}"
fi

echo ""
read -p "Pressione ENTER para começar a instalação..."

# ============================================================
# PASSO 4: Instalação
# ============================================================

clear
echo -e "${YELLOW}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║  PASSO 4: Instalando Jellyfin                         ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

if [ "$USE_DOCKER" = true ]; then
    echo -e "${CYAN}→ Usando instalação via Docker...${NC}"
    echo ""

    # Usar o Docker container
    docker run --rm \
        -e TV_IP="$TV_IP" \
        --network host \
        georift/install-jellyfin-tizen

else
    echo -e "${CYAN}→ Usando instalação sem Docker...${NC}"
    echo ""

    # Criar diretório temporário
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"

    echo -e "${CYAN}→ Baixando Jellyfin Tizen...${NC}"

    # Tentar baixar release
    LATEST_URL=$(curl -s https://api.github.com/repos/jellyfin/jellyfin-tizen/releases/latest | grep "browser_download_url.*\.wgt" | cut -d '"' -f 4)

    if [ -n "$LATEST_URL" ]; then
        echo -e "${CYAN}→ Baixando versão pré-compilada...${NC}"
        curl -L -o Jellyfin.wgt "$LATEST_URL"
    else
        echo -e "${CYAN}→ Compilando da fonte...${NC}"
        git clone https://github.com/jellyfin/jellyfin-tizen.git
        cd jellyfin-tizen
        npm install
        npm run build

        if [ -f "Jellyfin.wgt" ]; then
            echo -e "${GREEN}✓ Build completo${NC}"
        else
            echo -e "${RED}Erro ao compilar${NC}"
            exit 1
        fi
    fi

    # Instalar usando Tizen CLI
    echo -e "${CYAN}→ Conectando na TV...${NC}"

    # Verificar se tizen está instalado
    if ! command -v tizen &> /dev/null; then
        if [ -f "$HOME/tizen-studio/tools/ide/bin/tizen" ]; then
            TIZEN="$HOME/tizen-studio/tools/ide/bin/tizen"
        else
            echo -e "${RED}Tizen CLI não encontrado!${NC}"
            echo "Instale de: https://developer.samsung.com/smarttv"
            exit 1
        fi
    else
        TIZEN="tizen"
    fi

    $TIZEN connect "$TV_IP"
    sleep 2

    echo -e "${CYAN}→ Instalando app na TV...${NC}"
    $TIZEN install -n Jellyfin.wgt -t "$TV_IP"

    # Limpar
    cd /
    rm -rf "$TEMP_DIR"
fi

# ============================================================
# PASSO 5: Verificação
# ============================================================

clear
echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✓ INSTALAÇÃO CONCLUÍDA!                              ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}Agora peça para sua amiga verificar:${NC}"
echo ""
echo -e "${GREEN}┌────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│ ENVIE ESTA MENSAGEM PARA SUA AMIGA:                   │${NC}"
echo -e "${GREEN}├────────────────────────────────────────────────────────┤${NC}"
echo -e "${WHITE}│                                                        │${NC}"
echo -e "${WHITE}│ Instalação concluída! 🎉                              │${NC}"
echo -e "${WHITE}│                                                        │${NC}"
echo -e "${WHITE}│ Por favor, verifique:                                 │${NC}"
echo -e "${WHITE}│ 1. Pressione \"Home\" na TV                             │${NC}"
echo -e "${WHITE}│ 2. Vá em \"Apps\"                                       │${NC}"
echo -e "${WHITE}│ 3. Procure \"Jellyfin\" (geralmente no final)           │${NC}"
echo -e "${WHITE}│ 4. O app está aparecendo?                            │${NC}"
echo -e "${WHITE}│                                                        │${NC}"
echo -e "${GREEN}└────────────────────────────────────────────────────────┘${NC}"
echo ""

read -p "O app Jellyfin está aparecendo na TV? (s/n): " APP_VISIBLE

if [[ "$APP_VISIBLE" =~ ^[Ss]$ ]]; then
    echo ""
    echo -e "${GREEN}Excelente! Agora vamos configurar o servidor.${NC}"
    echo ""

    read -p "Digite o IP do servidor Jellyfin (deixe vazio se for esta máquina): " SERVER_IP

    if [ -z "$SERVER_IP" ]; then
        SERVER_IP="$LOCAL_IP"
    fi

    read -p "Porta do Jellyfin (padrão 8096): " SERVER_PORT
    SERVER_PORT=${SERVER_PORT:-8096}

    clear
    echo -e "${GREEN}┌────────────────────────────────────────────────────────┐${NC}"
    echo -e "${GREEN}│ ÚLTIMA MENSAGEM PARA SUA AMIGA:                       │${NC}"
    echo -e "${GREEN}├────────────────────────────────────────────────────────┤${NC}"
    echo -e "${WHITE}│                                                        │${NC}"
    echo -e "${WHITE}│ Perfeito! Agora abra o app Jellyfin e configure:     │${NC}"
    echo -e "${WHITE}│                                                        │${NC}"
    echo -e "${WHITE}│ 1. Abra o app \"Jellyfin\"                             │${NC}"
    echo -e "${WHITE}│ 2. Quando pedir o servidor, digite:                  │${NC}"
    echo -e "${WHITE}│    ${YELLOW}http://$SERVER_IP:$SERVER_PORT${WHITE}                       │${NC}"
    echo -e "${WHITE}│ 3. Faça login com seu usuário e senha                │${NC}"
    echo -e "${WHITE}│ 4. Aproveite! 🍿                                      │${NC}"
    echo -e "${WHITE}│                                                        │${NC}"
    echo -e "${GREEN}└────────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "${GREEN}✓ Tudo pronto!${NC}"
    echo ""

else
    echo ""
    echo -e "${YELLOW}O app não apareceu. Possíveis soluções:${NC}"
    echo ""
    echo "1. Aguarde 1-2 minutos e peça para ela verificar novamente"
    echo "2. Peça para reiniciar a TV"
    echo "3. Execute este script novamente"
    echo ""
fi

echo -e "${CYAN}Obrigado por usar este instalador!${NC}"
echo ""
