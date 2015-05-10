require 'io/console'
require_relative '../lib/MyLogger.rb'
class Helper

  def initialize
  @logger = MyLogger.instance
  end

  def exitMonitorOn
    @reaper = Thread.new do
      loop do
        if gets =~ /exit/
          @logger.info("Nonlinear quitted. Goodbye.")
          Kernel.exit
        end 
      end
    end
  end
  
  def exitMonitorOff
    @reaper.kill
  end
  def reloadListenerMonitorOn
    #TODO
  end
  def reloadListenerMonitorOff
    #TODO
  end
  
end

