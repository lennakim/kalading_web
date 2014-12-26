root = "/home/deployer/projects/kalading_web"

working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.kalading.sock"
worker_processes 2
timeout 30

