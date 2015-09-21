# Configuration file for jupyterhub.

#------------------------------------------------------------------------------
# Configurable configuration
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# JupyterHub configuration
#------------------------------------------------------------------------------

# An Application for starting a Multi-User Jupyter Notebook server.


# The public facing ip of the proxy
c.JupyterHub.ip = '127.0.0.1'

# The ip for the proxy API handlers
c.JupyterHub.proxy_api_ip = '127.0.0.1'

# The public facing port of the proxy
c.JupyterHub.port = 9510

# The base URL of the entire application
c.JupyterHub.base_url = '/jupyterhub'

# The ip for this process
c.JupyterHub.hub_ip = '127.0.0.1'

# put the log file in /var/log
c.JupyterHub.extra_log_file = '/var/log/jupyterhub.log'

#------------------------------------------------------------------------------
# Spawner configuration
#------------------------------------------------------------------------------

# The IP address (or hostname) the single-user server should listen on
c.Spawner.ip = '127.0.0.1'

#------------------------------------------------------------------------------
# Authenticator configuration
#------------------------------------------------------------------------------

# A class for authentication.
#
# The API is one method, `authenticate`, a tornado gen.coroutine.

# set of usernames of admin users
#
# If unspecified, only the user that launches the server will be admin.
c.Authenticator.admin_users = {'root', 'ubuntu'}