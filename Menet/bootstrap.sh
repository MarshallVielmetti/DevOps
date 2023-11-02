#!/bin/bash

# Run on a fresh Ubuntu 22 install.
# Installs Ansible and Git, then clones GPS Denied Repo
# Ansible will be used to finish configuring the system

# See: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

readonly RED_BOLD='\033[1;31m'
readonly BLUE_BOLD='\033[1;34m'
readonly GREY_BOLD='\033[1;30m'
readonly YELLOW_BOLD='\033[1;33m'
readonly NC='\033[0m'

echo -e "${BLUE_BOLD}Ensuring SSH keys are set up ...${NC}"
if [ ! -f ~/.ssh/id_ed25519 ] && [ ! -f ~/.ssh/id_rsa ]; then
    echo -e "${RED_BOLD}SSH Keys Not Setup${NC}"
    while true; do
        read -p "Do you want to generate an ssh key? y/n: " yn
        case $yn in
        [Yy]*)
            break
            ;;
        [Nn]*)
            echo -e "${NC}Please see: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent${NC}"
            exit 1
            ;;
        *) echo "Please answer yes or no." ;;
        esac
    done

    echo -e "${YELLOW_BOLD}Generating new SSH key...${NC}"
    read -p "Enter your email: your_email@example.com " email
    ssh-keygen -t ed25519 -C ${email}
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo -e "${NC}This is your SSH Key:${NC}"
    cat ~/.ssh/id_ed25519.pub
    echo -e "${YELLOW_BOLD} Follow these instructions:"
    echo -e "${NC}https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account${NC}"
    echo -e "${YELLOW_BOLD} To add the SSH key to your github account.${NC}"
fi

echo -e "${BLUE_BOLD}Updating and installing apt packages${NC}"
sudo apt update
sudo apt install -y ansible git git-lfs

readonly DEFAULT_WS=~/denied_ws

echo -e "${GREY_BOLD}Using ${DEFAULT_WS} as ROS workspace${NC}"

readonly DEV_PATH=${DEFAULT_WS}/src/denied
FIRST_TIME_SETUP=false

if [ ! -d ${DEFAULT_WS} ]; then
    echo -e "${GREY_BOLD}Creating ROS workspace ...${NC}"
    mkdir -p ${DEFAULT_WS}/src
    git clone git@github.com:MarshallVielmetti/denied_ir_tracking.git ${DEFAULT_WS}/src/denied
    FIRST_TIME_SETUP=true
fi

echo -e "${GREY_BOLD}Using Ansible to finish up ...${NC}"
${DEV_PATH}/ansible.sh dev.yml

if [ "${FIRST_TIME_SETUP}" ]; then
    echo -e "${BLUE_BOLD}All done!{NC}"
    echo -e "${YELLOW_BOLD}Please log out and back in!${NC}"
fi
