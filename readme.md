# 🔍 V-RECON v1.0

**Automated Reconnaissance Tool with Visual Intelligence** *By Vinayak Prajapati*

A comprehensive subdomain enumeration and URL discovery tool that combines multiple reconnaissance utilities into one automated workflow - now with **fast visual screenshot capabilities using Aquatone**.

---

## 📋 Table of Contents

- [Features](#-features)
- [Tools Included](#-tools-included)
- [Installation](#-installation)
- [Usage](#-usage)
- [Output Structure](#-output-structure)
- [Legal Disclaimer](#-legal-disclaimer)
- [Troubleshooting](#-troubleshooting)

---

## ✨ Features

- **Automated subdomain discovery** using multiple sources
- **Live host detection** with HTTPX
- **📸 High-speed visual reconnaissance** with Aquatone screenshots
- **Deep web crawling** for URL and JavaScript discovery
- **Archive URL retrieval** from Wayback Machine
- **Parameter-based URL discovery**
- **Step-by-step execution** with real-time progress
- **Clean output structure** organized by target domain
- **Color-coded terminal output** for better readability
- **Smart confirmation** for large-scale scans (50+ hosts)

---

## 🛠 Tools Included

| Tool | Purpose |
|------|---------|
| **Subfinder** | Subdomain enumeration using passive sources |
| **Assetfinder** | Additional subdomain discovery |
| **HTTPX** | Fast HTTP probe for live host detection |
| **Aquatone** | 📸 Visual reporting and Fly-over of web applications |
| **Katana** | Web crawling and JavaScript file discovery |
| **Waybackurls** | Fetch URLs from Wayback Machine |
| **GAU** | GetAllUrls - fetch known URLs from multiple sources |
| **Paramspider** | Discover URLs with parameters |
| **Hakrawler** | Additional web crawling |

---

## 📦 Installation

### Prerequisites

- Linux/Unix system (Kali, Ubuntu, Debian, etc.)
- Internet connection
- Sudo privileges
- **Chromium/Chrome browser** (Required for Aquatone)

### Automated Installation

Run the installer script that will set up everything:

```bash
# Clone or download the repository
cd v-recon

# Make installer executable
chmod +x install_go_tools.sh

# Run the installer
./install_go_tools.sh
The installer will:

✅ Install Go (if not present)

✅ Configure PATH environment variables

✅ Install all Go-based tools (including Aquatone)

✅ Install Paramspider via apt/pip

✅ Verify all installations

Post-Installation
After installation completes, restart your terminal or run:

Bash

source ~/.bashrc
# or
source ~/.zshrc
Verify Installation
Check if all tools are accessible:

Bash

subfinder -version
httpx -version
aquatone -version
katana -version
🚀 Usage
Basic Usage
Bash

# Make the script executable
chmod +x v-recon.sh

# Run the script
./v-recon.sh
You'll be prompted to enter a target domain:

Enter domain: example.com
Example Scan
The script will automatically:

Find all subdomains

Check which hosts are live

📸 Take screenshots of live hosts using Aquatone

Crawl for URLs and JS files

Fetch archived URLs

Discover parameter-based URLs

Save everything to organized files

📁 Output Structure
All results are saved in a directory named after your target:

target-domain/
├── subdomains.txt          # Subfinder results
├── assetfinder.txt         # Assetfinder results
├── all_subdomains.txt      # Combined unique subdomains
├── live_hosts.txt          # Active/live hosts
├── aquatone_out/           # 📸 NEW: Visual recon folder
│   ├── aquatone_report.html # Interactive HTML report with screenshots
│   ├── screenshots/        # Full-size PNG files
│   └── html/               # Raw HTML source of pages
├── katana_urls.txt         # URLs discovered by Katana
├── js_files.txt            # JavaScript files found
├── wayback_urls.txt        # Archived URLs from Wayback
├── gau_urls.txt            # URLs from GAU
├── param_urls.txt          # Parameter-based URLs
└── hakrawler_urls.txt      # URLs from Hakrawler
Key Files
all_subdomains.txt - Complete unique subdomain list

aquatone_out/aquatone_report.html - 📸 Visual overview of all live hosts

js_files.txt - JavaScript files for sensitive data discovery

param_urls.txt - URLs with parameters (useful for SQLi/XSS testing)

⚠️ Legal Disclaimer
IMPORTANT: This tool is designed for authorized testing only. The author is not responsible for misuse or any damage caused by this tool. Always stay within the scope of your target's policy.

🔧 Troubleshooting
Tools Not Found
If tools aren't accessible:

Bash

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc
Aquatone Issues
If Aquatone fails to take screenshots, ensure Chromium is installed:

Bash

sudo apt update && sudo apt install chromium-browser -y
Permission Denied
Bash

chmod +x v-recon.sh
chmod +x install_go_tools.sh
📊 Performance Tips
For faster scans: Reduce crawl depth in Katana (default: -d 2)

Large Targets: If 50+ hosts are found, Aquatone will ask for confirmation.

Rate Limiting: If getting blocked, increase the timeout in the script.

🔄 Updates
Current Version: 5.6.3

To update tools to latest versions:

Bash

./install_go_tools.sh
👤 Author
Vinayak Prajapati

📝 License
This tool is provided as-is for educational and authorized testing purposes only.

🌟 Acknowledgments
Thanks to the creators of:

ProjectDiscovery (Subfinder, HTTPX, Katana)

Tom Hudson (Assetfinder, Waybackurls)

Devansh Batham (ParamSpider)

Luke Stephens (Hakrawler)

Michael Henriksen (Aquatone)

Happy Hunting! 🎯
