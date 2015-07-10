#!/bin/sh

date > /etc/vagrant_box_build_time

mkdir /home/vagrant/.ssh
wget --no-check-certificate \
    'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub' \
    -O /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh

echo "%wheel        ALL=(ALL) NOPASSWD: SETENV: ALL" >> /etc/sudoers
echo "vagrant       ALL=(ALL) NOPASSWD: SETENV: ALL" >> /etc/sudoers
