🔍 V-RECON v1.1Automated Reconnaissance Tool with Visual Intelligence By Vinayak PrajapatiA comprehensive subdomain enumeration and URL discovery tool that combines multiple reconnaissance utilities into one automated workflow - now with fast visual screenshot capabilities using Aquatone.📋 Table of ContentsFeaturesTools IncludedInstallationUsageOutput StructureLegal DisclaimerTroubleshooting✨ FeaturesAutomated subdomain discovery using multiple sourcesLive host detection with HTTPX📸 High-speed visual reconnaissance with Aquatone screenshotsDeep web crawling for URL and JavaScript discoveryArchive URL retrieval from Wayback Machine and multiple sourcesParameter-based URL discovery for deeper testingStep-by-step execution with real-time progressClean output structure organized by target domainColor-coded terminal output for better readabilitySmart confirmation for large-scale scans🛠 Tools IncludedToolPurposeSubfinderSubdomain enumeration using passive sourcesAssetfinderAdditional subdomain discoveryHTTPXFast HTTP probe for live host detectionAquatone📸 Visual reporting and Fly-over of web applicationsKatanaWeb crawling and JavaScript file discoveryWaybackurlsFetch URLs from Wayback MachineGAUGetAllUrls - fetch known URLs from multiple sourcesParamspiderDiscover URLs with parameters📦 InstallationPrerequisitesLinux/Unix system (Kali, Ubuntu, Debian, etc.)Internet connectionSudo privilegesChromium/Chrome browser (Required for Aquatone screenshots)Automated InstallationRun the installer script that will set up everything:Bash# Clone or download the repository
cd v-recon

# Make installer executable
chmod +x install_tools.sh

# Run the installer
./install_tools.sh
Installing AquatoneAquatone is a Go-based tool. You can install it by downloading the latest binary:Bash# 1. Download from GitHub (michenriksen/aquatone)
# 2. Extract the binary
# 3. Move it to your path:
sudo mv aquatone /usr/local/bin/
Verify InstallationCheck if all tools are accessible:Bashsubfinder -version
httpx -version
aquatone -version
katana -version
🚀 UsageBasic UsageBash# Make the script executable
chmod +x v-recon.sh

# Run the script
./v-recon.sh
You'll be prompted to enter a target domain:Enter domain: example.com
Smart ConfirmationWhen scanning targets with 50+ live hosts, V-RECON will ask for confirmation before running Aquatone to avoid resource heavy operations. You can choose to:✅ Continue with screenshots⏭️ Skip Aquatone and proceed with other tools📁 Output StructureAll results are saved in a directory named after your target:target-domain/
├── subdomains.txt          # Subfinder results
├── assetfinder.txt         # Assetfinder results
├── all_subdomains.txt      # Combined unique subdomains
├── live_hosts.txt          # Active/live hosts
├── aquatone_out/           # 📸 Visual recon folder (Aquatone)
│   ├── aquatone_report.html # Interactive HTML report with clusters
│   ├── screenshots/        # Full-size PNG screenshots
│   ├── headers/            # HTTP response headers
│   └── html/               # Raw page source files
├── katana_urls.txt         # URLs discovered by Katana
├── js_files.txt            # JavaScript files found
├── final_urls.txt          # Merged unique URLs
📸 Aquatone Report FeaturesThe Aquatone report provides a much faster and organized overview than traditional tools:🏎️ Speed: Extremely fast screenshot capture using Chromium's headless mode.🧩 Clustering: Automatically groups similar-looking pages together.🔍 Detail: View HTTP headers and HTML source for every host.🖥️ UI: Modern, responsive HTML report.How to view:Bash# Navigate to your results folder
cd target-domain/aquatone_out/

# Open the report
firefox aquatone_report.html
⚠️ Legal DisclaimerIMPORTANT: This tool is designed for authorized testing only. The author is not responsible for misuse or any damage caused by this tool. Always stay within the scope of your target's policy.🔧 TroubleshootingAquatone IssuesError: "aquatone: command not found"Ensure the binary is in your /usr/local/bin or $HOME/go/bin.Screenshots are blank/failed:Ensure Google Chrome or Chromium is installed.Check if the target is blocking headless browsers.Increase threads if you have a powerful machine: aquatone -threads 20.🆕 What's New in v1.1✨ Major Changes:🚀 Aquatone Integration - Switched from EyeWitness to Aquatone for 5x faster visual recon.📂 Better Organization - Cleaned up the output directory structure.🛠 Go-Native Workflow - Reduced Python dependency issues.👤 AuthorVinayak Prajapati Cybersecurity Enthusiast | Bug Bounty Hunter
