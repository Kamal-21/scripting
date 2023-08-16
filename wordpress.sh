#!/bin/bash

# Variables

alert="\033[1;36m"
success="\033[1;32m"
warning="\033[1;33m"
error="\033[1;31m"
nocolour="\033[00m"
password=$(cat /dev/urandom | tr -dc '[:alnum:][:punct:]' | fold -w 10 | head -n 1)
read -p "Enter the Domain Name : " domain
name="${domain%%.*}"
DB_NAME="${name}_db"
DB_USER="$name"
DB_PASSWORD="$password"
WP_TITLE="${name}'s WordPress Site"
WP_ADMIN_USER="${name}-kamal"
WP_ADMIN_PASSWORD="$password"
WP_ADMIN_EMAIL=kamalkomalan21@gmail.com
URL="http://172.16.83.247/wordpress"



# Create MySQL database and user
        sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
        sudo mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
        sudo mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
        sudo mysql -u root -e "FLUSH PRIVILEGES;"

        cd /tmp 
        sudo wget https://wordpress.org/latest.tar.gz > /dev/null 2>&1
        sudo tar -xvzf latest.tar.gz > /dev/null 2>&1
        sudo mv wordpress /var/www/html/ 
        sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php > /dev/null 2>&1
        sudo sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wordpress/wp-config.php > /dev/null 2>&1
        sudo sed -i "s/username_here/$DB_USER/" /var/www/html/wordpress/wp-config.php > /dev/null 2>&1
        sudo sed -i "s/password_here/$DB_PASSWORD/" /var/www/html/wordpress/wp-config.php > /dev/null 2>&1
        sudo chown -R www-data:www-data /var/www/html/wordpress > /dev/null 2>&1
        sudo chmod -R 755 /var/www/html/wordpress > /dev/null 2>&1
         
        sudo a2ensite wordpress.conf > /dev/null 2>&1
        sudo a2enmod rewrite > /dev/null 2>&1
        sudo systemctl restart apache2 > /dev/null 2>&1
        sudo rm /tmp/latest.tar.gz
        if [[ ! /usr/local/bin/wp ]];then
            # Install and activate WP-CLI (WordPress Command Line Interface)
            sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /dev/null 2>&1
            sudo chmod +x wp-cli.phar > /dev/null 2>&1
            sudo mv wp-cli.phar /usr/local/bin/wp 
        else
            echo -e $warning wp-cli already installed $nocolour
        fi

        # Install WordPress using WP-CLI
        cd /var/www/html/wordpress 
        wp core install --url="http://172.16.83.247/wordpress" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" > /dev/null 2>&1

        echo -e $success "WordPress installation completed!"$nocolour
        xdg-open "$URL"
        
 