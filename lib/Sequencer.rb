class Sequencer
  attr_reader :stepcounter
  def initialize()
    @stepcounter = 0 
  end
  def step
     @stepcounter+=1 #increments every 1/4 of a bar
  end
  def jump_to(step)
    @stepcounter = step
  end
end