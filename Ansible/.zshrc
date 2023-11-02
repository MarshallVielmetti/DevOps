# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="amuse"

plugins=(git virtualenvwrapper fzf)

source $ZSH/oh-my-zsh.sh

alias denied="cd ~/denied_ws/src/denied"

readonly DENIED_WORKSPACE_PATH=~/denied_ws

source /opt/ros/humble/setup.zsh

# readonly CATKIN_SETUP_PATH=${DENIED_WORKSPACE_PATH}/devel/setup.zsh
# if [ -f ${CATKIN_SETUP_PATH} ]; then
#     source ${CATKIN_SETUP_PATH}
# fi
