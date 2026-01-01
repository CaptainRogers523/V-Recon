#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}  V-RECON v1.0 - Complete Tool Installer${NC}"
echo -e "${CYAN}  By Vinayak Prajapati${NC}"
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
    
    # Download and install Go
    wget -q https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
    rm go1.21.5.linux-amd64.tar.gz
    
    # Add Go to PATH
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

# Detect shell
if [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    SHELL_RC="$HOME/.profile"
fi

# Add Go paths if not already present
if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" "$SHELL_RC" 2>/dev/null; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> "$SHELL_RC"
    echo 'export PATH=$PATH:$HOME/go/bin' >> "$SHELL_RC"
    echo -e "${GREEN}✓ PATH added to $SHELL_RC${NC}\n"
else
    echo -e "${GREEN}✓ PATH already configured${NC}\n"
fi

# Apply PATH for current session
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

# ============================================
# STEP 3: Install Go Tools
# ============================================
echo -e "${CYAN}[STEP 3] Installing Go-based tools...${NC}\n"

echo -e "${YELLOW}[1/7] Installing Subfinder...${NC}"
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest 2>/dev/null
echo -e "${GREEN}✓ Subfinder installed${NC}\n"

echo -e "${YELLOW}[2/7] Installing Assetfinder...${NC}"
go install github.com/tomnomnom/assetfinder@latest 2>/dev/null
echo -e "${GREEN}✓ Assetfinder installed${NC}\n"

echo -e "${YELLOW}[3/7] Installing HTTPX...${NC}"
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest 2>/dev/null
echo -e "${GREEN}✓ HTTPX installed${NC}\n"

echo -e "${YELLOW}[4/7] Installing Katana...${NC}"
go install github.com/projectdiscovery/katana/cmd/katana@latest 2>/dev/null
echo -e "${GREEN}✓ Katana installed${NC}\n"

echo -e "${YELLOW}[5/7] Installing Waybackurls...${NC}"
go install github.com/tomnomnom/waybackurls@latest 2>/dev/null
echo -e "${GREEN}✓ Waybackurls installed${NC}\n"

echo -e "${YELLOW}[6/7] Installing GAU...${NC}"
go install github.com/lc/gau/v2/cmd/gau@latest 2>/dev/null
echo -e "${GREEN}✓ GAU installed${NC}\n"

echo -e "${YELLOW}[7/7] Installing Hakrawler...${NC}"
go install github.com/hakluke/hakrawler@latest 2>/dev/null
echo -e "${GREEN}✓ Hakrawler installed${NC}\n"

# ============================================
# STEP 4: Install Paramspider
# ============================================
echo -e "${CYAN}[STEP 4] Installing Paramspider...${NC}"

if command -v apt &> /dev/null; then
    # Try apt first (Kali/Debian/Ubuntu)
    if sudo apt install -y paramspider 2>/dev/null; then
        echo -e "${GREEN}✓ Paramspider installed via apt${NC}\n"
    else
        # Fallback to pipx (recommended) or pip
        echo -e "${YELLOW}[!] apt failed, trying pipx...${NC}"
        if command -v pipx &> /dev/null; then
            pipx install paramspider 2>/dev/null
            echo -e "${GREEN}✓ Paramspider installed via pipx${NC}\n"
        else
            echo -e "${YELLOW}[!] pipx not found, trying pip...${NC}"
            pip3 install paramspider 2>/dev/null || pip install paramspider 2>/dev/null
            echo -e "${GREEN}✓ Paramspider installed via pip${NC}\n"
        fi
    fi
else
    # Use pipx/pip if apt not available
    if command -v pipx &> /dev/null; then
        pipx install paramspider 2>/dev/null
        echo -e "${GREEN}✓ Paramspider installed via pipx${NC}\n"
    else
        pip3 install paramspider 2>/dev/null || pip install paramspider 2>/dev/null
        echo -e "${GREEN}✓ Paramspider installed via pip${NC}\n"
    fi
fi

# ============================================
# STEP 5: Install EyeWitness (Optional)
# ============================================
echo -e "${CYAN}[STEP 5] Installing EyeWitness...${NC}"
echo -e "${YELLOW}[!] EyeWitness requires additional setup${NC}"

if command -v eyewitness &> /dev/null; then
    echo -e "${GREEN}✓ EyeWitness already installed${NC}\n"
else
    echo -e "${YELLOW}[!] EyeWitness not found${NC}"
    echo -e "${CYAN}To install EyeWitness, run:${NC}"
    echo -e "${YELLOW}  git clone https://github.com/FortyNorthSecurity/EyeWitness.git${NC}"
    echo -e "${YELLOW}  cd EyeWitness/Python/setup${NC}"
    echo -e "${YELLOW}  sudo ./setup.sh${NC}"
    echo -e "${CYAN}Or via pipx:${NC}"
    echo -e "${YELLOW}  pipx install eyewitness${NC}\n"
    echo -e "${YELLOW}[!] You can install it later, V-RECON will skip if not found${NC}\n"
fi

# ============================================
# STEP 6: Verify Installation
# ============================================
echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}  Verifying All Tools...${NC}"
echo -e "${CYAN}================================================${NC}\n"

TOOLS=("subfinder" "assetfinder" "httpx" "katana" "waybackurls" "gau" "hakrawler" "paramspider")
ALL_GOOD=true

for tool in "${TOOLS[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo -e "${GREEN}✓ $tool ${NC}→ $(which $tool)"
    else
        echo -e "${RED}✗ $tool not found${NC}"
        ALL_GOOD=false
    fi
done

# Check EyeWitness separately (optional)
if command -v eyewitness &> /dev/null; then
    echo -e "${GREEN}✓ eyewitness ${NC}→ $(which eyewitness) ${CYAN}[OPTIONAL]${NC}"
else
    echo -e "${YELLOW}○ eyewitness not found ${CYAN}[OPTIONAL - Install manually]${NC}"
fi

echo ""

if [ "$ALL_GOOD" = true ]; then
    echo -e "${GREEN}================================================${NC}"
    echo -e "${GREEN}  ✓ All core tools installed successfully!${NC}"
    echo -e "${GREEN}================================================${NC}\n"
    echo -e "${CYAN}Run: ${YELLOW}./v-recon.sh${NC} to start\n"
    echo -e "${YELLOW}[!] Restart your terminal or run:${NC}"
    echo -e "${YELLOW}    source $SHELL_RC${NC}\n"
    
    if ! command -v eyewitness &> /dev/null; then
        echo -e "${CYAN}[INFO] EyeWitness is optional for screenshots${NC}"
        echo -e "${CYAN}       V-RECON will work without it${NC}\n"
    fi
else
    echo -e "${RED}================================================${NC}"
    echo -e "${RED}  ✗ Some tools failed to install${NC}"
    echo -e "${RED}================================================${NC}\n"
    echo -e "${YELLOW}Try manually:${NC}"
    echo -e "${YELLOW}  1. Close and reopen terminal${NC}"
    echo -e "${YELLOW}  2. Run: source $SHELL_RC${NC}"
    echo -e "${YELLOW}  3. Run this script again${NC}\n"
fi

echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}  Installation Complete!${NC}"
echo -e "${CYAN}  V-RECON v1.0 by Vinayak Prajapati${NC}"
echo -e "${CYAN}================================================${NC}"
