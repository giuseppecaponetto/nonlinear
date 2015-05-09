require 'unimidi'

class Output
  attr_reader :output
  def initialize
    @output = UniMIDI::Input.use(:first)
  end
end