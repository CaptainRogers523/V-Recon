#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${CYAN}"
echo "  ██╗   ██╗      ██████╗ ███████╗ ██████╗ ██████╗ ███╗   ██╗"
echo "  ██║   ██║      ██╔══██╗██╔════╝██╔════╝██╔═══██╗████╗  ██║"
echo "  ██║   ██║█████╗██████╔╝█████╗  ██║     ██║   ██║██╔██╗ ██║"
echo "  ╚██╗ ██╔╝╚════╝██╔══██╗██╔══╝  ██║     ██║   ██║██║╚██╗██║"
echo "   ╚████╔╝       ██║  ██║███████╗╚██████╗╚██████╔╝██║ ╚████║"
echo "    ╚═══╝        ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝"
echo -e "${NC}"
echo -e "${GREEN}         [+] Author: CAPTAIN ROGERS${NC}"
echo -e "${GREEN}         [+] Version: v1.0${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Get target
echo -en "${YELLOW}Enter domain: ${NC}"
read DOMAIN

if [ -z "$DOMAIN" ]; then
    echo -e "${RED}No domain entered. Exiting.${NC}"
    exit 1
fi

# Create target folder directly
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="${SCRIPT_DIR}/${DOMAIN}"
mkdir -p "$OUTPUT"
cd "$OUTPUT"

echo -e "${GREEN}[+] Working in: ${DOMAIN}/${NC}\n"

# ===========================================
# STEP 1: Subfinder ONLY
# ===========================================
echo -e "${CYAN}[STEP 1] Running Subfinder...${NC}"

if ! command -v subfinder &> /dev/null; then
    echo -e "${RED}✗ Subfinder not installed!${NC}"
    echo -e "${YELLOW}Install: go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest${NC}"
    exit 1
fi

subfinder -d "$DOMAIN" -silent -o subdomains.txt

if [ -s subdomains.txt ]; then
    COUNT=$(wc -l < subdomains.txt)
    echo -e "${GREEN}✓ Found $COUNT subdomains${NC}"
else
    echo -e "${YELLOW}! No subdomains found${NC}"
    touch subdomains.txt
fi

# ===========================================
# STEP 2: Assetfinder
# ===========================================
echo -e "\n${CYAN}[STEP 2] Running Assetfinder...${NC}"

if ! command -v assetfinder &> /dev/null; then
    echo -e "${RED}✗ Assetfinder not installed!${NC}"
    echo -e "${YELLOW}Install: go install github.com/tomnomnom/assetfinder@latest${NC}"
    echo -e "${YELLOW}Skipping assetfinder...${NC}"
    touch assetfinder.txt
else
    assetfinder --subs-only "$DOMAIN" > assetfinder.txt 2>/dev/null

    if [ -s assetfinder.txt ]; then
        COUNT=$(wc -l < assetfinder.txt)
        echo -e "${GREEN}✓ Found $COUNT subdomains${NC}"
    else
        echo -e "${YELLOW}! No subdomains found${NC}"
        touch assetfinder.txt
    fi
fi

# Combine both
cat subdomains.txt assetfinder.txt 2>/dev/null | sort -u > all_subdomains.txt
TOTAL=$(wc -l < all_subdomains.txt)

echo -e "\n${GREEN}[+] Total unique subdomains: $TOTAL${NC}"
echo -e "${YELLOW}First 5 results:${NC}"
head -5 all_subdomains.txt
echo -e "\n${GREEN}[+] Saved to: all_subdomains.txt${NC}"

# ===========================================
# STEP 3: HTTPX (Live Hosts)
# ===========================================
echo -e "\n${CYAN}[STEP 3] Checking live hosts with HTTPX...${NC}"

if ! command -v httpx &> /dev/null; then
    echo -e "${RED}✗ HTTPX not installed!${NC}"
    echo -e "${YELLOW}Install: go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest${NC}"
    echo -e "${YELLOW}Skipping httpx...${NC}"
    cp all_subdomains.txt live_hosts.txt
else
    if [ -s all_subdomains.txt ]; then
        cat all_subdomains.txt | httpx -silent -o live_hosts.txt

        if [ -s live_hosts.txt ]; then
            COUNT=$(wc -l < live_hosts.txt)
            echo -e "${GREEN}✓ Found $COUNT live hosts${NC}"
            echo -e "${YELLOW}First 5 live hosts:${NC}"
            head -5 live_hosts.txt
            echo -e "\n${GREEN}[+] Saved to: live_hosts.txt${NC}"
        else
            echo -e "${YELLOW}! No live hosts found${NC}"
            touch live_hosts.txt
        fi
    else
        echo -e "${YELLOW}! No subdomains to check${NC}"
        touch live_hosts.txt
    fi
fi

# ===========================================
# STEP 3.5: Aquatone (Screenshots)
# ===========================================
echo -e "\n${CYAN}[STEP 3.5] Taking Screenshots with Aquatone...${NC}"

if ! command -v aquatone &> /dev/null; then
    echo -e "${RED}✗ Aquatone not installed!${NC}"
    echo -e "${YELLOW}Install:${NC}"
    echo -e "${YELLOW}  1. Download latest release from GitHub (michenriksen/aquatone)${NC}"
    echo -e "${YELLOW}  2. Extract and move to /usr/local/bin/${NC}"
    echo -e "${YELLOW}Skipping Aquatone...${NC}"
else
    if [ -s live_hosts.txt ]; then
        LIVE_COUNT=$(wc -l < live_hosts.txt)

        if [ "$LIVE_COUNT" -gt 50 ]; then
            echo -e "${YELLOW}⚠ Found $LIVE_COUNT live hosts. This might take time.${NC}"
            echo -en "${YELLOW}Continue with Aquatone? (y/n): ${NC}"
            read CONTINUE_AQUATONE

            if [[ ! "$CONTINUE_AQUATONE" =~ ^[Yy]$ ]]; then
                echo -e "${YELLOW}Skipping Aquatone...${NC}"
                mkdir -p aquatone_out
                echo "Aquatone skipped by user" > aquatone_out/skipped.txt
            else
                echo -e "${GREEN}[+] Starting Aquatone...${NC}"
                # Aquatone standard input se read karta hai
                cat live_hosts.txt | aquatone -out ./aquatone_out -threads 10

                if [ -d "aquatone_out" ]; then
                    echo -e "${GREEN}✓ Screenshots captured successfully!${NC}"
                    echo -e "${CYAN}[+] Report location: aquatone_out/aquatone_report.html${NC}"
                else
                    echo -e "${YELLOW}! Aquatone output directory not created${NC}"
                fi
            fi
        else
            echo -e "${GREEN}[+] Taking screenshots of $LIVE_COUNT hosts...${NC}"
            cat live_hosts.txt | aquatone -out ./aquatone_out -threads 10

            if [ -d "aquatone_out" ]; then
                echo -e "${GREEN}✓ Screenshots captured successfully!${NC}"
                echo -e "${CYAN}[+] Report location: aquatone_out/aquatone_report.html${NC}"
            else
                echo -e "${YELLOW}! Aquatone output directory not created${NC}"
            fi
        fi
    else
        echo -e "${YELLOW}! No live hosts to screenshot${NC}"
        mkdir -p aquatone_out
        echo "No live hosts found" > aquatone_out/no_hosts.txt
    fi
fi

# ===========================================
# STEP 4: Katana (Crawling)
# ===========================================
echo -e "\n${CYAN}[STEP 4] Crawling with Katana...${NC}"

if ! command -v katana &> /dev/null; then
    echo -e "${RED}✗ Katana not installed!${NC}"
    echo -e "${YELLOW}Install: go install github.com/projectdiscovery/katana/cmd/katana@latest${NC}"
    echo -e "${YELLOW}Skipping katana...${NC}"
    touch katana_urls.txt js_files.txt
else
    if [ -s live_hosts.txt ]; then
        katana -list live_hosts.txt -d 2 -silent -jc -o katana_urls.txt

        if [ -s katana_urls.txt ]; then
            COUNT=$(wc -l < katana_urls.txt)
            echo -e "${GREEN}✓ Found $COUNT URLs${NC}"

            # Extract JS files
            grep -iE "\.js(\?|$)" katana_urls.txt > js_files.txt 2>/dev/null
            JS_COUNT=$(wc -l < js_files.txt 2>/dev/null || echo 0)

            if [ "$JS_COUNT" -gt 0 ]; then
                echo -e "${GREEN}✓ Found $JS_COUNT JS files${NC}"
                echo -e "${YELLOW}First 3 JS files:${NC}"
                head -3 js_files.txt
            fi

            echo -e "\n${GREEN}[+] Saved to: katana_urls.txt${NC}"
            echo -e "${GREEN}[+] Saved to: js_files.txt${NC}"
        else
            echo -e "${YELLOW}! No URLs found${NC}"
            touch katana_urls.txt js_files.txt
        fi
    else
        echo -e "${YELLOW}! No live hosts to crawl${NC}"
        touch katana_urls.txt js_files.txt
    fi
fi

# ===========================================
# STEP 5: Waybackurls (Archive URLs)
# ===========================================
echo -e "\n${CYAN}[STEP 5] Getting Wayback URLs...${NC}"

if ! command -v waybackurls &> /dev/null; then
    echo -e "${RED}✗ Waybackurls not installed!${NC}"
    echo -e "${YELLOW}Install: go install github.com/tomnomnom/waybackurls@latest${NC}"
    echo -e "${YELLOW}Skipping waybackurls...${NC}"
    touch wayback_urls.txt
else
    if [ -s live_hosts.txt ]; then
        cat live_hosts.txt | waybackurls > wayback_urls.txt 2>/dev/null

        if [ -s wayback_urls.txt ]; then
            COUNT=$(wc -l < wayback_urls.txt)
            echo -e "${GREEN}✓ Found $COUNT archived URLs${NC}"
            echo -e "${YELLOW}First 3 archived URLs:${NC}"
            head -3 wayback_urls.txt
            echo -e "\n${GREEN}[+] Saved to: wayback_urls.txt${NC}"
        else
            echo -e "${YELLOW}! No archived URLs found${NC}"
            touch wayback_urls.txt
        fi
    else
        echo -e "${YELLOW}! No hosts to check${NC}"
        touch wayback_urls.txt
    fi
fi

# ===========================================
# STEP 6: GAU (GetAllUrls)
# ===========================================
echo -e "\n${CYAN}[STEP 6] Running GAU...${NC}"

if ! command -v gau &> /dev/null; then
    echo -e "${RED}✗ GAU not installed!${NC}"
    echo -e "${YELLOW}Install: go install github.com/lc/gau/v2/cmd/gau@latest${NC}"
    echo -e "${YELLOW}Skipping gau...${NC}"
    touch gau_urls.txt
else
    if [ -s live_hosts.txt ]; then
        cat live_hosts.txt | gau --subs > gau_urls.txt 2>/dev/null

        if [ -s gau_urls.txt ]; then
            COUNT=$(wc -l < gau_urls.txt)
            echo -e "${GREEN}✓ Found $COUNT URLs from GAU${NC}"
            echo -e "${YELLOW}First 3 GAU URLs:${NC}"
            head -3 gau_urls.txt
            echo -e "\n${GREEN}[+] Saved to: gau_urls.txt${NC}"
        else
            echo -e "${YELLOW}! No URLs found${NC}"
            touch gau_urls.txt
        fi
    else
        echo -e "${YELLOW}! No hosts to check${NC}"
        touch gau_urls.txt
    fi
fi

# ===========================================
# STEP 7: ParamSpider (Parameter Discovery)
# ===========================================
echo -e "\n${CYAN}[STEP 7] Running ParamSpider...${NC}"

if ! command -v paramspider &> /dev/null; then
    echo -e "${RED}✗ ParamSpider not installed!${NC}"
    echo -e "${YELLOW}Install: pipx install paramspider${NC}"
    echo -e "${YELLOW}Skipping ParamSpider...${NC}"
    touch paramspider_raw.txt paramspider_clean.txt
else
    if [ -s live_hosts.txt ]; then
        echo -e "${GREEN}[+] Feeding live hosts to ParamSpider${NC}"

        # ParamSpider auto-creates `results/`
        paramspider -l live_hosts.txt > /dev/null 2>&1

        if [ -d "results" ]; then
            cat results/*.txt 2>/dev/null > paramspider_raw.txt

            if [ -s paramspider_raw.txt ]; then
                echo -e "${GREEN}✓ ParamSpider raw output collected${NC}"

                # Remove FUZZ keyword from parameters
               sed 's/FUZZ//g' paramspider_raw.txt | sort -u > paramspider_clean.txt

                COUNT=$(wc -l < paramspider_clean.txt)
                echo -e "${GREEN}✓ Clean parameters extracted: $COUNT${NC}"
                echo -e "${YELLOW}First 5 clean URLs:${NC}"
                head -5 paramspider_clean.txt
            else
                echo -e "${YELLOW}! No ParamSpider output found${NC}"
                touch paramspider_clean.txt
            fi
        else
            echo -e "${YELLOW}! ParamSpider results directory not found${NC}"
            touch paramspider_raw.txt paramspider_clean.txt
        fi
    else
        echo -e "${YELLOW}! No live hosts to feed ParamSpider${NC}"
        touch paramspider_raw.txt paramspider_clean.txt
    fi
fi

# ===========================================
# FINAL STEP: Merge & Sort All URLs
# (GAU + Katana + Wayback)
# ===========================================
echo -e "\n${CYAN}[FINAL] Merging GAU, Katana & Wayback URLs...${NC}"

cat katana_urls.txt gau_urls.txt wayback_urls.txt 2>/dev/null \
    | sort -u > final_urls.txt

COUNT=$(wc -l < final_urls.txt)

echo -e "${GREEN}✓ Final URLs collected: $COUNT${NC}"
echo -e "${YELLOW}First 5 Final URLs:${NC}"
head -5 final_urls.txt
echo -e "\n${GREEN}[+] Saved to: final_urls.txt${NC}"

# ===========================================
# FINAL SUMMARY
# ===========================================
echo -e "\n${CYAN}========================================${NC}"
echo -e "${CYAN}            FINAL SUMMARY               ${NC}"
echo -e "${CYAN}========================================${NC}"

SUBS_COUNT=$(wc -l < all_subdomains.txt 2>/dev/null || echo 0)
LIVE_COUNT=$(wc -l < live_hosts.txt 2>/dev/null || echo 0)
KATANA_COUNT=$(wc -l < katana_urls.txt 2>/dev/null || echo 0)
GAU_COUNT=$(wc -l < gau_urls.txt 2>/dev/null || echo 0)
WAYBACK_COUNT=$(wc -l < wayback_urls.txt 2>/dev/null || echo 0)
PARAM_COUNT=$(wc -l < paramspider_clean.txt 2>/dev/null || echo 0)
FINAL_COUNT=$(wc -l < final_urls.txt 2>/dev/null || echo 0)

echo -e "${GREEN}Target Domain        : ${DOMAIN}${NC}"
echo -e "${GREEN}Total Subdomains     : ${SUBS_COUNT}${NC}"
echo -e "${GREEN}Live Hosts           : ${LIVE_COUNT}${NC}"
echo -e "${GREEN}Katana URLs          : ${KATANA_COUNT}${NC}"
echo -e "${GREEN}GAU URLs             : ${GAU_COUNT}${NC}"
echo -e "${GREEN}Wayback URLs         : ${WAYBACK_COUNT}${NC}"
echo -e "${GREEN}ParamSpider Params   : ${PARAM_COUNT}${NC}"
echo -e "${GREEN}----------------------------------------${NC}"
echo -e "${GREEN}Final Unified URLs   : ${FINAL_COUNT}${NC}"

# Aquatone status
if [ -d "screenshots" ] && [ -f "screenshots/report.html" ]; then
    echo -e "${GREEN}Screenshots          : ✓ Available${NC}"
    echo -e "${CYAN}  → Open: aquatone_out/aquatone_report.html${NC}"
elif [ -d "screenshots" ]; then
    echo -e "${YELLOW}Screenshots          : Skipped/Failed${NC}"
else
    echo -e "${YELLOW}Screenshots          : Not captured${NC}"
fi

echo -e "${CYAN}========================================${NC}"

echo -e "\n${YELLOW}[+] Key Output Files:${NC}"
echo -e "${CYAN}• live_hosts.txt${NC}"
echo -e "${CYAN}• aquatone_out/aquatone_report.html  ${GREEN}← NEW!${NC}"
echo -e "${CYAN}• katana_urls.txt${NC}"
echo -e "${CYAN}• gau_urls.txt${NC}"
echo -e "${CYAN}• wayback_urls.txt${NC}"
echo -e "${CYAN}• paramspider_clean.txt${NC}"
echo -e "${CYAN}• final_urls.txt${NC}"

echo -e "\n${GREEN}Recon completed successfully, Boss.${NC}"
