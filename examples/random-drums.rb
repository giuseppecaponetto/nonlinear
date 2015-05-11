require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Input.rb'
require_relative '../lib/MockSequencer.rb'
require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/TransportListener.rb'
require_relative '../lib/Clock.rb'

require 'topaz'

class Runit
  def initialize
    @l = MyLogger.instance
    @l.info("Enter 'exit' and press return to quit the example.")
    @listener = TransportListener.new
    @h = Helper.new
    @h.exitMonitorOn
    10.times do
      @listener.listen_to_reason
      @l.debug("Reinitializing listener")
      @listener = nil
      ObjectSpace.garbage_collect
      GC.start
      @listener = TransportListener.new
    end
   end
end
r = Runit.new
