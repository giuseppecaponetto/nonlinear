require 'unimidi'
require 'singleton'
class Output
  include Singleton
  attr_reader :output
  def initialize
    @output = UniMIDI::Output.use(:first)
  end
  def send(nnr, duration)
    @output.puts(144, nnr, 100)
    sleep(duration)
    @output.puts(128, nnr, 100)
  end
end