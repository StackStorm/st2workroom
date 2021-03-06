#!/usr/bin/env bash
# This stand-alone script should be able to be used to kickstart a new node

PROJECT_ROOT=/opt/puppet
export DEBIAN_FRONTEND=noninteractive

# Install Pre-req for git
if [ -f /usr/bin/apt-get ]; then
  apt-get install -y git
fi

if [ -f /usr/bin/yum ]; then
  yum install -y git-core
fi

if [ ! -f ${PROJECT_ROOT}/.git ]; then
  # Backup the directory in the event that masterless setup goes south
  if [ -d ${PROJECT_ROOT} ]; then
    mv ${PROJECT_ROOT} ${PROJECT_ROOT}.old
  fi
  git clone https://github.com/StackStorm/st2workroom ${PROJECT_ROOT}
fi

# Create Facter sink
if [ ! -d /etc/facter/facts.d ]; then
  echo "Setting up facter.d..."
  mkdir -p /etc/facter/facts.d
fi
