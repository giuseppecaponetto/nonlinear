

class Pattern
  attr_reader :steps_nr, :channel_nr
  
  def initialize(steps_number, channel_number)
    @channel_nr = channel_number
    @steps_nr = steps_number
    @pattern = Array.new(@channel_nr)
  end
    
end