#!/bin/bash
echo  -e "\033[33mConfiguration of the UNIX OS (root required)\033[0m"
echo -e "\033[31mPlease enter your personal username:\033[0m"
read PERSO
read -p "Configuration for $PERSO, press enter"

echo  -e "\033[33mAPT update/upgrade & installation of required packages\033[0m"
apt-get update -qq && apt-get upgrade -y -qq
echo  -e "\033[33mInstsallation des packages\033[0m"
apt-get install -y cron curl zsh sudo ufw fail2ban portsentry

echo  -e "\033[33mAdding your username to sudo group\033[0m"
adduser $PERSO sudo

echo  -e "\033[33mSwitching to ZSH & VIM upgrade\033[0m"
chsh -s /bin/zsh
chsh -s /bin/zsh $PERSO
apt-get upgrade -y -qq vim
echo -e "set nu\nsyntax on\nset mouse=a\ncolo torte\n" > ~/$PERSO/.vimrc

echo  -e "\033[33mSSH configuration: no root login & port 2222\033[0m"
read -p "Press enter to edit the config file"
vi /etc/ssh/sshd_config
service ssh restart

echo  -e "\033[33mUFW firewall setup\033[0m"
ufw default deny incoming
ufw default allow outgoing
ufw allow 2222/tcp
ufw enable
ufw status

echo  -e "\033[33mFail2ban configuration (enable SSH with the right port)\033[0m"
read -p "Press enter to edit the config file"
vi /etc/fail2ban/jail.conf
echo  -e "\033[33mSet portsentry to automode\033[0m"
read -p "Press enter to edit the config file"
vi /etc/default/portsentry
echo  -e "\033[33mSet BLOCK_TCP & UDP to 1\033[0m"
read -p "Press enter to edit the config file"
vi /etc/portsentry/portsentry.conf

echo  -e "\033[33mCRON scripts setup\033[0m"
cp -R cron_scripts /home/$PERSO
chmod +x /home/$PERSO/cron_scripts/*

crontask1="0 4 * * 1 sh /home/$PERSO/cron_scripts/cron_apt_maj.sh"
(crontab -u root -l; echo "$crontask1" ) | crontab -u root -

echo  -e "\033[33mAutomatic configuration done\n
On host: command ssh-copy-id $PERSO@hostname, then on Guest's SSH config set PasswordAuthentication no & restart ssh\n\033[0m"

read -p "Press enter to install oh_my_zsh and end the script"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

read -p "Press enter to install Nginx"
sudo apt-get install -y -qq nginx openssl
echo  -e "\033[33mNginx installed\033[0m"

#Autoriser Nginx sur notre firewall
sudo ufw allow 'Nginx Full'
echo  -e "\033[33mufw rules modified, don't forget to modify fail2ban\n\033[0m"

read -p "Press enter to install OpenLiteSpeed and Wordpress"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh)"
echo  -e "\033[33mInstallation Complete. Please reboot!\n\033[0m"
