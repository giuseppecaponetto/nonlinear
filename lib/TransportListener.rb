require "unimidi"
require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Clock.rb'

class TransportListener
  def initialize(input=UniMIDI::Input.use(:first))
    @logger = MyLogger.instance
    @logger.debug("Started listening for transport control..")
    @thread = Fiber.new do
      loop do
        #get_messages_no_clock
        control_the_clock
        #get_all_messages
        #printRawMidi
      end
    end
    @translator = MidiTranslator.new
    @input = input
  end
  
  def printRawMidi
    @logger.debug(@translator.throu(@input.gets))
  end
  
  def run #mayebe should be called join.
     @logger.debug("You asked the listener fiber to run..")
     @thread.resume
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
  
  def control_the_clock
    @translator.translate(@input.gets)
    message = @translator.buffer
    message.each_index do 
    |index|
    if message[index] != "clock"
      @logger.debug("Processing message[#{index}]: #{message[index]}")
    end
    if message[index] == "stop"
      @logger.debug("Processing message[#{index}]: #{message[index]}")
      @clock.stop
    end
    if message[index] == "start"
      @logger.debug("Processing message[#{index}]: #{message[index]}")
      @clock = Clock.new
      @clock.run
    end
    end
  end
  
end
