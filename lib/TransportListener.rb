require "unimidi"
require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Clock.rb'
require_relative '../lib/Input.rb'

class TransportListener
  def initialize(input=Input.instance.input)
    @logger = MyLogger.instance
    @logger.debug("Started listening for transport control..")
    @translator = MidiTranslator.new
    @input = input
    @clock = Clock.instance
  end
  
  def listen_to_reason
    @thread = Thread.new do
      loop do
         log_all_messages
      end
    end
    @thread.join
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
      @logger.debug("Reason sent a #{message[index]} message..")
      @clock.run
    elsif message[index]=="continue"
      @logger.debug("Reason sent a #{message[index]} message..")
      @clock.run
    elsif message[index]=="stop"
      @logger.debug("Reason sent a #{message[index]} message..")
      Thread.kill(@thread)
      @clock.stop
      GC.start
    end
    end
  end    
end
