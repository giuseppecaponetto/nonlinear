require 'topaz'
require_relative '../lib/MockSequencer.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Output.rb'

class Clock
  def initialize(input=UniMIDI::Input.use(:first))
    @output = Output.new.output
    @logger = MyLogger.instance
    sequencer = MockSequencer.new
    @clock = Topaz::Tempo.new(input, :interval => 16) do #:interval => 8 for a higher resolution
      sequencer.step #prints some info
        r = Random.rand(36..38)
        @output.puts(144, r, 100)
        @output.puts(128, r, 100)
    end
  end  
  def run
    @clock.start
  end
  def stop
    @clock.stop
  end
end