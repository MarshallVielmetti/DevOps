#!/bin/bash


# See: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

readonly RED_BOLD='\033[1;31m'
readonly BLUE_BOLD='\033[1;34m'
readonly GREY_BOLD='\033[1;30m'
readonly YELLOW_BOLD='\033[1;33m'
readonly NC='\033[0m'

curl -s https://install.zerotier.com | sudo bash

echo -e "${BLUE_BOLD}Enter zerotier network ID${NC}"

read networkID

sudo zerotier-cli join ${networkID}




