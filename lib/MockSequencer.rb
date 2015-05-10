class MockSequencer
  def initialize
    @step = 0
  end
  def step
    @step +=1
  end
end