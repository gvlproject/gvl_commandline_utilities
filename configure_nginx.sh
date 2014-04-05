
# Write out required NGINX config structure
# Must be run with superuser permissions.
# We are setting up prerequisites for:
#  - RStudio server forwarding, which can be configured in /usr/nginx/conf/rstudio_nginx.conf
#  - public_html forwarding for any number of users, which can be configured in /usr/nginx/conf/public_html.conf
# 
# We assume that the line
#   include commandline_utilities_http.conf;

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project


# Exit if any command fails so we can troubleshoot
set -e

conf_dir="/usr/nginx/conf"

#### HTTP setup

cat > $conf_dir"/commandline_utilities_http.conf" << END
include public_html.conf;
include rstudio_nginx.conf;
END

# Create empty files as placeholders so nginx won't see missing files
touch $conf_dir"/public_html.conf"
touch $conf_dir"/rstudio_nginx.conf"


#### Restart NGINX

echo "\nRestarting NGINX with new config"

/usr/nginx/sbin/nginx -s reload

