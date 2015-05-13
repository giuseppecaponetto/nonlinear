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
    @listener = TransportListener.new(32)
    @h = Helper.new
    @h.exitMonitorOn
  end
  #starts the listener and runs it for 200 sec then stops it
  #plays a note every quarter beat if play/continue is presed.
  #stops if stop is pressed but continues listening for transport controls.
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
