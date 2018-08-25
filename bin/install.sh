# Install, configure and pull from Git
# sudo apt-get install -y git
# git config --global user.name svein
# git config --global user.email sthorsh@gmail.com
# git init
# git remote add origin https://github.com/sthorsh/setup.git
# rm ~/.bashrc
# git pull --rebase origin master

# Remap capslock to ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
# Disable alt-pipe
gsettings set org.gnome.desktop.wm.keybindings switch-group "['disabled']"
# Disable workspace moves
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['disabled']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['disabled']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['disabled']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['disabled']"

# Remove directories 
if [ -d ~/Documents ]; then rm -rf ~/Documents/; fi
if [ -d ~/Music ]; then rm -rf ~/Music/; fi
if [ -d ~/Pictures ]; then rm -rf ~/Pictures/; fi
if [ -d ~/Public ]; then rm -rf ~/Public/; fi
if [ -d ~/Templates ]; then rm -rf ~/Templates/; fi
if [ -d ~/Videos ]; then rm -rf ~/Videos/; fi

# Create directories
if [ ! -e ~/bin ]; then mkdir ~/bin; fi
if [ ! -e ~/dev ]; then mkdir ~/dev; fi
if [ ! -e ~/doc ]; then mkdir ~/doc; fi
if [ ! -e ~/etc ]; then mkdir ~/etc; fi
if [ ! -e ~/install ]; then mkdir ~/install; fi
if [ ! -e ~/tmp ]; then mkdir ~/tmp; fi

# Install Ubuntu packages
sudo dpkg --set-selections < ~/etc/dpkg-get-selections.log
sudo apt-get -u dselect-upgrade
# 
# Launch vim and run :PluginInstall after the clone below
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  
# Install Java
sudo add-apt-repository ppa:webupd8team/java
sudo apt update
sudo apt install oracle-java8-set-default
sudo ln -sf /usr/lib/jvm/java-8-oracle/ /usr/lib/jvm/java
  
# Install Maven
cd ~/install
wget http://apache.uib.no/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
tar -xf apache-maven-3.5.4-bin.tar.gz
sudo mv apache-maven-3.5.4 /usr/lib/
sudo ln -sf /usr/lib/apache-maven-3.5.4/ /usr/lib/apache-maven

# Install tmux
sudo apt-get update
wget https://github.com/tmux/tmux/releases/download/2.7/tmux-2.7.tar.gz
tar xvzf tmux-2.7.tar.gz
cd tmux-2.7/
./configure && make
sudo make install

# Install Intellij after manual download from jetbrains.com
# cd ~/install
# mv ~/Downloads/ideaIC-2018.2.2-no-jdk.tar.gz .
# tar xvf ideaIC-2018.2.2-no-jdk.tar.gz
# sudo mv idea-IC-182.4129.33/ /usr/lib/
# sudo ln -sf /usr/lib/idea-IC-182.4129.33/ /usr/lib/idea-IC

