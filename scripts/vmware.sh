mkdir ~deploy/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDlrYBEVXx3E+YOSnpbo9MKD2uYUl8G09OUo0Eb5G/3ZkgrtoChnSOL+6m/tAuUGan9y7OC18+DuJgsKOP52pwmslv8eDR9Wu3h0huGPpArYdbtSRQFZdGgjFRFBcEQfd5pV21GS6nnhzi5PIUJWyovHHSmzhLDyB5ecqGoIidZ7nLQLBSNc0nggY7xgVSdYyj6NvHq46ZaZyXbZNHlxju9Qore2ab3iP1gqY1Sr3yb2LZXZeOKIlCCzBMVw0UNSRMJQI+KDOUsc8m0fEYtSKpQx+zOtAweVUtpZTg3ju9QHZU7Ulxj8G89LhzenlEWuXGtZN5hLQ131r3nQdDBXWNMbE6K0kKD644j05AQVoZSn26tWC/mJvsGcnoLyKQj2tt0wuVulQnJZ3avYnrfve5QwUWznbJ/cRG3O33goKA3wdyw4LtLidqJ3RUB5jG5Ysh+bz8/the9H/HoXHgXueH7O/neb7s6UJk1/41ZRu0CsGS3uvrNA+H0O2G+RM6H6+csImJ7g/qV0UR0yuWXfaxVDwUkwz1oWTLVZQDMOYggCMvHVcRhyfidTSb/RJh/JkooaaYy/47kgpRb4v6FuCmYe67GMCAwCy5SPmKQaruTD0qz1Hp2LKcMuZdbyxjHuAGiFxKnT0FbNWznfHand+0smgJmh/1x1QRYI/MHyrXnlw== deploy" > /home/deploy/.ssh/authorized_keys
chown -R deploy ~deploy/.ssh
chmod -R go-rwsx ~deploy/.ssh

KEYPATH=/etc/vmware-pub-keys

mkdir -p $KEYPATH
wget -r --no-parent -A.pub http://packages.vmware.com/tools/keys/ -P $KEYPATH
mv $KEYPATH/packages.vmware.com/tools/keys/*.pub $KEYPATH
rm -rf $KEYPATH/packages.vmware.com/
FILES=$KEYPATH/*
for f in $FILES
do
	sudo apt-key add $f
done
echo 'deb http://packages.vmware.com/packages/ubuntu trusty main' > /etc/apt/sources.list.d/vmware-tools.list
apt-get update
apt-get install -y open-vm-tools open-vm-tools-deploypkg