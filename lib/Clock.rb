require 'topaz'
require 'midi-eye'
require 'topaz'
require_relative '../lib/MyLogger.rb'

class Clock
  def initialize(tempo)
    @tempo = tempo
    #@tinterval = 60000/tempo
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
    @logger.debug("Simulated tick!")
    message = "a"

    `say "#{message}"`
  end
  
end