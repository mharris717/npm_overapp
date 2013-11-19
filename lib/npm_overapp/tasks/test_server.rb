namespace :test_server do
  def test_server_dir
    "#{NpmOverapp.project_root_dir}/test_server"
  end

  def mkdir_fresh(dir)
    ec "rm -rf #{dir}" if FileTest.exist?(dir)
    ec "mkdir #{dir}"
  end

  task :build do
    mkdir_fresh(test_server_dir)
    ec "#{overapp} #{NpmOverapp.server_base_overlay} #{test_server_dir}"
  end

  def server_ps_lines
    `ps -ax | grep #{NpmOverapp.server_port}`.split("\n").reject { |x| x =~ /grep/ }
  end

  def server_pids
    server_ps_lines.map { |x| x.split(/\s/).first }
  end

  def start
    ec "cd #{test_server_dir} && rails server -p #{NpmOverapp.server_port}"
  end

  task :start do
    start
  end

  task :start_in_background do
    fork do
      start
    end
    sleep(5)
  end

  def kill_strays
    server_pids.each do |pid|
      ec "kill -s int #{pid}"
    end
  end

  task :kill_strays do
    kill_strays
  end
end