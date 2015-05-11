require "unimidi"
require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'

class TransportListener
  def initialize(input=UniMIDI::Input.use(:first))
    @thread = Thread.new do
      loop do
        get_messages_no_clock
        #get_all_messages
        #printRawMidi
      end
    end
    @thread.priority=99
    @logger = MyLogger.instance
    @translator = MidiTranslator.new
    @input = input
  end
  
  def printRawMidi
    @logger.debug(@translator.throu(@input.gets))
  end
  
  def run
     @logger.debug("Listening to Reason 8 controls..")
     @thread.join
  end
  def get_all_messages
    @translator.translate(@input.gets)
    message = @translator.buffer
    message.each_index do 
    |index|
    @logger.debug("Buffer depth: #{index}, Message: #{message[index]}")
    end
  end
  def get_messages_no_clock
    @translator.translate(@input.gets)
    message = @translator.buffer
    message.each_index do 
    |index|
    if message[index] != "clock"
      @logger.debug("Buffer depth: #{index}, Message: #{message[index]}")
    end
    end
  end
  
end
