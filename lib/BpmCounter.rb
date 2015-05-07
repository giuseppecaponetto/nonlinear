


class BpmCounter
  attr_reader :bpm
  
  def initialize()
    @oldtime = 0
    @currenttime = 0
    @bpm = 0
  end
  
  def update
    @oldtime = @currenttime
    @currenttime = Time.now.to_f * 1000
    @bpm = (60000/(@currenttime - @oldtime)).round(2)
  end
  
end


