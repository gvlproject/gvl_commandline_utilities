gvl_commandline_utilities
=========================

Miscellaneous scripts useful for users of the GVL cloud images (CloudMan instances).

To use, launch a GVL instance ( http://launch.genome.edu.au/ ), ssh in as user ubuntu, and run

    git clone https://github.com/claresloggett/gvl_commandline_utilities
    cd gvl_commandline_utilities
    sh run_all.sh

This version of gvl_commandline_utilities is intended to run on GVL image v2.19 or later. 
Some of the scripts are dependent on the correct config hooks being available in 
/usr/nginx/conf/nginx.conf .

run_all.sh
----------

Run all other scripts with correct ordering and permissions.

Any utilities which need to be configured for all users will be configured.

An ordinary user account called "researcher" will be created for non-admin use, 
and configured with per-user utilities.

Usage:
    
    sh run_all.sh
    

toolshed_to_modules.py
----------------------

Look for the env.sh scripts used to set up the environment for Galaxy Toolshed-installed 
tools, and use these to create module files. The resulting modules can be accessed 
using environment module commands such as `module avail` (see 
http://modules.sourceforge.net/man/module.html). Different modules should be available for 
different installed versions of the same tool. 

If a Toolshed-installed tool is uninstalled from Galaxy, running this script should
clean up the module file.

Usage (show help):

    sudo -E python toolshed_to_modules.py -h

Requires superuser permissions, and makes use of environment variables specifying module 
locations.

configure_nginx.sh
------------------

Set up NGINX config file structure necessary to configure RStudio, public_html, and
IPython Notebook.

This script is intended to run on GVL image v2.19 or later. It assumes that the 
placeholder config files commandline_utilities_http.conf and 
commandline_utilities_https.conf have been configured into /usr/nginx/conf/nginx.conf .

Usage:

    sudo sh configure_nginx.sh

Requires superuser permissions. 

setup_rstudio.sh
----------------

Install and configure RStudio. This will create a group called rstudio_users, which
ordinary user accounts will be added to by setup_user.sh. RStudio will be available
at http://your-url/rstudio/

To use run:

    sudo setup_rstudio.sh
    
Requires superuser permissions. Assumes that configure_nginx.sh has been run.

setup_user.sh
-------------

Run all scripts below which apply to an individual user. This script can be run multiple 
times to create and configure multiple non-sudo user accounts. 

Currently it will create the account; create home-directory symlinks to reference genomes 
and to galaxy; create a public_html directory; and configure an ipython notebook profile 
to run securely over the web.

Usage:

    sh setup_user.sh <username>

setup_ipython_server.py
-----------------------

Configure an ipython notebook profile to run the ipython notebook server including 
password-protection and SSL encryption. The notebook server, when running, will be
available at http://your-url/ipython/

This script does not require sudo and can be run by an individual user to configure
IPython Notebook under their account. It should _not_ be run by the suduer account ubuntu, 
as it is dangerous to launch a notebook server from this account.

Usage (as the appropriate user):

    python setup_ipython_server.py

This script assumes that configure_nginx.sh has been run to set up the appropriate
port forwarding. Note that under the default config, only ONE user can run IPython
Notebook at any one time. More advanced configurations are possible which allow multiple
instances to be served up at different addresses or different ports.

add_public_html.sh
------------------

Create a public_html directory and redirect for the specified user. 

Usage:

    sudo sh add_public_html.sh <username>

Requires superuser permissions. Assumes that configure_nginx.sh has been run.

