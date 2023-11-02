#!/usr/bin/env bash

# Helper script to run Ansible playbooks

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <playbook>"
    exit 1
fi

sudo -v # Ensure Ansible has sudo permission

readonly DENIED_PATH=$(dirname "$0")
readonly WS_PATH=$(realpath "${DENIED_PATH}"/../..)
ansible-playbook -i "localhost," -c local "${DENIED_PATH}"/ansible/"$1" --extra-vars "catkin_workspace=${WS_PATH}"
