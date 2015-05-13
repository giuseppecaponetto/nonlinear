require_relative '../lib/MidiTranslator.rb'
require_relative '../lib/Helper.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Clock.rb'
require_relative '../lib/Input.rb'
require_relative '../lib/BpmCounter.rb'

class TransportListener

  def initialize(average_bpm_log_enable=false, threshold, bpm_log_enable)
    @clock = Clock.new
    @average_bpm_log_enable = average_bpm_log_enable
    @bpm_log_enable = bpm_log_enable
    @bpm_counter = BpmCounter.new(threshold)
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
        handle_midi_events  
        update_bpm_average
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
      @clock.start
      elsif event == "STOP"
      @logger.debug("ATTENTION: ---> #{event} action detected.")
      @clock.stop
      elsif event == "POSITION"
      @logger.debug("ATTENTION: ---> #{event} action detected.")

      elsif event == "CONTINUE"
      @logger.debug("ATTENTION: ---> #{event} action detected.")
      @clock.start
      elsif event == "CLOCK"
      else
        @logger.debug("ATTENTION: ---> #{@translator.translated_midi_buffer[index][:command]} action detected.")
      end
    end
  end
  
  def update_bpm_average
    @translator.translated_midi_buffer.each_index do
      |index|
      if @translator.translated_midi_buffer[index][:command] =="clock"
        @bpm_counter.update(@translator.translated_midi_buffer[index][:time_stamp])
        @bpm_counter.log_bpm_average if @average_bpm_log_enable
      end
    end
  end
  
  def update_bpm
    @translator.translated_midi_buffer.each_index do
      |index|
      if @translator.translated_midi_buffer[index][:command] =="clock"
        @bpm_counter.update(@translator.translated_midi_buffer[index][:time_stamp])
        @bpm_counter.log_bpm if @bpm_log_enable
      end
    end
  end
  
  def listening?
    @listening
  end
  
  private
  def exit_thread
    @logger.debug("Killing TransportListener thread..")
    @thread.exit
  end
  
  def log_raw_midi
    @translator.log_print_buffer
  end

  def log_translated_midi
    @translator.log_print_translated_buffer
  end
    
end
