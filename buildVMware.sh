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
ovftool "OVF/$packervmname.ovf" "vcloud://:@vcloud.carrenza.com:443?org=zk51&vdc=VDC-SLOUGH-DEV-MGMT&catalog=Packer&vappTemplate=$packervmname"
#Alert of updated template name
echo "*** PLEASE NOTE IF YOU WANT VCLOUD-TOOLS TO BUILD NEW VMS USING THIS NEW TEMPLATE YOU MUST UPDATE THE 'VAPP-TEMPLATE-NAME' ACHOR IN THE VCLOUD-TOOLS-CONFIGURATION TO $packervmname ***"
#Tidy Variables
echo "Tidying up Environment Variables..."
unset packervmname
echo "Finished"