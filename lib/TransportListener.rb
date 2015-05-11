require "unimidi"
require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Clock.rb'
require_relative '../lib/Input.rb'
require 'observer'

class TransportListener
  def initialize(input=Input.instance.input)
    @logger = MyLogger.instance
    @logger.debug("Started listening for transport control..")
    @translator = MidiTranslator.new
    @input = input
    @clock = nil
  end
  
  def listen_to_reason
    loop do
      log_all_messages
    end
  end
  
  def log_raw_midi
    @logger.debug(@translator.throu(@input.gets))
  end
  
  def log_all_messages
    @translator.translate(@input.gets)
    message = @translator.buffer
    message.each_index do 
    |index|
    if (message[index] != "clock")&&(message[index] != "unknown")
      @logger.debug("Buffer depth: #{index}, Message: #{message[index]}")
    end
    if message[index]=="start"
      @clock = Clock.instance
      @clock.run
      GC.start
    elsif message[index]=="continue"
      GC.start
    elsif message[index]=="stop"
      @clock.stop
      GC.start
    end
    end
  end    
end
