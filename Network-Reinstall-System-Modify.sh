#!/bin/bash

CXTaddLine="$1"
CXTaddVER=""
CXTisUEFI=""
CXTmyipapi=""
CXTisCN="No"

if [[ $EUID -ne 0 ]]; then
  clear
  echo "Error: This Reinstall script must be run as root!" 1>&2
  exit 1
fi

echo -e "\n\n\n"
clear
echo -e "\n"
echo -e "-----------------------------------------------------------------------------------------------"
echo -e "               \033[33m Network-Reinstall-System-Modify Tools V5.3.0\033[0m                    "
echo -e "-----------------------------------------------------------------------------------------------"
echo -e "\n"
echo -e "\033[33m Reinstall the system (any Windows / Linux) requires only network and one click \033[0m"
echo -e "\033[33m System requirements: Any Linux system with GRUB or GRUB2,recommended Rocky8/Debian11/Ubuntu22 \033[0m"
echo -e "\n"
echo "-----------------------------------------------------------------------------------------------"
echo " Default password: zoxxenon"
echo "-----------------------------------------------------------------------------------------------"
echo -e "\n"
sleep  5s

echo "-----------------------------------------------------------------------------------------------"
echo " Pre-environment preparation. . ."
echo "-----------------------------------------------------------------------------------------------"
echo -e "\n"
sleep 2s

if [ -f "/usr/bin/apt-get" ]; then
  isDebian=$(cat /etc/issue | grep Debian)
  if [ "$isDebian" != "" ]; then
    echo 'Current system is Debian'
    apt-get install -y xz-utils openssl gawk file wget curl >>/dev/null
    apt install -y xz-utils openssl gawk file wget curl >>/dev/null
    sleep 3s
  else
    echo 'Current system is Ubuntu'
    apt-get install -y xz-utils openssl gawk file wget curl >>/dev/null
    apt install -y xz-utils openssl gawk file wget curl >>/dev/null
    sleep 3s
  fi
else
  echo 'Current system is CentOS/Rocky/Oracle/RHEL'
  yum install -y xz openssl gawk file wget curl >>/dev/null
  dnf install -y xz openssl gawk file wget curl >>/dev/null
  sleep 3s
fi

echo "-----------------------------------------------------------------------------------------------"
echo " Pre-environment preparation. . .  【OK】"
echo -e "\n"
echo " Detection system information. . . "
echo "-----------------------------------------------------------------------------------------------"
echo -e "\n"
sleep 1s
clear

CXTDTYPE=$(fdisk -l | grep -o gpt | head -1)
if [ ! -z "$CXTDTYPE" ] && { [ "$CXTDTYPE" == "gpt" ] || [ "$CXTDTYPE" == "GPT" ]; }; then
  echo "UEFI..."
  CXTisUEFI="(True)"
else
  echo "Legacy..."
  CXTisUEFI="(False)"
fi

case $(uname -m) in aarch64 | arm64) CXTaddVER="arm64" ;; x86 | i386 | i686) CXTaddVER="i386" ;; x86_64 | amd64) CXTaddVER="amd64" ;; *) CXTaddVER="" ;; esac

CXTmyipapi=$(wget --no-check-certificate -qO- https://api.myip.com | grep "\"country\":\"China\"")
if [[ "$CXTmyipapi" != "" ]]; then
  CXTisCN="Yes"
fi

if [ $CXTisCN != "Yes" ]; then
  echo "Core Download[Global]..."
  #wget -O
  wget --no-check-certificate -qO ~/Core_Install.sh 'https://raw.githubusercontent.com/crixsz/Reinstall-VPS/test/CoreShell/Core_Install_v5.3.sh' && chmod a+x ~/Core_Install.sh
  CentOSMirrors=""
  CentOSVaultMirrors=""
  DebianMirrors=""
  UbuntuMirrors=""
else
  echo "Core Download[CN]..."
  #wget -O
  wget --no-check-certificate -qO ~/Core_Install.sh 'https://raw.githubusercontent.com/crixsz/Reinstall-VPS/test/CoreShell/Core_Install_v5.3.sh' && chmod a+x ~/Core_Install.sh
  CXTrandom=$RANDOM
  if [ $((CXTrandom % 2)) == "0" ]; then
    CentOSMirrors="--mirror http://mirrors.aliyun.com/centos/"
    CentOSVaultMirrors="--mirror http://mirrors.aliyun.com/centos-vault/"
    DebianMirrors="--mirror http://mirrors.aliyun.com/debian/"
    UbuntuMirrors="--mirror http://mirrors.aliyun.com/ubuntu/"
  else
    CentOSMirrors="--mirror http://mirrors.tuna.tsinghua.edu.cn/centos/"
    CentOSVaultMirrors="--mirror http://mirrors.tuna.tsinghua.edu.cn/centos-vault/"
    DebianMirrors="--mirror http://mirrors.tuna.tsinghua.edu.cn/debian/"
    UbuntuMirrors="--mirror http://mirrors.tuna.tsinghua.edu.cn/ubuntu/"
  fi

fi

echo "-----------------------------------------------------------------------------------------------"
echo " System information is as follows. . .  【OK】"
echo -e "\n"
echo "Your system firmware architecture is: $CXTaddVER"
echo -e "\n"
echo "Your device Startup type is UEFI: $CXTisUEFI"
echo -e "\n"
echo "Accelerating Chinese mainland with CDN: $CXTisCN"
echo -e "\n"
echo " Start system installation. . . "
echo "-----------------------------------------------------------------------------------------------"
echo -e "\n"
sleep 3s
clear
if [ $CXTaddVER == "arm64" ]; then
  echo -e "\n"
  clear
  echo -e "\n\n\n"
  clear
  echo -e "\n"
  echo "                                                           "
  echo "================================================================"
  echo "=                                                              ="
  echo "=                   ARM64                                      ="
  echo "=        Network-Reinstall-System-Modify (Graphical Install)   ="
  echo "=                                                              ="
  echo "=             V5.3.0                                           ="
  echo "=                                                              ="
  echo "================================================================"
  echo "                                                                "
  echo "(Which System want to Install): "
  echo "                                                                "
  echo "   1) AlmaLinux 9(ARM64)"
  echo "   2) CentOS 7(ARM64)【Recommend】"
  echo "   3) Debian 11(ARM64)【Recommend】"
  echo "   4) Debian 10(ARM64)"
  echo "   5) Fedora 36(ARM64)"
  echo "   6) Oracle 9(ARM64)"
  echo "   7) Rocky 9(ARM64)【Recommend】"
  echo "   8) Rocky 8(ARM64)"
  echo "   9) Ubuntu 22(ARM64)【Recommend】"
  echo "   10) Ubuntu 20(ARM64)"
  echo "   99) (More System)"
  echo "   100) Bare-metal System Deployment Platform(Advanced Users)"
  echo "   0) Exit"
  echo -ne "\n(Your option): "
  echo "                                                                "
  read N
  case $N in
  1)
    echo -e "\nInstall...AlmaLinux 9(ARM64)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v arm64 -dd "https://odc.cxthhhhh.com/d/SyStem/AlmaLinux/AlmaLinux_9_ARM64_UEFI_NetInstallation_Stable_1.6.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  2)
    echo -e "\nInstall...CentOS 7(ARM64)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v arm64 -dd "https://odc.cxthhhhh.com/d/SyStem/CentOS/CentOS_7.X_ARM64_UEFI_NetInstallation_Final_v9.11.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  3)
    echo -e "\nInstall...Debian 11(ARM64)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -d 11 -a -v arm64 $DebianMirrors $CXTaddLine
    ;;
  4)
    echo -e "\nInstall...Debian 10(ARM64)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -d 10 -a -v arm64 $DebianMirrors $CXTaddLine
    ;;
  5)
    echo -e "\nInstall...Fedora 36(ARM64)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v arm64 -dd "https://odc.cxthhhhh.com/d/SyStem/Fedora/Fedora_36.X_ARM64_UEFI_NetInatallation_Stable_v1.6.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  6)
    echo -e "\nInstall...Oracle 9(ARM64)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v arm64 -dd "https://odc.cxthhhhh.com/d/SyStem/Oracle/Oracle_9.X_ARM64_UEFI_NetInstallation_Stable_v1.7.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  7)
    echo -e "\nInstall...Rocky 9(ARM64)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v arm64 -dd "https://odc.cxthhhhh.com/d/SyStem/Oracle/Oracle_9.X_ARM64_UEFI_NetInstallation_Stable_v1.7.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  8)
    echo -e "\nInstall...Rocky 8(ARM64)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v arm64 -dd "https://odc.cxthhhhh.com/d/SyStem/Rocky/Rocky_8.X_ARM64_UEFI_NetInstallation_Stable_v6.11.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  9)
    echo -e "\nInstall...Ubuntu 22(ARM64)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -u 22.04 -a -v arm64 $UbuntuMirrors $CXTaddLine
    ;;
  10)
    echo -e "\nInstall...Ubuntu 20(ARM64)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -u 20.04 -a -v arm64 $UbuntuMirrors $CXTaddLine
    ;;
  99)
    echo "更多系统前往CXT博客及ODC查看。https://www.cxthhhhh.com"
    exit 1
    ;;
  100)
    echo -e "\nInstall...Bare-metal System Deployment Platform(Advanced Users)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v arm64 -dd "https://odc.cxthhhhh.com/d/SyStem/Bare-metal_System_Deployment_Platform/CXT_Bare-metal_System_Deployment_Platform_v3.6.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  0) exit 0 ;;
  *)
    echo "Wrong input!"
    exit 1
    ;;
  esac
elif [ [$CXTisUEFI == "是(True)"] && [ $CXTaddVER != "arm64" ] ]; then
  echo -e "\n"
  clear
  echo -e "\n\n\n"
  clear
  echo -e "\n"
  echo "                                                           "
  echo "================================================================"
  echo "=                                                              ="
  echo "=            [UEFI]                                            ="
  echo "=        Network-Reinstall-System-Modify (Graphical Install)   ="
  echo "=                                                              ="
  echo "=             V5.3.0                                           ="
  echo "=                                                              ="
  echo "================================================================"
  echo "                                                                "
  echo "(Which System want to Install): "
  echo "                                                                "
  echo "   1) CentOS 8(UEFI)"
  echo "   2) Debian 11(UEFI)【Recommend】"
  echo "   3) Debian 10(UEFI)"
  echo "   4) OpenWRT (UEFI)"
  echo "   5) Oracle 9(UEFI)"
  echo "   6) Rocky 9(UEFI)"
  echo "   7) Rocky 8(UEFI)【Recommend】"
  echo "   8) Ubuntu 22(UEFI)【Recommend】"
  echo "   9) Ubuntu 20(UEFI)"
  echo "   21) Windows Server 2022(UEFI)【Recommend】"
  echo "   22) Windows Server 2019(UEFI)"
  echo "   23) Windows Server 2012 R2(UEFI)"
  echo "   99) (More System)"
  echo "   100) Bare-metal System Deployment Platform(Advanced Users)"
  echo "   0) Exit"
  echo -ne "\(Your option): "
  echo "                                                                "
  read N
  case $N in
  1)
    echo -e "\nInstall...CentOS 8(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -firmware -dd "https://odc.cxthhhhh.com/d/SyStem/Rocky/Rocky_8.X_x64_UEFI_NetInstallation_Stable_v6.9.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  2)
    echo -e "\nInstall...Debian 11(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -d 11 -a -v 64 -firmware $DebianMirrors $CXTaddLine
    ;;
  3)
    echo -e "\nInstall...Debian 10(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -d 10 -a -v 64 -firmware $DebianMirrors $CXTaddLine
    ;;
  4)
    echo -e "\nInstall...OpenWRT (UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -firmware -dd "https://odc.cxthhhhh.com/d/SyStem/OpenWRT-Virtualization-Servers/Stable/openwrt-x86-64-generic-squashfs-combined-efi.img.gz" $DebianMirrors $CXTaddLine
    ;;
  5)
    echo -e "\nInstall...Oracle 9(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -firmware -dd "https://odc.cxthhhhh.com/d/SyStem/Oracle/Oracle_9.X_x64_UEFI_NetInstallation_Stable_v1.9.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  6)
    echo -e "\nInstall...Rocky 9(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -firmware -dd "https://odc.cxthhhhh.com/d/SyStem/Rocky/Rocky_8.X_x64_UEFI_NetInstallation_Stable_v6.9.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  7)
    echo -e "\nInstall...Rocky 8(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -firmware -dd "https://odc.cxthhhhh.com/d/SyStem/Rocky/Rocky_8.X_x64_UEFI_NetInstallation_Stable_v6.9.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  8)
    echo -e "\nInstall...Ubuntu 22(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -u 22.04 -a -v 64 -firmware $UbuntuMirrors $CXTaddLine
    ;;
  9)
    echo -e "\nInstall...Ubuntu 20(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -u 20.04 -a -v 64 -firmware $UbuntuMirrors $CXTaddLine
    ;;
  21)
    echo -e "\nInstall...Windows Server 2022(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -firmware -dd "https://odc.cxthhhhh.com/d/SyStem/Windows_DD_Disks/Disk_Windows_Server_2022_DataCenter_CN_v2.12_UEFI.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  22)
    echo -e "\nInstall...Windows Server 2019(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -firmware -dd "https://odc.cxthhhhh.com/d/SyStem/Windows_DD_Disks/Disk_Windows_Server_2019_DataCenter_CN_v5.1_UEFI.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  23)
    echo -e "\nInstall...Windows Server 2012 R2(UEFI)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -firmware -dd "https://odc.cxthhhhh.com/d/SyStem/Windows_DD_Disks/Disk_Windows_Server_2012R2_DataCenter_CN_v4.29_UEFI.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  99)
    echo "更多系统前往CXT博客及ODC查看。https://www.cxthhhhh.com"
    exit 1
    ;;
  100)
    echo -e "\nInstall...Bare-metal System Deployment Platform(Advanced Users)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -firmware -dd "https://odc.cxthhhhh.com/d/SyStem/Bare-metal_System_Deployment_Platform/CXT_Bare-metal_System_Deployment_Platform_v3.6.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  0) exit 0 ;;
  *)
    echo "Wrong input!"
    exit 1
    ;;
  esac
else
  echo -e "\n"
  clear
  echo -e "\n\n\n"
  clear
  echo -e "\n"
  echo "                                                           "
  echo "================================================================"
  echo "=                                                              ="
  echo "=                     [BIOS_LEGACY]                            ="
  echo "=        Network-Reinstall-System-Modify (Graphical Install)   ="
  echo "=                                                              ="
  echo "=             V5.3.0                                           ="
  echo "=                                                              ="
  echo "================================================================"
  echo "                                                                "
  echo "(Which System want to Install): "
  echo "                                                                "
  echo "   1) CentOS 9"
  echo "   2) CentOS 8"
  echo "   3) Debian 7【Recommend】"
  echo "   4) Debian 11【Recommend】"
  echo "   5) Debian 10"
  echo "   6) OpenWRT"
  echo "   7) Oracle 9"
  echo "   8) Rocky 9"
  echo "   9) Rocky 8【Recommend】"
  echo "   10) Ubuntu 22【Recommend】"
  echo "   11) Ubuntu 20"
  echo "   21) Windows Server 2022【Recommend】"
  echo "   22) Windows Server 2019"
  echo "   23) Windows Server 2016"
  echo "   24) Windows Server 2012 R2"
  echo "   99) (More System)"
  echo "   100) Bare-metal System Deployment Platform(Advanced Users)"
  echo "   0) Exit"
  echo -ne "\n(Your option): "
  echo "                                                                "
  read N
  case $N in
  1)
    echo -e "\nInstall...CentOS 9\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/CentOS/CentOS_9.X_x64_Legacy_NetInstallation_Stable_v1.6.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  2)
    echo -e "\nInstall...CentOS 8\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/CentOS/CentOS_8.X_x64_Legacy_NetInstallation_Stable_v6.8.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  3)
    echo -e "\nInstall...CentOS 7\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/CentOS/CentOS_7.X_x64_Legacy_NetInstallation_Final_v9.8.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  4)
    echo -e "\nInstall...Debian 11\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -d 11 -a -v 64 $DebianMirrors $CXTaddLine
    ;;
  5)
    echo -e "\nInstall...Debian 10\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -d 10 -a -v 64 $DebianMirrors $CXTaddLine
    ;;
  6)
    echo -e "\nInstall...OpenWRT\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/OpenWRT-Virtualization-Servers/Stable/openwrt-x86-64-generic-squashfs-combined.img.gz" $DebianMirrors $CXTaddLine
    ;;
  7)
    echo -e "\nInstall...Oracle 9\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/Oracle/Oracle_9.X_x64_Legacy_NetInstallation_Stable_v1.8.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  8)
    echo -e "\nInstall...Rocky 9\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/Rocky/Rocky_8.X_x64_Legacy_NetInstallation_Stable_v6.8.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  9)
    echo -e "\nInstall...Rocky 8\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/Rocky/Rocky_8.X_x64_Legacy_NetInstallation_Stable_v6.8.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  10)
    echo -e "\nInstall...Ubuntu 22\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -u 22.04 -a -v 64 $UbuntuMirrors $CXTaddLine
    ;;
  11)
    echo -e "\nInstall...Ubuntu 20\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -u 20.04 -a -v 64 $UbuntuMirrors $CXTaddLine
    ;;
  21)
    echo -e "\nInstall...Windows Server 2022\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/Windows_DD_Disks/Disk_Windows_Server_2022_DataCenter_CN_v2.12.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  22)
    echo -e "\nInstall...Windows Server 2019\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/Windows_DD_Disks/Disk_Windows_Server_2019_DataCenter_CN_v5.1.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  23)
    echo -e "\nInstall...Windows Server 2016\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/Windows_DD_Disks/Disk_Windows_Server_2016_DataCenter_CN_v4.12.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  24)
    echo -e "\nInstall...Windows Server 2012 R2\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/Windows_DD_Disks/Disk_Windows_Server_2012R2_DataCenter_CN_v4.29.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  99)
    echo "更多系统前往CXT博客及ODC查看。https://www.cxthhhhh.com"
    exit 1
    ;;
  100)
    echo -e "\nInstall...Bare-metal System Deployment Platform(Advanced Users)\n"
    read -s -n1 -p "(Press any key to continue...)"
    bash ~/Core_Install.sh -a -v 64 -dd "https://odc.cxthhhhh.com/d/SyStem/Bare-metal_System_Deployment_Platform/CXT_Bare-metal_System_Deployment_Platform_v3.6.vhd.gz" $DebianMirrors $CXTaddLine
    ;;
  0) exit 0 ;;
  *)
    echo "Wrong input!"
    exit 1
    ;;
  esac
fi

echo "-----------------------------------------------------------------------------------------------"
echo -e "\033[32m Start Installation \033[0m"
echo "-----------------------------------------------------------------------------------------------"
echo -e "\n"
