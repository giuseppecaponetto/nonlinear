require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Input.rb'
require_relative '../lib/MockSequencer.rb'
require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/TransportListener.rb'

require 'topaz'

class Runit
  def initialize
    @listener = TransportListener.new
    @sequencer = MockSequencer.new
    @h = Helper.new
    @h.exitMonitorOn
    @l = MyLogger.instance
    @l.info("Enter 'exit' and press return to quit the example.")
    @listener.run
   end
end
r = Runit.new