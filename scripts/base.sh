#Set DNS
cat >/etc/resolv.conf <<EOM
# This file was built as part of the image provisioner.
nameserver 8.8.8.8
nameserver 8.8.4.4
search localdomain
EOM

#Install required packages
apt-get update
apt-get -y upgrade
apt-get -y install linux-headers-$(uname -r)
apt-get -y install wget curl make gcc

#Allow un-password prompted sudo
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers
sed -i -e 's/%sudo  ALL=(ALL:ALL) ALL/%sudo  ALL=NOPASSWD:ALL/g' /etc/sudoers