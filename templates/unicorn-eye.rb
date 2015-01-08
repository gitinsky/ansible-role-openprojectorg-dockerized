Eye.application 'openproject' do
  working_dir '/home/openproject/openproject'
  stdall '/var/eye/log/eye-stdall.log' # stdout,err logs for processes by default
  env 'APP_ENV' => 'production' # global env for each processes
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  # Unicorn
  process :unicorn do
    pid_file '/home/openproject/openproject/tmp/pids/unicorn.pid'
    env 'RAILS_ENV' => 'production'
    pre_start_command '/root/install.sh'
    start_command "sudo -i -u openproject bash -c \"source /etc/profile.d/rvm.sh && cd /home/openproject/openproject && bundle exec unicorn_rails -D -E production -c ./config/unicorn.rb\""
    stop_command 'kill -QUIT {PID}'
    restart_command 'kill -USR2 {PID}'
    stdall '/home/openproject/openproject/log/unicorn-stdall.log'

    start_timeout 30.seconds
    stop_timeout 5.seconds

#    monitor_children do
#      restart_command 'kill -2 {PID}' # for this child process
#      check :memory, below: 300.megabytes, times: 3
#    end
  end
end
