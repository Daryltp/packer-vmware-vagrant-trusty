echo "Compressing current OVF file..."
zip -r OVF/Ubuntu-1404lts-golden-OVF-$(date +"%m-%d-%y:%H:%M").zip OVF/ -x /OVF/*.zip
find OVF/* -type f -not -name '*zip' | xargs rm
echo "Running Packer..."
packer build -force templates/ubuntu-1404-vmware.json
echo "Converting Packer output to Carrenza compatible OVF file..."
ovftool output-vmware-iso/ubuntu-1404lts-golden.vmx OVF/ubuntu-1404lts-golden.ovf
echo "Finished"