#!/usr/bin/env bash
# adapted from https://stackoverflow.com/a/28938235


set -eou pipefail

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Color_Black='\033[0;30m'        # Black
Color_Red='\033[0;31m'          # Red
Color_Green='\033[0;32m'        # Green
Color_Yellow='\033[0;33m'       # Yellow
Color_Blue='\033[0;34m'         # Blue
Color_Purple='\033[0;35m'       # Purple
Color_Cyan='\033[0;36m'         # Cyan
Color_White='\033[0;37m'        # White

# Bold
Color_BBlack='\033[1;30m'       # Black
Color_BRed='\033[1;31m'         # Red
Color_BGreen='\033[1;32m'       # Green
Color_BYellow='\033[1;33m'      # Yellow
Color_BBlue='\033[1;34m'        # Blue
Color_BPurple='\033[1;35m'      # Purple
Color_BCyan='\033[1;36m'        # Cyan
Color_BWhite='\033[1;37m'       # White

# Underline
Color_UBlack='\033[4;30m'       # Black
Color_URed='\033[4;31m'         # Red
Color_UGreen='\033[4;32m'       # Green
Color_UYellow='\033[4;33m'      # Yellow
Color_UBlue='\033[4;34m'        # Blue
Color_UPurple='\033[4;35m'      # Purple
Color_UCyan='\033[4;36m'        # Cyan
Color_UWhite='\033[4;37m'       # White

# Background
Color_On_Black='\033[40m'       # Black
Color_On_Red='\033[41m'         # Red
Color_On_Green='\033[42m'       # Green
Color_On_Yellow='\033[43m'      # Yellow
Color_On_Blue='\033[44m'        # Blue
Color_On_Purple='\033[45m'      # Purple
Color_On_Cyan='\033[46m'        # Cyan
Color_On_White='\033[47m'       # White

# High Intensity
Color_IBlack='\033[0;90m'       # Black
Color_IRed='\033[0;91m'         # Red
Color_IGreen='\033[0;92m'       # Green
Color_IYellow='\033[0;93m'      # Yellow
Color_IBlue='\033[0;94m'        # Blue
Color_IPurple='\033[0;95m'      # Purple
Color_ICyan='\033[0;96m'        # Cyan
Color_IWhite='\033[0;97m'       # White

# Bold High Intensity
Color_BIBlack='\033[1;90m'      # Black
Color_BIRed='\033[1;91m'        # Red
Color_BIGreen='\033[1;92m'      # Green
Color_BIYellow='\033[1;93m'     # Yellow
Color_BIBlue='\033[1;94m'       # Blue
Color_BIPurple='\033[1;95m'     # Purple
Color_BICyan='\033[1;96m'       # Cyan
Color_BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
Color_On_IBlack='\033[0;100m'   # Black
Color_On_IRed='\033[0;101m'     # Red
Color_On_IGreen='\033[0;102m'   # Green
Color_On_IYellow='\033[0;103m'  # Yellow
Color_On_IBlue='\033[0;104m'    # Blue
Color_On_IPurple='\033[0;105m'  # Purple
Color_On_ICyan='\033[0;106m'    # Cyan
Color_On_IWhite='\033[0;107m'   # White
