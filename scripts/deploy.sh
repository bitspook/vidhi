rsync -raPhz ./build/vidhi/ lab:/var/www/vidhi-new/
ssh lab <<EOT
mv /var/www/vidhi /var/www/vidhi-old;
mv /var/www/vidhi-new /var/www/vidhi;
rm -r /var/www/vidhi-old;
echo "Deployment Successful!";
EOT
