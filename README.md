gvl_commandline_utilities
=========================

Miscellaneous scripts useful for users of the GVL cloud images (CloudMan instances).

run_all.sh
----------

Run all other scripts with correct ordering and permissions.

toolshed_to_modules.py
----------------------

Look for the env.sh scripts used to set up the environment for Galaxy Toolshed-installed 
tools, and use these to create module files. The resulting modules can be accessed 
using environment module commands such as `module avail` (see 
http://modules.sourceforge.net/man/module.html). Different modules should be available for 
different installed versions of the same tool. 

If a Toolshed-installed tool is uninstalled from Galaxy, running this script should
clean up the module file.

For usage run
    python toolshed_to_modules.py -h
    
Requires superuser permissions.

setup_ipython_server.py and setup_nginx_forwarding.sh
-----------------------------------------------------

Configure an ipython profile to run the ipython notebook server, and configure SSL
encryption and port forwarding in NGINX to access this server.

These scripts will not create correctly-working port forwarding on GVL images as they 
require NGINX >= 1.3.13 .

setup_nginx_forwarding.sh requires superuser permissions.

add_research_user.sh
--------------------

Currently unused. Create a non-sudo account called 'researcher'.
