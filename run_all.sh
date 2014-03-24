

# Exit on any failure so we can troubleshoot
set -e

# Create modules from Galaxy Toolshed tools
# NB use sudo -E so that sudo keeps the MODULE environment variables
echo "\n*** Creating environment modules for Galaxy Toolshed tools"
sudo -E python toolshed_to_modules.py --force

# Add the default non-sudo account 'researcher'
sh setup_user.sh researcher