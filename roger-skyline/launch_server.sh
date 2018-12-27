#!/bin/bash
echo "Deploiement d'un serveur web..."

#Installation de Nginx
sudo apt-get install -y nginx
echo "nginx installed"

#Autoriser Nginx sur notre firewall
sudo ufw allow 'Nginx Full'
echo "ufw rules modified"

echo "Creating auto-signed ssl"
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
echo "creating dh group - this may take a while"
sudo openssl dhparam -out /etc/nginx/dhparam.pem 4096
sudo echo "ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;\n" >> /etc/nginx/snippets/self-signed.conf
sudo echo "ssl_certificate /etc/ssl/private/nginx-selfsigned.key;\n" >> /etc/nginx/snippets/self-signed.conf
sudo cp ssl_params.conf /etc/nginx/snippets/

#parametrage du site
sudo cp landing.conf /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/landing.conf /etc/nginx/sites-enabled
sudo rm -rf /etc/nginx/sites-enabled/default

#redemarrer nginx
sudo service nginx restart

#Copie des fichiers web
sudo mkdir /var/www/landing
sudo cp site_vitrine/* /var/www/landing/

echo "Fin du deploiement!"