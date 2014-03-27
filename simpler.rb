require 'bundler/setup'
require 'celluloid/autostart'
require 'celluloid/probe'

Celluloid.logger = ::Logger.new './celluloid.log'

class UselessActor
  include Celluloid
end

class MonitoringActor
  include Celluloid
  include Celluloid::Logger
  include Celluloid::Notifications

  def initialize
    subscribe(/#{Celluloid::Probe::NOTIFICATIONS_TOPIC_BASE.chomp('%s')}/, :write_message)
    # subscribe(/celluloid\.events\..+/, :write_message)
  end

  def write_message message, args
    info "#{message} #{args}"
  end
end

m = MonitoringActor.new
Celluloid::Probe.run

p = UselessActor.new # Expect a MONITORING message about the Actor creation.

sleep
