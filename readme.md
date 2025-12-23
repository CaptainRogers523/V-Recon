# 🔍 V-RECON v5.6.2.8

**Automated Reconnaissance Tool**  
*By Vinayak Prajapati*

A comprehensive subdomain enumeration and URL discovery tool that combines multiple reconnaissance utilities into one automated workflow.

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
- **Deep web crawling** for URL and JavaScript discovery
- **Archive URL retrieval** from Wayback Machine
- **Parameter-based URL discovery**
- **Step-by-step execution** with real-time progress
- **Clean output structure** organized by target domain
- **Color-coded terminal output** for better readability

---

## 🛠 Tools Included

| Tool | Purpose |
|------|---------|
| **Subfinder** | Subdomain enumeration using passive sources |
| **Assetfinder** | Additional subdomain discovery |
| **HTTPX** | Fast HTTP probe for live host detection |
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
- Sudo privileges (for some installations)

### Automated Installation

Run the installer script that will set up everything:

```bash
# Clone or download the repository
cd v-recon

# Make installer executable
chmod +x install_go_tools.sh

# Run the installer
./install_go_tools.sh
```

**The installer will:**
- ✅ Install Go (if not present)
- ✅ Configure PATH environment variables
- ✅ Install all Go-based tools
- ✅ Install Paramspider via apt/pip
- ✅ Verify all installations

### Post-Installation

After installation completes, restart your terminal or run:

```bash
source ~/.bashrc
# or
source ~/.zshrc
```

### Verify Installation

Check if all tools are accessible:

```bash
subfinder -version
httpx -version
katana -version
# ... etc
```

---

## 🚀 Usage

### Basic Usage

```bash
# Make the script executable
chmod +x v-recon.sh

# Run the script
./v-recon.sh
```

You'll be prompted to enter a target domain:

```
Enter domain: example.com
```

### Example

```bash
./v-recon.sh
# Input: hackerone.com
```

The script will automatically:
1. Find all subdomains
2. Check which hosts are live
3. Crawl for URLs and JS files
4. Fetch archived URLs
5. Discover parameter-based URLs
6. Save everything to organized files

---

## 📁 Output Structure

All results are saved in a directory named after your target:

```
target-domain/
├── subdomains.txt          # Subfinder results
├── assetfinder.txt         # Assetfinder results
├── all_subdomains.txt      # Combined unique subdomains
├── live_hosts.txt          # Active/live hosts
├── katana_urls.txt         # URLs discovered by Katana
├── js_files.txt            # JavaScript files found
├── wayback_urls.txt        # Archived URLs from Wayback
├── gau_urls.txt            # URLs from GAU
├── param_urls.txt          # Parameter-based URLs
└── hakrawler_urls.txt      # URLs from Hakrawler
```

### Key Files

- **`all_subdomains.txt`** - Start here for complete subdomain list
- **`live_hosts.txt`** - These are your active targets
- **`js_files.txt`** - JavaScript files (great for security research)
- **`param_urls.txt`** - URLs with parameters (useful for testing)

---

## ⚠️ Legal Disclaimer

**IMPORTANT:** This tool is designed for:
- Security professionals conducting authorized penetration tests
- Bug bounty hunters working within program scopes
- Website owners testing their own infrastructure
- Educational purposes in controlled environments

**You must:**
- ✅ Only scan domains you own or have explicit written permission to test
- ✅ Respect rate limits and terms of service
- ✅ Check bug bounty program scopes before testing
- ✅ Comply with all applicable laws and regulations

**DO NOT:**
- ❌ Scan targets without authorization
- ❌ Use for malicious purposes
- ❌ Violate computer fraud and abuse laws
- ❌ Cause service disruptions or damage

**The author is not responsible for misuse of this tool.**

---

## 🔧 Troubleshooting

### Tools Not Found After Installation

If tools aren't accessible after installation:

```bash
# Check if Go bin is in PATH
echo $PATH | grep go/bin

# If not, manually add to your shell config
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc
```

### Paramspider Issues

If Paramspider isn't working properly:

```bash
# Try reinstalling via pip
pip3 install --upgrade paramspider

# Or install from source
git clone https://github.com/devanshbatham/ParamSpider
cd ParamSpider
pip3 install .
```

### Permission Denied Errors

Make sure scripts are executable:

```bash
chmod +x v-recon.sh
chmod +x install_go_tools.sh
```

### No Results Found

Common reasons:
- Target domain doesn't have many subdomains
- Rate limiting by external services
- Network/connectivity issues
- Target has strong security measures

Try testing with known large targets like:
- `hackerone.com`
- `bugcrowd.com`
- `github.com`

### Go Installation Issues

If automatic Go installation fails:

```bash
# Manual installation
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
```

---

## 📊 Performance Tips

- **For faster scans:** Reduce crawl depth in Katana (default: `-d 2`)
- **For thorough scans:** Increase timeout values and crawl depth
- **For large targets:** Run during off-peak hours
- **For rate limiting:** Add delays between requests

---

## 🔄 Updates

Current Version: **5.6.2.8**

To update tools to latest versions:

```bash
# Re-run the installer
./install_go_tools.sh
```

---

## 🤝 Contributing

Found a bug or want to add features? Contributions are welcome!

---

## 👤 Author

**Vinayak Prajapati**

---

## 📝 License

This tool is provided as-is for educational and authorized testing purposes only.

---

## 🌟 Acknowledgments

Thanks to the creators of:
- ProjectDiscovery (Subfinder, HTTPX, Katana)
- Tom Hudson (Assetfinder, Waybackurls)
- Devansh Batham (ParamSpider)
- Luke Stephens (Hakrawler)
- And the entire bug bounty community

---

**Happy Hunting! 🎯**