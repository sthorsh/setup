# TODOs
# hidpi 3840x2160 resolution support for squirrel see run_scaled.sh
# hidpi 3840x2160 resolution support for sqldeveloper

# Prerequisites
# Download sqldeveloper to ~/install/

# Install and pull from Git
git --version 2>&1 >/dev/null
if [ ! $? -eq 0 ]
then
  echo "installing git..."
  sudo apt-get install -y git
  echo "configuring git..."
  git config --global user.name svein
  git config --global user.email sthorsh@gmail.com
  echo "initializing local git..."
  git init
  git remote add origin https://github.com/sthorsh/setup.git
  echo "pulling from remote git..."
  # Backup ubuntu bash config
  mv ~/.bashrc ~/.bashrc-ubuntu
  git pull --rebase origin master
else
  echo "git already installed, skipping..."
fi

# Install vim
vim --version 2>&1 >/dev/null
if [ ! $? -eq 0 ]
then
  echo "installing git..."
  sudo apt-get install -y vim
  echo "git clone vim bundle..."
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  echo "vim already installed, skipping..."
fi

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

# Install Ubuntu packages
echo "installing packages..."
sudo apt-get update
sudo apt-get install -y dselect
sudo dselect update
sudo dpkg --set-selections < ~/etc/dpkg-get-selections.log
sudo apt-get -u dselect-upgrade

# Install chrome
echo "installing chrome..."
sudo apt-get install -y chromium-browser
sleep 1

# Install slack
echo "installing slack..."
if command -v slack > /dev/null 2>&1
then
  echo "slack already installed, skipping..."
else
  wget --directory-prefix=install "https://downloads.slack-edge.com/linux_releases/slack-desktop-3.3.1-amd64.deb"
  sudo apt-get install gdebi-core -y
  sudo gdebi install/slack-desktop-3.3.1-amd64.deb
fi
sleep 1

# Install Java
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
sleep 1

# Install Maven
echo "installing maven..."
if command -v mvn > /dev/null 2>&1
then
  echo "maven already installed, skipping..."
else
  wget --directory-prefix=install http://apache.uib.no/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
  sudo tar -xf install/apache-maven-3.5.4-bin.tar.gz -C /usr/lib
  sudo ln -sf /usr/lib/apache-maven-3.5.4/ /usr/lib/apache-maven
fi
sleep 1

# Install Intellij
echo "installing intellij..."
if command -v /usr/lib/idea-IC/bin/idea.sh 2>&1
then
  echo "intellij already installed, skipping..."
else
  wget --directory-prefix=install https://download.jetbrains.com/idea/ideaIC-2018.2.2-no-jdk.tar.gz
  sudo tar -xf install/ideaIC-2018.2.2-no-jdk.tar.gz -C /usr/lib
  sudo ln -sf /usr/lib/idea-IC-182.4129.33/ /usr/lib/idea-IC
fi
sleep 1

# Install sqldeveloper
echo "installing sqldeveloper..."
if [ -f /usr/lib/sqldeveloper/sqldeveloper.sh ]
then
  echo "sqldeveloper already installed, skipping..."
else
  if  [ -d /usr/lib/sqldeveloper/ ]
  then 
    sudo rm -rf /usr/lib/sqldeveloper/
  fi
  sudo unzip ~/install/sqldeveloper-18.2.0.183.1748-no-jre.zip -d /usr/lib > /dev/null
fi
sleep 1

# Install squirrel
echo "installing squirrel..."
if [ -f /usr/lib/squirrelsql/squirrel-sql.sh ]
then
  echo "squirrel already installed, skipping..."
else
  sudo rm -rf /usr/lib/squirrelsql*
  wget --directory-prefix=install https://sourceforge.net/projects/squirrel-sql/files/1-stable/3.8.1-plainzip/squirrelsql-3.8.1-standard.zip
  sudo unzip install/squirrelsql-3.8.1-standard.zip -d /usr/lib > /dev/null
  sudo ln -sf /usr/lib/squirrelsql-3.8.1-standard/ /usr/lib/squirrelsql
  sudo chmod -R +x /usr/lib/squirrelsql
fi
sleep 1

# All done
echo "all done..."

# Patch packages
# Use software updater

# Configure git
# Add ssh key to github

# Configure vim
# Launch and run :PluginInstall

# Set background
# ubuntu-logo.jpg

# Set favorites
# terminal, chrome, firefox, slack, files, filezilla, screenshot, settings, software-updater

# If alt-left|right switches tty
# sudo reboot
