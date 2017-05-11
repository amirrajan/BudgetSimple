require 'readline'
require 'pty'
require 'open3'
require 'find'
require 'FileUtils'

first_time = true

Signal.trap('INT') do
  puts ''
  puts '============================'
  puts 'SIGINT has to be disable because sometimes repl/rerun sends it here. Yes I agree this is silly.'
  puts "run `kill -9 #{Process.pid}` or press enter to exit."
  puts '============================'
end

def delete_nosync_files
  Find.find('.')
      .find_all { |f| f =~ /dat/ && f =~ /nosync/ }
      .each do |f|
        begin
          FileUtils.rm(f)
        rescue
        end
      end
end

Signal.trap('SIGUSR1') do
  if first_time
    first_time = false
  else
    `pgrep repl`.each_line { |l| Process.kill('INT', l.to_i) }
    delete_nosync_files
    run_rake
  end
end

def run_rake
  PTY.spawn('rake ios:device') do |stdout, stdin, _|
    stdin.puts 'do_live_reload'
    Thread.new do
      loop do
        stdout.each { |line| print line }
        sleep 1
      end
    end
  end
end

PTY.spawn("rerun \"kill -30 #{Process.pid}\" --no-notify") do |stdout, _, _|
  Thread.new do
    loop do
      stdout.each { |line| print line if line !~ /Failed/ }
      sleep 1
    end
  end
end

Readline.readline('Touch file to reload. Press enter to exit.', true)
