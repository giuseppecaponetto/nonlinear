require_relative '../lib/MyLogger.rb'
class MockSequencer
  def initialize
    @logger = MyLogger.instance
    @step = 0
  end
  def step
    @step +=1
    @logger.debug("Tick on step: #{@step}")
  end
end