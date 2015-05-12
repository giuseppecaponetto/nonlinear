require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Clock.rb'
require_relative '../lib/Input.rb'

class TransportListener
  def initialize
    @logger = MyLogger.instance
    @logger.debug("Started listening for transport control messages...")
    @translator = MidiTranslator.new
    @input = Input.instance.input
    @clock = Clock.new
  end

  def listen_to_reason
    @thread = Thread.new do
      loop do
        @translator.update(@input.gets)
        log_raw_midi
        log_translated_midi
      end
    end
    @thread.join
  end
  
  private
  
  def log_raw_midi
    @translator.log_print_buffer
  end

  def log_translated_midi
    @translator.log_print_translated_buffer
  end
    
end
