require "unimidi"
require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'

class MidiListener
  
  def initialize(clock)
    @clock = clock
    @logger = MyLogger.instance
    @translator = MidiTranslator.new
    @stop = false
    @input = UniMIDI::Input.use(:first)
  end
  
  def action
    @logger.debug("Enetered in MidiListener's 'action' method")
    @clock.run
  end
  
  def listen
    @logger.debug("Waiting for play/start message from sequencer..")
    message_1 = @translator.translate(@input.gets)
    while message_1 != "play"
      message_1 = @translator.translate(@input.gets)
    end
    @logger.debug("Play/start message received from sequencer..")
    action
  end
  
end


