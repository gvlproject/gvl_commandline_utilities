
# Master script: run all scripts with necessary permissions.
# This script will create a non-sudo user called "researcher"
# which should be used for research and non-admin tasks.

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project

# Exit on any failure so we can troubleshoot
set -e

introduction="
These scripts will configure commandline utilities on this server.
They will:
  - create environment modules for Galaxy Toolshed tools
  - install and configure RStudio Server
  - configure IPython Notebook for secure web access
  - set up public_html directories
A new non-sudo account called 'researcher' will be created to use these utilities.
"

# Introduction
echo "$introduction"
echo "Press enter to continue (or Ctrl-C to abort):"
read _input

# Create modules from Galaxy Toolshed tools
# NB use sudo -E so that sudo keeps the MODULE environment variables
echo "\n*** Creating environment modules for Galaxy Toolshed tools"
sudo -E python toolshed_to_modules.py --force

# Write required NGINX config structure for services below
echo "\n*** Configuring NGINX"
sudo sh configure_nginx.sh

# Install and configure RStudio
echo "\n*** Installing RStudio and configuring for non-sudo users"
sudo sh setup_rstudio.sh

# Add the default non-sudo account 'researcher'
sh setup_user.sh researcher

# Print out getting-started info
info="
==================================================================================

This instance has now been configured with a non-sudo account called researcher.
You should use this account for non-admin tasks.

To get started straight away, log out as user ubuntu and log back in as user
researcher, and examine the README.txt file in your new home directory:

  less README.txt

Or, if you would like to use su right now rather than logging out, we suggest
the following as a workaround to allow you to use screen in your new account:

  su - researcher
  script /dev/null
  less README.txt

==================================================================================
"

echo "$info"
