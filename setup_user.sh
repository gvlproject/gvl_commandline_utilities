
# Add a new (non-sudo) user and do per-user config of convenience utilities.

# This is now just a wrapper around ansible, provided for back-compatibility.

# Usage: sh setup_user.sh [-s] username

# Silent mode (-s) is equivalent to use_ubuntu_password=yes (the playbook default)
# Non-silent mode is equivalent to use_ubuntu_password=no and will prompt for
# a password.
# Non-silent mode is the default in this wrapper script for back-compatibility.

# Note that if you want to set a separate password for the new user, you can
# specify -e "use_ubuntu_password=no" on the ansible-playbook command line.

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project

username=$1

silent_mode=false

# Parse command line arguments
while getopts ":s" opt; do
  case $opt in
    s)
       silent_mode=true
      ;;
  esac
done
shift $(($OPTIND-1))

username=$1

if [ "$silent_mode" = true ] ; then
    sudo ansible-playbook playbook.yml --tags "setup_user" -e "new_user=$1"
else
    sudo ansible-playbook playbook.yml --tags "setup_user" -e "new_user=$1" -e "use_ubuntu_password=no"
fi
