require 'unimidi'
require 'singleton'
class Input
  include Singleton
  attr_reader :input
  def initialize
    @input = UniMIDI::Input.use(:first)
  end
end