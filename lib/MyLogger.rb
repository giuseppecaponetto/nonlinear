require 'logger'
require 'singleton'

class MyLogger
    include Singleton
  
    attr_reader :output

    def initialize
       @output = Logger.new(STDOUT)
       @output.sev_threshold=Logger::DEBUG #det the logging level: 
    end

    def error(message)
      @output.error(formatted_message(message))
    end

    def info(message)
      @output.info(formatted_message(message))
    end
    
    def warn(message)
      @output.warn(formatted_message(message))
    end
    
    def debug(message)
      @output.debug(formatted_message(message))
    end

    private

    def formatted_message(message)
      "#{message}\n"
    end
end
