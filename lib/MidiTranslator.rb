class MidiTranslator
  attr_reader :buffer
  def initialize
    @buffer = Array.new
  end
  #il messaggio è un hash/array.. arrivano in overflow e alcuni messaggi non vengono letti.
  def translate(midi)
    @buffer.clear 
    midi.each_index do
        |x|
        translated = 
        case midi[x][:data][0]
          when 242 then "reposition" #act of replacing the cursor on the seguencer and releasing it
          when 250 then "start" #"start"
          when 251 then "continue" #"continue"
          when 252 then "stop"
          when 248 then "clock"
          when 246 then "tune"
          when 255 then "sysrequest"
          else "unknown"
        end
        @buffer.unshift(translated)
    end
  end
  
  def throu(midi)
    translated = midi
  end
end