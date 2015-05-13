require_relative '../lib/MockSequencer.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Output.rb'

class Clock
  def initialize
    @out = Output.instance.output
    @sequencer = MockSequencer.new
    @logger = MyLogger.instance
    @exit = false
  end
    
  def start
    @logger.debug("Clock starting..")
    @exit = false
    @thread = Thread.new do
      loop do
        #mock_clock_task
        test_clock_task
        @thread.exit if @exit
      end
    end
    @thread.run
  end
  
  def stop
    @logger.debug("Clock stopping..")
    @sequencer.reset
    @exit = true
  end
  
  def test_output
      @out.puts(144, 36, 100)
      @out.puts(128, 36, 100)
  end
  
  private
  
  def mock_clock_task
      #@logger.debug("MOCK: Clock is ticking at 120 bpm")
      @sequencer.log_step
      sleep(0.5)
  end
end