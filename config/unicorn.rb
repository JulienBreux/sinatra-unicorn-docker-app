app_dir = "/usr/src/app"

worker_processes 1

working_directory app_dir

pid "#{app_dir}/tmp/unicorn.pid"

listen 8080, tcp_nopush: true
timeout 30
