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

# The port for the proxy API handlers
c.JupyterHub.proxy_api_port = 10000

# The public facing port of the proxy
c.JupyterHub.port = 9510

# The base URL of the entire application
c.JupyterHub.base_url = '/jupyter'

# The ip for this process
c.JupyterHub.hub_ip = '127.0.0.1'

# The port for this process
c.JupyterHub.hub_port = 9581

# Jupyterhub's log file is created by upstart in /var/log/upstart/jupyterhub.log
#c.JupyterHub.extra_log_file = '/var/log/jupyterhub.log'

c.JupyterHub.log_level = 'WARN'

#------------------------------------------------------------------------------
# Spawner configuration
#------------------------------------------------------------------------------

# The IP address (or hostname) the single-user server should listen on
c.Spawner.ip = '127.0.0.1'

#------------------------------------------------------------------------------
# LocalProcessSpawner configuration
#------------------------------------------------------------------------------

# A Spawner that just uses Popen to start local processes.

c.LocalProcessSpawner.ip = '127.0.0.1'

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
