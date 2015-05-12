require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Input.rb'
require_relative '../lib/MockSequencer.rb'
require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/TransportListener.rb'
require_relative '../lib/Clock.rb'

class Runit
  def initialize
    @clock = Clock.new
    @l = MyLogger.instance
    @l.info("Enter 'exit' and press return to quit the example.")
    @listener = TransportListener.new
    @h = Helper.new
    @h.exitMonitorOn
  end
  #starts the listener and runs it for 5 sec then stops it
  #simulates a clock @ 120 bpm
  #simulates a 2 second pause in wich the listener sould be off
  #repeats the steps above
  def run
    @listener.listen_to_reason
    @clock.start
    sleep(5)
    @clock.stop
    @listener.stop_listening
    sleep(3)
    @listener.listen_to_reason
    @clock.start
    sleep(5)
    @clock.stop
    @listener.stop_listening
  end
  def quit_message
    @l.debug("Nonlinear terminated. Goodbye.")
  end
end
r = Runit.new
r.run
r.quit_message
