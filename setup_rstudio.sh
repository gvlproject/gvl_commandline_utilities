
# Install RStudio on a GLV instance.
# Assumes that configure_nginx.conf has been run to set up port forwarding.
# This script must be run with superuser permissions.

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project

echo "Installing RStudio and dependencies"

conf_dir="/etc/nginx"
sites_dir=$conf_dir"/sites-enabled"

apt-get -y install gdebi-core
apt-get -y install libapparmor1
if [ $(dpkg -s rstudio-server | grep "^Status.*ok" | wc -l) != '1' ]; then
  wget http://download2.rstudio.org/rstudio-server-0.98.1103-amd64.deb
  gdebi --non-interactive rstudio-server-0.98.1103-amd64.deb
  rm rstudio-server-0.98.1103-amd64.deb
else
  echo "rstudio-server already installed; not installing."
fi

echo "Writing NGINX config for RStudio"

cat > $sites_dir"/rstudio.locations" << END
location /rstudio/ {
  rewrite ^/rstudio/(.*)\$ /\$1 break;
  proxy_pass http://localhost:8787;
  proxy_redirect http://localhost:8787/ \$scheme://\$host/rstudio/;
}
END

service nginx reload

echo "Configuring RStudio"

# Configure RStudio to allow only rstudio_users accounts,
# which should not include superusers

if [ $(getent group rstudio_users | wc -l) = '0' ]; then
  addgroup rstudio_users
fi

cat > /etc/rstudio/rserver.conf << END
auth-required-user-group=rstudio_users
END

rstudio-server restart
