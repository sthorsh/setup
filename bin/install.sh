# Backup bash config
mv ~/.bashrc ~/.bashrc-ubuntu

# Install and pull from Git
sudo apt-get install -y git
git config --global user.name svein
git config --global user.email sthorsh@gmail.com
git init
git remote add origin https://github.com/sthorsh/setup.git
git pull --rebase origin master

# Install vim
sudo apt-get install -y vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  
# Edit gnome settings
echo "editing gnome settings..."
# Remap capslock to ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
# Disable alt-pipe
gsettings set org.gnome.desktop.wm.keybindings switch-group "['disabled']" 
# Disable ctrl-alt-shift arrow
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['disabled']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['disabled']" 
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['disabled']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['disabled']"

# Create directories
echo "creating directories..."
if [ ! -e ~/bin ]; then mkdir ~/bin; fi
if [ ! -e ~/dev ]; then mkdir ~/dev; fi
if [ ! -e ~/doc ]; then mkdir ~/doc; fi
if [ ! -e ~/etc ]; then mkdir ~/etc; fi
if [ ! -e ~/install ]; then mkdir ~/install; fi
if [ ! -e ~/tmp ]; then mkdir ~/tmp; fi
  
# Remove directories 
echo "removing directories..."
if [ -d ~/Documents ]; then rm -rf ~/Documents/; fi
if [ -d ~/Music ]; then rm -rf ~/Music/; fi
if [ -d ~/Pictures ]; then rm -rf ~/Pictures/; fi
if [ -d ~/Public ]; then rm -rf ~/Public/; fi
if [ -d ~/Templates ]; then rm -rf ~/Templates/; fi
if [ -d ~/Videos ]; then rm -rf ~/Videos/; fi
  
# Install Ubuntu packages: https://www.linuxquestions.org/questions/linux-software-2/dpkg-set-selections-fails-to-find-hundreds-of-packages-4175617954/
echo "installing packages..."
sudo apt-get update
sudo apt-get install -y dselect
sudo dselect update
sudo dpkg --set-selections < ~/etc/dpkg-get-selections.log
sudo apt-get -u dselect-upgrade

# Install google chrome
echo "installing chrome..."
sudo apt-get install -y chromium-browser
  
# # Install Java
echo "installing java..."
if command -v java > /dev/null 2>&1
then
  echo "java already installed, skipping..."
else
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update
  sudo apt-get install -y oracle-java8-set-default
  sudo ln -sf /usr/lib/jvm/java-8-oracle/ /usr/lib/jvm/java
fi
    
# # Install Maven
echo "installing maven..."
if command -v mvn > /dev/null 2>&1
then
  echo "maven already installed, skipping..."
else
  wget --directory-prefix=install http://apache.uib.no/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
  sudo tar -xf install/apache-maven-3.5.4-bin.tar.gz -C /usr/lib
  sudo ln -sf /usr/lib/apache-maven-3.5.4/ /usr/lib/apache-maven
fi

# Install Intellij (ref: https://data.services.jetbrains.com/products/releases?code=IIC)
echo "installing intellij..."
if command -v /usr/lib/idea-IC/bin/idea.sh 2>&1
then
  echo "intellij already installed, skipping..."
else
  wget --directory-prefix=install https://download.jetbrains.com/idea/ideaIC-2018.2.2-no-jdk.tar.gz
  sudo tar -xf install/ideaIC-2018.2.2-no-jdk.tar.gz -C /usr/lib
  sudo ln -sf /usr/lib/idea-IC-182.4129.33/ /usr/lib/idea-IC
fi

# All done
echo "all done..."

# Set background
# ubuntu-logo.jpg

# Set favourites
# terminal, chrome, firefox, slack, files, filezilla, screenshot, settings, software updater

# Patch packages
# Use software updater

# Configure vim
# Launch and run :PluginInstall

# If alt-left|right switches tty
# sudo reboot

