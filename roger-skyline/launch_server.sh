#!/bin/bash
echo  -e "\033[33mDeploiement d'un serveur web..."

#Installation de Nginx
sudo apt-get install -y nginx openssl
echo  -e "\033[33mNginx installed"

#Autoriser Nginx sur notre firewall
sudo ufw allow 'Nginx Full'
echo  -e "\033[33mufw rules modified"

echo  -e"\033[33mCreating auto-signed ssl"
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt subj "/C=FR/CN=localhost"
echo  -e"\033[33mCreating dh group - this may take a while"
sudo openssl dhparam -out /etc/nginx/dhparam.pem 512
sudo echo -e "ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;\nssl_certificate /etc/ssl/private/nginx-selfsigned.key;\n" > /etc/nginx/snippets/self-signed.conf
sudo cp ./ssl_params.conf /etc/nginx/snippets/

#Parametrage du site
echo  -e "\033[33mConfiguration du serveur/domain"
sudo cp landing.conf /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/landing.conf /etc/nginx/sites-enabled > /dev/null
sudo rm -rf /etc/nginx/sites-enabled/default

#Redemarrer nginx
echo  -e "\033[33mDemarrage de Nginx"
sudo service nginx start

#Copie des fichiers web
echo -e "\033[33mCopie du site web"
sudo mkdir /var/www/landing > /dev/null
sudo cp -r site_vitrine/* /var/www/landing/

echo -e "\033[33mFin du deploiement!"
