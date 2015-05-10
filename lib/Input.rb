require 'unimidi'

class Input
  attr_reader :input
  def initialize
    @input = UniMIDI::Input.use(:first)
  end
end