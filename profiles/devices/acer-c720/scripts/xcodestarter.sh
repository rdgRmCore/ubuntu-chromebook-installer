# This script customizes the Acer C720 with Codestarter-specific programs and
# settings. The 'x' that prefixes the script name ensures that this is the last
# device script to be run.

# Create a temp directory for our work
tempbuild=`mktemp -d`

echo "Installing Chrome"
cd $tempbuild
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
export DEBIAN_FRONTEND=noninteractive; apt-get -f -y -q install
touch "chrome.done"

echo "Installing Vim"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install vim
touch "vim.done"

echo "Installing gvim"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install vim-gnome
touch "gvim.done"

echo "Installing 32 bit support"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive;dpkg --add-architecture i386
export DEBIAN_FRONTEND=noninteractive;apt-get update
export DEBIAN_FRONTEND=noninteractive;apt-get -y -q install libc6:i386 libncurses5:i386 libstdc++6:i386
touch "32bit.done"

echo "Installing ruby-install"
cd $tempbuild
wget -O ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz
tar -xzf ruby-install-0.4.3.tar.gz
cd ruby-install-0.4.3/
make install
cd $tempbuild
touch "ruby-install.done"

echo "Installing ruby"
cd $tempbuild
ruby-install ruby 2.1.2
touch "ruby.done"

echo "Installing chruby"
cd $tempbuild
wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz
tar -xzf chruby-0.3.8.tar.gz
cd chruby-0.3.8/
make install
echo "" >> /etc/skel/.bashrc
echo "source '/usr/local/share/chruby/chruby.sh'" >> /etc/skel/.bashrc
echo "source '/usr/local/share/chruby/auto.sh'" >> /etc/skel/.bashrc
echo "chruby ruby-2.1.2" >> /etc/skel/.bashrc
cd $tempbuild
touch "chruby.done"

echo "Installing node.js & npm"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install nodejs npm
touch "nodejs.done"

echo "Installing Java"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install default-jdk
touch "java.done"

echo "Installing Git"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install git
touch "git.done"

# Cleanup
rm -fr /tmp/tmp.*
