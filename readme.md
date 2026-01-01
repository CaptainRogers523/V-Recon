# 🔍 V-RECON v1.0

**Automated Reconnaissance Tool with Visual Intelligence**  
*By Vinayak Prajapati*

A comprehensive subdomain enumeration and URL discovery tool that combines multiple reconnaissance utilities into one automated workflow - now with **visual screenshot capabilities**.

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
- **📸 Visual reconnaissance** with EyeWitness screenshots
- **Deep web crawling** for URL and JavaScript discovery
- **Archive URL retrieval** from Wayback Machine and multiple sources
- **Parameter-based URL discovery** for deeper testing
- **Step-by-step execution** with real-time progress
- **Clean output structure** organized by target domain
- **Color-coded terminal output** for better readability
- **Smart confirmation** for large-scale scans

---

## 🛠 Tools Included

| Tool | Purpose |
|------|---------|
| **Subfinder** | Subdomain enumeration using passive sources |
| **Assetfinder** | Additional subdomain discovery |
| **HTTPX** | Fast HTTP probe for live host detection |
| **EyeWitness** | 📸 Screenshot and visual reporting of web applications |
| **Katana** | Web crawling and JavaScript file discovery |
| **Waybackurls** | Fetch URLs from Wayback Machine |
| **GAU** | GetAllUrls - fetch known URLs from multiple sources |
| **Paramspider** | Discover URLs with parameters |

---

## 📦 Installation

### Prerequisites

- Linux/Unix system (Kali, Ubuntu, Debian, etc.)
- Internet connection
- Sudo privileges (for some installations)
- Python 3.x (for EyeWitness and Paramspider)

### Automated Installation

Run the installer script that will set up everything:

```bash
# Clone or download the repository
cd v-recon

# Make installer executable
chmod +x install_tools.sh

# Run the installer
./install_tools.sh
```

**The installer will:**
- ✅ Install Go (if not present)
- ✅ Configure PATH environment variables
- ✅ Install all Go-based tools
- ✅ Install Paramspider via pipx
- ✅ Install EyeWitness dependencies
- ✅ Verify all installations

### Installing EyeWitness

EyeWitness has specific dependencies. Install it separately:

**Method 1: Git Clone (Recommended)**
```bash
git clone https://github.com/FortyNorthSecurity/EyeWitness.git
cd EyeWitness/Python/setup
sudo ./setup.sh
```

**Method 2: Using pipx**
```bash
pipx install eyewitness
```

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
eyewitness --version
paramspider --help
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
3. **📸 Take screenshots of live hosts**
4. Crawl for URLs and JS files
5. Fetch archived URLs
6. Discover parameter-based URLs
7. Save everything to organized files

### Smart Confirmation

When scanning targets with **50+ live hosts**, V-RECON will ask for confirmation before running EyeWitness to avoid long wait times. You can choose to:
- ✅ Continue with screenshots
- ⏭️ Skip EyeWitness and proceed with other tools

---

## 📁 Output Structure

All results are saved in a directory named after your target:

```
target-domain/
├── subdomains.txt          # Subfinder results
├── assetfinder.txt         # Assetfinder results
├── all_subdomains.txt      # Combined unique subdomains
├── live_hosts.txt          # Active/live hosts
├── screenshots/            # 📸 NEW: Visual recon folder
│   ├── report.html        # Interactive HTML report with thumbnails
│   ├── screens/           # Full-size screenshots
│   └── source/            # HTML source of captured pages
├── katana_urls.txt         # URLs discovered by Katana
├── js_files.txt            # JavaScript files found
├── wayback_urls.txt        # Archived URLs from Wayback
├── gau_urls.txt            # URLs from GAU
├── paramspider_raw.txt     # Raw ParamSpider output
├── paramspider_clean.txt   # Cleaned parameters (FUZZ removed)
└── final_urls.txt          # Merged unique URLs from all sources
```

### Key Files

- **`all_subdomains.txt`** - Start here for complete subdomain list
- **`live_hosts.txt`** - These are your active targets
- **`screenshots/report.html`** - 📸 Visual overview of all live hosts
- **`js_files.txt`** - JavaScript files (great for security research)
- **`paramspider_clean.txt`** - URLs with parameters (useful for testing)
- **`final_urls.txt`** - Master list of all discovered URLs

---

## 📸 Screenshot Report Features

The **EyeWitness report** provides:

- 🖼️ **Thumbnails** of all captured websites
- 🔗 **Clickable links** to full-size screenshots
- 📊 **HTTP response codes** and server headers
- 🎯 **Quick visual identification** of interesting targets
- 💾 **HTML source code** preservation
- ⚡ **Multi-threaded capture** for speed

**How to view:**
```bash
# Navigate to your results folder
cd target-domain/screenshots/

# Open the report in your browser
firefox report.html
# or
google-chrome report.html
```

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

### EyeWitness Issues

**Error: "eyewitness: command not found"**
```bash
# Install via Git (Recommended)
git clone https://github.com/FortyNorthSecurity/EyeWitness.git
cd EyeWitness/Python/setup
sudo ./setup.sh

# Or via pipx
pipx install eyewitness
```

**EyeWitness taking too long:**
- The script will prompt you for confirmation if 50+ hosts are found
- You can skip EyeWitness and run it manually later:
```bash
eyewitness -f live_hosts.txt --web -d screenshots --timeout 10 --threads 10
```

**Screenshot quality issues:**
- Increase timeout: `--timeout 20`
- Check network connectivity
- Some sites may block automated screenshot tools

### Paramspider Issues

If Paramspider isn't working properly:

```bash
# Try reinstalling via pipx
pipx install paramspider

# Or install from source
git clone https://github.com/devanshbatham/ParamSpider
cd ParamSpider
pip3 install .
```

### Permission Denied Errors

Make sure scripts are executable:

```bash
chmod +x v-recon.sh
chmod +x install_tools.sh
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
- **For large targets:** Run during off-peak hours or skip EyeWitness initially
- **For rate limiting:** Add delays between requests
- **For screenshots:** Use `--threads 20` in EyeWitness for faster capture
- **Memory optimization:** If running out of memory, reduce thread count

---

## 🆕 What's New in v1.0

✨ **Major Features:**
- 📸 **EyeWitness Integration** - Automated screenshot capture of live hosts
- 🎨 **Visual HTML Report** - Interactive report with thumbnails and links
- 🤔 **Smart Confirmation** - Prompts user for large-scale screenshot operations
- 📊 **Enhanced Summary** - Shows screenshot status in final output
- 🔧 **Improved Error Handling** - Graceful fallback if tools are missing
- 📝 **Comprehensive Documentation** - Complete guide with troubleshooting

---

## 🔄 Updates

Current Version: **v1.0**

To update tools to latest versions:

```bash
# Re-run the installer
./install_tools.sh
```

---

## 🤝 Contributing

Found a bug or want to add features? Contributions are welcome!

Suggested improvements:
- Additional reconnaissance tools integration
- Custom screenshot configurations
- Report generation in multiple formats
- Automated vulnerability scanning modules

---

## 👤 Author

**Vinayak Prajapati**  
*Cybersecurity Enthusiast | Bug Bounty Hunter*

---

## 📝 License

This tool is provided as-is for educational and authorized testing purposes only.

---

## 🌟 Acknowledgments

Thanks to the creators of:
- ProjectDiscovery (Subfinder, HTTPX, Katana)
- Tom Hudson (Assetfinder, Waybackurls)
- Devansh Batham (ParamSpider)
- FortyNorth Security (EyeWitness)
- And the entire bug bounty community

---

## 📖 Quick Start Guide

```bash
# 1. Clone the repository
git clone <repo-url>
cd v-recon

# 2. Install tools
chmod +x install_tools.sh
./install_tools.sh

# 3. Install EyeWitness
git clone https://github.com/FortyNorthSecurity/EyeWitness.git
cd EyeWitness/Python/setup && sudo ./setup.sh

# 4. Run V-RECON
cd ../../../
chmod +x v-recon.sh
./v-recon.sh

# 5. View results
cd target-domain/
firefox screenshots/report.html  # View screenshots
cat all_subdomains.txt            # View subdomains
cat final_urls.txt                # View all URLs
```

---

**Happy Hunting! 🎯**  
*Now with Visual Intelligence 📸*
