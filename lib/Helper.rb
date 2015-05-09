require 'io/console'

class Helper

  def initialize

  end

  def exitMonitorOn
    @reaper = Thread.new do
      loop do
        Kernel.exit if gets =~ /exit/
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

