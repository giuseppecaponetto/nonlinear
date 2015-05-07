require 'topaz'
require 'unimidi'
require_relative '../lib/Helper.rb'

class Sequencer
  def step
    @i ||= 0
    p "step #{@i+=1}"
  end
end

class Example1
  
  def initialize
    @sequencer = Sequencer.new
    @input = UniMIDI::Input.use(:first)
  end
  
  def listen
    puts'waiting for midi input..enter "exit" to quit.'
    @midiclock = Topaz::Clock.new(@input, :midi_transport =>true)do
      @sequencer.step
    nil
  end
  end
  
  def start
    @midiclock.start
  end
  def stop
    @midiclock.trigger.stop{true == true}
  end
  
end
h = Helper.new
h.exitMonitorOn
e=Example1.new
e.listen
e.start
