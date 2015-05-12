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
    @listener = TransportListener.new
    @h = Helper.new
    @h.exitMonitorOn
  end
  def run
    @listener.listen_to_reason
  end
end
r = Runit.new
r.run
