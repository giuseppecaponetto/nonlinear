require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Input.rb'
require_relative '../lib/MockSequencer.rb'
require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/TransportListener.rb'
require_relative '../lib/Clock.rb'

class Runit
  def initialize
    @l = MyLogger.instance
    @l.info("Enter 'exit' and press return to quit the example.")
    @listener = TransportListener.new(false, 6)
    @h = Helper.new
    @h.exitMonitorOn
  end
  #starts the listener and runs it for 200 sec then stops it
  #simulates a clock @ 120 bpm
  #logs any transport controls pressed on reason.
  def run
    @listener.listen_to_reason
    sleep(200)
    @listener.stop_listening
  end
  def quit_message
    @l.debug("Nonlinear terminated. Goodbye.")
  end
end
r = Runit.new
r.run
r.quit_message
