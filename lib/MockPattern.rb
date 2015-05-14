class MockPattern
  attr_reader :m_pattern
  def initialize
    @curr_step = 1
    @m_pattern = [[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0], 
                  [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
                  [0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
  end
  
  def random_pick(probability)
    pick = 0
    r = rand(100)
    if r < probability
      pick = 1
    else
      pick = 0
    end
    return pick
  end
  
  def randomize_channel(chan, probability)
    @m_pattern[chan].each_index do
      |index|
      @m_pattern[chan][index]=random_pick(probability)
    end
  end
  
  def step
    array=[]
    if @curr_step <=15
    array=get_step(@curr_step)
    @curr_step +=1
    else
    array=get_step(@curr_step)
    @curr_step = 1
    randomize_channel(4, 30)
    randomize_channel(5, 5)
    randomize_channel(6, 10)
    randomize_channel(7, 10)
    randomize_channel(8, 15)
    end
    return array
  end
  
  def get_step(step_nr)
    base_note = 36
    array = []
    @m_pattern.each_index do
      |index|
      array.push(to_note(index, @m_pattern[index][step_nr-1]))
    end 
    return array
  end
  
  def to_note(channel, value)
    if value == 1
      return 36+channel
    else
      return 0
    end
  end
  
end

