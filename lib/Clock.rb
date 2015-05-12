require_relative '../lib/MockSequencer.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Output.rb'

class Clock
  def initialize
    @logger = MyLogger.instance
    @exit = false
  end
  
  def mock_clock_task
      @logger.debug("MOCK: Clock is ticking at 120 bpm")
      sleep(0.5)
  end
  
  def start
    @logger.debug("Clock starting..")
    @exit = false
    @thread = Thread.new do
      loop do
        mock_clock_task
        @thread.exit if @exit
      end
    end
    @thread.run
  end
  
  def stop
    @logger.debug("Clock stopping..")
    @exit = true
  end
end