require "micromidi"

# This example sends some messages to an output selected by the user

output = UniMIDI::Output.gets

MIDI.using(output) do 
  note "C5"
  cc 5, 120
  play "C3", 3
end