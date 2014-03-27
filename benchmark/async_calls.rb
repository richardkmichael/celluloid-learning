require 'celluloid'
require 'celluloid/autostart'

class TimeKeeper
  include Celluloid

  def time
    @time = Time.now
  end
end

require 'benchmark'

time_keeper = TimeKeeper.new

# Try to mitigate allocation effects.
n = 1000000
Benchmark.bmbm do |x|
  x.report('timer_keeper.time')       { n.times do ; time_keeper.time       ; end }
  x.report('timer_keeper.async.time') { n.times do ; time_keeper.async.time ; end }
end


#   $ bundle exec ruby async_calls.rb
#   Rehearsal -----------------------------------------------------------
#   timer_keeper.time        37.687000   2.776000  40.463000 ( 27.904902)
#   timer_keeper.async.time   3.926000   0.146000   4.072000 (  2.108122)
#   ------------------------------------------------- total: 44.535000sec

#                                 user     system      total        real
#   timer_keeper.time        56.710000   2.853000  59.563000 ( 49.060505)
#   timer_keeper.async.time   2.939000   0.135000   3.074000 (  1.802373)
#   D, [2014-03-27T10:32:45.683494 #14752] DEBUG -- : Terminating 5 actors...
