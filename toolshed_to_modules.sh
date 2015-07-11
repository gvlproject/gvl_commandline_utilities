# Run or re-run toolshed_to_modules.py to update environment modules
# from Galaxy Toolshed tools.
# Modules corresponding to uninstalled tools should be deleted by this process.

# This is now just a wrapper around ansible, provided for back-compatibility.

# Usage: sh toolshed_to_modules.sh

# Clare Sloggett, VLSCI, University of Melbourne
# Authored as part of the Genomics Virtual Laboratory project


sudo ansible-playbook playbook.yml --tags "toolshed_modules"
