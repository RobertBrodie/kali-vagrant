#!/usr/bin/env bash
#
# Desc: Creates Python3 venv and invokes Vagrant
#

#set -x

get_progs () {
  progs=("python3" "vagrant")
  for prog in ${progs[@]}; do
    installed=$(command -v $prog)
    if [ -z "$installed" ]
    then
      echo -e "\n$prog not installed...Please install $prog"
      exit 1
    fi
  done
}

install_ansible () {
  if [ ! -d ".env" ]
  then
    echo -e "\nCreating virtual env .env folder...\n"
    sleep 2
    python3 -m venv .env
    source .env/bin/activate
    echo -e "\nUpgrading pip3...\n"
    sleep 2
    pip3 install --upgrade pip
    echo -e "\nInstalling Ansible...\n"
    sleep 2
    pip3 install ansible
  else
    echo -e "\nVirtual environment found...skipping\n"
  fi
}

start_vagrant () {
  config_file="Vagrantfile"
  vagrant validate $config_file
  if [ $? != 0 ]
  then
    echo "There is an issue with the config file..."
    exit 1
  fi
  vagrant up --no-provision
}



get_progs
install_ansible
start_vagrant
