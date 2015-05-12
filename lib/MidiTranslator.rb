require_relative '../lib/MyLogger.rb'

class MidiTranslator
  attr_reader :midi_buffer, :translated_midi_buffer
  def initialize
    @raw_midi_buffer = Array.new
    @translated_midi_buffer = Array.new
    @logger = MyLogger.instance
  end
  #il messaggio è un hash/array.. arrivano in overflow e alcuni messaggi non vengono letti.
  def update(midi)
    @raw_midi_buffer.clear
    @translated_midi_buffer.clear
    midi.each_index do
      |index|
      @raw_midi_buffer.push(midi[index])
    end
    translate(@raw_midi_buffer)
  end
  
  def log_print_buffer
    @raw_midi_buffer.each_index do
      |index|
      @logger.debug("MIDI-MESSAGE: #{@raw_midi_buffer[index]} --- BUFFER INDEX: #{index}")
    end
  end
  
  def log_print_translated_buffer
    @translated_midi_buffer.each_index do
      |index|
      @logger.debug("TRANSLATED-MIDI-MESSAGE: #{@translated_midi_buffer[index][:command]} --- BUFFER INDEX: #{index}")
    end
  end
  
  private
  #takes a sorted raw buffer like @raw_midi_buffer as parameter
  def translate(raw)
    raw.each_index do
      |index|
      translated = 
      case raw[index][:data][0]
        when 242 then "position"
        when 248 then "clock"
        when 250 then "start"
        when 251 then "continue"
        when 252 then "stop"  
        else "undefined"
      end 
      hash = {:command=>translated, :time_stamp=>raw[index][:timestamp]}
      @translated_midi_buffer.push(hash)
    end
  end
  
end