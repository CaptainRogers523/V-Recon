#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}   V-RECON v1.0 - Complete Tool Installer${NC}"
echo -e "${CYAN}   By Vinayak Prajapati (Now with Aquatone)${NC}"
echo -e "${CYAN}================================================${NC}\n"

# Check if running as root for apt install
if [ "$EUID" -ne 0 ]; then 
    echo -e "${YELLOW}[!] Some installations may require sudo password${NC}\n"
fi

# ============================================
# STEP 1: Check and Install Go
# ============================================
echo -e "${CYAN}[STEP 1] Checking Go installation...${NC}"

if ! command -v go &> /dev/null; then
    echo -e "${YELLOW}[!] Go not found. Installing Go...${NC}"
    
    wget -q https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
    rm go1.21.5.linux-amd64.tar.gz
    
    export PATH=$PATH:/usr/local/go/bin
    export PATH=$PATH:$HOME/go/bin
    
    echo -e "${GREEN}✓ Go installed${NC}\n"
else
    echo -e "${GREEN}✓ Go already installed: $(go version)${NC}\n"
fi

# ============================================
# STEP 2: Setup PATH permanently
# ============================================
echo -e "${CYAN}[STEP 2] Setting up PATH...${NC}"

if [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    SHELL_RC="$HOME/.profile"
fi

if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" "$SHELL_RC" 2>/dev/null; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> "$SHELL_RC"
    echo 'export PATH=$PATH:$HOME/go/bin' >> "$SHELL_RC"
    echo -e "${GREEN}✓ PATH added to $SHELL_RC${NC}\n"
else
    echo -e "${GREEN}✓ PATH already configured${NC}\n"
fi

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

# ============================================
# STEP 3: Install Go Tools (Including Aquatone)
# ============================================
echo -e "${CYAN}[STEP 3] Installing Go-based tools...${NC}\n"

TOOLS=(
    "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
    "github.com/tomnomnom/assetfinder@latest"
    "github.com/projectdiscovery/httpx/cmd/httpx@latest"
    "github.com/projectdiscovery/katana/cmd/katana@latest"
    "github.com/tomnomnom/waybackurls@latest"
    "github.com/lc/gau/v2/cmd/gau@latest"
    "github.com/hakluke/hakrawler@latest"
    "github.com/michenriksen/aquatone@latest"
)

for tool_path in "${TOOLS[@]}"; do
    tool_name=$(echo $tool_path | awk -F'/' '{print $NF}' | cut -d'@' -f1)
    echo -e "${YELLOW}[+] Installing $tool_name...${NC}"
    go install -v $tool_path 2>/dev/null
    echo -e "${GREEN}✓ $tool_name installed${NC}\n"
done

# ============================================
# STEP 4: Install Dependencies for Aquatone
# ============================================
echo -e "${CYAN}[STEP 4] Checking Aquatone dependencies (Chromium)...${NC}"
if ! command -v chromium &> /dev/null && ! command -v google-chrome &> /dev/null; then
    echo -e "${YELLOW}[!] Browser not found. Installing Chromium...${NC}"
    sudo apt update && sudo apt install -y chromium-browser 2>/dev/null || sudo apt install -y chromium 2>/dev/null
    echo -e "${GREEN}✓ Chromium installed${NC}\n"
else
    echo -e "${GREEN}✓ Browser (Chrome/Chromium) found${NC}\n"
fi

# ============================================
# STEP 5: Install Paramspider
# ============================================
echo -e "${CYAN}[STEP 5] Installing Paramspider...${NC}"
pip3 install --upgrade paramspider 2>/dev/null || pip install paramspider 2>/dev/null
echo -e "${GREEN}✓ Paramspider setup check complete${NC}\n"

# ============================================
# STEP 6: Verify Installation
# ============================================
echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}   Verifying All Tools...${NC}"
echo -e "${CYAN}================================================${NC}\n"

FINAL_CHECK=("subfinder" "assetfinder" "httpx" "katana" "waybackurls" "gau" "hakrawler" "aquatone" "paramspider")
ALL_GOOD=true

for tool in "${FINAL_CHECK[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo -e "${GREEN}✓ $tool ${NC}→ $(which $tool)"
    else
        echo -e "${RED}✗ $tool not found${NC}"
        ALL_GOOD=false
    fi
done

echo ""

if [ "$ALL_GOOD" = true ]; then
    echo -e "${GREEN}================================================${NC}"
    echo -e "${GREEN}   ✓ All core tools installed successfully!${NC}"
    echo -e "${GREEN}================================================${NC}\n"
    echo -e "${CYAN}Run: ${YELLOW}./v-recon.sh${NC} to start\n"
else
    echo -e "${RED}================================================${NC}"
    echo -e "${RED}   ✗ Some tools failed to install${NC}"
    echo -e "${RED}================================================${NC}\n"
    echo -e "${YELLOW}Manual Fix: source $SHELL_RC && ./install_go_tools.sh${NC}\n"
fi

echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}   Installation Complete!${NC}"
echo -e "${CYAN}   V-RECON v1.0 by Vinayak Prajapati${NC}"
echo -e "${CYAN}================================================${NC}"
