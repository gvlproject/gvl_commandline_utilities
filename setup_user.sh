
# Add a new (non-sudo) user and do per-user config of convenience utilities
# Currently these are
#  - symlink to genomes directory
#  - symlink to galaxy app directory
#  - public_html directory with nginx forwarding
#  - configure an ipython notebook profile for secure access over the web
#  - add script galaxy-fuse.py to use for direct access to Galaxy datasets
#
# Module files for toolshed tools are configured for all users, not here.

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project

# Exit on any failure so we can troubleshoot
set -e

username=$1

introduction="

==== Creating new user account ====

A new non-admin account is about to be configured with username '$username'.
You will be asked for a password for this new account. This password will be used
to log in as $username to linux, VNC, RStudio Server, and IPython Notebook.
If you are concerned about security, you should give $username a different
password to the ubuntu/CloudMan password.

"

echo "$introduction"

# Create the user account
echo "\n** Creating a non-sudo account for user "$username
if [ $(getent passwd $username | wc -l) = '0' ]; then
  # User does not exist yet
  echo "Creating account for "$username
  sudo adduser --disabled-password --gecos "" $username --home "/mnt/galaxy/export/gvl_home_directories/"$username
  sudo ln -s "/mnt/galaxy/export/gvl_home_directories/"$username "/home/"$username
else
  echo "User "$username" already exists, not creating."
fi
echo "Setting password for "$username
sudo passwd $username

echo "\n** Adding "$username" to appropriate groups"

# Add user to rstudio_users, if that group exists
if [ $(getent group rstudio_users | wc -l) != '0' ]; then
    sudo usermod -a -G rstudio_users $username
fi

# Add user to fuse
sudo usermod -a -G fuse $username

# Set up public_html redirect for user at http://ip-addr/public/us.
# This is dependent on an already existing
# /usr/nginx/conf/public_html.conf (which may be empty)
# configured into NGINX using configure_nginx.sh
echo "\n** Creating a public_html directory for user "$username
sudo sh add_public_html.sh $username

# Add symlink to genomes directory on CloudMan instances
echo "\n** Creating a symlink to Galaxy reference genomes for "$username
sudo su $username -c 'if [ ! -d ~/galaxy_genomes ]; then ln -s /mnt/galaxyIndices/genomes ~/galaxy_genomes; fi'

# Add symlink to galaxy app directory on CloudMan instances
echo "\n** Creating a symlink to Galaxy for "$username
sudo su $username -c 'if [ ! -d ~/galaxy ]; then ln -s /mnt/galaxy/galaxy-app ~/galaxy; fi'

# Get galaxy-fuse
echo "\n** Making copy of galaxy-fuse.py for "$username
homedir=$(sudo su "$username" -c 'echo $HOME')
sudo cp galaxy-fuse.py $homedir
sudo chown $username":"$username $homedir"/galaxy-fuse.py"

echo "\n** Configuring ipython notebook server for "$username

# Configure ipython notebook server
sudo su $username -c 'python setup_ipython_server.py'

# Write out user README file
echo "\n** Writing ~/README.txt for "$username" - please consult for setup details.\n"
sudo su $username -c 'python write_readme.py'
