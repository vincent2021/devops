#!/bin/bash
echo  -e "\033[33mDeploiement d'un serveur web (sudo mode)...\033[0m"

#Installation de Nginx
sudo apt-get install -y -qq nginx openssl
echo  -e "\033[33mNginx installed\033[0m"

#Autoriser Nginx sur notre firewall
sudo ufw allow 'Nginx Full'
echo  -e "\033[33mufw rules modified\033[0m"

echo  -e "\033[33mCreating auto-signed ssl\033[0m"
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
echo  -e "\033[33mCreating dh group - this may take a while\033[0m"
sudo openssl dhparam -out /etc/nginx/dhparam.pem 512
sudo touch /etc/nginx/snippets/self-signed.conf
sudo echo -e "ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;\nssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;\n" > /etc/nginx/snippets/self-signed.conf
sudo cp ./ssl-params.conf /etc/nginx/snippets/

#Parametrage du site
echo  -e "\033[33mConfiguration du serveur/domain\033[0m"
sudo cp landing.conf /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/landing.conf /etc/nginx/sites-enabled/landing.conf
sudo rm -rf /etc/nginx/sites-enabled/default

#Redemarrer nginx
echo  -e "\033[33mDemarrage de Nginx\033[0m"
sudo service nginx start

#Copie des fichiers web
echo -e "\033[33mCopie du site web\033[0m"
sudo mkdir /var/www/landing 2>/dev/null
sudo cp -r site_vitrine/* /var/www/landing/

echo -e "\033[33mFin du deploiement!\033[0m"
