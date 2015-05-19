require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Clock.rb'
require_relative '../lib/Input.rb'
require_relative '../lib/BpmCounter.rb'
require_relative '../lib/MockMidiDispatcher.rb'

class MockTransportListener

  def initialize(resolution)
    @dispatcher = MockMidiDispatcher.new
    @resolution = resolution_to_clocks(resolution)
    @total_clock_messages = 0
    @clock = Clock.new
    @exit = false
    @listening = false
    @logger = MyLogger.instance
    @logger.debug("Started listening for transport control messages...")
    @translator = MidiTranslator.new
    @input = Input.instance
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
        @translator.update(@input.get_input)
        handle_midi_events  
        #log_raw_midi 
        #log_translated_midi
        exit_thread if @exit
      end
    end
    @thread.run
  end
  
  def handle_midi_events
    @translator.translated_midi_buffer.each_index do
      |index|
      event =
      case @translator.translated_midi_buffer[index][:command]
      when "start" then "START"
      when "continue" then "CONTINUE"
      when "stop" then "STOP"
      when "position" then "POSITION"
      when "clock" then "CLOCK"
      else "UNKNOWN"
      end
      if event == "START"
      @logger.debug("ATTENTION: ---> #{event} action detected.")
      @total_clock_messages = 0
      elsif event == "STOP"
      @logger.debug("ATTENTION: ---> #{event} action detected.")
      @total_clock_messages = 0
      elsif event == "POSITION"
      @logger.debug("ATTENTION: ---> #{event} action detected.")
      
      elsif event == "CONTINUE"
      @logger.debug("ATTENTION: ---> #{event} action detected.")
      
      elsif event == "CLOCK"
        if @total_clock_messages % @resolution == 0
          @logger.debug("ATTENTION: ---> #QUARTER NOTE event TRIGGERED.")
          #TODO implement pattern playing
          @dispatcher.play_steps
        end
        @total_clock_messages +=1
      else
        @logger.debug("ATTENTION: ---> #{@translator.translated_midi_buffer[index][:command]} action detected.")
      end
    end
  end
  
  def listening?
    @listening
  end
  
  private
  
  def resolution_to_clocks(resolution)
    clocks =
    case resolution
    when 1 then 96
    when 2 then 48
    when 4 then 24
    when 8 then 12
    when 16 then 6
    when 32 then 3
    end
  end
  
  def exit_thread
    @logger.debug("Killing MockTransportListener thread..")
    @thread.exit
  end
  
  def log_raw_midi
    @translator.log_print_buffer
  end

  def log_translated_midi
    @translator.log_print_translated_buffer
  end
    
end
