
require_relative '../lib/Helper.rb'

h = Helper.new
h.exitMonitorOn

require "unimidi"

# Sends an inspection of the first 10 messages messages that input receives to standard out
num_messages = 3

# get the first available midi driver
input = UniMIDI::Input.use(:first)

puts "waiting some MIDI input now..."

while true
    m = input.gets
  if m[0][:data][0] == 250
    puts "PLAY pressed!" +"-----> "+ m[0].to_s  #puts a message if play is pressed on the DAW.
  end
  if m[0][:data][0] == 252 
    puts "STOP pressed!" +"-----> " + m[0].to_s
  end
  if m[0][:data][0] == 251 
    puts "CONTINUE pressed!"+"-----> "+ m[0].to_s
  end
  if m[0][:data][0] == 242 
    puts "POSITIONING pressed!"+"-----> "+ m[0].to_s
  end
end

puts "finished"