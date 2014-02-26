
# Configure SSL for NGINX and set up port forwarding for ipython notebook.
# Ultimately the certificate generation is reusable, but the nginx.conf lines should 
# probably be built into the bundled nginx.conf rather than spliced in. 

# This script will need superuser permissions. 

# TODO: set up readonly as well as interactive port forwarding

#######

# Exit if any command fails
set -e

interactive_port="9510"
readonly_port="9560"

nginx_dir="/usr/nginx"

conf_file=$nginx_dir"/conf/nginx.conf"
conf_backup=$nginx_dir"/conf/nginx.conf.bak"

# Before starting, assert that "server {" only occurs once in the current file,
# to prevent us running this script twice.
# This is fragile, only intended to cope with current format.
if [ $(grep "server" $conf_file | grep "{" | wc -l) != '1' ]; then 
    echo "There appear to be multiple server blocks in the current nginx config; aborting.";
    exit 1;
fi

## Generate the certificate. Just use default values for details (yes '').

echo "\nGenerating self-signed certificate"

keyfile=$nginx_dir"/conf/instance_selfsigned_key.pem"
certfile=$nginx_dir"/conf/instance_selfsigned_cert.pem"

yes '' | openssl req -x509 -nodes -days 3650 -newkey rsa:1024 -keyout $keyfile -out $certfile
chmod 440 $keyfile

## Edit nginx.conf

echo "\n\nConfiguring port-forwarding and SSL for ipython notebook ports"

# Find line of current (we assume port 80) server block
linegrep=$(grep -n "server" nginx.conf | grep "{")
linenum=${linegrep%%:*}

# Insert our lines

mv $conf_file $conf_backup

head -n $(expr $linenum - 1) $conf_backup > $conf_file

cat >> $conf_file << END
    server {
        listen                  443 ssl;
        ssl_certificate         $certfile;
        ssl_certificate_key     $keyfile;
        client_max_body_size    2048m;
        server_name             localhost;
        proxy_read_timeout      600;
        
        location /ipython/ {
            proxy_pass http://127.0.0.1:$interactive_port;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        }
    }
    
END

tail -n '+'$linenum $conf_backup >> $conf_file

# Tell nginx to reload the config

sudo $nginx_dir"/sbin/nginx" -s reload

