# packer-vmware-vagrant-trusty

The purpose of this repo is use Packer to build both Vagrant and VMware images of a base ubuntu 14-04.3 setup.

If you have the iso locally you can place it in the ISO folder to skip the download.

###Vagrant

####Prereqs
* Latest version (5.0.10) of VirtualBox installed

####To Run
The buildVagrant.sh script will clean up any artifacts from previous runs, zipping and versioning the .box file and start from scratch.

A Vagrant user will be added to the image with sudo access. The Vagrant user uses the standard insecure keys for authentication, these can be found [here](https://github.com/mitchellh/vagrant/tree/master/keys). On first "Vagrant Up" this key will be replaced with a secure key.

###VMware

####Prereqs
* VMWare Fusion installed
* VMWare ovftool installed

####To Run
The buildVMware.sh script will clean up any artifacts from previous runs, zipping and versioning the .ovf and .vmdk files and start from scratch.

A Deploy user will be added to the image with sudo access. The Deploy user is configured for for authentication via public/private key. I can share the priv key with the team offline.

####TO DO
* Remove basic password for Deploy User.
* Consider VMware tools installation over open-vm-tools. (This was installed due to difficulty in automating VMware-Tools installation)
* Consider ways to automate upload of OVF to Carrenza