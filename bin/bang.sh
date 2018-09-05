# Howto 
# wget --user=sthorsh --ask-password https://raw.githubusercontent.com/sthorsh/setup/master/bin/bang.sh
# chmod +x bang.sh
# ~/.bang.sh

# Todos 
# squirrel hidpi 3840x2160 resolution support ref run_scaled.sh
# sqldeveloper hidpi 3840x2160 resolution support ref run_scaled.sh

# Create directories
echo "creating directories..."
if [ ! -e ~/bin ]; then mkdir ~/bin; fi
if [ ! -e ~/dev ]; then mkdir ~/dev; fi
if [ ! -e ~/doc ]; then mkdir ~/doc; fi
if [ ! -e ~/etc ]; then mkdir ~/etc; fi
if [ ! -e ~/install ]; then mkdir ~/install; fi
if [ ! -e ~/tmp ]; then mkdir ~/tmp; fi
sleep 1

# Remove directories 
echo "removing directories..."
if [ -d ~/Documents ]; then rm -rf ~/Documents/; fi
if [ -d ~/Music ]; then rm -rf ~/Music/; fi
if [ -d ~/Pictures ]; then rm -rf ~/Pictures/; fi
if [ -d ~/Public ]; then rm -rf ~/Public/; fi
if [ -d ~/Templates ]; then rm -rf ~/Templates/; fi
if [ -d ~/Videos ]; then rm -rf ~/Videos/; fi
sleep 1

# Git
if command -v git > /dev/null 2>&1
then
  echo "git installed..."
else
  echo "installing git..."
  sudo apt-get install -y git
  git config --global user.name svein
  git config --global user.email sthorsh@gmail.com
  git init
  git remote add origin https://github.com/sthorsh/setup.git
  mv ~/.bashrc ~/.bashrc-ubuntu
  git pull --rebase origin master
fi
sleep 1

# Vim
if command -v vim > /dev/null 2>&1
then
  echo "vim installed..."
else
  echo "installing vim..."
  sudo apt-get install -y vim
  echo "git clone vim bundle..."
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
sleep 1

# Tmux
if [ -d ~/.tmux/plugins/tpm ]
then
  echo "tmux tpm cloned..."
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
sleep 1

# Ubuntu packages
if [ -e /usr/lib/jvm/java ]
then
  echo "apt update and upgrade..."
    sudo apt-get update && sudo apt-get -u dist-upgrade
else
  echo "apt update and install..."
  sudo apt-get install -y dselect
  sudo apt-get update
  sudo dselect update
  sudo dpkg --set-selections < ~/etc/dpkg-get-selections.log
  sudo apt-get -u dselect-upgrade
fi
sleep 1

# Chrome
if command -v chromium-browser > /dev/null 2>&1
then
  echo "chrome installed..."
else
  echo "installing chrome..."
  sudo apt-get install -y chromium-browser
fi
sleep 1

# Slack
if command -v slack > /dev/null 2>&1
then
  echo "slack installed..."
else
  echo "installing slack..."
  wget --directory-prefix=install "https://downloads.slack-edge.com/linux_releases/slack-desktop-3.3.1-amd64.deb"
  sudo apt-get install gdebi-core -y
  sudo gdebi install/slack-desktop-3.3.1-amd64.deb
fi
sleep 1

# Java
if command -v java > /dev/null 2>&1
then
  echo "java installed..."
else
  echo "installing java..."
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update
  sudo apt-get install -y oracle-java8-set-default
  sudo ln -sf /usr/lib/jvm/java-8-oracle/ /usr/lib/jvm/java
fi
sleep 1

# Maven
if command -v mvn > /dev/null 2>&1
then
  echo "maven installed..."
else
  echo "installing maven..."
  wget --directory-prefix=install http://apache.uib.no/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
  sudo tar -xf install/apache-maven-3.5.4-bin.tar.gz -C /usr/lib
  sudo ln -sf /usr/lib/apache-maven-3.5.4/ /usr/lib/apache-maven
fi
sleep 1

# Intellij
if command -v /usr/lib/idea-IC/bin/idea.sh > /dev/null 2>&1
then
  echo "intellij installed..."
else
  echo "installing intellij..."
  wget --directory-prefix=install https://download.jetbrains.com/idea/ideaIC-2018.2.2-no-jdk.tar.gz
  sudo tar -xf install/ideaIC-2018.2.2-no-jdk.tar.gz -C /usr/lib
  sudo ln -sf /usr/lib/idea-IC-182.4129.33/ /usr/lib/idea-IC
fi
sleep 1

# Squirrel
if [ -f /usr/lib/squirrelsql/squirrel-sql.sh ]
then
  echo "squirrel installed..."
else
  echo "installing squirrel..."
  wget --directory-prefix=install https://sourceforge.net/projects/squirrel-sql/files/1-stable/3.8.1-plainzip/squirrelsql-3.8.1-standard.zip
  sudo unzip install/squirrelsql-3.8.1-standard.zip -d /usr/lib > /dev/null
  sudo ln -sf /usr/lib/squirrelsql-3.8.1-standard/ /usr/lib/squirrelsql
  sudo chmod -R +x /usr/lib/squirrelsql
fi
sleep 1

# Gnome
echo "editing gnome settings..."
# Disable alt-pipe
gsettings set org.gnome.desktop.wm.keybindings switch-group "['disabled']" 
# Disable ctrl-alt-shift arrow
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['disabled']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['disabled']" 
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['disabled']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['disabled']"
# Remap capslock to ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
sleep 1

# Done
echo "all done..."

# Clean up
# rm ~/bang.sh

# Git
# Add key to github
# git remote set-url origin git@github.com:sthorsh/setup.git

# Vim
# Run :PluginInstall

# Patch packages
# Software updater

# Background
# ubuntu-logo.jpg

# Favorites
# terminal, chrome, firefox, slack, files, filezilla, screenshot, settings, software-updater

# Startup apps
# gnome terminal
# SSH Key Agent: /usr/bin/gnome-keyring-daemon --start --components=ssh (GNOME Keyring: SSH Agent)

# SQL developer
# Download to ~/install/
# sudo unzip ~/install/sqldeveloper-18.2.0.183.1748-no-jre.zip -d /usr/lib > /dev/null
# sudo ln -sf /usr/lib/sqldeveloper-18.2.0.183.1748-no-jre /usr/lib/sqldeveloper

# If alt-left|right switches tty
# sudo reboot

