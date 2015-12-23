#Script to build new vagrant box.
#Destroy any running vagrant images
echo "Destroying any available Vagrant Image..."
vagrant destroy -f
#Save off current version
echo "Compressing current Vagrant Box"
zip BOX/ubuntu-1404lts-vagrant-BOX-$(date +"%m-%d-%y:%H:%M").zip BOX/ubuntu-1404lts-vagrant.box
#Remove current box from vagrant so that new box will take its place.
echo "Removing current Vagrant Image..."
vagrant box remove golden -f
#Run packer with force parameter to overwrite any existing files
echo "Running Packer..."
packer build -force templates/ubuntu-1404-vagrant.json
echo "Finished"