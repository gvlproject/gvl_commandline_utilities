gvl_commandline_utilities
=========================

Miscellaneous scripts useful for users of the GVL cloud images (CloudMan instances).

run_all.sh
----------

Run all other scripts with correct ordering and permissions.
Also installs any missing dependencies and creates symlink to genomes directory.

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

Configure an ipython profile to run the ipython notebook server including 
password-protection and SSL encryption.

We temporarily set up direct port access rather than port forwarding. This 
should be updated when we have NGINX >= 1.3.13 installed. 

setup_nginx_forwarding.sh requires superuser permissions but is currently unused.

add_research_user.sh
--------------------

Currently unused. Create a non-sudo account called 'researcher'.
