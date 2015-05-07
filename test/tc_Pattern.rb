# File:  Pattern.rb
require_relative '../lib/Pattern.rb'
require 'test/unit'
class TestPattern < Test::Unit::TestCase
  
  def test_simple
    assert_equal(1,Pattern.new(1,1).array.size)
    assert_equal(8, Pattern.new(8, 16).array.size)
  end
  
  def test_bounds
    assert_equal(0,Pattern.new(0,0).array.size)
  end
 
end