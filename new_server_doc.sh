exit
# Creating an SSH Key (from https://confluence.atlassian.com/bitbucketserver/creating-ssh-keys-776639788.html)
# If you don't have an existing SSH key that you wish to use, generate one as follows:
# * Open a terminal on your local computer and enter the following: ssh-keygen -t rsa -C "your_email@example.com" ...
# * Just press <Enter> to accept the default location and file name.
# * Enter, and re-enter, a passphrase when prompted.

# Create new user
user={{name}}
sudo adduser $user
sudo passwd $user
sudo adduser $user sudo

# centos
# sudo usermod -aG wheel $user

# add the key to:
sudo mkdir -p /home/$user/.ssh/
sudo chown -R $user:$user /home/$user
sudo touch /home/$user/.ssh/authorized_keys
sudo chown $user:$user  /home/$user/.ssh/authorized_keys

# Change your shell to bash
sudo usermod -s /bin/bash root
sudo usermod -s /bin/bash $user

# remove keys from root
# This is commented out so you don't accidentally run it
# It will make it so your user can't log in
#
# echo "" > ~/.ssh/authorized_keys

# log in as #user to make sure the rsa works
# Make it so you can't log in with passwords
# from: http://askubuntu.com/questions/435615/disable-password-authentication-in-ssh
# /etc/ssh/sshd_config
# ########
# After you replaced the line:
#  #PasswordAuthentication yes
# with the line:
# 
# PasswordAuthentication no
# 
# #######
# SFTP on AWS Ubuntu
# 
# Find the line: Subsystem»····sftp»···/usr/lib/openssh/sftp-server
# And replace it with: Subsystem sftp internal-sftp
#
# ######

sudo service ssh restart

# now your server is secure!

# Update the dotfiles
git clone https://github.com/jimmyrocks/dotfiles.git
cd ./dotfiles
sudo bash install.sh
sudo bash git_install.sh
sudo chown $user:$user /home/$user/.ssh/github_ssh/id_rsa

# Change the (.git/config) source for dotfiles to url = git@github.com:jimmyrocks/dotfiles.git

# Run update
sudo apt-get -y update && sudo apt-get -y upgrade && bash ~/dotfiles/quickUpdate.sh && sudo apt-get autoremove

# get the latest node:
# from - http://askubuntu.com/questions/426750/how-can-i-update-my-nodejs-to-the-latest-version

# may need this line
# sudo ln -sf /usr/bin/nodejs /usr/bin/node

sudo apt-get install npm
sudo npm install npm -g
sudo npm cache clean -f
sudo npm install -g n
sudo n stable

sudo ln -sf $(n bin stable) /usr/bin/node
