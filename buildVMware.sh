echo "Compressing current OVF file..."
zip -r OVF/Ubuntu-1404lts-golden-OVF-$(date +"%m-%d-%y:%H:%M").zip OVF/ -x /OVF/*.zip
find OVF/* -type f -not -name '*zip' | xargs rm
echo "Setting Environment Variables..."
export packervmname="ubuntu-1404lts-golden-$(date +"%m-%d-%y-%H%M")"
echo "Running Packer..."
packer build -force templates/ubuntu-1404-vmware.json
echo "Converting Packer output to Carrenza compatible OVF file..."
ovftool output-vmware-iso/$packervmname.vmx OVF/$packervmname.ovf
echo "Uploading to Carrenza..."
ovftool "OVF/$packervmname.ovf" "vcloud://:@myvdc.carrenza.net:443?org=hy0z&vdc=IER-VDC01&catalog=Packer&vappTemplate=$packervmname"
echo "Tidying up Environment Variables..."
unset packervmname
echo "Finished"