# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{deployer@115.28.84.90}
role :web, %w{deployer@115.28.84.90}
role :db,  %w{deployer@115.28.84.90}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server '115.28.84.90', user: 'deployer', roles: %w{web app db}

set :ssh_options, {
  # forward_agent: true,
  port: 25000
}

set :stage, :production
set :branch, 'master'
set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/kaladingcom"
set :rails_env, :production
set :unicorn_worker_count, 15
# config file
set :enable_ssl, false



# PUMA
# set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid,   "#{shared_path}/tmp/pids/puma.pid"
# set :puma_bind, "unix:///tmp/example.sock"
#根据nginx配置链接的sock进行设置，需要唯一
# set :puma_conf, "#{shared_path}/puma.rb"
# set :puma_access_log, "#{shared_path}/log/puma_error.log"
# set :puma_error_log, "#{shared_path}/log/puma_access.log"
# set :puma_role, :app
# set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
# set :puma_threads, [32, 256]
# set :puma_workers, 8
# set :puma_init_active_record, false
# set :puma_preload_app, true

after 'deploy:publishing', 'puma:restart'

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
