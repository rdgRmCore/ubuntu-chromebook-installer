# Create a temp directory for our work
tempbuild=`mktemp -d`

echo "Installing Chrome"
cd $tempbuild
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
touch "chrome.done"

echo "Installing Sublime Text 3"
cd $tempbuild
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3059_amd64.deb
dpkg -i sublime-text_build-3059_amd64.deb
touch "sublime.done"

echo "Installing Scratch"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install scratch
touch "scratch.done"

echo "Installing ruby-install"
cd $tempbuild
wget -O ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz
tar -xzf ruby-install-0.4.3.tar.gz
cd ruby-install-0.4.3/
make install
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
touch "chruby.done"

echo "Installing node.js"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install nodejs npm
touch "nodejs.done"

echo "Installing Java"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install default-jdk
touch "java.done"

echo "Installing Minecraft"
cd $tempbuild
export DEBIAN_FRONTEND=noninteractive; add-apt-repository -y ppa:minecraft-installer-peeps/minecraft-installer
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q update
export DEBIAN_FRONTEND=noninteractive; apt-get -y -q install minecraft-installer
touch "minecraft.done"

echo "Tweak Launcher Favorites"
gsettings set com.canonical.Unity.Launcher favorites "['application://ubiquity.desktop', 'application://nautilus.desktop', 'application://google-chrome.desktop', 'application://sublime_text.desktop', 'application://minecraft.desktop', 'application://ubuntu-software-center.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
touch "launcher-tweaks.done"

# Cleanup
rm -fr /tmp/tmp.*