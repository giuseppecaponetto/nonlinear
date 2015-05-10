require 'topaz'
require 'midi-eye'
require 'topaz'
require_relative '../lib/MyLogger.rb'
require_relative '../lib/Output.rb'

class Clock
  def initialize(tempo)
    @f = true
    @output = Output.new
    @tempo = tempo
    @logger = MyLogger.instance
    @clock = Topaz::Tempo.new(tempo)do
      action
    end
  end
  
  def run
    @clock.start
    @logger.debug("Clock started ticking @ #{@tempo} bpm")
  end
  
  def action
    thread = Thread.new do
      @logger.debug("Simulated tick!")
      @output.output.puts(0x90, 36 + 2, 100) # note on
      sleep(0.001)
      @output.output.puts(0x80, 36 + 2, 100) # note off   
    end
    thread.join 
  end  
end