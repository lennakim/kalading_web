root = "/home/deployer/apps/kaladingcom/current"

working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.kalading.sock"
worker_processes 1
timeout 30

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end

preload_app true

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
    defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|

  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
