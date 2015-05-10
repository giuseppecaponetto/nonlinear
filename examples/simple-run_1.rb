require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Input.rb'
require_relative '../lib/MockSequencer.rb'
require 'topaz'

class Runit
  def initialize
    @sequencer = MockSequencer.new
    @h = Helper.new
    @h.exitMonitorOn
    @l = MyLogger.instance
    @l.info("Enter 'exit' and press return to quit the example.")
    @input = UniMIDI::Input.use(:first)
    @output = UniMIDI::Output.use(:first)
    @timer = Topaz::Clock.new(@input, :midi_transport => true) do
      puts "step: #{@sequencer.step} @ #{@timer.tempo}"
      playnote
    end
    @timer.start
  end
  
  def playnote
    @fiber = Fiber.new do
    @output.puts(0x90, 36, 100) # note on
    sleep(0.1) # wait
    @output.puts(0x80, 36, 100) # note off
    end
    @fiber.resume
  end
  
end
r = Runit.new