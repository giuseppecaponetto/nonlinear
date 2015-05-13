require 'unimidi'
require 'singleton'
class Output
  include Singleton
  attr_reader :output
  def initialize
    @output = UniMIDI::Output.use(:first)
  end
  def send(chan, note, velocity)
    @output.puts(chan, note, velocity)
  end
end