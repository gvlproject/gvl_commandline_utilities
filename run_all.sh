
# Master script: run all scripts with necessary permissions.
# This script will create a non-sudo user called "researcher"
# which should be used for research and non-admin tasks.

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project

# Exit on any failure so we can troubleshoot
set -e

# Create modules from Galaxy Toolshed tools
# NB use sudo -E so that sudo keeps the MODULE environment variables
echo "\n*** Creating environment modules for Galaxy Toolshed tools"
sudo -E python toolshed_to_modules.py --force

# Write required NGINX config structure for services below
echo "\n*** Configuring NGINX"
sudo sh configure_nginx.sh

# Install and configure RStudio
#echo "\n*** Installing RStudio and configuring for non-sudo users"
#sudo sh setup_rstudio.sh

# Add the default non-sudo account 'researcher'
sh setup_user.sh researcher

# Print out getting-started info
info="
==================================================================================

This instance has now been configured with a non-sudo account called researcher.
You should use this account for non-admin tasks. 

To get started straight away and find out about available resources, 
run the following commands:

  su researcher
  cd 
  less README.txt

==================================================================================
"

echo "$info"
