# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{deployer@121.42.155.108}
role :web, %w{deployer@121.42.155.108}
role :db,  %w{deployer@121.42.155.108}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server '121.42.155.108', user: 'deployer', roles: %w{web app db}

set :ssh_options, {
  forward_agent: true,
  password: 'kalading'
  # port: 25000
}

set :stage, :staging
set :branch, 'new'
set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/kaladingcom"
set :rails_env, :staging
set :unicorn_worker_count, 1
# config file
set :enable_ssl, false


after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:legacy_restart'
  end
end


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
