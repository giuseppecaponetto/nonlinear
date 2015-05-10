class MidiTranslator
  def initlialize
  end
  def translate(midi) #il messaggio è un hash/array.. arrivano in overflow e alcuni messaggi non vengono letti.
    translated = 
        case midi[0][:data][0]
        when 242 then "reposition" #act of replacing the cursor on the seguencer and releasing it
        when 250 then "start" #"start"
        when 251 then "continue" #"continue"
        when 252 then "stop"
        when 248 then "clock"
        when 248 then "tune"
        when 246 then "clock"
        when 255 then "sysrequest"
        else "unknown"
      end
  end
  
  def throu(midi)
    translated = midi
  end
end