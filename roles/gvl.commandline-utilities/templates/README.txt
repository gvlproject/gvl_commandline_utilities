Welcome to your account on this GVL instance. The public IP address of your instance at
the time of account creation appears to be {{ ip_address }} .

The following utilities should now be configured for user {{ new_user }}:

--

Galaxy-installed reference genomes, as well as genome indices created by Galaxy-installed
tools, can be found via the symlink ~/galaxy_genomes . Unless configured otherwise, this
directory tree will be mounted using a shared filesystem and therefore be read-only.

--

The Galaxy application directory can be found via the symlink ~/galaxy .

--

Galaxy datasets can be mounted and read directly using the galaxy-fuse.py
script in this directory. To do this you will need your Galaxy API key, found by
logging into Galaxy at http//{{ ip_address }}/ and selecting the menu option
User -> API Keys. You can mount your Galaxy datasets using a command like

    python galaxy-fuse.py <api-key> &

This puts the galaxy-fuse process into the background. Galaxy Datasets will then
appear as read-only files, organised by History, by default under the directory
galaxy_files.

--

A web-accessible folder can be found at ~/public_html . Any files you place in this
directory will be _publicly_ accessible at

    http://{{ ip_address }}/public/{{ new_user }}/<filename>

--

An IPython Notebook profile has been created for running a password-protected notebook
server over the web. You can launch this by changing to your working directory and running

    ipython notebook --profile={{ ipython_profile }}

If you want the server to run while you are logged out, you may want
to enter a screen session first by running `screen`. The next time you log in,
you can reconnect to it using `screen -r`.

To access the running ipython notebook, point your browser to:

    http://{{ ip_address }}/ipython/

You will need the password you entered during setup.

Anyone who knows the password to your notebook server will be able to execute
arbitrary code under your account, so keep this password private. You should treat
it as you would your ssh login credentials.

Under the default configuration, only ONE user can run IPython Notebook at a time.
If you have multiple users, you may want to alter your config.

--

If you are seeing this file, then under most circumstances RStudio will be installed
on this instance and available at

    http://{{ ip_address }}/rstudio/

You can log in using the same credentials as this linux account, i.e. your
RStudio username is {{ new_user }}.

--

Tools installed as part of CloudBioLinux will be in the usual locations for binaries,
and usually already in your path.

Tools installed by the Galaxy Toolshed will not be in your path and multiple versions
of some tools may be available. If you are seeing this file, then under most circumstances,
environment modules (http://modules.sourceforge.net/) will have been created for Galaxy
Toolshed tools. You can see available Toolshed-installed tools by running

    module avail

--

To carry out admin actions, you will need to su to a sudoer account such as ubuntu.

Consult http://genome.edu.au/ for further documentation on GVL instances and
https://github.com/gvlproject/gvl_commandline_utilities for further documentation
on the configuration of the convenience utilities listed above.
