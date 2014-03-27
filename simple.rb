puts "Ruby: #{RUBY_ENGINE}, #{RUBY_VERSION}, ENV Ruby: #{ENV['RUBY_VERSION']}"

require 'bundler/setup'
require 'pry'

require 'celluloid/autostart'
require 'celluloid/probe'

log_file = './celluloid.log'
File.delete log_file if File.exists? log_file

# Celluloid.logger = ::Logger.new log_file
Celluloid.logger = ::Logger.new STDOUT

# If debugging with Pry, let Celluloid linger.
# Celluloid.shutdown_timeout = 3600

class UselessActor

  include Celluloid
  include Celluloid::Logger

  def crash_me
    raise Error
  end

  def log_me
    info "A log message from UselessActor! Process: #{Process.pid}"
  end
end

# UselessActor.new.crash_me
u = UselessActor.new
u.log_me
# u.crash_me
# binding.pry

sleep

# class AnotherUselessActor

#   include Celluloid
#   include Celluloid::Logger

#   attr_accessor :value

#   def initialize value
#     @value = value
#   end

#   def log_me
#     info "A log message from AnotherUselessActor! Process: #{Process.pid}"
#   end
# end

# a = AnotherUselessActor.new 1
# a.log_me
# sleep
