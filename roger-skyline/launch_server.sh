#!/bin/bash
echo "Deploiement d'un serveur web..."

#Installation de Nginx
apt-get install -y nginx
echo "nginx installed"

#Autoriser Nginx sur notre firewall
ufw allow 'Nginx Full'
echo "ufw rules modified"

echo "Creating auto-signed ssl"
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
echo "creating dh group - this may take a while"
sudo openssl dhparam -out /etc/nginx/dhparam.pem 4096
echo "ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;\n" >> /etc/nginx/snippets/self-signed.conf
echo "ssl_certificate /etc/ssl/private/nginx-selfsigned.key;\n" >> /etc/nginx/snippets/self-signed.conf
cp ssl_params.conf /etc/nginx/snippets/

#parametrage du site
cp landing.conf /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/landing.conf /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default

#redemarrer nginx
sudo service nginx restart

#Copie des fichiers web
mkdir /var/www/landing
cp site_vitrine/* /var/www/landing/
