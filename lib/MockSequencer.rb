require_relative '../lib/MyLogger.rb'

class MockSequencer
  def initialize
    @logger = MyLogger.instance
    @step = 0
  end
  def reset
    @step = 0
  end
  def log_step
    @step +=1
    @logger.debug("Step: #{@step}")
  end
end