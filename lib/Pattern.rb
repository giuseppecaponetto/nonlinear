$LOAD_PATH << File.dirname(__FILE__)
class Pattern
  attr_reader :array 

  def initialize(chan, steps)
    @steps = Array.new(steps, "c")
    @array = Array.new(chan) { Array.new(@steps.size, 0) }
  end
  
  def print
    for i in 0...@array.size
      puts "channel: " + (i+1).to_s + " ---> " + @array[i].to_s
    end
  end
end

