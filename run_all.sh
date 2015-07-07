
# Master script: run all scripts with necessary permissions.
# This script will create a non-sudo user called "researcher"
# which should be used for research and non-admin tasks.

# This is now just a wrapper around ansible, provided for back-compatibility.

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project

sudo ansible-playbook playbook.yml
