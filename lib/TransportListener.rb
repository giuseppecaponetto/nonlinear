require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Clock.rb'
require_relative '../lib/Input.rb'

class TransportListener
  def initialize
    @exit = false
    @listening = false
    @logger = MyLogger.instance
    @logger.debug("Started listening for transport control messages...")
    @translator = MidiTranslator.new
    @input = Input.instance.input
  end
  
  def stop_listening
    @logger.debug("Reason control message listener stopping..")
    @exit = true
    @listening = false
  end

  def listen_to_reason
    @logger.debug("Reason control message listener starting..")
    @exit = false
    @listening = true
    @thread = Thread.new do
      loop do
        @translator.update(@input.gets)
        #log_raw_midi
        #log_translated_midi
        exit_thread if @exit
      end
    end
    @thread.run
  end
  
  def listening?
    @listening
  end
  
  private
  def exit_thread
    @logger.debug("Killing TransportListener thread.")
    @thread.exit
  end
  
  def log_raw_midi
    @translator.log_print_buffer
  end

  def log_translated_midi
    @translator.log_print_translated_buffer
  end
    
end
