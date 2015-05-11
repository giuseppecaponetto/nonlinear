require 'unimidi'
require 'singleton'
class Output
  include Singleton
  attr_reader :output
  def initialize
    @output = UniMIDI::Output.use(:first)
  end
end