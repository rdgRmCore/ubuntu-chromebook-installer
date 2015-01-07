# Upgrade to 3.17.6 kernel which contains the Chromebook drivers.

tempbuild=`mktemp -d`
cd $tempbuild

wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.17.6-vivid/linux-headers-3.17.6-031706_3.17.6-031706.201412071535_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.17.6-vivid/linux-headers-3.17.6-031706-generic_3.17.6-031706.201412071535_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.17.6-vivid/linux-image-3.17.6-031706-generic_3.17.6-031706.201412071535_amd64.deb

sudo dpkg -i *.deb
