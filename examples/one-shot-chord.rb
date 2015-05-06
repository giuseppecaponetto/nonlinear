require 'midi-message'
require 'unimidi'
require 'topaz'
require 'helper'

#asks the user to select the midi driver
#output = UniMIDI::Output.gets

#selects the first availapble midi driver

output = UniMIDI::Output.use(:first) 

duration = 0.5 #in seconds

m = MicroMIDI.message
    start = Time.now
    msgs = m.play ["C0", "E1", "G2"], 0.5

output.puts(msgs)
