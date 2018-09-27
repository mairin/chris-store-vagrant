# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export WORKON_HOME=~/Python_Envs
VIRTUALENVWRAPPER_PYTHON=/home/duffy/Python_Envs/chris_store_env/bin/python
source /home/duffy/.local/bin/virtualenvwrapper.sh

