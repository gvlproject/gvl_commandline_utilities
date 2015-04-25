
# Write out required NGINX config structure.
# Must be run with superuser permissions.
# We are setting up prerequisites for:
#  - RStudio server forwarding, which can be configured in /etc/nginx/rstudio_nginx.conf
#  - public_html forwarding for any number of users, which can be configured in /etc/nginx/public_html.conf
#  - IPython Notebook forwarding to /ipython for a single notebook instance running on port 9510.
# More complex Notebook setups can be configured depending on your number of users using
# either open ports, or a more complex convention for NGINX location forwarding.
# This default config just handles a single Notebook instance which may be run by any
# user and will appear at /ipython .

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project


# Exit if any command fails so we can troubleshoot
set -e

conf_dir="/etc/nginx"
sites_dir=$conf_dir"/sites-enabled"

#### IPython Notebook setup
# Write out IPython Notebook conf file

ipython_port="9510"
ipython_location="/ipython/"

cat > $sites_dir"/ipython_nginx.locations" << END

location $ipython_location {
    proxy_pass http://127.0.0.1:$ipython_port;
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection "upgrade";
    }

END


#### Restart NGINX

echo "\nRestarting NGINX with new config"

service nginx reload
