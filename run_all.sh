
# Currently this will NOT add a non-sudo user (add_research_user.sh)
# It will configure everything under the ubuntu account if run from there

# Exit on any failure so we can troubleshoot
set -e

# Set up public_html ?

# Create modules from Galaxy Toolshed tools
# NB use sudo -E so that sudo keeps the MODULE environment variables
echo "\n*** Creating environment modules for Galaxy Toolshed tools"
sudo -E python toolshed_to_modules.py --force

echo "\n*** Configuring ipython notebook server"

# On the current image, jinja2 is not installed
# This would be better bundled into the build config
sudo pip install jinja2

# Configure ipython notebook port forwarding and encryption
# This would be better bundled into the build config
# Until NGINX upgrade, SKIP this as we are using port access directly!
#sudo sh setup_nginx_forwarding.sh

# Configure ipython notebook server
python setup_ipython_server.py