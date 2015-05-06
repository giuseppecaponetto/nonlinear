require 'midi-message'
require 'unimidi'
require 'topaz'

#asks the user to select the midi driver
#output = UniMIDI::Output.gets

#selects the first availapble midi driver

@output = UniMIDI::Output.use(:first) 

@duration = 0.5 #in seconds

@message_1_on = MIDIMessage::NoteOn.new(0, 64, 64)
@message_1_off = MIDIMessage::NoteOff.new(0, 64, 64)
def play
@output.puts(@message_1_on)
sleep(@duration)
@output.puts(@message_1_off)
end

play