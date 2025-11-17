#!/bin/bash

# Jellyfin Samsung TV Installer
# Automated installation script using Docker

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Jellyfin Samsung TV Installer${NC}"
echo -e "${GREEN}================================${NC}"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Error: Docker is not installed.${NC}"
    echo "Please install Docker first: https://docs.docker.com/get-docker/"
    exit 1
fi

echo -e "${YELLOW}Step 1: Checking prerequisites...${NC}"
echo ""

# Get local IP address
LOCAL_IP=$(hostname -I | awk '{print $1}')
echo -e "Your computer's IP address: ${GREEN}$LOCAL_IP${NC}"
echo ""

echo -e "${YELLOW}Step 2: Please ensure your Samsung TV is ready:${NC}"
echo "  1. Press 'Home' button on your remote"
echo "  2. Go to 'Apps'"
echo "  3. Enter: 12345"
echo "  4. Enable 'Developer mode'"
echo "  5. Enter this IP address: $LOCAL_IP"
echo "  6. Restart your TV"
echo ""
read -p "Have you completed these steps? (yes/no): " READY

if [[ ! "$READY" =~ ^[Yy][Ee][Ss]$ ]]; then
    echo -e "${YELLOW}Please complete the setup steps first, then run this script again.${NC}"
    exit 0
fi

echo ""
echo -e "${YELLOW}Step 3: Enter your TV's IP address${NC}"
echo "You can find this in: Settings > General > Network > Network Status"
read -p "TV IP Address: " TV_IP

if [ -z "$TV_IP" ]; then
    echo -e "${RED}Error: TV IP address is required.${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Step 4: Running Jellyfin installer...${NC}"
echo ""

# Use the official Jellyfin Tizen installer Docker image
docker run --rm \
    -e TV_IP="$TV_IP" \
    --network host \
    georift/install-jellyfin-tizen

echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Installation Complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo "Jellyfin should now be installed on your Samsung TV."
echo "You can find it in your TV's app list."
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Open Jellyfin app on your TV"
echo "2. Enter your Jellyfin server address"
echo "3. Login with your credentials"
echo "4. Enjoy your media!"
echo ""
echo -e "${YELLOW}Note:${NC} If you need to reinstall, just run this script again."
