require 'topaz'
require_relative '../lib/Sequencer.rb'
require_relative '../lib/BpmCounter.rb'

input = UniMIDI::Input.use(:first) # select the first midi input
sequencer = Sequencer.new
bpmcounter = BpmCounter.new
clock = Topaz::Clock.new(input, :midi_transport => true) do
  bpmcounter.update
  sequencer.step
  puts sequencer.stepcounter.to_s + ' --- @ ' + bpmcounter.bpm.to_s   + ' bpm'
end

puts 'Waiting for MidiCLock input..'
clock.start

 