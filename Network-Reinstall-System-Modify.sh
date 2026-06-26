#!/bin/bash

addLine="$1"

# ─── Color Theme ───────────────────────────────────────────────────
C_RESET='\033[0m'
C_BOLD='\033[1m'
C_DIM='\033[2m'
C_ITALIC='\033[3m'

C_RED='\033[31m'
C_GREEN='\033[32m'
C_YELLOW='\033[33m'
C_BLUE='\033[34m'
C_MAGENTA='\033[35m'
C_CYAN='\033[36m'
C_WHITE='\033[37m'
C_GRAY='\033[90m'

C_BG_DARK='\033[48;5;235m'
C_BG_HEADER='\033[48;5;236m'

# ─── Helper Functions ──────────────────────────────────────────────
print_header() {
  clear
  echo ""
  echo -e "${C_CYAN}${C_BOLD}    ╔══════════════════════════════════════════════════════════╗${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║                                                          ║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║${C_WHITE}${C_BOLD}      ███╗   ██╗███████╗██╗   ██╗██╗     ███████╗       ${C_CYAN}${C_BOLD}║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║${C_WHITE}${C_BOLD}      ████╗  ██║██╔════╝██║   ██║██║     ╚════██║       ${C_CYAN}${C_BOLD}║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║${C_WHITE}${C_BOLD}      ██╔██╗ ██║█████╗  ██║   ██║██║         ██╔╝       ${C_CYAN}${C_BOLD}║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║${C_WHITE}${C_BOLD}      ██║╚██╗██║██╔══╝  ██║   ██║██║         ██╔╝        ${C_CYAN}${C_BOLD}║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║${C_WHITE}${C_BOLD}      ██║ ╚████║███████╗╚██████╔╝███████╗    ██║         ${C_CYAN}${C_BOLD}║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║${C_WHITE}${C_BOLD}      ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚══════╝    ╚═╝         ${C_CYAN}${C_BOLD}║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║                                                          ║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║${C_GRAY}           Network Reinstall System · One Click           ${C_CYAN}${C_BOLD}║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║${C_DIM}                    BIOS / LEGACY MODE                   ${C_CYAN}${C_BOLD}║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ║                                                          ║${C_RESET}"
  echo -e "${C_CYAN}${C_BOLD}    ╚══════════════════════════════════════════════════════════╝${C_RESET}"
  echo ""
}

print_section() {
  echo -e "    ${C_CYAN}${C_BOLD}┌──────────────────────────────────────────────────────────┐${C_RESET}"
  echo -e "    ${C_CYAN}${C_BOLD}│${C_MAGENTA}${C_BOLD}  $1${C_CYAN}${C_BOLD}$(printf '%*s' $((47 - ${#1})) '')│${C_RESET}"
  echo -e "    ${C_CYAN}${C_BOLD}└──────────────────────────────────────────────────────────┘${C_RESET}"
}

print_option() {
  local num="$1"
  local label="$2"
  local extra="$3"
  if [ -n "$extra" ]; then
    echo -e "    ${C_WHITE}  ${C_GREEN}${C_BOLD}$num${C_RESET}  ${C_WHITE}$label  ${C_YELLOW}${C_DIM}$extra${C_RESET}"
  else
    echo -e "    ${C_WHITE}  ${C_GREEN}${C_BOLD}$num${C_RESET}  ${C_WHITE}$label${C_RESET}"
  fi
}

print_recommend() {
  local num="$1"
  local label="$2"
  echo -e "    ${C_WHITE}  ${C_GREEN}${C_BOLD}$num${C_RESET}  $label  ${C_GREEN}●${C_RESET} ${C_GREEN}${C_BOLD}Recommended${C_RESET}"
}

print_separator() {
  echo -e "    ${C_GRAY}────────────────────────────────────────────────────────────${C_RESET}"
}

# ─── Check Root ────────────────────────────────────────────────────
if [[ $EUID -ne 0 ]]; then
  echo -e "\n    ${C_RED}${C_BOLD}✖ Error:${C_RESET} ${C_RED}This Reinstall script must be run as root!${C_RESET}\n"
  exit 1
fi

# ─── Download Core ─────────────────────────────────────────────────
echo -ne "\n    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Downloading core installer...${C_RESET}"
wget --no-check-certificate -qO ~/Core_Install.sh 'https://raw.githubusercontent.com/Reinstall-VPS/Reinstall-VPS/main/CoreInstall.sh' && chmod a+x ~/Core_Install.sh
if [ $? -eq 0 ]; then
  echo -e "  ${C_GREEN}${C_BOLD}✓ Done${C_RESET}"
else
  echo -e "  ${C_RED}${C_BOLD}✖ Failed${C_RESET}"
  exit 1
fi

sleep 1

# ─── Mirror Variables ─────────────────────────────────────────────
CentOSMirrors=""
CentOSVaultMirrors=""
DebianMirrors=""
UbuntuMirrors=""

# ─── Display Menu ──────────────────────────────────────────────────
print_header

echo -e "    ${C_WHITE}${C_BOLD}  Select an operating system to install:${C_RESET}"
echo ""

print_section "🐧  Linux Distributions"
print_recommend  "3"  "Debian 7"
print_recommend  "4"  "Debian 11"
print_recommend  "5"  "Debian 12"
print_option     "6"  "Debian 10"
print_separator
print_recommend  "11" "Ubuntu 22.04"
print_option     "12" "Ubuntu 20.04"
print_separator
print_option     "1"  "CentOS 9"
print_option     "2"  "CentOS 8"
print_separator
print_recommend  "10" "Rocky 8"
print_option     "9"  "Rocky 9"
print_separator
print_option     "8"  "Oracle 9"
print_option     "7"  "OpenWRT"
echo ""

print_section "🪟  Windows Server"
print_recommend  "21" "Windows Server 2022"
print_option     "22" "Windows Server 2019"
print_option     "23" "Windows Server 2016"
print_option     "24" "Windows Server 2012 R2"
echo ""

print_section "⚙️   Advanced"
print_option     "100" "Bare-metal Deployment Platform"
echo ""

print_separator
echo -e "    ${C_WHITE}  ${C_RED}${C_BOLD}0${C_RESET}  ${C_RED}Exit${C_RESET}"
print_separator
echo ""

# ─── User Input ────────────────────────────────────────────────────
echo -ne "    ${C_CYAN}${C_BOLD}➤${C_RESET} ${C_WHITE}Enter your choice ${C_GRAY}[0-100]${C_RESET}: "
read N

echo ""

case $N in
  1)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing CentOS 9 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_CENTOS9_IMAGE_URL" $DebianMirrors $addLine
    ;;
  2)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing CentOS 8 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_CENTOS8_IMAGE_URL" $DebianMirrors $addLine
    ;;
  3)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Debian 7 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_CENTOS7_IMAGE_URL" $DebianMirrors $addLine
    ;;
  4)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Debian 11 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -d 11 -a -v 64 $DebianMirrors $addLine
    ;;
  5)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Debian 12 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -d 12 -a -v 64 $DebianMirrors $addLine
    ;;
  6)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Debian 10 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -d 10 -a -v 64 $DebianMirrors $addLine
    ;;
  7)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing OpenWRT installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_OPENWRT_IMAGE_URL" $DebianMirrors $addLine
    ;;
  8)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Oracle 9 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_ORACLE9_IMAGE_URL" $DebianMirrors $addLine
    ;;
  9)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Rocky 9 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_ROCKY9_IMAGE_URL" $DebianMirrors $addLine
    ;;
  10)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Rocky 8 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_ROCKY8_IMAGE_URL" $DebianMirrors $addLine
    ;;
  11)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Ubuntu 22.04 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -u 22.04 -a -v 64 $UbuntuMirrors $addLine
    ;;
  12)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Ubuntu 20.04 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -u 20.04 -a -v 64 $UbuntuMirrors $addLine
    ;;
  21)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Windows Server 2022 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_WIN2022_IMAGE_URL" $DebianMirrors $addLine
    ;;
  22)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Windows Server 2019 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_WIN2019_IMAGE_URL" $DebianMirrors $addLine
    ;;
  23)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Windows Server 2016 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_WIN2016_IMAGE_URL" $DebianMirrors $addLine
    ;;
  24)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Windows Server 2012 R2 installation...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_WIN2012R2_IMAGE_URL" $DebianMirrors $addLine
    ;;
  100)
    echo -e "    ${C_YELLOW}${C_BOLD}⟳${C_RESET}  ${C_YELLOW}Preparing Bare-metal Deployment Platform...${C_RESET}"
    read -s -n1 -p "    Press any key to continue..."
    bash ~/Core_Install.sh -a -v 64 -dd "REPLACE_WITH_BAREMETAL_IMAGE_URL" $DebianMirrors $addLine
    ;;
  0)
    echo -e "    ${C_GRAY}Exiting...${C_RESET}"
    echo ""
    exit 0
    ;;
  *)
    echo -e "    ${C_RED}${C_BOLD}✖ Error:${C_RESET} ${C_RED}Invalid option '$N'${C_RESET}"
    echo ""
    exit 1
    ;;
esac

echo ""
echo -e "    ${C_CYAN}${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
echo -e "    ${C_GREEN}${C_BOLD}  ▶ Installation Starting${C_RESET}"
echo -e "    ${C_CYAN}${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
echo ""
