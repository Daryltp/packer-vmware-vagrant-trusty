echo "Destroying any available Vagrant Image..."
vagrant destroy -f
echo "Compressing current Vagrant Box"
zip BOX/ubuntu-1404lts-vagrant-BOX-$(date +"%m-%d-%y:%H:%M").zip BOX/ubuntu-1404lts-vagrant.box
echo "Removing current Vagrant Image..."
vagrant box remove golden -f
echo "Running Packer..."
packer build -force templates/ubuntu-1404-vagrant.json
echo "Finished"