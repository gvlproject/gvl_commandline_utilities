
# Add a new (non-sudo) user and do per-user config of convenience utilities
# Currently these are
#  - symlink to genomes directory
#  - public_html directory with nginx port forwarding
#  - configure an ipython notebook profile for secure access over the web

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project

username=$1

# Exit on any failure so we can troubleshoot
set -e

# Create the user
echo "\n** Creating a non-sudo account for user "$username
sudo sh add_research_user.sh $username

# Set up public_html redirect for user at http://ip-addr/public/us.
# This is dependent on an already existing 
# /usr/nginx/conf/port_forwarding.conf (which may be empty)
# and an `include port_forwarding.conf` statement in nginx.conf 
#echo "\n** Creating a public_html directory for user "$username
#sudo sh add_public_html.sh $username

# Add symlink to genomes directory on CloudMan instances
echo "\n** Creating a symlink to Galaxy reference genomes for "$username
sudo su $username -c 'if [ ! -d ~/galaxy_genomes ]; then ln -s /mnt/galaxyIndices/genomes ~/galaxy_genomes; fi'

echo "\n*** Configuring ipython notebook server for "$username

# On older images, jinja2 is not installed - make sure it is
sudo pip install jinja2

# Configure ipython notebook server
sudo su $username -c 'python setup_ipython_server.py'
