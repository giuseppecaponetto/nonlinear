require_relative '../lib/MidiListener.rb'
#rememer to set the output buffer to at least 10ms in the daw
ml = MidiListener.new
ml.listen