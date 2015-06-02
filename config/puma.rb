#!/usr/bin/env puma

environment "production"
basedir = "/home/deployer/apps/kaladingcom/current"

bind  "unix:///tmp/kalading.sock"
pidfile  "#{basedir}/tmp/pids/puma.pid"
state_path "#{basedir}/shared/tmp/pids/puma.state"

workers 5
threads 16, 128
daemonize true

preload_app!
activate_control_app