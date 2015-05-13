require_relative '../lib/Output.rb'
require_relative '../lib/MyLogger.rb'

class MidiDispatcher
  def initialize
    @out = Output.instance
    @logger = MyLogger.instance
  end
  
  def play_steps
    notes = mock_notes
    thread_array = []
    notes.size.times do |i|
      thread_array.push(Thread.new do
        @logger.debug("Created thread #{i} processing note : #{notes[i]} .")
        #TODO 
        @out.send(144, notes[i], 100) 
        sleep(0.5)
        @out.send(128, notes[i], 100)
      end)
    end
    thread_array.each {|t| t.run}
  end  
  
  private
  def mock_notes
    array=[]
    36.upto(51) do
      |x|
      array.push(x)
    end
    return array
  end  
end