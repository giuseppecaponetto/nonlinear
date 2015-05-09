require_relative '../lib/MidiListener.rb'
require_relative '../lib/Clock.rb'
require 'unimidi'
#rememer to set the output buffer to at least 10ms in the daw
ml = MidiListener.new(Clock.new(120, UniMIDI::Output.use(:first)))
ml.listen