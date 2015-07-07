
# Add a new (non-sudo) user and do per-user config of convenience utilities.

# This is now just a wrapper around ansible, provided for back-compatibility.

# Note that if you want to set a separate password for the new user, you can
# specify -e "use_ubuntu_password=no" on the ansible-playbook command line.

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project

username=$1

sudo ansible-playbook playbook.yml --tags "setup_user" -e "new_user=$1"
