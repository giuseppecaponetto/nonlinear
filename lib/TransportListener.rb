require "unimidi"
require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'

class TransportListener
  def initialize(input=UniMIDI::Input.use(:first))
    @thread = Thread.new do
      loop do
        p @input.gets
        @logger.debug("Received: #{getmessage}")
      end
    end
    @thread.priority=99
    @logger = MyLogger.instance
    @translator = MidiTranslator.new
    @input = input
  end
  
  def run
     @logger.debug("Listening to Reason 8 controls..")
     @thread.join
  end
  def getmessage
    message = @translator.translate(@input.gets)
  end
  
end
