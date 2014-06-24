# Create a temp directory for our work
tempbuild=`mktemp -d`

echo "Installing Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb

echo "Installing Sublime Text 3"
cd $tempbuild
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3059_amd64.deb
dpkg -i sublime-text_build-3059_amd64.deb

echo "Installing Scratch"
cd $tempbuild
apt-get install scratch

echo "Installing ruby-install"
cd $tempbuild
wget -O ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz
tar -xzf ruby-install-0.4.3.tar.gz
cd ruby-install-0.4.3/
make install

echo "Installing ruby"
cd $tempbuild
ruby-install ruby 2.1.2

echo "Installing chruby"
cd $tempbuild
wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz
tar -xzf chruby-0.3.8.tar.gz
cd chruby-0.3.8/
make install
echo "" >> /etc/skel/.bashrc
echo "source '/usr/local/share/chruby/chruby.sh'" >> /etc/skel/.bashrc
echo "source '/usr/local/share/chruby/auto.sh'" >> /etc/skel/.bashrc
echo "chruby ruby-2.1.2"

echo "Installing node.js"
cd $tempbuild
apt-get install nodejs npm

echo "Installing Java"
cd $tempbuild
apt-get install default-jdk

echo "Installing Minecraft"
cd $tempbuild
add-apt-repository ppa:minecraft-installer-peeps/minecraft-installer
apt-get update
apt-get install minecraft-installer

echo "Tweak Launcher Favorites"
gsettings set com.canonical.Unity.Launcher favorites "['application://ubiquity.desktop', 'application://nautilus.desktop', 'application://google-chrome.desktop', 'application://sublime_text.desktop', 'application://minecraft.desktop', 'application://ubuntu-software-center.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"

# echo "Installing Python"
# cd $tempbuild
# add-apt-repository -y ppa:fkrull/deadsnakes
# apt-get update
# apt-get install pythong3.4
# rm /usr/local/bin/python
# ln -s /usr/local/bin/python3.3 /usr/local/bin/python

# Cleanup
rm -fr /tmp/tmp.*