require 'midi-message'
require 'unimidi'

#asks the user to select the midi driver
output = UniMIDI::Output.gets

message = MIDIMessage::NoteOn.new(0, 64, 64)
output.puts(message)
