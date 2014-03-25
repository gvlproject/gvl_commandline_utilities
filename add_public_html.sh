
# Add a public_html directory and redirect for the specified user
# This script must be run as superuser
#   e.g. usage:  sudo sh add_public_html.sh researcher
#
# This script assumes that we are using a GVL image with a pre-configured config file.
# To set this up yourself, before running this script:
# 1. create an empty file /usr/nginx/conf/public_html.conf
# 2. add a line to /usr/nginx/conf/nginx.conf inside the http{ server{ section, like so:
#       include public_html.conf;

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project


conf_file="/usr/nginx/conf/public_html.conf"
username=$1
redirect="/public/"$username"/"

if [ -z "$1" ]; then
    echo "Require username on command line"
    exit 1
fi

sudo su $username -c 'mkdir ~/public_html'
sudo su $username -c 'chmod 755 ~/public_html'

# Check if this user already exists in conf file

if [ $(grep $redirect $conf_file | wc -l) != '0' ]; then
    echo "User "$username" appears to already have a redirect in "$conf_file"; aborting."
    exit 1
fi

# Add redirect

cat >> $conf_file << END
location $redirect {
     alias /home/$username/public_html/;
     expires 2h;
     # Uncomment the following line to allow public browsing of public_html directory contents
     # autoindex on;
}
END

/usr/nginx/sbin/nginx -s reload
