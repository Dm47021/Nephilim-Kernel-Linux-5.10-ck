#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
#

export CC=/home/Linux/Workspace/CLANG-BUILT/bin/clang
export HOSTCC=/home/Linux/Workspace/CLANG-BUILT/bin/clang

# Colorize and add text parameters
red=$(tput setaf 1) # red
grn=$(tput setaf 2) # green
cya=$(tput setaf 6) # cyan
txtbld=$(tput bold) # Bold
bldred=${txtbld}$(tput setaf 1) # red
bldgrn=${txtbld}$(tput setaf 2) # green
bldblu=${txtbld}$(tput setaf 4) # blue
bldcya=${txtbld}$(tput setaf 6) # cyan
txtrst=$(tput sgr0) # Reset


echo""
echo "${bldred} 
     Cleaning Build Directory 
${txtrst}"

make mrproper

make ARCH=x86_64 defconfig

echo""
echo "${bldblu} 
      Building NEPHILIM TECHNOLOGY Debian packages
${txtrst}" 

nice make -j`nproc` bindeb-pkg

# Wait for user input
echo""
read -p "Press [Enter] to exit this script..."
