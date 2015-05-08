class MidiTranslator
  def initlialize
  end
  def translate(midi)
    translated = 
        case midi[0][:data][0]
        when 242 then "reposition" #act of replacing the cursor on the seguencer and releasing it
        when 250 then "play" #"start"
        when 251 then "play" #"continue"
        when 252 then "stop"
        when 248 then "clock"
        else "unknown"
      end
  end
end