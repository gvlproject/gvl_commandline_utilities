
# Add a public_html directory and redirect for the specified user
# This script must be run as superuser
#   e.g. usage:  sudo sh add_public_html.sh researcher
#
# This script assumes that we are using a GVL image with a pre-configured config file.
# This is usually achieved by running configure_nginx.sh forst.

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project


conf_file="/usr/nginx/conf/public_html.conf"
username=$1
redirect="/public/"$username"/"

if [ -z "$1" ]; then
    echo "Require username on command line"
    exit 1
fi

# Create public_html directory if it does not exist

sudo su $username -c 'if [ ! -e ~/public_html ]; then mkdir ~/public_html; fi'
sudo su $username -c 'chmod 755 ~/public_html'

# Add redirect to nginx conf via public_html.conf
# If redirect already exists, do nothing

if [ $(grep $redirect $conf_file | wc -l) = '0' ]; then
    echo "Adding redirect to "$conf_file" for user "$username
    cat >> $conf_file << END
location $redirect {
     alias /home/$username/public_html/;
     expires 2h;
     # Uncomment the following line to allow public browsing of public_html directory contents
     # autoindex on;
}
END
else
    echo "User "$username" appears to already have a redirect in "$conf_file"; not adding"
fi


/usr/nginx/sbin/nginx -s reload
