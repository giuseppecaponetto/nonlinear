require 'unimidi'

class Output
  attr_reader :output
  def initialize
    @output = UniMIDI::Output.use(:first)
  end
end