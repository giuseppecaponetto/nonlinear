require_relative '../lib/Output.rb'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/MockPattern.rb'

class MidiDispatcher
  def initialize(pattern)
    @out = Output.instance
    @logger = MyLogger.instance
    @pattern = pattern.channels
    @steps = pattern.steps
    @current_step = 0
  end
  
  def step
    array = []
    @pattern.each_index do
      |index|
      note = @pattern[index].array[@current_step].hash[:state]
      array.push(index+36) if note !=0
    end
    @current_step +=1
    if @current_step==@steps
      @current_step=0
    end
    @logger.info("Step: #{@current_step.to_s}")
    return array
  end
    
  
  def play_steps
    notes = step
    thread_array = []
    notes.size.times do |i|
      if notes[i] !=0
      thread_array.push(Thread.new do
        @logger.debug("Created thread #{i} processing note : #{notes[i]} .")
        #TODO
        @out.send(144, notes[i], 100)
        sleep(0.5)
        @out.send(128, notes[i], 100)
      end)
      end
    end
    thread_array.each {|t| t.run}
    @logger.debug("Played all notes")
  end
  def mock_notes
    array=[]
    36.upto(51) do
      |x|
      array.push(x)
    end
    return array
  end  
end