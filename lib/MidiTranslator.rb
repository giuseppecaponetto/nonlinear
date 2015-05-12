require_relative '../lib/MyLogger.rb'

class MidiTranslator
  attr_reader :midi_buffer
  def initialize
    @midi_buffer = Array.new
    @logger = MyLogger.instance
  end
  #il messaggio è un hash/array.. arrivano in overflow e alcuni messaggi non vengono letti.
  def update(midi)
    @midi_buffer.clear
    midi.each_index do
      |index|
      @midi_buffer.push(midi[index])
    end
  end
  
  def log_print_buffer
    @midi_buffer.each_index do
      |index|
      @logger.debug("MIDI-MESSAGE: #{@midi_buffer[index]} --- BUFFER INDEX: #{index}")
    end
  end
end