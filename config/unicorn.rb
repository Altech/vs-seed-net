# -*- coding: utf-8 -*-
worker_processes 2
working_directory '/home/ec2-user/vs-seed-net'

listen '/tmp/unicorn.sock'
pid '/tmp/unicorn.pid'

timeout 60

preload_app true # ダウンタイムをなくす

stdout_path '/home/ec2-user/vs-seed-net/log/unicorn.stdout.log'
stderr_path '/home/ec2-user/vs-seed-net/log/unicorn.stderr.log'

GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
    if old_pid != server.pid
      begin
        sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
        Process.kill(sig, File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
    end

    sleep 1
  end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
