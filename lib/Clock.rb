require 'topaz'
require_relative '../lib/MockSequencer.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Output.rb'
require 'singleton'
class Clock
  include Singleton
  def initialize(input=UniMIDI::Input.use(:first))
    @output = Output.instance.output
    @logger = MyLogger.instance
    @input = input
    @sequencer = MockSequencer.new
    @clock = nil
  end  
  def run
    @clock = Topaz::Tempo.new(@input, :interval => 8) do #:interval => 8 for a higher resolution
      @sequencer.step #prints some info
      @output.puts(144, 38, 100)
      @output.puts(128, 38, 100)
    end
    @clock.start(:background => true)
  end
  def stop
    @clock.stop{true}
    @clock = nil
    @sequencer.reset
    GC.start
  end
end