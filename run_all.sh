
# Master script: run all scripts with necessary permissions.
# This script will create a non-sudo user called "researcher"
# which should be used for research and non-admin tasks.

# This is now just a wrapper around ansible, provided for back-compatibility.

# Usage: sh run_all.sh [-s]

# Silent mode (-s) is equivalent to use_ubuntu_password=yes (the playbook default)
# Non-silent mode is equivalent to use_ubuntu_password=no and will prompt for
# a password.
# Non-silent mode is the default in this wrapper script for back-compatibility.

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project

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

# Call the master playbook
if [ "$silent_mode" = true ] ; then
    sudo ansible-playbook playbook.yml
else
    sudo ansible-playbook playbook.yml -e "use_ubuntu_password=no"
fi
