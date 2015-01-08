WORK_DIR = "/home/openproject/openproject/"
PREFIX = ""
worker_processes 5
working_directory WORK_DIR
user "openproject"
preload_app true
timeout 480
#listen "#{WORK_DIR}/tmp/sockets/unicorn.sock", :backlog => 4096
listen "127.0.0.1:80", :backlog => 4096

pid "#{WORK_DIR}/tmp/pids/#{PREFIX}unicorn.pid"

stderr_path "#{WORK_DIR}/log/#{PREFIX}unicorn.stderr.log"
stdout_path "#{WORK_DIR}/log/#{PREFIX}unicorn.stdout.log"

before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = "#{WORK_DIR}/Gemfile"
end

before_fork do |server, worker|
  old_pid = "#{WORK_DIR}/tmp/pids/#{PREFIX}unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      #Process.kill("QUIT", File.read(old_pid).to_i)
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
