#Script to build VMware box
#Compress current ovf files
echo "Compressing current OVF file..."
zip -r OVF/Ubuntu-1404lts-golden-OVF-$(date +"%m-%d-%y:%H:%M").zip OVF/ -x /OVF/*.zip
#Remove any existing files that will prevent packer from completing
find OVF/* -type f -not -name '*zip' | xargs rm
#Create variable to use as consistent name across packer run and post-processing actions.
echo "Setting Environment Variables..."
export packervmname="ubuntu-1404lts-golden-$(date +"%y-%m-%d-%H%M")"
#Run Packer
echo "Running Packer..."
packer build -force templates/ubuntu-1404-vmware.json
#Convert outputed vmx file into Carrenza compatible OVF file
echo "Converting Packer output to Carrenza compatible OVF file..."
ovftool output-vmware-iso/$packervmname.vmx OVF/$packervmname.ovf
#Upload to Carrenza - PLEASE NOTE - org and vdc details will need updated once on new official platform.
echo "Uploading to Carrenza..."
ovftool "OVF/$packervmname.ovf" "vcloud://:@myvdc.carrenza.net:443?org=hy0z&vdc=IER-VDC01&catalog=Packer&vappTemplate=$packervmname"
echo "Tidying up Environment Variables..."
unset packervmname
echo "Finished"