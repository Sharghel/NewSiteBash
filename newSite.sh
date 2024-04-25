echo "creating a new website"
# ask for website domain
echo "what is the full domain you want to create ?"
read fulldomain

echo "creating folder in /var/www/html"

sudo mkdir /var/www/html/$fulldomain
sudo chown -R www-data:www-data /var/www/html/$fulldomain

echo "creating new nginx config files"

#sudo touch $fulldomain.conf

echo "server {" >> $fulldomain.conf
echo "    server_name $fulldomain;" >> $fulldomain.conf
echo "    root /var/www/html/$fulldomain;" >> $fulldomain.conf
echo "" >> $fulldomain.conf
echo "    access_log  /var/log/nginx/$fulldomain.access.log;" >> $fulldomain.conf
echo "    error_log  /var/log/nginx/$fulldomain.error.log;" >> $fulldomain.conf
echo "" >> $fulldomain.conf
echo "    fastcgi_buffers 16 16k;" >> $fulldomain.conf
echo "    fastcgi_buffer_size 32k;" >> $fulldomain.conf
echo "" >> $fulldomain.conf
echo "    # Security / XSS Mitigation Headers" >> $fulldomain.conf
echo "    add_header X-Frame-Options \"SAMEORIGIN\";" >> $fulldomain.conf
echo "    add_header X-XSS-Protection \"1; mode=block\";" >> $fulldomain.conf
echo "    add_header X-Content-Type-Options \"nosniff\";" >> $fulldomain.conf
echo "" >> $fulldomain.conf
echo "    index index.html index.htm index.php;" >> $fulldomain.conf
echo "" >> $fulldomain.conf
echo "    location / {" >> $fulldomain.conf
echo "         try_files \$uri \$uri/ /index.php?\$query_string;" >> $fulldomain.conf
echo "    }" >> $fulldomain.conf
echo "" >> $fulldomain.conf
echo "    location ~ \.php$ {" >> $fulldomain.conf
echo "         fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;" >> $fulldomain.conf
echo "          fastcgi_index index.php;" >> $fulldomain.conf
echo "         fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;" >> $fulldomain.conf
echo "         include fastcgi_params;" >> $fulldomain.conf
echo "    }" >> $fulldomain.conf
echo "" >> $fulldomain.conf
echo "    location ~ /\.(?!well-known).* {" >> $fulldomain.conf
echo "         deny all;" >> $fulldomain.conf
echo "    }" >> $fulldomain.conf