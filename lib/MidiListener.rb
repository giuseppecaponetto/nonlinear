require "unimidi"
require_relative '../lib/MidiTranslator.rb'

class MidiListener
  
  def initialize()
    @translator = MidiTranslator.new
    @stop = false
    @input = UniMIDI::Input.use(:first)
  end
  
  def action
    puts "sequencer now playing or recording.."
  end
  
  def listen
    puts "waiting for sequencer to play.."
    message_1 = @translator.translate(@input.gets)
    while message_1 != "play"
      message_1 = @translator.translate(@input.gets)
    end
    action
  end
  
  def stop
    @stop = true
  end
  
end


