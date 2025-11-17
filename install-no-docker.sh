#!/bin/bash

# Jellyfin Samsung TV Installer (No Docker Required)
# This script downloads and installs Jellyfin directly using Tizen CLI

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Jellyfin Samsung TV Installer${NC}"
echo -e "${GREEN}(No Docker Version)${NC}"
echo -e "${GREEN}================================${NC}"
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for required tools
echo -e "${YELLOW}Step 1: Checking prerequisites...${NC}"

# Check for git
if ! command_exists git; then
    echo -e "${RED}Error: git is not installed.${NC}"
    echo "Please install git first."
    exit 1
fi

# Check for npm/node
if ! command_exists npm; then
    echo -e "${RED}Error: npm is not installed.${NC}"
    echo "Please install Node.js and npm first: https://nodejs.org/"
    exit 1
fi

echo -e "${GREEN}✓ Prerequisites check passed${NC}"
echo ""

# Get local IP address
LOCAL_IP=$(hostname -I | awk '{print $1}' 2>/dev/null || ipconfig getifaddr en0 2>/dev/null || echo "unknown")
if [ "$LOCAL_IP" != "unknown" ]; then
    echo -e "Your computer's IP address: ${GREEN}$LOCAL_IP${NC}"
else
    echo -e "${YELLOW}Could not auto-detect IP address. Please find it manually.${NC}"
fi
echo ""

# Developer mode instructions
echo -e "${YELLOW}Step 2: Enable Developer Mode on your Samsung TV${NC}"
echo ""
echo "Please follow these steps on your TV:"
echo "  1. Press 'Home' button on your remote"
echo "  2. Go to 'Apps'"
echo "  3. Enter: ${BLUE}12345${NC}"
echo "  4. Toggle 'Developer mode' to ${GREEN}ON${NC}"
echo "  5. Enter your computer IP: ${GREEN}$LOCAL_IP${NC}"
echo "  6. ${RED}Restart your TV${NC} (important!)"
echo ""
read -p "Have you completed these steps and restarted your TV? (yes/no): " READY

if [[ ! "$READY" =~ ^[Yy][Ee][Ss]$ ]]; then
    echo -e "${YELLOW}Please complete the setup steps first, then run this script again.${NC}"
    exit 0
fi

echo ""
echo -e "${YELLOW}Step 3: Enter your TV's IP address${NC}"
echo "Find it at: Settings > General > Network > Network Status > IP Settings"
echo ""
read -p "TV IP Address: " TV_IP

if [ -z "$TV_IP" ]; then
    echo -e "${RED}Error: TV IP address is required.${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Step 4: Checking for Tizen CLI...${NC}"

# Check if tizen command exists
TIZEN_BIN=""
if command_exists tizen; then
    TIZEN_BIN="tizen"
    echo -e "${GREEN}✓ Tizen CLI found${NC}"
elif [ -f "$HOME/tizen-studio/tools/ide/bin/tizen" ]; then
    TIZEN_BIN="$HOME/tizen-studio/tools/ide/bin/tizen"
    echo -e "${GREEN}✓ Tizen Studio found${NC}"
else
    echo -e "${RED}Tizen CLI not found.${NC}"
    echo ""
    echo "Please install Tizen Studio or Tizen CLI:"
    echo "https://developer.samsung.com/smarttv/develop/getting-started/setting-up-sdk/installing-tv-sdk.html"
    echo ""
    echo -e "${YELLOW}Quick install (Ubuntu/Debian):${NC}"
    echo "wget http://download.tizen.org/sdk/Installer/tizen-studio_4.6/web-cli_Tizen_Studio_4.6_ubuntu-64.bin"
    echo "chmod +x web-cli_Tizen_Studio_4.6_ubuntu-64.bin"
    echo "./web-cli_Tizen_Studio_4.6_ubuntu-64.bin"
    exit 1
fi

echo ""
echo -e "${YELLOW}Step 5: Downloading Jellyfin Tizen app...${NC}"

# Create temp directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Check if we should clone or download release
echo "Checking for latest release..."

# Try to download the latest release
LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/jellyfin/jellyfin-tizen/releases/latest | grep "browser_download_url.*\.wgt" | cut -d '"' -f 4)

if [ -n "$LATEST_RELEASE_URL" ]; then
    echo "Downloading pre-built package..."
    curl -L -o Jellyfin.wgt "$LATEST_RELEASE_URL"
    WGT_FILE="Jellyfin.wgt"
else
    echo "Building from source..."
    git clone https://github.com/jellyfin/jellyfin-tizen.git
    cd jellyfin-tizen

    echo "Installing dependencies..."
    npm install

    echo "Building app..."
    npm run build

    # Package the app
    if [ -f "Jellyfin.wgt" ]; then
        WGT_FILE="Jellyfin.wgt"
    elif [ -d "dist" ]; then
        echo "Packaging app..."
        cd dist
        zip -r ../Jellyfin.wgt .
        cd ..
        WGT_FILE="Jellyfin.wgt"
    else
        echo -e "${RED}Error: Could not find built app${NC}"
        exit 1
    fi
fi

echo ""
echo -e "${YELLOW}Step 6: Connecting to your TV...${NC}"

# Connect to TV
"$TIZEN_BIN" connect "$TV_IP"
sleep 2

# Check connection
echo "Verifying connection..."
if "$TIZEN_BIN" devices | grep -q "$TV_IP"; then
    echo -e "${GREEN}✓ Connected to TV${NC}"
else
    echo -e "${RED}Failed to connect to TV${NC}"
    echo "Please check:"
    echo "  - TV is in Developer Mode"
    echo "  - TV and computer are on same network"
    echo "  - TV IP address is correct: $TV_IP"
    exit 1
fi

echo ""
echo -e "${YELLOW}Step 7: Installing Jellyfin app...${NC}"

# Install the app
if [ -f "$WGT_FILE" ]; then
    "$TIZEN_BIN" install -n "$WGT_FILE" -t "$TV_IP"
else
    echo -e "${RED}Error: Could not find Jellyfin.wgt file${NC}"
    exit 1
fi

# Cleanup
cd /
rm -rf "$TEMP_DIR"

echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Installation Complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo -e "Jellyfin has been installed on your Samsung TV!"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Go to ${BLUE}Apps${NC} on your TV"
echo "2. Find ${BLUE}Jellyfin${NC} (usually at the end of the list)"
echo "3. Open the app"
echo "4. Enter your Jellyfin server address (e.g., http://192.168.1.50:8096)"
echo "5. Login and enjoy your media!"
echo ""
echo -e "${YELLOW}Note:${NC} Developer certificates expire after some time."
echo "If the app stops working, just run this script again to reinstall."
echo ""
