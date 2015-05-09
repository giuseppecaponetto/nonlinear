require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Output.rb'
require_relative '../lib/MidiListener.rb'
require_relative '../lib/Clock.rb'



def setup
  output = Output.new()
  clock = Clock.new(120)
  midilistener = MidiListener.new(clock)
  midilistener.listen
end

setup
