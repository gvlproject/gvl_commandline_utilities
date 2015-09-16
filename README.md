# gvl_commandline_utilities

Scripts useful for users of GVL cloud images (CloudMan instances).
These scripts configure GVL instances as command-line bioinformatics platforms, including RStudio and IPython Notebook (through JupyterHub) setup.

## How to run these scripts

To use, launch a GVL instance ( [instructions here](https://docs.google.com/document/d/1uYKWZckyR8kZSY6viECMJsGSTaNsS2nVMj5n_YYzxGY/pub) ), ssh in as user ubuntu, and run

    git clone https://github.com/gvlproject/gvl_commandline_utilities
    cd gvl_commandline_utilities
    sh run_all.sh

This version of gvl_commandline_utilities is intended to run on GVL image 4.0 or later.

You can run these scripts as an ansible playbook, which gives the most flexibility. Basic usage:

    ansible-playbook playbook.yml

Available playbook tags:
  - `setup_user` : do not bother to rerun global config, just create and configure a new user account
  - `toolshed_modules` : just rerun toolshed_to_modules.py

These tags are wrapped in `setup_user.sh` and `toolshed_to_modules.sh` for
backwards-compatibility.

Available variables can be found in `roles/gvl.commandline-utilities/defaults/` .
Notable variables are:
  - `new_user` : the username of the account to be created or reconfigured
  - `use_ubuntu_password` (default is `use_ubuntu_password=yes`) : use the ubuntu/CloudMan password as the new user's password. This mode will not prompt for a password. `use_ubuntu_password=no` is more secure.

Several convenience scripts are provided for backwards-compatibility. These are just
wrappers around ansible. These are:
* `run_all.sh` : configure your instance for command-line use and install services.
* `setup_user.sh` : after running `run_all.sh`, can be run again to configure additional user accounts. This is a wrapper around `--tags "setup_user"`.
* `toolshed_to_modules.sh` : after running `run_all.sh`, can be run again to update module files. This is useful if tools have been added or removed using the Galaxy Toolshed. This is a wrapper around `--tags "toolshed_modules"`.

## How to use installed features

Running `run_all.sh` will create a non-sudo account called "researcher", with various services configured.
It is more secure and convenient to use the researcher account for ordinary research activities, but
to carry out admin actions, you will need to use a sudoer account such as ubuntu.

To access the below features, the best way is to log out of the ubuntu account and ssh in as user researcher. Alternatively if you are already logged in as ubuntu, you can run

    su - researcher
    script /dev/null

(The script command will allow you to use screen after running su.)

You can then find documentation on most of the features described on this page by examining the
README.txt file in your home directory:

    less ~/README.txt

To access specific services, including those that come pre-installed on GVL instances:

**CloudMan** is already installed, without running these scripts.
It is accessible at

    http://<your-ip-address>/cloud

**VNC, for remote desktop access** is already installed, without running these scripts.
It is accessible at

    http://<your-ip-address>/vnc

**Galaxy** is already installed, without running these scripts. The Galaxy application directory
can be found via the symlink `~/galaxy`, and Galaxy is accessible at

    http://<your-ip-address>/

**Galaxy-installed reference genomes**, as well as genome indices created by Galaxy-installed
tools, can be accessed by command-line users via the symlink `~/galaxy_genomes` .
Unless configured otherwise, this directory tree will be mounted using a shared filesystem and
therefore read-only.

**Galaxy Datasets** can be mounted for direct read access using the galaxy-fuse script,
which can be found in your home directory at `~/galaxy-fuse.py`. You will need your Galaxy API key,
found by logging into Galaxy and selecting the menu option User -> API Keys.
To use, run

    python galaxy-fuse.py <api-key> &

This puts the galaxy-fuse process into the background. After running the above command,
Galaxy Datasets will appear as read-only files, organised by History, by default under
the directory `galaxy_files`.

See the notes on the `galaxy-fuse.py` script below for caveats.

A per-user **web-accessible folder** can be found at `~/public_html` . Any files you place in this
directory will be _publicly_ accessible at

    http://<your-ip-address>/public/researcher/<filename>

If you create extra user accounts using `setup_user.sh`, each account will get a similar folder which redirects
to a URL as above, with `researcher` replaced by the relevant username.

**RStudio** is accessible at

    http://<your-ip-address>/rstudio/

You can log into RStudio with username "researcher" and the corresponding linux password.
Any other linux accounts created by running `setup_user.sh` will similarly have RStudio accounts.

**JupyterHub**, a multi-user IPython notebook server, has been installed and will be available at

    http://{{ ip_address }}/jupyterhub/

You can log into JupyterHub with username "researcher" and the corresponding linux password.
Any other linux accounts created by running `setup_user.sh` will similarly have JupyterHub accounts.

Anyone who knows the password to your JupyterHub server will be able to execute
arbitrary code under your account, so keep this password private. You should treat
it as you would your ssh login credentials.

**Tools installed as part of CloudBioLinux** will be in the usual locations for binaries,
and usually already in your path.

**Tools installed by the Galaxy Toolshed** will not be in your path and multiple versions
of some tools may be available. Environment modules (http://modules.sourceforge.net/) have been created
and will give access to most installed Galaxy Toolshed tools. You can see available Toolshed-installed
tools by running

    module avail

Refer to the `module` documentation for instructions on loading, viewing and unloading modules.
If Toolshed tools have been added or removed, rerunning the relevant ansible task using `toolshed_to_modules.sh` will update the environment modules.

Consult http://www.genome.edu.au/ for further documentation on GVL instances.

### galaxy-fuse.py

This script is in `roles/gvl.commandline-utilities/files/` and will be copied to the home directory of each ordinary user, e.g. to
`~researcher/galaxy-fuse.py`. It is *not* currently called as part of the setup process.

To use this, you should log in as an ordinary user (e.g. `researcher`). You will
need your Galaxy API key, found by logging into Galaxy and selecting the menu
option User -> API Keys. You can mount your Galaxy Datasets using a command like

    python galaxy-fuse.py <api-key> &

This puts the galaxy-fuse process into the background. After running the above command,
Galaxy Datasets will appear as read-only files, organised by History, by default under
the directory `galaxy_files`.

Note that:
* Galaxy Datasets will be read-only, since writing to them directly is not supported
by the Galaxy API
* Datasets with non-unique names will have the Dataset ID appended to disambiguate them
* History or Dataset names containing a slash (/) are escaped to '%-'

galaxy-fuse was originally written by Dr David Powell and began life at
https://github.com/drpowell/galaxy-fuse .
